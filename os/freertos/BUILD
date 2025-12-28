cc_library(
    name = "free_rtos_c28x_app",
    srcs = glob(
        ["*.c"],
        exclude = ["heap_1.c"],
    ),
    deps = [
        "//os/freertos/include:free_rtos_c28x_include",
        "//platforms/c2000/port/freertos:free_rtos_c28x_portable",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)
