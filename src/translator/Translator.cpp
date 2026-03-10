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

        std::unordered_map<std::pair<int, int>, double, PairHash> original_heightmap = heightmap;

        // TODO: Remove debug stuff
        // Debug: zheights before smoothing
        double raw_sum = 0;
        for (const auto& pair : heightmap) raw_sum += pair.second;
        std::cout << "Sum of Z heights before smoothing: " << raw_sum << std::endl;

        // Phase 2: Smooth the Heightmap
        applyHeightSmoothing(heightmap, config, minX, maxX, minY, maxY);

        // Debug: zheights after smoothing
        double smooth_sum = 0;
        for (const auto& pair : heightmap) smooth_sum += pair.second;
        std::cout << "Sum of Z heights AFTER smoothing: " << smooth_sum << std::endl;
       
        // Phase 3: Morph the IR
        
        
        // TODO Remove testing cout when finished
        std::cout << "Heightmap built with " << heightmap.size() << " pixels." << std::endl;

        std::cout << "Translation complete." << std::endl;
    }
    

    // Throwback to trig
    void Translator::applyHeightSmoothing(std::unordered_map<std::pair<int, int>, double, PairHash>& heightmap, const TranslatorConfig& config, int minX, int maxX, int minY, int maxY) {
    
        const double PI = std::acos(-1.0);

         // Convert degrees to radians for C++ tan()
        double rad = config.max_clearance_angle * PI / 180.0;

        // The maximum Z we can drop over 1 pixel distance
        double drop_straight = std::tan(rad) * config.grid_resolution;

        // The maximum Z we can drop over 1 pixel diagonally
        // The 1.41421 is derived from pythagorean theorem (Approximation of sqrt(2))
        double drop_diagonal = std::tan(rad) * (config.grid_resolution * 1.41421);
    
        // 2. Forward Sweep
        for (int x = minX; x <= maxX; ++x) {
            for (int y = minY; y <= maxY; ++y) {

                auto key = std::make_pair(x, y);

                // Get curZ from map
                if (heightmap.count(key) > 0) {
                    double my_Z = heightmap[key];
                
                
                    // 1. Check Right Neighbor (x + 1, y)
                    auto key_right = std::make_pair(x + 1, y);

                    if (my_Z - heightmap[key_right] > drop_straight) {

                        heightmap[key_right] = my_Z - drop_straight;
                    }

                    // Check lower neighbor (x, y + 1)
                    auto key_below = std::make_pair(x, y + 1);

                    if (my_Z - heightmap[key_below] > drop_straight) {

                        heightmap[key_below] = my_Z - drop_straight;
                    }

                    // Check diagonal neighbor (x + 1, y + 1)
                    auto key_diagonal = std::make_pair(x + 1, y + 1);

                    if (my_Z - heightmap[key_diagonal] > drop_diagonal) {

                        heightmap[key_diagonal] = my_Z - drop_diagonal;
                    }
                }
            }
        }

        // 3. Backward Sweep
        for (int x = maxX; x >= minX; --x) {
            for (int y = maxY; y >= minY; --y) {

                auto key = std::make_pair(x, y);

                // Get curZ from map
                if (heightmap.count(key) > 0) {
                    double my_Z = heightmap[key];
                
                
                    // 1. Check Right Neighbor (x - 1, y)
                    auto key_right = std::make_pair(x - 1, y);

                    if (my_Z - heightmap[key_right] > drop_straight) {

                        heightmap[key_right] = my_Z - drop_straight;
                    }

                    // Check lower neighbor (x, y+1)
                    auto key_below = std::make_pair(x, y - 1);

                    if (my_Z - heightmap[key_below] > drop_straight) {

                        heightmap[key_below] = my_Z - drop_straight;
                    }

                    // Check diagonal neighbor (x - 1, y - 1)
                    auto key_diagonal = std::make_pair(x - 1, y - 1);

                    if (my_Z - heightmap[key_diagonal] > drop_diagonal) {

                        heightmap[key_diagonal] = my_Z - drop_diagonal;
                    }
                }
            }
        }
    }

    void Translator::applyIRMorphing(GCodeFile& ir, const std::unordered_map<std::pair<int, int>, double, PairHash>& heightmap, 
                             const std::unordered_map<std::pair<int, int>, double, PairHash>& original_map, const TranslatorConfig& config) {

        // Track the absolute nozzle position
        double curX = 0;
        double curY = 0;
        double curZ = 0;

        // Basically the same logic as phase 1 BUT instead we are modifying the heightmap.
        for (Layer& layer : ir.layers) {
            for (GCodeCommand& cmd : layer.commands) {
                
                double oldX = curX;
                double oldY = curY;

                if (cmd.params.count('X')) {
                    curX = cmd.params.at('X');
                }

                if (cmd.params.count('Y')) {
                    curY = cmd.params.at('Y');
                }

                if (cmd.params.count('Z')) {
                    curZ = cmd.params.at('Z');
                }

                double distX = (curX - oldX);
                double distY = (curY - oldY);
                double dist = std::sqrt(distX * distX + distY * distY);
                double step_size = config.grid_resolution / 2.0;

                if (cmd.type == CommandType::MOVE && cmd.params.count('E')) {
                    
                    for (double s = 0; s <= dist; s += step_size) {

                        double distX = (curX - oldX);
                        double distY = (curY - oldY);
                        double dist = std::sqrt(distX * distX + distY * distY);
                        double step_size = config.grid_resolution / 2.0;

                        double t = (dist == 0) ? 1.0 : s/ dist;

                        // Gather the current interpolated X and Y values
                        double interpX = oldX + t * distX;
                        double interpY = oldY + t * distY;

                        // Gather the final "address" of the "pixel"
                        int gX = static_cast<int>(std::floor(interpX / config.grid_resolution));
                        int gY = static_cast<int>(std::floor(interpY / config.grid_resolution));

                        auto key = std::make_pair(gX, gY);

                        // Only apply warping IF there is actualy extrusion
                        if (heightmap.count(key) && original_map.count(key)) {

                            // Calculate the Delta (The thickness of the ramp added)
                            double smoothed_Z = heightmap.at(key);
                            double original_Z = original_map.at(key);
                            double delta_Z = smoothed_Z - original_Z;

                            // Warp the command
                            cmd.params['Z'] = curZ + delta_Z;
                        }
                    }
                }
            }
        }
    }

} // namespace planeify
