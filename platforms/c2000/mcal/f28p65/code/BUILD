cc_library(
    name = "mcal_f28p65x_h",
    srcs = glob(["*.h"]),
    deps = [
        "//platforms/c2000/mcal/f28p65/code/inc:mcal_f28p65x_inc_h",
        "//platforms/c2000/toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "mcal_f28p65x",
    srcs = glob(["*.c"]),
    deps = [
        ":mcal_f28p65x_h",
        "//platforms/c2000/toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
