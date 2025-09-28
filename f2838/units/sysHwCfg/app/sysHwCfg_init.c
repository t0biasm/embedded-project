#include "sysctl.h"
#include "sysHwCfg_init.h"

void sysHwCfg_init(void)
{
    SysCtl_disableWatchdog();
}
