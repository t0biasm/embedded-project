cc_test(
    name = "sysHwCfg_init_test",
    size = "small",
    srcs = [
        "sysHwCfg_init_test.cc",
        "//machine/sumobotBlackMagic/components/sysHwCfg/code:sources",
        "//machine/sumobotBlackMagic/components/sysHwCfg/code:headers",
    ],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "//platforms/avr8/mcal/test:mcal_avr_h",
    ],
    includes = [
        "../code",
    ],
)
