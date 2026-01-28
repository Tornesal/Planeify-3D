#include "identify/CandidateFinder.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <limits>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

namespace {

static inline char lowerChar(char c) {
  if (c >= 'A' && c <= 'Z') return static_cast<char>(c - 'A' + 'a');
  return c;
}

static std::string lowerCopy(const std::string& s) {
  std::string out;
  out.resize(s.size());
  for (size_t i = 0; i < s.size(); ++i) out[i] = lowerChar(s[i]);
  return out;
}

static bool containsI(const std::string& haystack, const char* needleLower) {
  std::string h = lowerCopy(haystack);
  return h.find(needleLower) != std::string::npos;
}

// Top-surface tag classifier for slicer feature labels.
static bool isTopFeatureTag(const std::string& featureType) {
  // Conservative tag matching for Bambu/Orca/Prusa feature labels.
  return containsI(featureType, "top");
}

struct LayerKey {
  int layer;
  bool operator==(const LayerKey& o) const { return layer == o.layer; }
};

}

namespace identify {

std::vector<CandidatePatch> findCandidates(const ir::ProgramIR& program, const IdentifyConfig& cfg) {
  std::vector<CandidatePatch> out;
  if (program.ops.size() != program.states.size()) return out;

  // Global Z extrema for fallback selection.
  double maxExtrusionZ = -std::numeric_limits<double>::infinity();

  for (size_t i = 0; i < program.ops.size(); ++i) {
    const auto& st = program.states[i];
    if (!st.isExtruding) continue;
    maxExtrusionZ = std::max(maxExtrusionZ, st.end.z);
  }

  // Top-surface qualification rules.
  auto isTopQualified = [&](size_t i) -> bool {
    const auto& st = program.states[i];
    const bool topTagged = isTopFeatureTag(st.featureType);
    if (cfg.requireTopTag) return topTagged;

    if (!cfg.allowTopZWindowFallback) return topTagged;
    if (!std::isfinite(maxExtrusionZ)) return topTagged;

    const double thresholdZ = maxExtrusionZ - cfg.topZWindowMm;
    const bool inTopBand = (st.end.z + cfg.zEps) >= thresholdZ;
    return topTagged || inTopBand;
  };

  // Retraction termination rule.
  auto isRetract = [&](size_t i) -> bool {
    const auto& st = program.states[i];
    const double eDelta = st.end.e - st.start.e;
    return eDelta < -1e-6;
  };

  size_t i = 0;
  while (i < program.ops.size()) {
    const auto& st = program.states[i];
    if (!isTopQualified(i) || !st.isExtruding) {
      ++i;
      continue;
    }

    const int layer = st.layer;
    const double z0 = st.end.z;
    std::string featureType = st.featureType;

    size_t begin = i;
    size_t end = i;
    double xyLen = 0.0;
    size_t moveCount = 0;

    // Candidate grouping rules and termination conditions.
    while (end < program.ops.size() && isTopQualified(end)) {
      const auto& cur = program.states[end];

      if (layer >= 0 && cur.layer >= 0 && cur.layer != layer) break;
      if (std::abs(cur.end.z - z0) > cfg.zEps) break;
      if (isRetract(end)) break;

      const double dx = cur.end.x - cur.start.x;
      const double dy = cur.end.y - cur.start.y;
      const double segLen = std::sqrt(dx * dx + dy * dy);

      if (cur.isExtruding) {
        xyLen += segLen;
        ++moveCount;
      } else {
        if (segLen > cfg.maxNonExtrudeGapMm) break;
      }

      ++end;
    }

    if (xyLen >= cfg.minPatchLengthMm && moveCount > 0) {
      CandidatePatch p;
      p.opBegin = begin;
      p.opEnd = end;
      p.layer = layer;
      p.baseZ = z0;
      p.featureType = std::move(featureType);
      p.moveCount = moveCount;
      p.approxXYLengthMm = xyLen;
      p.lineBegin = program.ops[begin].lineNumber;
      p.lineEnd = program.ops[end - 1].lineNumber;
      out.push_back(std::move(p));
    }

    i = end;
  }

  return out;
}

}

