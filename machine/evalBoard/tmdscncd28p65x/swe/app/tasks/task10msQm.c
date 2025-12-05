#include "drvLedCtrl.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "task10msQm.h"
#include "semphr.h"

#define TASK10MSQM_CYCLE_TIME_MS           (100U)   // 100 milliseconds

StackType_t  task10msQmStack[STACK_SIZE_TASK10MSQM];
StaticTask_t task10msQmBuffer;

//-------------------------------------------------------------------------------------------------
void task10msQm(void * pvParameters)
{
    uint32_t counter = 0U;
    for(;;)
    {
        // if(xSemaphoreTake( xSemaphore, portMAX_DELAY ) == pdTRUE)
        // {
            counter++;
            drvLedCtrl_cyclic();
            vTaskDelay(TASK10MSQM_CYCLE_TIME_MS / portTICK_PERIOD_MS);
        // }
    }
}
