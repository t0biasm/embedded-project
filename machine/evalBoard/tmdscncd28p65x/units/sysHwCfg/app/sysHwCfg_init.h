/**
 * @file sysHwCfg_init.h
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief External data of LED control driver component
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

#ifndef SYSHWCFG_INIT_H
#define SYSHWCFG_INIT_H

/* ---------------------------------------- Includes --------------------------------------------*/
#if 1  /* Includes */
#include "public_types.h"
#endif /* Includes */

/* ----------------------------------------- Defines --------------------------------------------*/
#if 1 /* Defines */
/// GPIO number for LED1
#define DEVICE_GPIO_PIN_LED1 31U
/// GPIO number for LED2
#define DEVICE_GPIO_PIN_LED2 34U
/// "pinConfig" for LED1
#define DEVICE_GPIO_CFG_LED1 GPIO_31_GPIO31
/// "pinConfig" for LED2
#define DEVICE_GPIO_CFG_LED2 GPIO_34_GPIO34
#endif /* Defines */

/* --------------------------------- Global Type Definitions ------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs */

#endif /* Structs */

#if 1  /* Unions */

#endif /* Unions */
#endif /* Global Type Definitions */

/* ------------------------------ Global Variable Declarations ----------------------------------*/
#if 1

#endif /* Global Variable Declarations */

/* ----------------------------------- Function Prototypes ------------------------------------- */
#if 1  /* Global Function Prototypes */
extern void gfSysHwCfg_Init(void);
#endif /* Global Function Prototypes */

#if 1  /* External Function Prototypes */

#endif /* External Function Prototypes */

#endif /* SYSHWCFG_INIT_H */
