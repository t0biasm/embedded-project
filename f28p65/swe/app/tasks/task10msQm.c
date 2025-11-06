#include "drvLedCtrl.h"
#include "task10msQm.h"

//-------------------------------------------------------------------------------------------------
void task10msQm(void * pvParameters)
{
    for(;;)
    {
        drvLedCtrl_cyclic();
    }
}
