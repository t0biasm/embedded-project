/**
 * @file task10msQm.c
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Task 10 milliseconds QM
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#if 1 /* Includes */
#include "drvLedCtrl.h"
#include "FreeRTOS.h"
#include "tasksCmn.h"
#include "task10msQm.h"
#include "semphr.h"
#endif /* Includes */

/* ----------------------------------------- Defines ---------------------------------------------*/
#if 1 /* Defines */
/// 100 millisecond cycle time
#define TASK10MSQM_CYCLE_TIME_MS (100U)
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
#if 1  /* Global Variables */
StackType_t  gTasks_10msQmStack[STACK_SIZE_TASK10MSQM];
StaticTask_t gTasks_10msQmBuffer;
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
 * @brief 10 milliseconds QM Task
 *
 * @param pParameters
 */
void gfTasks_10msQm(void* pParameters)
{
    uint32 counter = 0U;
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

#endif /* Global functions */

#if 1  /* External functions */

#endif /* External functions */

#if 1  /* File local (static) functions */

#endif /* File local (static) functions */
#endif /* Function Definitions */
