cc_library(
    name = "drvLedCtrl",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        "//platforms/c2000/mcal/f28p65:mcal_f28p65x",
        "//machine/evalBoard/tmdscncd28p65x/public:public_types_h",
        "//machine/evalBoard/tmdscncd28p65x/units/sysHwCfg:sysHwCfg_app",
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)