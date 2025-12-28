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
        "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x_h",
        "//os/freertos/include:free_rtos_c28x_include",
        "//platforms/c2000/toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//os/freertos:__subpackages__"],
)
