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
        "//platforms/mcal/f28p65:mcal_f28p65x_h",
        "//platforms/os/freertos/include:free_rtos_c28x_include",
        "//toolchain/c28:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//platforms/os/freertos:__subpackages__"],
)
