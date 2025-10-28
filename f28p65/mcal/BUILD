cc_library(
    name = "mcal_f28p65x_h",
    srcs = glob(["*.h"]),
    deps = [
        "//f28p65/mcal/inc:mcal_f28p65x_inc_h",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "mcal_f28p65x",
    srcs = glob(["*.c"]),
    deps = [
        ":mcal_f28p65x_h",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
