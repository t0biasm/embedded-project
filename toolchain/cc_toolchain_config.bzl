load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "tool", "tool_path", "feature", "flag_group", "flag_set", "env_entry", "env_set")
load("//toolchain:c2000.bzl", "C2000_COMPILER_FLAGS", "C2000_LINKER_FLAGS_APP")

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
    builtin_sysroot = None
    cxx_builtin_include_directories = []
    # Build tool pathes
    archiver = "../" + ctx.file._archiver.dirname + "/" + ctx.file._compiler.basename
    compiler = "../" + ctx.file._compiler.dirname + "/" + ctx.file._compiler.basename
    linker = "../" + ctx.file._linker.dirname + "/" + ctx.file._linker.basename
    strip = "../" + ctx.file._strip.dirname + "/" + ctx.file._strip.basename

    action_configs = [
        action_config (
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    path = compiler,
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [tool(path = compiler)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [tool(path = archiver)],
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [tool(path = strip)],
        ),
    ]

    features = [
        feature(name = "no_legacy_features", enabled = True),
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
                        # ---- General Compiler Flags ----- #
                        flag_group(
                            flags = C2000_COMPILER_FLAGS,
                        ),
                        # ---------- Include Paths -------- #
                        # Compilers built in path
                        flag_group(
                            flags = [
                                "-I", Label("@ti_cgt_c2000//:include").workspace_root + "/include",
                                "-I", Label("@ti_cgt_c2000//:lib").workspace_root + "/lib",
                            ]
                        ),
                        # System include paths
                        flag_group(
                            iterate_over = "system_include_paths",
                            flags = ["-I", "%{system_include_paths}"],
                        ),
                        # Normal include paths
                        flag_group(
                            iterate_over = "include_paths",
                            flags = ["-I", "%{include_paths}"],
                        ),
                    ],
                ),
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_executable],
                    flag_groups = [
                        flag_group(
                            flags = C2000_LINKER_FLAGS_APP,
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
        action_configs = action_configs,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "_archiver": attr.label(
            default = Label("@ti_cgt_c2000//:ar2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
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
