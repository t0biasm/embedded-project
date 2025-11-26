#include "drvLedCtrl.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "task10msQm.h"
#include "semphr.h"

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
            vTaskDelay(1U / portTICK_PERIOD_MS);
        // }
    }
}
