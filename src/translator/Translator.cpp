#include "Translator.h"
#include <iostream>
#include <unordered_map>
#include <cmath>
#include <utility>
#include <limits>


namespace planeify {

    void Translator::translate(GCodeFile &ir, const TranslatorConfig &config) {
        
        std::cout << "Starting translation..." << std::endl;

        // Min and Max X and Y values for determining the bounding box
        int minX = std::numeric_limits<int>::max();
        int maxX = std::numeric_limits<int>::min();
        int minY = std::numeric_limits<int>::max();
        int maxY = std::numeric_limits<int>::min();

        // Phase 1: Build the Heightmap
        std::unordered_map<std::pair<int, int>, double, PairHash> heightmap;

        // Variables to hold persistent values
        double curX = 0;
        double curY = 0;
        double curZ = 0;

        // Loop through all layers and all commands within them
        for (Layer& layer : ir.layers) {

            for (GCodeCommand& cmd : layer.commands) {

                double oldX = curX;
                double oldY = curY;
                
                // Update positional values
                if (cmd.params.count('X')) {
                    curX = cmd.params.at('X');
                }

                if (cmd.params.count('Y')) {
                    curY = cmd.params.at('Y');
                }

                if (cmd.params.count('Z')) {
                    curZ = cmd.params.at('Z');
                }

                if (cmd.type == CommandType::MOVE && cmd.params.count('E')) {

                    double distX = (curX - oldX);
                    double distY = (curY - oldY);
                    double dist = std::sqrt(distX * distX + distY * distY);
                    double step_size = config.grid_resolution / 2.0;

                    // Sample line at regular interval to fill in grid
                    for (double s = 0; s <= dist; s += step_size) {

                        // If distance is 0, there is no line to interpolate. This avoids division by 0
                        // t is the interpolation factor. Basically, it is how far along the distance of the line we are.
                        // A t of 0.5 means we are halfway along the time (At the midpoint).
                        double t = (dist == 0) ? 1.0 : s/ dist;

                        // Gather the current interpolated X and Y values
                        double interpX = oldX + t * distX;
                        double interpY = oldY + t * distY;

                        // Gather the final "address" of the "pixel"
                        int gX = static_cast<int>(std::floor(interpX / config.grid_resolution));
                        int gY = static_cast<int>(std::floor(interpY / config.grid_resolution));

                        // Update bounding box ranges
                        if (gX < minX) minX = gX;
                        if (gX > maxX) maxX = gX;
                        if (gY < minY) minY = gY;
                        if (gY > maxY) maxY = gY;

                        // If the current nozzle height (curZ) is heigher than what we currently have in
                        // that pixel, replace it.
                        double& mapZ = heightmap[std::make_pair(gX, gY)];

                        if (curZ > mapZ) {
                            mapZ = curZ;
                        }

                    }

                }

            }

        }

        const double PI = std::acos(-1.0);

        // Phase 2: Smooth the Heightmap

        // Convert degrees to radians for C++ tan()
        double rad = config.max_clearance_angle * PI / 180.0;

        // The maximum Z we can drop over 1 pixel distance
        double drop_straight = std::tan(rad) * config.grid_resolution;

        // The maximum Z we can drop over 1 pixel diagonally
        double drop_diagonal = std::tan(rad) * (config.grid_resolution * 1.41421);



        // Phase 3: Morph the IR
        
        // TODO Remove testing cout when finished
        std::cout << "Heightmap built with " << heightmap.size() << " pixels." << std::endl;

        std::cout << "Translation complete." << std::endl;
    }
    

    void applyHeightSmoothing(std::unordered_map<std::pair<int, int>, double, PairHash>& heightmap, const TranslatorConfig& config, int minX, int maxX, int minY, int maxY) {
    // 1. Math constants (PI, rad, drop_straight, drop_diagonal)
    
    // 2. Forward Sweep
    for (int x = minX; x <= maxX; ++x) {
        for (int y = minY; y <= maxY; ++y) {
            // Get curZ from map
            // If curZ exists (is > 0):
            //   - Check neighbor (x+1, y)
            //   - Check neighbor (x, y+1)
            //   - Check neighbor (x+1, y+1)
        }
    }
    // 3. Backward Sweep
    // (Exactly the same but count x from maxX to minX and y from maxY to minY)
}

} // namespace planeify
