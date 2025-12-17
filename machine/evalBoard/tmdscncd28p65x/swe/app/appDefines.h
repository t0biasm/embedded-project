#define _COPY_CLA_SECTIONS
#define _FLASH

//
// 20MHz XTAL on controlCARD. For use with SysCtl_getClock() and
// SysCtl_getAuxClock().
//
#define DEVICE_OSCSRC_FREQ 20000000U
//
// 200MHz SYSCLK frequency based on the above DEVICE_SETCLOCK_CFG. Update the
// code below if a different clock configuration is used!
//
#define DEVICE_SYSCLK_FREQ ((DEVICE_OSCSRC_FREQ * 40) / (2 * 2 * 1))
//
// Define to pass to SysCtl_setAuxClock(). Will configure the clock as follows:
// AUXPLLCLK = 20MHz (XTAL_OSC) * 50 (IMULT) / (2 (REFDIV) * 4 (ODIV) * 1(AUXPLLDIV) )
//
#define DEVICE_AUXSETCLOCK_CFG   \
    (SYSCTL_AUXPLL_OSCSRC_XTAL | \
     SYSCTL_AUXPLL_IMULT(50) |   \
     SYSCTL_REFDIV(2U) |         \
     SYSCTL_ODIV(4U) |           \
     SYSCTL_AUXPLL_DIV_1 |       \
     SYSCTL_AUXPLL_ENABLE |      \
     SYSCTL_DCC_BASE_0)
