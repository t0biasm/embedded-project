#include "FreeRTOS.h"
#include "public_types.h"

#define STACK_SIZE_TASK10MSQM   (256U)
#define TASK10MSQM              0xDEADBEAF

static StackType_t  redTaskStack[STACK_SIZE_TASK10MSQM];
static StaticTask_t redTaskBuffer;

//-------------------------------------------------------------------------------------------------
extern void task10msQm(void * pvParameters);
