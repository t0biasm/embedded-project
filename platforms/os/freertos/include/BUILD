cc_library(
    name = "free_rtos_c28x_include",
    hdrs = glob(["*.h"]),
    deps = [
        "//machine/evalBoard/tmdscncd28p65x/swe/app/tasks:free_rtos_app_config",
        "//toolchain/c28:c2000_builtin_directories",
    ],
    includes = ["."],
    visibility = ["//platforms/os/freertos:__subpackages__"],
)
