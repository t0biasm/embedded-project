/**
 * @file tasksCmn.c
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Generic/Common code for tasks setup
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#if 1 /* Includes */
#include "appDefines.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "semphr.h"
#endif /* Includes */

/* ----------------------------------------- Defines ---------------------------------------------*/
#if 1  /* Defines */
#define STACK_SIZE_TASKIDLE (256U)
#endif /* Defines */

/* ------------------------------------ Type Definitions -----------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs and Classes*/

#endif /* Structs and Classes*/

#if 1  /* Unions */

#endif /* Unions */
#endif /* Type Definitions */

/* ---------------------------------- Variable Declarations --------------------------------------*/
#if 1
#if 1  /* Global Variables */
SemaphoreHandle_t gTasks_Semaphore = NULL;
#endif /* Global Variables */

#if 1  /* File local (static) variables */
static StaticSemaphore_t gTasks_SemaphoreBuffer;
static StaticTask_t      gTasks_IdleTaskBuffer;
static StackType_t       gTasks_IdleTaskStack[STACK_SIZE_TASKIDLE];
#endif /* File local (static) variables */
#endif /* Variable Declarations */

/* ----------------------------------- Function Prototypes ---------------------------------------*/
#if 1

#endif /* Function Prototypes */

/* ----------------------------------- Function Definitions --------------------------------------*/
#if 1
#if 1 /* Global functions */
/**
 * @brief Interrupt function executed when timer1 interrupt occures
 *
 * @return interrupt
 */
interrupt void gfInterrupts_Timer1(void)
{
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    xSemaphoreGiveFromISR(gTasks_Semaphore, &xHigherPriorityTaskWoken);

    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

/**
 * @brief Function for generic/common task initialization
 *
 */
void gfTasks_CmnInit(void)
{
    // Create Semaphore
    gTasks_Semaphore = xSemaphoreCreateBinaryStatic(&gTasks_SemaphoreBuffer);

    /* ------------- Setup timer module -------------- */
    Interrupt_register(INT_TIMER1, &gfInterrupts_Timer1);

    CPUTimer_setPeriod(CPUTIMER1_BASE, 0xFFFFFFFF);
    CPUTimer_setPreScaler(CPUTIMER1_BASE, 0);
    CPUTimer_stopTimer(CPUTIMER1_BASE);
    CPUTimer_reloadTimerCounter(CPUTIMER1_BASE);

    // Configure CPU Timer
    uint32_t temp, freq = DEVICE_SYSCLK_FREQ;

    //
    // Initialize timer period:
    //
    temp = ((freq / 1000000U) * 100000U);
    CPUTimer_setPeriod(CPUTIMER1_BASE, temp);

    //
    // Set pre-scale counter to divide by 1 (SYSCLKOUT):
    //
    CPUTimer_setPreScaler(CPUTIMER1_BASE, 0U);

    //
    // Initializes timer control register. The timer is stopped, reloaded,
    // free run disabled, and interrupt enabled.
    // Additionally, the free and soft bits are set
    //
    CPUTimer_stopTimer(CPUTIMER1_BASE);
    CPUTimer_reloadTimerCounter(CPUTIMER1_BASE);
    CPUTimer_setEmulationMode(CPUTIMER1_BASE, CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_enableInterrupt(CPUTIMER1_BASE);

    Interrupt_enable(INT_TIMER1);
    CPUTimer_startTimer(CPUTIMER1_BASE);
}

#endif /* Global functions */

#if 1  /* External functions */
// NOLINTBEGIN(readability-identifier-naming)
void vApplicationGetIdleTaskMemory(StaticTask_t**          ppxIdleTaskTCBBuffer,
                                   StackType_t**           ppxgTasks_IdleTaskStackBuffer,
                                   configSTACK_DEPTH_TYPE* pulgTasks_IdleTaskStackSize)
{
    *ppxIdleTaskTCBBuffer          = &gTasks_IdleTaskBuffer;
    *ppxgTasks_IdleTaskStackBuffer = gTasks_IdleTaskStack;
    *pulgTasks_IdleTaskStackSize   = STACK_SIZE_TASKIDLE;
}

// NOLINTEND(readability-identifier-naming)
#endif /* External functions */

#if 1  /* File local (static) functions */

#endif /* File local (static) functions */
#endif /* Function Definitions */
