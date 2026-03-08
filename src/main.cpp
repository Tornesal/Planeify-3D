#include "parser/Parser.h"
#include "translator/Translator.h"
#include <fstream>
#include <iostream>

int main(int argc, char *argv[]) {
  // MVP: Hardcode or take generic arg
  std::string filename = (argc > 1) ? argv[1] : "test.gcode";

  std::cout << "Planeify-3D: Processing " << filename << "..." << std::endl;

  std::ifstream file(filename);
  if (!file.is_open()) {
    std::cerr << "Error: Could not open file " << filename << std::endl;
    return 1;
  }

  planeify::Parser parser;
  planeify::GCodeFile ir = parser.parse(file);

  std::cout << "Parsed " << ir.layers.size() << " layers." << std::endl;

  // Future steps:
  // 3. Identifier::identify()
  
  planeify::TranslatorConfig config;
  config.grid_resolution = 0.1;
  config.max_clearance_angle = 15.0; 

  planeify::Translator translator;
  translator.translate(ir, config);

  // 5. Builder::build()

  return 0;
}
