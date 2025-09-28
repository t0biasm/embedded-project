#include "public_types.h"
#include "gpio.h"

uint16_t global_test = 2U;

void main(void) 
{
    // Main
    uint16_t i = 8U;
    i += global_test;

    // Test MCAL function call
    GPIO_writePin(20U, 1U);
}
