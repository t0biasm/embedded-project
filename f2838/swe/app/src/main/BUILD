load("//toolchain:cc_binary_c2000.bzl", "cc_binary_c2000")

cc_library(
    name = "main",
    srcs = [
        "main.c",
    ],
    # linkopts = [
    #     "//f2838/swe/app/linker:linker_script",
    # ]
    # deps = [
    #     "//f2838/swe/app/linker:linker_script",
    # ]
    # target_compatible_with = [":c2000_f2838"]
)

cc_binary_c2000(
    name = "app",
    srcs = [
        "main.c",
    ],
    # linkopts = [
    #     "//f2838/swe/app/linker:linker_script",
    # ]
    deps = [
        ":main",
    ],
    output_name = "app",
    # target_compatible_with = [":c2000_f2838"]
)