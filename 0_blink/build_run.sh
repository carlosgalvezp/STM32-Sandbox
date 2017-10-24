#!/bin/bash
# Compile
arm-none-eabi-g++ -c -mcpu=cortex-m3 -mthumb --std=c++14 -O2 -fno-rtti -fno-exceptions main.cpp -o main.o

# Link
arm-none-eabi-g++ -mcpu=cortex-m3 -mthumb -Tstm32f103c8t6.ld -nostartfiles main.o -o main.elf

# Create bin
arm-none-eabi-objcopy -O binary main.elf main.bin

# Write to flash
stm32flash -w main.bin /dev/ttyUSB0

# Run
stm32flash -g0 /dev/ttyUSB0
