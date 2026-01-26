#pragma once

#include <cstddef>
#include <string>
#include <vector>

#include "ir/ProgramIR.h"

namespace identify {

struct CandidatePatch {
  std::size_t opBegin = 0;
  std::size_t opEnd = 0;

  int layer = -1;
  double baseZ = 0.0;
  std::string featureType;

  std::size_t moveCount = 0;
  double approxXYLengthMm = 0.0;

  std::size_t lineBegin = 0;
  std::size_t lineEnd = 0;
};

struct IdentifyConfig {
  // Explicit top-feature selection as the default filter.
  bool requireTopTag = true;

  // Optional fallback for slicers without feature tags.
  bool allowTopZWindowFallback = false;

  // Width of the top-of-print Z band used by the fallback.
  double topZWindowMm = 0.6;

  // Maximum non-extruding gap allowed inside a patch.
  double maxNonExtrudeGapMm = 2.0;

  // Minimum XY length for a patch to be reported.
  double minPatchLengthMm = 5.0;

  // Z equality tolerance within a patch.
  double zEps = 1e-4;
};

// Identify candidate patches suitable for non-planar planning.
std::vector<CandidatePatch> findCandidates(const ir::ProgramIR& program, const IdentifyConfig& cfg);

} // namespace identify

