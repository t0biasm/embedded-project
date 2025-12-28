load(":cc_toolchain_config_gcc.bzl", "cc_toolchain_config_gcc")

platform(
    name = "gcc_windows",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    visibility = ["//visibility:public"],
)

filegroup(name = "empty")

cc_toolchain_config_gcc(
    name = "gcc_toolchain_config",
)

cc_toolchain(
    name = "gcc_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    toolchain_config = ":gcc_toolchain_config",
    toolchain_identifier = "gcc-toolchain",
)

toolchain(
    name = "gcc_toolchain_windows",
    toolchain = ":gcc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
)