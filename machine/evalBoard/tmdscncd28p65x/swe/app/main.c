#include "appDefines.h"
#include "flash.h"
#include "gpio.h"
#include "public_types.h"
#include "sysHwCfg_init.h"
#include "task10msQm.h"
#include "task.h"

#define DEVICE_FLASH_WAITSTATES 3U

extern uint16_t gRamfuncsRunStart;
extern uint16_t gRamfuncsLoadStart;
extern uint16_t gRamfuncsLoadSize;
extern uint16_t gCla1ProgRunStart;
extern uint16_t gCla1ProgLoadStart;
extern uint16_t gCla1ProgLoadSize;

//-------------------------------------------------------------------------------------------------
// NOLINTBEGIN(readability-identifier-naming)
void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName)
{
    while (1);
}

void vApplicationTickHook(void)
{
    ;
}

// NOLINTEND(readability-identifier-naming)

//-------------------------------------------------------------------------------------------------
void main(void)
{
#ifdef _FLASH
#ifndef CMDTOOL
    //
    // Copy time critical code and flash setup code to RAM. This includes the
    // following functions: InitFlash();
    //
    // The gRamfuncsLoadStart, gRamfuncsLoadSize, and gRamfuncsRunStart symbols
    // are created by the linker. Refer to the device .cmd file.
    //
    memcpy(&gRamfuncsRunStart, &gRamfuncsLoadStart, (size_t)&gRamfuncsLoadSize);
#endif

#ifdef _COPY_CLA_SECTIONS
    //
    // Copy time critical code and flash setup code to RAM.
    //
    (void)memcpy(&gCla1ProgRunStart, &gCla1ProgLoadStart, (size_t)&gCla1ProgLoadSize);
#endif

    //
    // Call Flash Initialization to setup flash waitstates. This function must
    // reside in RAM.
    //
    Flash_initModule(FLASH0CTRL_BASE, FLASH0ECC_BASE, DEVICE_FLASH_WAITSTATES);
#endif

    /* ----------------------------------------- */

    // Setup and initialize MCU peripherals
    gfSysHwCfg_Init();

    // Initialize common task setup - Semaphores, etc.
    gfTasks_CmnInit();

    // Enable global Interrupts and higher priority real-time debug events:
    EINT;    // Enable Global interrupt INTM
    ERTM;    // Enable Global realtime interrupt DBGM

    // Create the task without using any dynamic memory allocation.
    xTaskCreateStatic(gfTasks_10msQm,           // Function that implements the task.
                      "10 ms QM Task",          // Text name for the task.
                      STACK_SIZE_TASK10MSQM,    // Number of indexes in the xStack array.
                      (void*)TASK10MSQM,        // Parameter passed into the task.
                      tskIDLE_PRIORITY + 1,     // Priority at which the task is created.
                      gTasks_10msQmStack,       // Array to use as the task's stack.
                      &gTasks_10msQmBuffer);    // Variable to hold the task's data structure.

    vTaskStartScheduler();
}
