cc_library(
    name = "free_rtos_c28x_app",
    srcs = glob(
        ["*.c"],
        exclude = ["heap_1.c"],
    ),
    deps = [
        "//platforms/os/freertos/include:free_rtos_c28x_include",
        "//platforms/os/freertos/c28:free_rtos_c28x_portable",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
