"""AVR-GCC Toolchain Configuration for Bazel"""

load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
     "action_config",
     "artifact_name_pattern",
     "env_entry",
     "env_set",
     "feature",
     "flag_group",
     "flag_set",
     "tool",
     "tool_path",
     "with_feature_set")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    tool_paths = [
        tool_path(name = "gcc", path = "/usr/bin/avr-gcc"),
        tool_path(name = "ld", path = "/usr/bin/avr-ld"),
        tool_path(name = "ar", path = "/usr/bin/avr-ar"),
        tool_path(name = "cpp", path = "/usr/bin/avr-cpp"),
        tool_path(name = "gcov", path = "/usr/bin/avr-gcov"),
        tool_path(name = "nm", path = "/usr/bin/avr-nm"),
        tool_path(name = "objdump", path = "/usr/bin/avr-objdump"),
        tool_path(name = "strip", path = "/usr/bin/avr-strip"),
    ]

    # Compiler flags for AVR
    compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-mmcu=%{mcu}",
                            "-DF_CPU=%{f_cpu}",
                            "-Os",  # Optimize for size
                            "-Wall",
                            "-ffunction-sections",
                            "-fdata-sections",
                            "-fno-exceptions",
                        ],
                    ),
                ],
            ),
        ],
    )

    # Linker flags for AVR
    linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-mmcu=%{mcu}",
                            "-Wl,--gc-sections",
                            "-Wl,-Map=%{output_execpath}.map",
                        ],
                    ),
                ],
            ),
        ],
    )

    # Default compile flags
    default_compile_flags = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=gnu11",  # For C files
                        ],
                    ),
                ],
            ),
        ],
    )

    # Opt feature (optimization)
    opt_feature = feature(
        name = "opt",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["-O2"])],
            ),
        ],
    )

    # Debug feature
    dbg_feature = feature(
        name = "dbg",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["-g"])],
            ),
        ],
    )

    # Action configs
    action_configs = []

    features = [
        compiler_flags,
        linker_flags,
        default_compile_flags,
        opt_feature,
        dbg_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "avr-toolchain",
        host_system_name = "local",
        target_system_name = "avr",
        target_cpu = ctx.attr.cpu,
        target_libc = "avr-libc",
        compiler = "avr-gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        features = features,
        action_configs = action_configs,
        builtin_sysroot = "/usr/lib/avr",
        cxx_builtin_include_directories = [
            "/usr/lib/gcc/avr/5.4.0/include",
            "/usr/lib/gcc/avr/5.4.0/include-fixed",
            "/usr/lib/avr/include",
        ],
    )

avr_cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "cpu": attr.string(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
)
