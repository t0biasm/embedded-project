#include "FreeRTOS.h"
#include "public_types.h"

#define STACK_SIZE_TASK10MSQM (256U)
#define TASK10MSQM            0xDEADBEAF

extern StackType_t  gTasks_10msQmStack[STACK_SIZE_TASK10MSQM];
extern StaticTask_t gTasks_10msQmBuffer;

//-------------------------------------------------------------------------------------------------
extern void gfTasks_10msQm(void* pParameters);
