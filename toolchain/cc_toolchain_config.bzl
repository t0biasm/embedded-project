load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "tool_path", "feature", "flag_group", "flag_set")

all_link_actions = [ # NEW
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = []
    builtin_sysroot = "external/ti_cgt_c2000"
    cxx_builtin_include_directories = [
        "%sysroot%/include",
        "%sysroot%/lib",
        "%sysroot%/lib/src",
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "c28-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "TMS320F28388D",
        target_libc = "local",
        compiler = "ti_cgt_c2000",
        abi_version = "local",
        abi_libc_version = "local",
        tool_paths = tool_paths,
        builtin_sysroot = builtin_sysroot,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
