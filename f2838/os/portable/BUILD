cc_library(
    name = "free_rtos_c28x_portable",
    srcs = [
        "portasm.asm",
        "port.c",
    ],
    hdrs = [
        "portmacro.h"
    ],
    deps = [
        "//f2838/mcal:mcal_f2838x_h",
        "//f2838/os/include:free_rtos_c28x_include",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//f2838:__subpackages__"],
)
