load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
     "action_config",
     "artifact_name_pattern",
     "tool",
     "tool_path",
     "feature",
     "flag_group",
     "flag_set",
     "env_entry",
     "env_set",
     "variable_with_value")
load("//toolchain:c2000.bzl",
     "C2000_COMPILER_FLAGS",
     "C2000_LINKER_FLAGS_APP",
     "C2000_ARCHIVER_FLAGS_APP",
     "C2000_ASSEMBLER_FLAGS")

all_compile_actions = [ # NEW
    ACTION_NAMES.c_compile,
]

all_link_actions = [ # NEW
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    # Used tools are handled via action_config
    tool_paths = []
    # Compiler sysroot needs to invoked via --include_path option of compiler
    # No need to set specific values here
    builtin_sysroot = None
    cxx_builtin_include_directories = []
    # Adjust bazel default file formats/endings to TI specific formats/endings
    artifact_name_patterns = [
        # Adjust .o to .obj
        artifact_name_pattern(
            category_name = "object_file",
            prefix = "",
            extension = ".obj",
        ),
        # Adjust .a to .lib
        artifact_name_pattern(
            category_name = "static_library",
            prefix = "",
            extension = ".lib",
        ),
    ]
    # Build tool pathes
    archiver = "../" + ctx.file._archiver.dirname + "/" + ctx.file._archiver.basename
    compiler = "../" + ctx.file._compiler.dirname + "/" + ctx.file._compiler.basename
    linker = "../" + ctx.file._linker.dirname + "/" + ctx.file._linker.basename
    strip = "../" + ctx.file._strip.dirname + "/" + ctx.file._strip.basename

    action_configs = [
        action_config (
            action_name = ACTION_NAMES.c_compile,
            tools = [tool(path = compiler)],
        ),
        action_config (
            action_name = ACTION_NAMES.assemble,
            tools = [tool(path = compiler)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [tool(path = archiver)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [tool(path = compiler)],
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [tool(path = strip)],
        ),
    ]

    features = [
        feature(name = "no_legacy_features", enabled = True),
        # Feature for compiling sources files to object files - .c/.h -> .o
        # Used for cc_library/cc_binary
        feature(
            name = "ti_compiler",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.c_compile,
                    ],
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
            ],
        ),
        feature(
            name = "ti_assembler",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.assemble,
                    ],
                    flag_groups = [
                        # ---- General Assembler Flags ----- #
                        flag_group(
                            flags = C2000_ASSEMBLER_FLAGS,
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
            ],
        ),
        # Feature for archiving object files to static library - .o -> .lib
        # Used for cc_library
        feature(
            name = "ti_archiver",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_static_library,
                    ],
                    flag_groups = [
                        # ---------- Linker flags --------- #
                        flag_group(
                            flags = C2000_ARCHIVER_FLAGS_APP,
                        ),
                        # ----- Libraries to be linked ---- #
                        flag_group (
                            expand_if_available = "libraries_to_link",
                            iterate_over = "libraries_to_link",
                            flag_groups = [
                                # All object files .o
                                flag_group(
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "object_file",
                                    ),
                                    flag_groups = [flag_group(flags = ["%{libraries_to_link.name}"])],
                                ),
                            ],
                        ),
                    ],
                ),
            ],
        ),
        # Feature for linking object files/static libraries to final executable - .o/.lib -> .out
        # Used for cc_binary
        feature(
            name = "ti_linker",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_executable,
                    ],
                    flag_groups = [
                        # ---------- Linker flags --------- #
                        flag_group(
                            flags = C2000_LINKER_FLAGS_APP,
                        ),
                        # ----- Libraries to be linked ---- #
                        # Linker search path (This option must appear before the --library option.)
                        flag_group(
                            flags = [
                                "--search_path=" + Label("@ti_cgt_c2000//:lib").workspace_root + "/lib",
                            ]
                        ),
                        # Add files to be linked
                        flag_group (
                            expand_if_available = "libraries_to_link",
                            iterate_over = "libraries_to_link",
                            flag_groups = [
                                # All object files .o
                                flag_group(
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "object_file",
                                    ),
                                    flag_groups = [
                                        flag_group(
                                            flags = ["%{libraries_to_link.name}"],
                                        ),
                                    ],
                                ),
                                # All static libraries .lib
                                flag_group(
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "static_library",
                                    ),
                                    flag_groups = [
                                        flag_group(
                                            flags = ["%{libraries_to_link.name}"],
                                        ),
                                    ],
                                ),
                            ],
                        ),
                        # Flag for automatic run-time support
                        # Needed to define an entry point (if c_int00 is not resolved by any specified object file or library)
                        # See compiler user guide
                        flag_group(
                            flags = [
                                "--library=libc.a",
                            ]
                        ),
                    ],
                ),
            ],
        ),
        feature(
            name = "ti_linkopts",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_static_library,
                        ACTION_NAMES.cpp_link_executable,
                    ],
                    flag_groups = [
                        # Linker script add-on
                        flag_group(
                            expand_if_available = "user_link_flags",
                            iterate_over = "user_link_flags",
                            flags = ["%{user_link_flags}"],
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
        artifact_name_patterns = artifact_name_patterns,
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
