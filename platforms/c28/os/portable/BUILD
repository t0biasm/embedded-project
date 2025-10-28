cc_library(
    name = "free_rtos_c28x_portable",
    srcs = [
        "portasm.asm",
        "port.c",
    ],
    hdrs = [
        "portmacro.h",
    ],
    deps = [
        "//f28p65/mcal:mcal_f28p65x_h",
        "//platforms/c28/os/include:free_rtos_c28x_include",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//platforms/c28/os:__subpackages__"],
)
