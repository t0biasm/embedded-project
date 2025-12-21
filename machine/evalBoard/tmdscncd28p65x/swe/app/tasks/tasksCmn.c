#include "appDefines.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "semphr.h"

#define STACK_SIZE_TASKIDLE (256U)

SemaphoreHandle_t        gTasks_Semaphore = NULL;
static StaticSemaphore_t gTasks_SemaphoreBuffer;

static StaticTask_t      gTasks_IdleTaskBuffer;
static StackType_t       gTasks_IdleTaskStack[STACK_SIZE_TASKIDLE];

interrupt void gfInterrupts_Timer1(void)
{
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    xSemaphoreGiveFromISR(gTasks_Semaphore, &xHigherPriorityTaskWoken);

    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

//-------------------------------------------------------------------------------------------------
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
