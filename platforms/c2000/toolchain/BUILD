load(":cc_toolchain_config_c2000.bzl", "cc_toolchain_config_c2000")

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


filegroup(
    name = "compiler_binaries",
    srcs = [
        "@ti_cgt_c2000//:ar2000",
        "@ti_cgt_c2000//:cl2000",
        "@ti_cgt_c2000//:include",
        "@ti_cgt_c2000//:lib",
        "@ti_cgt_c2000//:lnk2000",
        "@ti_cgt_c2000//:ofd2000",  # Also include all other files
        "@ti_cgt_c2000//:strip2000",
        "@ti_cgt_c2000//:all_files",
    ],
)

cc_toolchain_config_c2000(
    name = "c2000_toolchain_config",
)

cc_toolchain(
    name = "c2000_cc_toolchain",
    all_files = ":compiler_binaries",
    compiler_files = ":compiler_binaries",
    dwp_files = ":empty",
    linker_files = ":compiler_binaries",
    objcopy_files = ":compiler_binaries",
    strip_files = ":compiler_binaries",
    supports_param_files = 0,
    toolchain_config = ":c2000_toolchain_config",
    toolchain_identifier = "c2000-toolchain",
)

# Toolchain type
toolchain(
    name = "c2000_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        ":c28",
    ],
    toolchain = ":c2000_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Constraint for c28 CPU
constraint_setting(
    name = "cpu"
)

constraint_value(
    name = "c28",
    constraint_setting = ":cpu",
    visibility = ["//visibility:public"],
)

# Platform definition for c2000
platform(
    name = "c2000",
    constraint_values = [
        "@platforms//cpu:x86_64",
        ":c28",
    ],
    visibility = ["//visibility:public"],
)
