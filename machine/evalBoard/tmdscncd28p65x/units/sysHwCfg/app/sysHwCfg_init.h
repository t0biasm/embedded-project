#include "public_types.h"

//
// GPIO configuration
//
#define DEVICE_GPIO_PIN_LED1 31U               // GPIO number for LED1
#define DEVICE_GPIO_PIN_LED2 34U               // GPIO number for LED2
#define DEVICE_GPIO_CFG_LED1 GPIO_31_GPIO31    // "pinConfig" for LED1
#define DEVICE_GPIO_CFG_LED2 GPIO_34_GPIO34    // "pinConfig" for LED2

extern void gfSysHwCfg_Init(void);
