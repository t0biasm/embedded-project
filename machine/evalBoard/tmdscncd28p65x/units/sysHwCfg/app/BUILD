cc_library(
    name = "sysHwCfg_app",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x",
        "//machine/evalBoard/tmdscncd28p65x/public:public_types_h",
        "//machine/evalBoard/tmdscncd28p65x/swe/app:app_defines",
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x/units/sysHwCfg:__subpackages__"],
)