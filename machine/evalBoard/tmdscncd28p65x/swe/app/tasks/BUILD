cc_library(
    name = "tasks",
    srcs = glob(["*.c"]),
    hdrs = glob(
        ["*.h"], 
        exclude = ["FreeRTOSConfig.h"],
    ),
    deps = [
        "//machine/evalBoard/tmdscncd28p65x/public:public_types_h",
        "//machine/evalBoard/tmdscncd28p65x/swe/app:app_defines",
        "//machine/evalBoard/tmdscncd28p65x/units/drvLedCtrl",
        "//platforms/os/freertos:free_rtos_c28x_app",
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x/swe/app:__subpackages__"],
)

cc_library(
    name = "free_rtos_app_config",
    hdrs = [
        "FreeRTOSConfig.h"
    ],
    includes = ["."],
    visibility = ["//platforms/os/freertos/include:__subpackages__"],
)
