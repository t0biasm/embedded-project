cc_library(
    name = "mcal_f2838x_h",
    srcs = glob(["*.h"]),
    deps = [
        "//f2838/mcal/inc:mcal_f2838x_inc_h",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "mcal_f2838x",
    srcs = glob(["*.c"]),
    deps = [
        ":mcal_f2838x_h",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)