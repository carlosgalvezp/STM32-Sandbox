# STM32-Sandbox

This repository is intended to serve as a central place to compile
information about programming STM32 chips.

## STM documentation

- [PM0056 STM32F10xxx Cortex-M3 programming manual](http://www.st.com/content/ccc/resource/technical/document/programming_manual/5b/ca/8d/83/56/7f/40/08/CD00228163.pdf/files/CD00228163.pdf/jcr:content/translations/en.CD00228163.pdf)
- [DS5319 - STM32F103x8 datasheet](http://www.st.com/content/ccc/resource/technical/document/datasheet/33/d4/6f/1d/df/0b/4c/6d/CD00161566.pdf/files/CD00161566.pdf/jcr:content/translations/en.CD00161566.pdf)
- [AN2606 - STM32 microcontroller system memory boot mode](http://www.st.com/content/ccc/resource/technical/document/application_note/b9/9b/16/3a/12/1e/40/0c/CD00167594.pdf/files/CD00167594.pdf/jcr:content/translations/en.CD00167594.pdf)
- [RM0008 STM32F10x reference manual](http://www.st.com/content/ccc/resource/technical/document/reference_manual/59/b9/ba/7f/11/af/43/d5/CD00171190.pdf/files/CD00171190.pdf/jcr:content/translations/en.CD00171190.pdf)
- [PM0075 - STM32F10xxx Flash mememory programming manual](http://www.st.com/content/ccc/resource/technical/document/programming_manual/10/98/e8/d4/2b/51/4b/f5/CD00283419.pdf/files/CD00283419.pdf/jcr:content/translations/en.CD00283419.pdf)

## Other resources
- [STM32 book](https://www.cs.indiana.edu/~geobrown/book.pdf)
- [STM32 from scratch](https://tty.uchuujin.de/2016/02/stm32-from-scratch-bare-minimals/)

## Definitions

- CMSIS - Cortext Micro-controller Software Interface Standard. Just a collection
of header files defining the registers available in the chip.
- StdPeriph_Driver - set of C libraries to interact with each of the modules

## Clock System

- Two external sources of clock: HSE (8 MHz) and LSE (32.768 kHz).
- PLL multiples HSE to get SYSCLK.
- SYSCLK is then divided to provide clock to different modules.
- LSE used for low-power real-time clock.

## Peripherals

- All peripherals are "memory-mapped", so the core interacts with the peripheral
hardware by reading and writing to registers.
- Base addresses defined in `stm32f10x.h`, part of CMSIS.

## Memory Model

- Flash memory (only writtable by bootloader), starting at 0x0800 0000.
  Contains machine code.
  First portion contains a vector table of pointers to different exception handlers.
- SRAM (read/write), starting at 0x2000 0000.
  Contains mutable state (variables and run-time stack).

The memory layout is defined in the **linker script**.

### Relevant memory sections:

- `.text`: always placed in Flash
- `.data`: always placed in SRAM. Initialized by **startup code**.
- `.bss`: always place in SRAM

Linker script in charge of defining memory regions, that the startup code
can later refer to.

## Boot sequence

At reset, the `ResetHandler` is called. It's defined in `startup_stm32f10x.c`:

  - Copies initial values for variables from Flash to RAM
  - Zeroes the uninitialized data portion on RAM

After that, it calls the `SystemInit` handler, defined in `system_stm32f10x.c`,
which initializes the clocking system, disables and clears interrupts.

Finally, the reset handler calls `main`.

## Software resources

- CMSIS library: https://github.com/ARM-software/CMSIS
  - `CMSIS/include/core_cm3.h`

- System and startup files:


