#include "appDefines.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "semphr.h"

#define STACK_SIZE_TASKIDLE (256U)

SemaphoreHandle_t        xSemaphore = NULL;
static StaticSemaphore_t xSemaphoreBuffer;

static StaticTask_t      idleTaskBuffer;
static StackType_t       idleTaskStack[STACK_SIZE_TASKIDLE];

interrupt void timer1_ISR(void)
{
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    xSemaphoreGiveFromISR(xSemaphore, &xHigherPriorityTaskWoken);

    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

//-------------------------------------------------------------------------------------------------
void vApplicationGetIdleTaskMemory(StaticTask_t**          ppxIdleTaskTCBBuffer,
                                   StackType_t**           ppxIdleTaskStackBuffer,
                                   configSTACK_DEPTH_TYPE* pulIdleTaskStackSize)
{
    *ppxIdleTaskTCBBuffer   = &idleTaskBuffer;
    *ppxIdleTaskStackBuffer = idleTaskStack;
    *pulIdleTaskStackSize   = STACK_SIZE_TASKIDLE;
}

void tasksCmn_init(void)
{
    // Create Semaphore
    xSemaphore = xSemaphoreCreateBinaryStatic(&xSemaphoreBuffer);

    /* ------------- Setup timer module -------------- */
    Interrupt_register(INT_TIMER1, &timer1_ISR);

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
