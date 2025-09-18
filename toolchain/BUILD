load(":cc_toolchain_config.bzl", "cc_toolchain_config")

filegroup(name = "empty")

cc_toolchain_config(
    name = "c28_toolchain_config",
    # cpu = "TMS320F28388D"
)

cc_toolchain(
    name = "c28_toolchain",
    toolchain_identifier = "c28-toolchain",
    toolchain_config = ":c28_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

toolchain(
    name = "c28_toolchain_windows",
    toolchain = ":c28_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "//constraints:f2838",
    ],
)