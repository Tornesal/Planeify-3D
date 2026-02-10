#include "Parser.h"

namespace planeify {

GCodeFile Parser::parse(std::istream &input) {

  GCodeFile file;
  std::string line;
  GCodeCommand cmd;

  // Assume it is a header line until Z changes.
  bool is_header = true;
  double z_height = 0.0;
  double last_z_height = -1;

  // TODO: Implement parsing loop
  while (std::getline(input, line)) {

    cmd = parseLine(line);

    // If the z height changes, store it in the z_height
    if (cmd.type == CommandType::MOVE && cmd.params.count('Z') != 0) {

      z_height = cmd.params['Z'];
    }

    // Checking for start of a new layer by seeing if there is positive
    // extrusion at a new z height
    if (cmd.type == CommandType::MOVE && cmd.params.count('E') > 0 &&
        cmd.params['E'] > 0) {

      double newE = cmd.params['E'];

      if (z_height != last_z_height) {

        is_header = false;

        last_z_height = z_height;

        file.layers.emplace_back();
        file.layers.back().z_height = z_height;
      }
    }

    // If it is part of the header, push it to the end of the vector.
    if (is_header) {
      file.header.push_back(cmd);

      // Else, we fetch the layer we made in the z if logic above and add the
      // commands to the correct place.
    } else {
      file.layers.back().commands.push_back(cmd);
    }
  }
  return file;
}

GCodeCommand Parser::parseLine(const std::string &line) {

  GCodeCommand cmd;
  cmd.original_text = line;

  // 1. Handle Comments first (strip anything after ;)
  std::string cleanLine = line;
  size_t commentPos = line.find(';');

  if (commentPos != std::string::npos) {

    // Get the text BEFORE the comment (;)
    cleanLine = line.substr(0, commentPos);

    // If the whole line starts with ;, set type to COMMENT
    if (commentPos == 0) {
      cmd.type = CommandType::COMMENT;
    }
  }

  // 2. Tokenize the clean part
  std::stringstream ss(cleanLine);
  std::string token;

  while (ss >> token) {
    // token will be "G1", "X10", "Y20.5"
    // Token command (EX: G, M, etc...) and value
    try {

      if (token.length() > 1) {
        cmd.params[token[0]] = std::stod(token.substr(1));
      }

    } catch (...) {
      // Ignore if it's not a number (e.g. just "G")
    }

    // Assign command
    if (token[0] == 'G') {
      cmd.type = CommandType::MOVE;

    } else if (token[0] == 'T') {
      cmd.type = CommandType::TOOL_CHANGE;

    } else if (token[0] == 'M') {
      cmd.type = CommandType::OTHER;
    }
  }

  return cmd;
}
} // namespace planeify