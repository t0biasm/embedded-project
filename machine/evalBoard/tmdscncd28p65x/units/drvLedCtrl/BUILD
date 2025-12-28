cc_library(
    name = "drvLedCtrl",
    srcs = glob(["*.c"]),
    hdrs = glob(["*.h"]),
    deps = [
        "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x",
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)

cc_test(
    name = "drvLedCtrl_test",
    size = "small",
    srcs = [
        "drvLedCtrl.c",
        "drvLedCtrl_test.cc",
        "drvLedCtrl.h",
    ],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//platforms/c2000/mcal/f28p65/test:mcal_f28p65x_h",
    ],
    linkopts = [
        "-Wl,--wrap=GPIO_togglePin",
    ]
)
