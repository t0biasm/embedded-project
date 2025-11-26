#include "FreeRTOS.h"
#include "public_types.h"

#define STACK_SIZE_TASK10MSQM   (256U)
#define TASK10MSQM              0xDEADBEAF

extern StackType_t  task10msQmStack[STACK_SIZE_TASK10MSQM];
extern StaticTask_t task10msQmBuffer;

//-------------------------------------------------------------------------------------------------
extern void task10msQm(void * pvParameters);
