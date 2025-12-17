#include "appDefines.h"
#include "flash.h"
#include "gpio.h"
#include "public_types.h"
#include "sysHwCfg_init.h"
#include "task10msQm.h"
#include "task.h"

#define DEVICE_FLASH_WAITSTATES 3U

extern uint16_t RamfuncsRunStart;
extern uint16_t RamfuncsLoadStart;
extern uint16_t RamfuncsLoadSize;
extern uint16_t Cla1ProgRunStart;
extern uint16_t Cla1ProgLoadStart;
extern uint16_t Cla1ProgLoadSize;

//-------------------------------------------------------------------------------------------------
void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName)
{
    while (1);
}

void vApplicationTickHook(void)
{
    // GPIO_togglePin(DEVICE_GPIO_PIN_LED2);
}

//-------------------------------------------------------------------------------------------------
void main(void)
{
#ifdef _FLASH
    #ifndef CMDTOOL
    //
    // Copy time critical code and flash setup code to RAM. This includes the
    // following functions: InitFlash();
    //
    // The RamfuncsLoadStart, RamfuncsLoadSize, and RamfuncsRunStart symbols
    // are created by the linker. Refer to the device .cmd file.
    //
    memcpy(&RamfuncsRunStart, &RamfuncsLoadStart, (size_t)&RamfuncsLoadSize);
    #endif

    #ifdef _COPY_CLA_SECTIONS
    //
    // Copy time critical code and flash setup code to RAM.
    //
    (void)memcpy(&Cla1ProgRunStart, &Cla1ProgLoadStart, (size_t)&Cla1ProgLoadSize);
    #endif

    //
    // Call Flash Initialization to setup flash waitstates. This function must
    // reside in RAM.
    //
    Flash_initModule(FLASH0CTRL_BASE, FLASH0ECC_BASE, DEVICE_FLASH_WAITSTATES);
#endif

    /* ----------------------------------------- */

    // Setup and initialize MCU peripherals
    sysHwCfg_init();

    // Initialize common task setup - Semaphores, etc.
    tasksCmn_init();

    // Enable global Interrupts and higher priority real-time debug events:
    EINT;    // Enable Global interrupt INTM
    ERTM;    // Enable Global realtime interrupt DBGM

    // Create the task without using any dynamic memory allocation.
    xTaskCreateStatic(task10msQm,               // Function that implements the task.
                      "10 ms QM Task",          // Text name for the task.
                      STACK_SIZE_TASK10MSQM,    // Number of indexes in the xStack array.
                      (void*)TASK10MSQM,        // Parameter passed into the task.
                      tskIDLE_PRIORITY + 1,     // Priority at which the task is created.
                      task10msQmStack,          // Array to use as the task's stack.
                      &task10msQmBuffer);       // Variable to hold the task's data structure.

    vTaskStartScheduler();
}
