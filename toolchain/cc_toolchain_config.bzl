load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "tool", "tool_path", "feature", "flag_group", "flag_set", "env_entry", "env_set")
load("//toolchain:c2000.bzl", "C2000_COMPILER_FLAGS", "C2000_LINKER_FLAGS")

all_compile_actions = [ # NEW
    ACTION_NAMES.c_compile,
]

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
    
    # Adjust tool pathes
    compiler = ctx.file._compiler.short_path.replace("+_repo_rules+", "external/+_repo_rules+")
    linker = ctx.file._linker.short_path.replace("+_repo_rules+", "external/+_repo_rules+")
    strip = ctx.file._strip.short_path.replace("+_repo_rules+", "external/+_repo_rules+")

    action_configs = [
        action_config (
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    # path = ctx.executable._compiler.path,
                    # path = ctx.executable._compiler.short_path,
                    # path = ctx.file._compiler.short_path
                    # path = ctx.file._compiler.short_path,
                    # path = "external/+_repo_rules+ti_cgt_c2000/bin/cl2000.exe",
                    path = compiler,
                    # path = "external/ti_cgt_c2000/bin/cl2000.exe"
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [tool(path = linker)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [tool(path = linker)],
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [tool(path = strip)],
        ),
    ]

    features = [
        feature(name = "no_legacy_features", enabled = True),
        # feature(name = "random_seed", enabled = False),
        # feature(name = "dependency_file", enabled = False),
        # feature(name = "pic", enabled = False),
        # feature(name = "no_canonical_prefixes", enabled = False),
        # feature(name = "supports_pic", enabled = False),
        # feature(name = "user_compile_flags", enabled = False),
        # feature(name = "default_compile_flags", enabled = False),
        # feature(name = "output_execpath_flags", enabled = False),
        feature(
            name = "ti_env",
            enabled = True,
            # env_sets = [
            #     env_set(
            #         actions = all_compile_actions,
            #         env_entries = [
            #             env_entry(key = "TI_COMPILER", value = ctx.file._compiler.path),
            #         ]
            #     ),
            # ],
            flag_sets = [
                flag_set(
                    actions = [ACTION_NAMES.c_compile],
                    flag_groups = [
                        flag_group(
                            flags = C2000_COMPILER_FLAGS,
                        ),
                    ],
                ),
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_executable],
                    flag_groups = [
                        flag_group(
                            flags = C2000_LINKER_FLAGS,
                        ),
                        # # All object files from compilation
                        # flag_group(
                        #     iterate_over = "linker_input_files",
                        #     flag_groups = [
                        #         flag_group(flags = ["%{linker_input_files}"]),
                        #     ],
                        # ),
                        # All libraries to link
                        flag_group(
                            iterate_over = "libraries_to_link",
                            flag_groups = [
                                flag_group(expand_if_available = "object", flags = ["%{object}"]),
                                flag_group(expand_if_available = "library", flags = ["%{library}"]),
                            ],
                        ),
                        # Linker input files (.cmd linker scripts)
                        flag_group(
                            iterate_over = "user_link_flags",
                            flag_groups = [flag_group(flags = ["%{user_link_flags}"])],
                        ),
                    ],
                ),
            ],
        ),
        # feature(
        #     name = "default_linker_flags",
        #     enabled = True,
        #     flag_sets = [
        #         flag_set(
        #             actions = all_link_actions,
        #             flag_groups = ([
        #                 flag_group(
        #                     flags = [
        #                         "-lstdc++",
        #                     ],
        #                 ),
        #             ]),
        #         ),
        #     ],
        # ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "c2000-toolchain",
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
        # action_configs = declare_actions(
        #     # ctx.file._compiler.path,
        #     ctx.file._executable.path
        # )
        action_configs = action_configs,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "_compiler": attr.label(
            default = Label("@ti_cgt_c2000//:cl2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "_linker": attr.label(
            default = Label("@ti_cgt_c2000//:lnk2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "_strip": attr.label(
            default = Label("@ti_cgt_c2000//:strip2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    provides = [CcToolchainConfigInfo],
)
