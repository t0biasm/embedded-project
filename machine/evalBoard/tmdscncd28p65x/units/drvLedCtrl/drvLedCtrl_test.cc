#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "drvLedCtrl.h"
#include "gpio_mock.h"

class DrvLedCtrlTest : public ::testing::Test {
protected:
    Gpio gpio_mock; // Mock instance for the test
 
    void SetUp() override {
        // Assign the global mock pointer to the test's mock
        gpio = &gpio_mock;
    }
 
    void TearDown() override {
        // Reset the global mock pointer to avoid leaks between tests
        gpio = nullptr;
    }
};

TEST_F(DrvLedCtrlTest, TogglesCorrectPin) {   
    // Expect GPIO_togglePin to be called with pin 5
    EXPECT_CALL(gpio_mock, GPIO_togglePin(31U)).Times(1);
    
    gfDrvLedCtrl_10ms();  // Your function that calls GPIO_togglePin(5)
}
