#!/bin/bash
set -e

# Re-create build folder
if [ -d build ]; then
    rm -rf build
fi
mkdir build

# Define docker run call
THIS_DIR=$(dirname $(readlink -f "$0"))
DOCKER_RUN="docker run --rm=true                        \
                       --tty=true                       \
                       --interactive=true               \
                       --volume=${THIS_DIR}:${THIS_DIR} \
                       --workdir=${THIS_DIR}/build      \
                       carlosgalvezp/stm32-dev"

# Compile
$DOCKER_RUN cmake -DCMAKE_TOOLCHAIN_FILE=$THIS_DIR/cmake/STM32_toolchain.cmake ..
$DOCKER_RUN make VERBOSE=1

