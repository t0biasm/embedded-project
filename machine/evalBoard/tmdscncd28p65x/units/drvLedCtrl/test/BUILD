cc_test(
    name = "drvLedCtrl_test",
    size = "small",
    srcs = [
        "drvLedCtrl_test.cc",
        "//machine/evalBoard/tmdscncd28p65x/units/drvLedCtrl/code:srcs",
        "//machine/evalBoard/tmdscncd28p65x/units/drvLedCtrl/code:hdrs",
    ],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//platforms/c2000/mcal/f28p65/test:mcal_f28p65x_h",
    ],
    includes = [
        "../code"
    ],
)
