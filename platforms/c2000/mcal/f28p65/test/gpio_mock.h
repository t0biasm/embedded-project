#ifndef GPIO_MOCK_H
#define GPIO_MOCK_H

#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <cstdint>

class Gpio {
public:
    MOCK_METHOD(void, GPIO_togglePin, (uint32_t pin));
};

// Global pointer for C code to access
extern Gpio* gpio = nullptr;

#ifdef __cplusplus
extern "C" {
#endif

void __wrap_GPIO_togglePin(uint32_t pin) {
    if (gpio) {
        gpio->GPIO_togglePin(pin);
    }
}

#ifdef __cplusplus
}
#endif

#endif
