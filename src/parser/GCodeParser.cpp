#include "parser/GCodeParser.h"

#include <algorithm>
#include <charconv>
#include <cmath>
#include <cstddef>
#include <limits>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace {

static inline bool iequals(char a, char b) {
  if (a >= 'A' && a <= 'Z') a = static_cast<char>(a - 'A' + 'a');
  if (b >= 'A' && b <= 'Z') b = static_cast<char>(b - 'A' + 'a');
  return a == b;
}

// Case-insensitive prefix match for command tokens.
static bool istarts_with(std::string_view s, std::string_view prefix) {
  if (s.size() < prefix.size()) return false;
  for (size_t i = 0; i < prefix.size(); ++i) {
    if (!iequals(s[i], prefix[i])) return false;
  }
  return true;
}

// Numeric parsing with a fast path and permissive fallback.
static std::optional<double> parseDouble(std::string_view s) {
  // Parsing strategy: fast path first, then a permissive fallback.
  double v = 0.0;
  auto* first = s.data();
  auto* last = s.data() + s.size();
  auto res = std::from_chars(first, last, v);
  if (res.ec == std::errc() && res.ptr == last) return v;

  try {
    std::string tmp(s);
    size_t idx = 0;
    v = std::stod(tmp, &idx);
    if (idx == tmp.size()) return v;
  } catch (...) {
  }
  return std::nullopt;
}

// Integer parsing used for slicer metadata keys.
static std::optional<int> parseInt(std::string_view s) {
  int v = 0;
  auto res = std::from_chars(s.data(), s.data() + s.size(), v);
  if (res.ec == std::errc() && res.ptr == s.data() + s.size()) return v;
  try {
    std::string tmp(s);
    size_t idx = 0;
    v = std::stoi(tmp, &idx);
    if (idx == tmp.size()) return v;
  } catch (...) {
  }
  return std::nullopt;
}

// Tokenization for a single G-code line segment.
static void splitTokens(std::string_view s, std::vector<std::string_view>& out) {
  out.clear();
  s = ir::trim(s);
  while (!s.empty()) {
    size_t i = 0;
    while (i < s.size() && s[i] != ' ' && s[i] != '\t') ++i;
    out.push_back(s.substr(0, i));
    while (i < s.size() && (s[i] == ' ' || s[i] == '\t')) ++i;
    s.remove_prefix(std::min(i, s.size()));
  }
}

// Case-insensitive key lookup within a slicer comment payload.
static std::string_view afterCommentKey(std::string_view comment, std::string_view key) {
  // Case-insensitive key lookup within a slicer comment payload.
  for (size_t i = 0; i + key.size() <= comment.size(); ++i) {
    bool match = true;
    for (size_t k = 0; k < key.size(); ++k) {
      if (!iequals(comment[i + k], key[k])) {
        match = false;
        break;
      }
    }
    if (!match) continue;
    return comment.substr(i + key.size());
  }
  return {};
}

// Slicer metadata extraction and normalization.
static void parseSlicerMetadata(std::string_view comment,
                                int& layerInOut,
                                std::string& featureTypeInOut,
                                int& implicitLayerCounterInOut,
                                bool& sawLayerChangeOut) {
  // Slicer metadata normalization across Bambu/Orca/Prusa variants.
  if (auto rest = afterCommentKey(comment, "LAYER:"); !rest.empty()) {
    rest = ir::trim(rest);
    if (auto v = parseInt(rest)) {
      layerInOut = *v;
      implicitLayerCounterInOut = *v;
    }
  }

  if (!afterCommentKey(comment, "LAYER_CHANGE").empty() ||
      istarts_with(ir::trim(comment), "LAYER_CHANGE") ||
      !afterCommentKey(comment, "CHANGE_LAYER").empty() ||
      istarts_with(ir::trim(comment), "CHANGE_LAYER")) {
    sawLayerChangeOut = true;
  }

  if (auto rest = afterCommentKey(comment, "TYPE:"); !rest.empty()) {
    rest = ir::trim(rest);
    if (!rest.empty()) featureTypeInOut = std::string(rest);
  }

  if (auto rest = afterCommentKey(comment, "FEATURE:"); !rest.empty()) {
    rest = ir::trim(rest);
    if (!rest.empty()) featureTypeInOut = std::string(rest);
  }

  if (auto rest = afterCommentKey(comment, "layer num/total_layer_count:"); !rest.empty()) {
    rest = ir::trim(rest);
    const size_t slash = rest.find('/');
    std::string_view lhs = (slash == std::string_view::npos) ? rest : rest.substr(0, slash);
    lhs = ir::trim(lhs);
    if (auto v = parseInt(lhs)) {
      // Bambu emits 1/82 for the first layer.
      const int zBased = std::max(0, *v - 1);
      layerInOut = zBased;
      implicitLayerCounterInOut = zBased;
    }
  }
}

} // namespace

