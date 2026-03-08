#include "Translator.h"
#include <iostream>
#include <unordered_map>
#include <cmath>
#include <utility>

namespace planeify {

    // Helper syntax for using std::pair as a key in std::unordered_map
    // Allows the keys to be a pair of coordinates (x, y)
    struct PairHash {
        template <class T1, class T2>
        std::size_t operator () (const std::pair<T1, T2>& p) const {
            auto h1 = std::hash<T1>{}(p.first);
            auto h2 = std::hash<T2>{}(p.second);
            // Simple hash combining
            return h1 ^ (h2 << 1); 
        }
    };

    void Translator::translate(GCodeFile &ir, const TranslatorConfig &config) {
        
        std::cout << "Starting translation..." << std::endl;

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

        // Phase 2: Smooth the Heightmap

        // Phase 3: Morph the IR
        std::cout << "Heightmap built with " << heightmap.size() << " pixels." << std::endl;

        std::cout << "Translation complete." << std::endl;
    }

} // namespace planeify
