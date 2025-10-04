load("//toolchain:cc_binary_c2000.bzl", "cc_binary_c2000")
load("//toolchain:debug.bzl", "debug_rule")

# Application specific FreeRTOS configuration
# Only allowed to be included within os/include
cc_library(
    name = "free_rtos_app_config",
    hdrs = [
        "FreeRTOSConfig.h"
    ],
    includes = ["."],
    visibility = ["//f2838/os/include:__subpackages__"],
)

cc_binary_c2000(
    name = "app",
    srcs = [
        "main.c",
    ],
    deps = [
        "//f2838/mcal:mcal_f2838x",
        "//f2838/public:public_types_h",
        "//f2838/swe/app/tasks:task10msQm",
        "//f2838/units:units_app",
    ],
    # Declare addation linker inputs - needed for linkopts
    additional_linker_inputs = [
        "//f2838/swe/linker:linker_cmd_app",
    ],
    # Linker options
    linkopts = [
        "--library=$(location //f2838/swe/linker:linker_cmd_app)",
    ],
)

cc_binary_c2000(
    name = "app_c2000",
    srcs = [
        ":app",
    ],
)

# cc_binary_c2000(
#     name = "app",
#     srcs = [
#         "main.c",
#     ],
#     deps = [
#         "//f2838/public:public_types_h"
#     ],
#     # linker_files = "//f2838/swe/linker:linker_scripts_app",
#     # linker_flags = C2000_LINKER_FLAGS_APP,
#     # output_name = "app",
#     # target_compatible_with = [":c2000_f2838"]
# )

debug_rule(
    name = "check_libraries",
    dep = ":app",
)
