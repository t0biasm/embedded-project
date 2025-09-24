#include "public_types.h"
#include "gpio.h"

void main(void) 
{
    // Main
    uint16_t i = 8U;
    i += 1;

    // Test MCAL function call
    GPIO_writePin(20U, 1U);
}
