load()

filegroup(
    name = "all",
    srcs = glob(["**/*",]),
)

cc_toolchain(
    name = "c2000_toolchain",
    toolchain_identifier = "c2000-toolchain",
    toolchain_config = ":c2000_toolchain_config",
    all_files = ":all",
    ar_files = ":all",
    as_files = ":all",
    compiler_files = ":all",
    dwp_files = ":all",
    linker_files = ":all",
    objcopy_files = ":all",
    dynamic_runtime_lib = ":all",
    static_runtime_lib = ":all",
    strip_files = ":all",
    supports_param_files = 0,
)