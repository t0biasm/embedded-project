/**
 * @file main.c
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Main entrance for TMDSCNCD28P65X PCB SW
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#if 1 /* Includes */
#include "appDefines.h"
#include "flash.h"
#include "gpio.h"
#include "public_types.h"
#include "sysHwCfg_init.h"
#include "task10msQm.h"
#include "tasksCmn.h"
#include "task.h"
#endif /* Includes */

/* ----------------------------------------- Defines ---------------------------------------------*/
#if 1  /* Defines */
#define DEVICE_FLASH_WAITSTATES 3U
#endif /* Defines */

/* ------------------------------------ Type Definitions -----------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs */

#endif /* Structs */

#if 1  /* Unions */

#endif /* Unions */
#endif /* Type Definitions */

/* ---------------------------------- Variable Declarations --------------------------------------*/
#if 1
#if 1 /* Global Variables */
extern uint16 gRamfuncsRunStart;
extern uint16 gRamfuncsLoadStart;
extern uint16 gRamfuncsLoadSize;
extern uint16 gCla1ProgRunStart;
extern uint16 gCla1ProgLoadStart;
extern uint16 gCla1ProgLoadSize;
#endif /* Global Variables */

#if 1  /* File local (static) variables */

#endif /* File local (static) variables */
#endif /* Variable Declarations */

/* ----------------------------------- Function Prototypes ---------------------------------------*/
#if 1

#endif /* Function Prototypes */

/* ----------------------------------- Function Definitions --------------------------------------*/
#if 1
#if 1 /* Global functions */

/**
 * @brief Main function of whole Software
 *
 * @return int
 */
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

#endif /* Global functions */

#if 1  /* External functions */
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
#endif /* External functions */

#if 1  /* File local (static) functions */

#endif /* File local (static) functions */
#endif /* Function Definitions */
