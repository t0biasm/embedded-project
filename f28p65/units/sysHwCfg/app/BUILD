cc_library(
    name = "sysHwCfg_app",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        "//f28p65/mcal:mcal_f28p65x",
        "//f28p65/public:public_types_h",
        "//f28p65/swe/app:app_defines",
    ],
    includes = ["."],
    visibility = ["//f28p65/units/sysHwCfg:__subpackages__"],
)