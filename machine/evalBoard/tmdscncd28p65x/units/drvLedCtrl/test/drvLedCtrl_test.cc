/**
 * @file sysHwCfg_init_test.cc
 * @author Tobias Maier (maier-tobias@gmx.de)
 * @brief Test module: System HW Configuration Initialization Code
 * @version 0.1
 * @date 2025-12-25
 *
 * @copyright Copyright (c) 2025
 *
 */

/* ---------------------------------------- Includes ---------------------------------------------*/
#if 1 /* Includes */
// Googletest setup
#include <gtest/gtest.h>
#include <gmock/gmock.h>
// SW unit header includes
#include "drvLedCtrl.h"
#include "gpio_mock.h"
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
// Class definition for test case setup and closure (entry/exit conditions)
class DrvLedCtrlTest : public ::testing::Test {
protected:
    Gpio gpio_mock; // Mock instance for the test
    
    /* -------------------------------------- Test Case Setup ------------------------------- */
    void SetUp() override {
        // Assign the global mock pointer to the test's mock
        gpio = &gpio_mock;
    }

    /* ------------------------------------- Test Case Closure ------------------------------ */
    void TearDown() override {
        // Reset the global mock pointer to avoid leaks between tests
        gpio = nullptr;
    }
};
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

/* ----------------------------------- Function Prototypes -------------------------------------- */
#if 1

#endif /* Function Prototypes */

/* ----------------------------------- Function Definitions ------------------------------------- */
#if 1
#if 1 /* Global functions */

#endif /* Global functions */

#if 1  /* External functions */

#endif /* External functions */

#if 1  /* File local (static) functions */
TEST_F(DrvLedCtrlTest, TogglesCorrectPin) {
    /* -------------------------------------- Preparation ----------------------------------- */

    /* -------------------------------------- Call SW Unit ---------------------------------- */
    EXPECT_CALL(gpio_mock, GPIO_togglePin(31U)).Times(1);

    /* -------------------------------------- Verification ---------------------------------- */    
    gfDrvLedCtrl_10ms();  // Your function that calls GPIO_togglePin(5)
}
#endif /* File local (static) functions */
#endif /* Function Definitions */