namespace parser {

// Parse raw G-code into the shared IR with normalized state.
ir::ProgramIR parseGCode(std::string_view gcodeText) {
  ir::ProgramIR program;

  ir::Position pos{};
  ir::ModalState modal{};

  // Slicer metadata and layer inference state.
  int currentLayer = -1;
  int implicitLayerCounter = -1;
  int inferredLayerCounter = -1;
  double inferredLayerZ = std::numeric_limits<double>::quiet_NaN();
  std::string currentFeatureType;
  bool sawLayerChange = false;

  std::vector<std::string_view> tokens;

  size_t start = 0;
  size_t lineNo = 0;
  while (start <= gcodeText.size()) {
    size_t end = gcodeText.find('\n', start);
    if (end == std::string_view::npos) end = gcodeText.size();

    std::string_view fullLine = gcodeText.substr(start, end - start);
    if (!fullLine.empty() && fullLine.back() == '\r') fullLine.remove_suffix(1);
    ++lineNo;

    // Parsing boundary between code and comment.
    std::string_view code = fullLine;
    std::string_view comment;
    if (size_t semi = fullLine.find(';'); semi != std::string_view::npos) {
      code = fullLine.substr(0, semi);
      comment = fullLine.substr(semi + 1);
    }

    // Metadata updates from comment-only or mixed lines.
    if (!comment.empty()) {
      parseSlicerMetadata(comment, currentLayer, currentFeatureType, implicitLayerCounter, sawLayerChange);
    }

    ir::Op op;
    op.lineNumber = lineNo;
    op.raw = std::string(fullLine);
    op.comment = std::string(comment);

    ir::OpState st;
    st.start = pos;
    st.layer = currentLayer;
    st.featureType = currentFeatureType;

    code = ir::trim(code);
    if (code.empty()) {
      op.data = ir::Other{};
      st.end = pos;
      st.modalAfter = modal;

      program.ops.push_back(std::move(op));
      program.states.push_back(std::move(st));

      if (end == gcodeText.size()) break;
      start = end + 1;
      continue;
    }

    splitTokens(code, tokens);
    std::string_view cmd = tokens.empty() ? std::string_view{} : tokens[0];

    auto finish = [&](const ir::Position& newPos) {
      st.end = newPos;
      st.modalAfter = modal;
      program.ops.push_back(std::move(op));
      program.states.push_back(std::move(st));
    };

    // Command dispatch: modal updates, position resets, motion, pass-through.
    if (istarts_with(cmd, "G90")) {
      modal.absoluteXYZ = true;
      op.data = ir::Other{};
      finish(pos);
    } else if (istarts_with(cmd, "G91")) {
      modal.absoluteXYZ = false;
      op.data = ir::Other{};
      finish(pos);
    } else if (istarts_with(cmd, "M82")) {
      modal.absoluteE = true;
      op.data = ir::Other{};
      finish(pos);
    } else if (istarts_with(cmd, "M83")) {
      modal.absoluteE = false;
      op.data = ir::Other{};
      finish(pos);
    } else if (istarts_with(cmd, "G92")) {
      // Position reset via G92.
      ir::Position newPos = pos;
      for (size_t i = 1; i < tokens.size(); ++i) {
        auto t = tokens[i];
        if (t.size() < 2) continue;
        char axis = t[0];
        auto v = parseDouble(t.substr(1));
        if (!v) continue;
        switch (axis) {
          case 'X': case 'x': newPos.x = *v; break;
          case 'Y': case 'y': newPos.y = *v; break;
          case 'Z': case 'z': newPos.z = *v; break;
          case 'E': case 'e': newPos.e = *v; break;
          default: break;
        }
      }
      pos = newPos;
      op.data = ir::Other{};
      finish(pos);
    } else if (istarts_with(cmd, "G0") || istarts_with(cmd, "G00") ||
               istarts_with(cmd, "G1") || istarts_with(cmd, "G01") ||
               istarts_with(cmd, "G2") || istarts_with(cmd, "G02") ||
               istarts_with(cmd, "G3") || istarts_with(cmd, "G03")) {
      ir::Move mv;
      mv.isRapid = istarts_with(cmd, "G0") || istarts_with(cmd, "G00");

      for (size_t i = 1; i < tokens.size(); ++i) {
        auto t = tokens[i];
        if (t.size() < 2) continue;
        char axis = t[0];
        auto v = parseDouble(t.substr(1));
        if (!v) continue;
        switch (axis) {
          case 'X': case 'x': mv.x = *v; break;
          case 'Y': case 'y': mv.y = *v; break;
          case 'Z': case 'z': mv.z = *v; break;
          case 'E': case 'e': mv.e = *v; break;
          case 'F': case 'f': mv.f = *v; break;
          default: break;
        }
      }

      ir::Position newPos = pos;
      if (mv.x) newPos.x = modal.absoluteXYZ ? *mv.x : (newPos.x + *mv.x);
      if (mv.y) newPos.y = modal.absoluteXYZ ? *mv.y : (newPos.y + *mv.y);
      if (mv.z) newPos.z = modal.absoluteXYZ ? *mv.z : (newPos.z + *mv.z);
      if (mv.e) newPos.e = modal.absoluteE ? *mv.e : (newPos.e + *mv.e);

      // Layer counters based on change markers when explicit IDs are missing.
      if (sawLayerChange && mv.z && modal.absoluteXYZ) {
        if (implicitLayerCounter < 0) implicitLayerCounter = 0;
        ++implicitLayerCounter;
        currentLayer = implicitLayerCounter;
        sawLayerChange = false;
        st.layer = currentLayer;
      }

      const double eDelta = newPos.e - pos.e;
      st.isExtruding = (eDelta > 1e-9);

      // Geometry-driven layer inference for files without slicer markers.
      if (currentLayer < 0 && st.isExtruding) {
        if (inferredLayerCounter < 0) {
          inferredLayerCounter = 0;
          currentLayer = 0;
          inferredLayerZ = newPos.z;
        } else if (std::isfinite(inferredLayerZ) && std::abs(newPos.z - inferredLayerZ) > 1e-5 && newPos.z > inferredLayerZ) {
          ++inferredLayerCounter;
          currentLayer = inferredLayerCounter;
          inferredLayerZ = newPos.z;
        }
        st.layer = currentLayer;
      }

      pos = newPos;

      // Arc commands update state but do not enter the move IR.
      if (istarts_with(cmd, "G2") || istarts_with(cmd, "G02") || istarts_with(cmd, "G3") || istarts_with(cmd, "G03")) {
        op.data = ir::Other{};
      } else {
        op.data = mv;
      }
      finish(pos);
    } else {
      // Pass-through for unknown commands.
      op.data = ir::Other{};
      finish(pos);
    }

    if (end == gcodeText.size()) break;
    start = end + 1;
  }

  return program;
}

} // namespace parser

