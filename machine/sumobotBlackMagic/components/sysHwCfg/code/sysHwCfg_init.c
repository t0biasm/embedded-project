/**
 * @file sysHwCfg_init.c
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief System HW Configuration Initialization Code
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#if 1  /* Includes */
#include "sysHwCfg_init.h"
#include <avr/io.h>
#endif /* Includes */

/* ----------------------------------------- Defines ---------------------------------------------*/
#if 1  /* Defines */

#endif /* Defines */

/* ------------------------------------ Type Definitions -----------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs and Classes*/

#endif /* Structs and Classes*/

#if 1  /* Unions */

#endif /* Unions */
#endif /* Type Definitions */

/* ---------------------------------- Variable Declarations --------------------------------------*/
#if 1
#if 1  /* Global Variables */

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
 * @brief Function to initialize system peripherals
 *
 */
void gfSysHwCfg_Init(void)
{
    // Set PC7 (pin 13 on Leonardo) as output
    DDRC |= (1 << DDC7);
}
#endif /* Global functions */

#if 1  /* External functions */

#endif /* External functions */

#if 1  /* File local (static) functions */

#endif /* File local (static) functions */
#endif /* Function Definitions */
