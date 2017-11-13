#!/bin/bash
set -e

# Define docker run call
THIS_DIR=$(dirname $(readlink -f "$0"))
DOCKER_RUN="docker run --rm=true                        \
                       --tty=true                       \
                       --interactive=true               \
                       --volume=${THIS_DIR}:${THIS_DIR} \
                       --workdir=${THIS_DIR}            \
                       --user=${UID}:${GROUPS}          \
                       --group-add=dialout              \
                       --device=/dev/ttyUSB0            \
                       carlosgalvezp/stm32-dev"

# Write to flash
$DOCKER_RUN stm32flash -w build/0_blinky.bin /dev/ttyUSB0

# Run
$DOCKER_RUN stm32flash -g0 /dev/ttyUSB0
