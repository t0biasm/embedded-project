cc_library(
    name = "sysHwCfg_init",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        # "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x",
        # "//machine/evalBoard/tmdscncd28p65x/public:public_types_h",
        # "//machine/evalBoard/tmdscncd28p65x/swe/app:app_defines",
    ],
    includes = ["."],
    visibility = ["//machine/sumobotBlackMagic:__subpackages__"],
)

cc_test(
    name = "sysHwCfg_init_test",
    size = "small",
    srcs = [
        "sysHwCfg_init.c",
        "sysHwCfg_init_test.cc",
        "sysHwCfg_init.h",
    ],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//platforms/avr8/mcal/test:mcal_avr_h",
    ],
    linkopts = [
        # "-Wl,--wrap=GPIO_togglePin",
    ]
)
