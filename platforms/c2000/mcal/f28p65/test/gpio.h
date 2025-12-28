#ifndef GPIO_H
#define GPIO_H

#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

void GPIO_togglePin(uint32_t pin);

#ifdef __cplusplus
}
#endif

#endif
