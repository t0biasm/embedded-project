cc_library(
    name = "mcal_avr_h",
    srcs = glob(["avr/*.c"]),
    hdrs = glob(["avr/*.h"]),
    deps = [
        # "//platforms/c2000/toolchain:c2000_builtin_directories",
        "@googletest//:gtest",
        "@googletest//:gtest_main",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
