load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "tool", "tool_path", "feature", "flag_group", "flag_set", "env_entry", "env_set")

all_compile_actions = [ # NEW
    ACTION_NAMES.c_compile,
]

all_link_actions = [ # NEW
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        # tool_path(
        #     name = "gcc",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/cl2000.exe",
        # ),
        # tool_path(
        #     name = "cpp",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/cl2000.exe",
        # ),
        # tool_path(
        #     name = "ld",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/cl2000.exe",
        # ),
        # tool_path(
        #     name = "ar",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/ar2000.exe",
        # ),
        # tool_path(
        #     name = "nm",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/nm2000.exe",
        # ),
        # tool_path(
        #     name = "objdump",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/ofd2000.exe",
        # ),
        # tool_path(
        #     name = "strip",    # C2000 compiler
        #     path = "external/ti_cgt_c2000/bin/strip2000.exe",
        # ),
    ]

    builtin_sysroot = "external/ti_cgt_c2000"

    # print("Sysroot: %s" % "%sysroot%/include")
    cxx_builtin_include_directories = [
        "%sysroot%/include",
        "%sysroot%/lib",
        "%sysroot%/lib/src",
    ]
    
    # print("Compiler path: %s" % ctx.file._compiler.path)
    # print("Compiler path: %s" % ctx.file._compiler.short_path)
    compiler = ctx.file._compiler.short_path.replace("+_repo_rules+", "external/+_repo_rules+")
    # print("Compiler path: %s" % compiler)

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
    ]

    features = [
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
                            flags = ["--run_linker --output_file=main.out"],
                            # flags = ["--output_file=main.out"],
                            # flags = ["--run_linker"],
                        ),
                    ],
                ),
                # flag_set(
                #     actions = [ACTION_NAMES.cpp_link_executable],
                #     flag_groups = [
                #         flag_group(
                #             flags = ["-Wl", "--gdb-index"],
                #         ),
                #     ],
                # ),
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
        # "_compiler": attr.label(allow_single_file = True, default = "@ti_cgt_c2000//:cl2000"),
        "_compiler": attr.label(
            default = Label("@ti_cgt_c2000//:cl2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        )
        # "_compiler": attr.label(
        #     default = "@ti_cgt_c2000//:cl2000",
        #     allow_single_file = True,
        #     executable = True,
        #     cfg = "exec",
        # )
    },
    provides = [CcToolchainConfigInfo],
)
