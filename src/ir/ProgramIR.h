#pragma once

#include <cstddef>
#include <optional>
#include <string>
#include <string_view>
#include <variant>
#include <vector>

namespace ir {

struct Position {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double e = 0.0;
};

struct ModalState {
  bool absoluteXYZ = true;
  bool absoluteE = true;
};

struct Move {
  bool isRapid = false;

  std::optional<double> x;
  std::optional<double> y;
  std::optional<double> z;
  std::optional<double> e;
  std::optional<double> f;
};

// Non-move lines are preserved as raw text and still influence modal state.
struct Other {
};

using OpData = std::variant<Move, Other>;

struct Op {
  std::size_t lineNumber = 0;
  std::string raw;
  std::string comment;

  OpData data;
};

struct OpState {
  Position start;
  Position end;

  ModalState modalAfter;

  // Best-effort metadata derived from slicer comments.
  int layer = -1;
  std::string featureType;

  bool isExtruding = false;
};

struct ProgramIR {
  std::vector<Op> ops;
  std::vector<OpState> states;
};

// Whitespace trimming used by the parser.
inline std::string_view trim(std::string_view s) {
  while (!s.empty() && (s.front() == ' ' || s.front() == '\t')) s.remove_prefix(1);
  while (!s.empty() && (s.back() == ' ' || s.back() == '\t')) s.remove_suffix(1);
  return s;
}

}

