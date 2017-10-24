#!/bin/bash
set -e

# Define docker run call
THIS_DIR=$(dirname $(readlink -f "$0"))
DOCKER_RUN="docker run --rm=true                        \
                       --tty=true                       \
                       --interactive=true               \
                       --volume=${THIS_DIR}:${THIS_DIR} \
                       --workdir=${THIS_DIR}            \
                       --device=/dev/ttyUSB0            \
                       carlosgalvezp/stm32-dev"

# Compile
echo "Compiling..."
$DOCKER_RUN arm-none-eabi-g++ -c -mcpu=cortex-m3 -mthumb --std=c++14 -O2 -fno-rtti -fno-exceptions main.cpp -o main.o

# Link
echo "Linking..."
$DOCKER_RUN arm-none-eabi-g++ -mcpu=cortex-m3 -mthumb -Tstm32f103c8t6.ld -nostartfiles main.o -o main.elf

# Create bin
echo "Creating bin..."
$DOCKER_RUN arm-none-eabi-objcopy -O binary main.elf main.bin

# Write to flash
echo "Deploying..."
$DOCKER_RUN stm32flash -w main.bin /dev/ttyUSB0

# Run
$DOCKER_RUN stm32flash -g0 /dev/ttyUSB0
