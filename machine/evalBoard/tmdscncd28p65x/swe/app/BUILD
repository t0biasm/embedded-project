load("//platforms/c2000/toolchain:cc_binary_c2000.bzl", "cc_binary_c2000")

# Application specific FreeRTOS configuration
# Only allowed to be included within os/include
cc_library(
    name = "app_defines",
    hdrs = [
        "appDefines.h"
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)

cc_binary_c2000(
    name = "app",
    srcs = [
        "codestart.asm",
        "main.c",
    ],
    deps = [
        ":app_defines",
        "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x",
        "//machine/evalBoard/tmdscncd28p65x/public:public_types_h",
        "//machine/evalBoard/tmdscncd28p65x/swe/app/tasks:tasks",
        "//machine/evalBoard/tmdscncd28p65x/units:units_app",
    ],
    # Declare addation linker inputs - needed for linkopts
    additional_linker_inputs = [
        "//machine/evalBoard/tmdscncd28p65x/swe/linker:linker_cmd_app",
    ],
    # Linker options
    linkopts = [
        "--library=$(location //machine/evalBoard/tmdscncd28p65x/swe/linker:linker_cmd_app)",
    ],
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)

cc_binary_c2000(
    name = "app_c2000",
    srcs = [
        ":app",
    ],
)
