/**
 * @file task10msQm.h
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Task 10 milliseconds QM
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

#ifndef TASK10MSQM_H
#define TASK10MSQM_H

/* ---------------------------------------- Includes --------------------------------------------*/
#if 1 /* Includes */
#include "platform_types.h"
#include "FreeRTOS.h"
#include "public_types.h"
#endif /* Includes */

/* ----------------------------------------- Defines --------------------------------------------*/
#if 1  /* Defines */
#define STACK_SIZE_TASK10MSQM (256U)
#define TASK10MSQM            0xDEADBEAF
#endif /* Defines */

/* --------------------------------- Global Type Definitions ------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs and Classes*/

#endif /* Structs and Classes*/

#if 1  /* Unions */

#endif /* Unions */
#endif /* Global Type Definitions */

/* ------------------------------ Global Variable Declarations ----------------------------------*/
#if 1
extern StackType_t  gTasks_10msQmStack[STACK_SIZE_TASK10MSQM];
extern StaticTask_t gTasks_10msQmBuffer;
#endif /* Global Variable Declarations */

/* ----------------------------------- Function Prototypes ------------------------------------- */
#if 1  /* Global Function Prototypes */
extern void gfTasks_10msQm(void* pParameters);
#endif /* Global Function Prototypes */

#if 1  /* External Function Prototypes */

#endif /* External Function Prototypes */

#endif /* TASK10MSQM_H */
