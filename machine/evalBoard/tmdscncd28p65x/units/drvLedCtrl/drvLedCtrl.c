#include "gpio.h"
#include "sysHwCfg_init.h"

//*****************************************************************************
//
// Function to disable pin locks on GPIOs.
//
//*****************************************************************************
void gfDrvLedCtrl_10ms(void)
{
    // Toggle LED
    //
    GPIO_togglePin(DEVICE_GPIO_PIN_LED1);
}
