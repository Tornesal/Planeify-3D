#ifndef PLANEIFY_3D_PARSER_H
#define PLANEIFY_3D_PARSER_H

#include "../ir/Types.h"
#include <iostream>
#include <sstream>
#include <string>

namespace planeify {
    // The Parser class is responsible for reading raw G-code text and converting it into our GCodeFile IR.
    // It handles:
    // 1. Reading the file line-by-line.
    // 2. Parsing each line into a GCodeCommand (extracting params, comments, etc.).
    // 3. Grouping commands into Layers based on Z-height changes or layer change comments.

    class Parser {

    public:

        // Main entry point. Reads from an input stream and returns the fully populated IR.
        GCodeFile parse(std::istream& input);

    private:

        // Helper function to parse a single line of text into a GCodeCommand struct.
        GCodeCommand parseLine(const std::string& line);
        
    };
}
#endif //PLANEIFY_3D_PARSER_H