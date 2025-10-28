#include "task10msQm.h"

//-------------------------------------------------------------------------------------------------
void task10msQm(void * pvParameters)
{
    for(;;)
    {
        vTaskDelay(250 / portTICK_PERIOD_MS);
    }
}
