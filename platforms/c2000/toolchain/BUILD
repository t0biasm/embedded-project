load(":cc_toolchain_config_c2000.bzl", "cc_toolchain_config_c2000")

constraint_setting(
    name = "cpu"
)

constraint_value(
    name = "c28",
    constraint_setting = ":cpu",
    visibility = ["//visibility:public"],
)

platform(
    name = "c2000",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
        ":c28",
    ],
    visibility = ["//visibility:public"],
)

filegroup(name = "empty")

cc_library(
    name = "c2000_builtin_directories",
    srcs = [],
    hdrs = [
        "@ti_cgt_c2000//:include",
        "@ti_cgt_c2000//:lib",
    ],
    includes = ["."],
    visibility = ["//visibility:public"],
)

cc_toolchain_config_c2000(
    name = "c2000_toolchain_config",
)

cc_toolchain(
    name = "c2000_toolchain",
    toolchain_identifier = "c2000-toolchain",
    toolchain_config = ":c2000_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

toolchain(
    name = "c2000_toolchain_windows",
    toolchain = ":c2000_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        ":c28",
    ],
)