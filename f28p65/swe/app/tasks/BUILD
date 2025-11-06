cc_library(
    name = "tasks",
    srcs = glob(["*.c"]),
    hdrs = glob(
        ["*.h"], 
        exclude = ["FreeRTOSConfig.h"],
    ),
    deps = [
        "//f28p65/public:public_types_h",
        "//f28p65/swe/app:app_defines",
        "//f28p65/units/drvLedCtrl",
        "//platforms/c28/os:free_rtos_c28x_app",
    ],
    includes = ["."],
    visibility = ["//f28p65/swe/app:__subpackages__"],
)

cc_library(
    name = "free_rtos_app_config",
    hdrs = [
        "FreeRTOSConfig.h"
    ],
    includes = ["."],
    visibility = ["//platforms/c28/os/include:__subpackages__"],
)
