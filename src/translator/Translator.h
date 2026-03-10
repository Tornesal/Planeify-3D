#ifndef PLANEIFY_3D_TRANSLATOR_H
#define PLANEIFY_3D_TRANSLATOR_H

#include "../ir/Types.h"
#include <unordered_map>

// The gist of this file is to translate the 2.5 dimensional tool pathing into 3
// dimensional tool pathing. This is accomplished by forming a topological map
// (or height map) of the top SURFACE (not layer) of the object. The print bed
// is divided into a 2d grid of pixels (x, y). Every extrusion is parsed and, if
// an extrusion crosses a pixel on the grid, that height is recorded. As the
// parsing continues, if that same pixel has extrusion in a layer that is higher
// up, that new height replaces the old height. This results in the height map
// containing the highest z value for ALL x, y coordinates.

// Once this map is created, the layers that the nozzle can successfully perform
// non planar movements on (without colliding with other geometry) now have a
// warp applied to them to achieve non planar printing.

namespace planeify {

    struct TranslatorConfig {
        double grid_resolution;
        double max_clearance_angle;
    };

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

    class Translator {

        public:
        void translate(GCodeFile &ir, const TranslatorConfig &config);

        private:
        void applyHeightSmoothing(std::unordered_map<std::pair<int, int>, double, PairHash>& heightmap, const TranslatorConfig& config, int minX, int maxX, int minY, int maxY);
    };

} // namespace planeify

#endif // PLANEIFY_3D_TRANSLATOR_H
