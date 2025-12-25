/**
 * @file main.c
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Main entrance for Arduino Leonardo PCB SW
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#pragma region
#include <avr/io.h>
#include <util/delay.h>
#pragma endregion /* Includes */

/* ----------------------------------------- Defines ---------------------------------------------*/
#pragma region

#pragma endregion /* Defines */

/* ------------------------------------ Type Definitions -----------------------------------------*/
#pragma region
#pragma region    /* Enumerations */

#pragma endregion /* Enumerations */

#pragma region    /* Typedefs */

#pragma endregion /* Typedefs */

#pragma region    /* Structs */

#pragma endregion /* Structs */

#pragma region    /* Unions */

#pragma endregion /* Unions */
#pragma endregion /* Type Definitions */

/* ---------------------------------- Variable Declarations --------------------------------------*/
#pragma region
#pragma region    /* Global Variables */

#pragma endregion /* Global Variables */

#pragma region    /* File local (static) variables */

#pragma endregion /* File local (static) variables */
#pragma endregion /* Variable Declarations */

/* ----------------------------------- Function Prototypes ---------------------------------------*/
#pragma region

#pragma endregion /* Function Prototypes */

/* ----------------------------------- Function Definitions --------------------------------------*/
#pragma region
#pragma region /* Global functions */

/**
 * @brief Main function of whole Software
 *
 * @return int
 */
int main(void)
{
    // Set PC7 (pin 13 on Leonardo) as output
    DDRC |= (1 << DDC7);

    while (1)
    {
        // Toggle LED
        PORTC ^= (1 << PORTC7);

        // Wait 500ms
        _delay_ms(1000);
    }

    return 0;
}

#pragma endregion /* Global functions */

#pragma region    /* External functions */

#pragma endregion /* External functions */

#pragma region    /* File local (static) functions */

#pragma endregion /* File local (static) functions */
#pragma endregion /* Function Prototypes */
