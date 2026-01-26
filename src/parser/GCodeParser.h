#pragma once

#include <string_view>

#include "ir/ProgramIR.h"

namespace parser {

// Parses raw G-code text into a shared IR plus normalized per-op state.
// - Preserves every line verbatim (minus newline).
// - Tracks modal state (G90/G91, M82/M83), current position, and best-effort
//   layer/feature metadata from slicer comments (Bambu/Orca/Prusa-derived).
ir::ProgramIR parseGCode(std::string_view gcodeText);

} // namespace parser

