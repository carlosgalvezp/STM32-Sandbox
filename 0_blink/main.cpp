#include "minsys.h"

void delay()
{
    // Number of iterations to loop one second
    const int clk_f = 8000000;  // 8 MHz internal clock
    const int cycles_per_loop = 3;
    const int n_iterations = (clk_f / cycles_per_loop);

    int n_iterations_final = n_iterations/5;
    while (n_iterations_final)
    {
        asm ("");
        --n_iterations_final;
    }
}

void mainFn()
{
    // Enable clock for GPIO Port C
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

    // Set PC13 as output
    GPIOC->CRH = 0b0100'0100'0011'0100'0100'0100'0100'0100;
    GPIOC->BRR = 1 << 13;

    // Loop
    while (1)
    {
        GPIOC->BRR = 1 << 13;
        delay();
        GPIOC->BSRR = 1 << 13;
        delay();
    }
}

// Vector table
extern void (* const vectors[])() __attribute__ ((section(".vectors"))) =
{
    (void (*)())0x20000400,
    mainFn,
};
