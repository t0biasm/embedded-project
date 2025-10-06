#include "public_types.h"
#include "gpio.h"
#include "sysHwCfg_init.h"
#include "task10msQm.h"
#include "task.h"

extern uint16 RamfuncsRunStart;
extern uint16 RamfuncsLoadStart;
extern uint16 RamfuncsLoadSize;
extern uint16 Cla1funcsRunStart;
extern uint16 Cla1funcsLoadStart;
extern uint16 Cla1funcsLoadSize;

//-------------------------------------------------------------------------------------------------
void vApplicationStackOverflowHook( TaskHandle_t xTask, char *pcTaskName )
{
    while(1);
}

void main(void) 
{
    /*** Initialize the .hwi_vec section ***/
    asm(" EALLOW"); /* Enable EALLOW protected register access */
    (void)memcpy(&RamfuncsRunStart, &RamfuncsLoadStart, (size_t)&RamfuncsLoadSize);
    (void)memcpy(&Cla1funcsRunStart, &Cla1funcsLoadStart, (size_t)&Cla1funcsLoadSize);
    asm(" EDIS"); /* Disable EALLOW protected register access */

    // Setup and initialize MCU peripherals
    sysHwCfg_init();

    // Create the task without using any dynamic memory allocation.
    xTaskCreateStatic(task10msQm,           // Function that implements the task.
                      "10 ms QM Task",      // Text name for the task.
                      STACK_SIZE_TASK10MSQM,           // Number of indexes in the xStack array.
                      ( void * ) TASK10MSQM,       // Parameter passed into the task.
                      tskIDLE_PRIORITY + 1, // Priority at which the task is created.
                      redTaskStack,         // Array to use as the task's stack.
                      &redTaskBuffer );     // Variable to hold the task's data structure.
}
