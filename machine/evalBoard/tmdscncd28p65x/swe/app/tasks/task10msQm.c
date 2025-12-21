#include "drvLedCtrl.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "task10msQm.h"
#include "semphr.h"

#define TASK10MSQM_CYCLE_TIME_MS (100U)    // 100 milliseconds

StackType_t  gTasks_10msQmStack[STACK_SIZE_TASK10MSQM];
StaticTask_t gTasks_10msQmBuffer;

//-------------------------------------------------------------------------------------------------
void gfTasks_10msQm(void* pParameters)
{
    uint32_t counter = 0U;
    for (;;)
    {
        // if(gTasks_SemaphoreTake( gTasks_Semaphore, portMAX_DELAY ) == pdTRUE)
        // {
        counter++;
        gfDrvLedCtrl_10ms();
        vTaskDelay(TASK10MSQM_CYCLE_TIME_MS / portTICK_PERIOD_MS);
        // }
    }
}
