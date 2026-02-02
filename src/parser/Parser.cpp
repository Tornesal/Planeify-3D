#include "Parser.h"

namespace planeify {

    GCodeFile Parser::parse(std::istream& input) {
        
        GCodeFile file;
        std::string line;

        // Assume it is a header line until Z changes.
        bool is_header = true;

        // TODO: Implement parsing loop
        while (std::getline(input, line)) { 
            
            

        }
        return file;
    }

    GCodeCommand Parser::parseLine(const std::string& line) {
        
        GCodeCommand cmd;
        cmd.original_text = line;

        // 1. Handle Comments first (strip anything after ;)
        std::string cleanLine = line;
        size_t commentPos = line.find(';');

        if (commentPos != std::string::npos) {

            // Get the text BEFORE the commnet (;)
            cleanLine = line.substr(0, commentPos);

            // If the whole line starts with ;, set type to COMMENT
            if (commentPos == 0) cmd.type = CommandType::COMMENT;

        }
        
        // 2. Tokenize the clean part
        std::stringstream ss(cleanLine);
        std::string token;
        
        while (ss >> token) {
            // token will be "G1", "X10", "Y20.5"
            // You can inspect token[0] to see if it's 'X', 'Y', 'G', etc.
        }
        return cmd;
    }
}