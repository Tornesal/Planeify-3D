#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>

#include "identify/CandidateFinder.h"
#include "parser/GCodeParser.h"

static std::string readAll(const std::string& path) {
  std::ifstream f(path, std::ios::binary);
  if (!f) throw std::runtime_error("Failed to open input: " + path);
  std::ostringstream ss;
  ss << f.rdbuf();
  return ss.str();
}

// CLI usage summary.
static void printUsage() {
  std::cerr
      << "Usage:\n"
      << "  planeify3d_candidates <input.gcode> [--top-only] [--include-fallback] [--top-window-mm N]\n"
      << "                        [--max-gap-mm N] [--min-len-mm N]\n"
      << "\n"
      << "Output: candidate patches (op range + line range + layer/Z/type stats)\n";
}

// Entry point for candidate identification.
int main(int argc, char** argv) {
  if (argc < 2) {
    printUsage();
    return 2;
  }

  // CLI parsing and candidate configuration.
  std::string inputPath;
  identify::IdentifyConfig cfg{};

  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    if (a == "--help" || a == "-h") {
      printUsage();
      return 0;
    }
    if (a == "--top-only") {
      cfg.requireTopTag = true;
      continue;
    }
    if (a == "--include-fallback") {
      cfg.requireTopTag = false;
      cfg.allowTopZWindowFallback = true;
      continue;
    }
    if (a == "--top-window-mm") {
      if (i + 1 >= argc) {
        std::cerr << "--top-window-mm requires a value\n";
        return 2;
      }
      cfg.topZWindowMm = std::stod(argv[++i]);
      continue;
    }
    if (a == "--max-gap-mm") {
      if (i + 1 >= argc) {
        std::cerr << "--max-gap-mm requires a value\n";
        return 2;
      }
      cfg.maxNonExtrudeGapMm = std::stod(argv[++i]);
      continue;
    }
    if (a == "--min-len-mm") {
      if (i + 1 >= argc) {
        std::cerr << "--min-len-mm requires a value\n";
        return 2;
      }
      cfg.minPatchLengthMm = std::stod(argv[++i]);
      continue;
    }
    if (!a.empty() && a[0] == '-') {
      std::cerr << "Unknown flag: " << a << "\n";
      return 2;
    }
    if (inputPath.empty()) inputPath = std::move(a);
    else {
      std::cerr << "Unexpected extra arg: " << a << "\n";
      return 2;
    }
  }

  if (inputPath.empty()) {
    printUsage();
    return 2;
  }

  try {
    // Parse input and report candidate patches.
    const std::string text = readAll(inputPath);
    const ir::ProgramIR program = parser::parseGCode(text);
    const auto candidates = identify::findCandidates(program, cfg);

    std::cout << "Candidates: " << candidates.size() << "\n";
    for (size_t i = 0; i < candidates.size(); ++i) {
      const auto& p = candidates[i];
      std::cout << "[" << i << "] "
                << "lines " << p.lineBegin << "-" << p.lineEnd
                << ", ops " << p.opBegin << "-" << (p.opEnd - 1)
                << ", layer " << p.layer
                << ", Z " << p.baseZ
                << ", moves " << p.moveCount
                << ", xyLenMm " << p.approxXYLengthMm
                << ", type \"" << p.featureType << "\""
                << "\n";
    }

    return 0;
  } catch (const std::exception& e) {
    std::cerr << "Error: " << e.what() << "\n";
    return 1;
  }
}

