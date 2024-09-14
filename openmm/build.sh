#!/bin/bash

CMAKE_FLAGS="${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF"

# Build in subdirectory and install.
mkdir -p build
cd build
cmake ${CMAKE_FLAGS} ${SRC_DIR}
make -j$CPU_COUNT
make -j$CPU_COUNT install PythonInstall

# Put examples into an appropriate subdirectory.
mkdir -p ${PREFIX}/share/openmm/
mv ${PREFIX}/examples ${PREFIX}/share/openmm/

# Fix some overlinking warnings/errors
for lib in ${PREFIX}/lib/plugins/*${SHLIB_EXT}; do
    ln -s $lib ${PREFIX}/lib/$(basename $lib) || true
done