load(":cc_toolchain_config.bzl", "cc_toolchain_config")

# package(default_visibility = ["//visibility:public"])

filegroup(name = "empty")

cc_toolchain_config(
    name = "f2838_toolchain_config",
    # cpu = "TMS320F28388D"
)

cc_toolchain(
    name = "f2838_toolchain",
    toolchain_identifier = "f2838-toolchain",
    toolchain_config = ":f2838_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

toolchain(
    name = "cc_toolchain_for_f2838",
    toolchain = ":f2838_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
    ],
)