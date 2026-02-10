#ifndef PLANEIFY_3D_TYPES_H
#define PLANEIFY_3D_TYPES_H
#include <map>
#include <string>
#include <vector>


// This types file gives us the basis to form a logical layout of the gcode
// file. Here is a top down view of the layout we use:

// 1. We store the parsed gcode file in the GCodeFile struct. This struct
// contains the headers, footers, and the layers in vectors.
// 2. Layers consist of a z_height, a bool that stores if it is a top surface,
// and the commands present in that layer.
// 3. The commands vector stores GCodeCommands, which is a struct that contains
// the original string, the command type, the parameters (Command char and
// value), and a bool that holds if it is modified or not.

namespace planeify {

// X, Y, and Z coordinates of each move (if it exists)
struct Point3D {
  double x;
  double y;
  double z;
  Point3D(double x = 0.0, double y = 0.0, double z = 0.0) : x(x), y(y), z(z) {}
};

// Depicts if the line is a move, comment, tool_change (For tool changers), or a
// different command
enum class CommandType { MOVE, COMMENT, TOOL_CHANGE, OTHER };

// Store the type of command, original string, commands, and if the line is
// modified. This allows us to easily inset the original line back into the
// reconstructed file if it has not been modified by the program.
struct GCodeCommand {
  CommandType type = CommandType::OTHER;
  std::string original_text;
  std::map<char, double> params;
  bool is_modified = false;
};

// Defines a layer. Stores current layer height and what commands are in the
// layer.
struct Layer {
  double z_height = 0.0;
  std::vector<GCodeCommand> commands;
  bool is_top_surface = false;
};

// Logical layout of the gcode file. The layers vector stores our Layer struct
// instances.
struct GCodeFile {
  std::vector<GCodeCommand> header;
  std::vector<Layer> layers;
  std::vector<GCodeCommand> footer;
};
} // namespace planeify
#endif // PLANEIFY_3D_TYPES_H