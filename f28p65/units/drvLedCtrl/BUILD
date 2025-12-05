cc_library(
    name = "drvLedCtrl",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        "//platforms/mcal/f28p65:mcal_f28p65x",
        "//f28p65/public:public_types_h",
        "//f28p65/units/sysHwCfg:sysHwCfg_app",
    ],
    includes = ["."],
    visibility = ["//f28p65:__subpackages__"],
)