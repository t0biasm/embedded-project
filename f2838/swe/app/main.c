#include "public_types.h"
#include "gpio.h"
#include "sysHwCfg_init.h"
#include "task10msQm.h"
#include "task.h"

uint16_t global_test = 2U;

void main(void) 
{
    // Main
    uint16_t i = 8U;
    i += global_test;

    // Setup and initialize MCU peripherals
    sysHwCfg_init();

    // // Create the task without using any dynamic memory allocation.
    // xTaskCreateStatic(task10msQm,           // Function that implements the task.
    //                   "10 ms QM Task",      // Text name for the task.
    //                   STACK_SIZE_TASK10MSQM,           // Number of indexes in the xStack array.
    //                   ( void * ) TASK10MSQM,       // Parameter passed into the task.
    //                   tskIDLE_PRIORITY + 1, // Priority at which the task is created.
    //                   redTaskStack,         // Array to use as the task's stack.
    //                   &redTaskBuffer );     // Variable to hold the task's data structure.
}
