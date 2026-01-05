/**
 * @file gpio.h
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief API informations for C2000 general purpose input/output test module
 * @version 0.1
 * @date 2026-01-05
 *
 * @copyright Copyright (c) 2026
 *
 */

#ifndef GPIO_H
#define GPIO_H

/* ---------------------------------------- Includes --------------------------------------------*/
#if 1 /* Includes */
#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <cstdint>
#endif /* Includes */

/* ----------------------------------------- Defines --------------------------------------------*/
#if 1  /* Defines */

#endif /* Defines */

/* --------------------------------- Global Type Definitions ------------------------------------*/
#if 1
#if 1  /* Enumerations */

#endif /* Enumerations */

#if 1  /* Typedefs */

#endif /* Typedefs */

#if 1  /* Structs and Classes*/
class Gpio
{
public:
    MOCK_METHOD(void, GPIO_togglePin, uint32_t pin);
};
#endif /* Structs and Classes*/

#if 1  /* Unions */

#endif /* Unions */
#endif /* Global Type Definitions */

/* ------------------------------ Global Variable Declarations ----------------------------------*/
#if 1  /* Global Variable Declarations */
extern Gpio* gpio_m;
#endif /* Global Variable Declarations */

/* ----------------------------------- Function Prototypes ------------------------------------- */
#if 1 /* Global Function Prototypes */
#ifdef __cplusplus
extern "C"
{
#endif
    extern void GPIO_togglePin(uint32_t pin);
#ifdef __cplusplus
}
#endif
#endif /* Global Function Prototypes */

#if 1  /* External Function Prototypes */

#endif /* External Function Prototypes */

#endif /* GPIO_H */
