load("//toolchain:cc_binary_c2000.bzl", "cc_binary_c2000")
load("//toolchain:c2000.bzl", "C2000_COMPILER_FLAGS", "C2000_LINKER_FLAGS_APP")
load("//toolchain:debug.bzl", "debug_rule")

# cc_library(
#     name = "main",
#     srcs = [
#         "main.c",
#     ],
#     # linkopts = [
#     #     "//f2838/swe/app/linker:linker_script",
#     # ]
#     # deps = [
#     #     "//f2838/swe/app/linker:linker_script",
#     # ]
#     # target_compatible_with = [":c2000_f2838"]
# )

# cc_binary_c2000(
#     name = "app",
#     srcs = [
#         "main.c",
#     ],
#     # linkopts = [
#     #     "//f2838/swe/app/linker:linker_script",
#     # ]
#     deps = [
#         ":main",
#         "//f2838/public:public_types_h"
#     ],
#     linker_files = "//f2838/swe/linker:linker_scripts_app",
#     linker_flags = C2000_LINKER_FLAGS_APP,
#     output_name = "app",
#     # target_compatible_with = [":c2000_f2838"]
# )

cc_binary(
    name = "app",
    srcs = [
        "main.c",
    ],
    deps = [
        "//f2838/mcal:mcal_f2838x",
        "//f2838/public:public_types_h",
    ],
    # Declare addation linker inputs - needed for linkopts
    additional_linker_inputs = [
        "//f2838/swe/linker:linker_cmd_app"
    ],
    # Linker options
    linkopts = [
        "--library=$(location //f2838/swe/linker:linker_cmd_app)",
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
