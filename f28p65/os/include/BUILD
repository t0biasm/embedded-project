cc_library(
    name = "free_rtos_c28x_include",
    hdrs = glob(["*.h"]),
    deps = [
        "//f28p65/swe/app:free_rtos_app_config",
        "//toolchain:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//f28p65/os:__subpackages__"],
)
