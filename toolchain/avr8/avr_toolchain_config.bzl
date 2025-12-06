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
    # Build tool pathes
    print(ctx.executable.gcc.path)
    tool_paths = [
        tool_path(name = "gcc", path = "C:/_git/embedded-project_v1/output/execroot/_main/external/+_repo_rules+avr8_compiler/bin/avr-gcc.exe"),
        tool_path(name = "ld", path = ctx.executable.ld.path),
        tool_path(name = "ar", path = ctx.executable.ar.path),
        tool_path(name = "cpp", path = ctx.executable.cpp.path),
        tool_path(name = "gcov", path = ctx.executable.gcov.path),
        tool_path(name = "nm", path = ctx.executable.nm.path),
        tool_path(name = "objdump", path = ctx.executable.objdump.path),
        tool_path(name = "strip", path = ctx.executable.strip.path),
    ]

    # Get MCU and F_CPU from attributes
    mcu = ctx.attr.mcu
    f_cpu = ctx.attr.f_cpu

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
                            "-mmcu=" + mcu,
                            "-DF_CPU=" + f_cpu,
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
                            "-mmcu=" + mcu,
                            "-Wl,--gc-sections",
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
        toolchain_identifier = "avr-toolchain-" + mcu,
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
        "mcu": attr.string(mandatory = True),
        "f_cpu": attr.string(mandatory = True),
        "gcc": attr.label(
            default = Label("@avr8_compiler//:avr-gcc"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "ld": attr.label(
            default = Label("@avr8_compiler//:avr-ld"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "ar": attr.label(
            default = Label("@avr8_compiler//:avr-ar"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "cpp": attr.label(
            default = Label("@avr8_compiler//:avr-cpp"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "gcov": attr.label(
            default = Label("@avr8_compiler//:avr-gcov"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "nm": attr.label(
            default = Label("@avr8_compiler//:avr-nm"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "objdump": attr.label(
            default = Label("@avr8_compiler//:avr-objdump"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "strip": attr.label(
            default = Label("@avr8_compiler//:avr-strip"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    provides = [CcToolchainConfigInfo],
)
