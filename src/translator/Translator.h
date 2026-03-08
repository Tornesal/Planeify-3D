#ifndef PLANEIFY_3D_TRANSLATOR_H
#define PLANEIFY_3D_TRANSLATOR_H

#include "../ir/Types.h"

// The gist of this file is to translate the 2.5 dimensional tool pathing into 3
// dimensional tool pathing. This is accomplished by forming a topological map
// (or height map) of the top SURFACE (not layer) of the object. The print bed
// is divided into a 2d grid of pixels (x, y). Every extrusion is parsed and, if
// an extrusion crosses a pixel on the grid, that height is recorded. As the
// parsing continues, if that same pixel has extrusion in a layer that is higher
// up, that new height replaces the old height. This results in the height map
// containing the highest z value for ALL x, y coordinates.

// Once this map is created, the layers that the nozzle can successfully perform
// non planar movements on (without colloding with other geometry) now have a
// warp applied to them to achieve non planar printing.

namespace planeify {

    struct TranslatorConfig {
        double grid_resolution;
        double max_clearance_angle;
    };

    class Translator {

        public:
        void translate(GCodeFile &ir, const TranslatorConfig &config);
    };

} // namespace planeify

#endif // PLANEIFY_3D_TRANSLATOR_H
