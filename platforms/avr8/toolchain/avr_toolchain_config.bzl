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
     "with_feature_set",
     "variable_with_value")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("//platforms/avr8/toolchain:avr8.bzl",
     "AVR_COMPILER_FLAGS",
     "AVR_LINKER_FLAGS_APP",
     "AVR_ARCHIVER_FLAGS_APP",
     "AVR_ASSEMBLER_FLAGS")

def _impl(ctx):
    # Extract custom rule options
    mcu = ctx.attr.mcu[BuildSettingInfo].value
    p_arch = ctx.attr.p_arch[BuildSettingInfo].value
    f_cpu = ctx.attr.f_cpu[BuildSettingInfo].value

    # Used tools are handled via action_config
    tool_paths = []
    # Compiler builtin directories
    cxx_builtin_include_directories = []
    # Adjust bazel default file formats/endings to TI specific formats/endings
    artifact_name_patterns = []
    # Builtin sysroot
    builtin_sysroot = None
    
    # Build tool pathes
    gcc = "../../../" + ctx.executable.gcc.path
    ld = "../../../" + ctx.executable.ld.path
    ar = "../../../" + ctx.executable.ar.path
    cpp = "../../../" + ctx.executable.cpp.path
    gcov = "../../../" + ctx.executable.gcov.path
    nm = "../../../" + ctx.executable.nm.path
    objdump = "../../../" + ctx.executable.objdump.path
    strip = "../../../" + ctx.executable.strip.path

    action_configs = [
        action_config (
            action_name = ACTION_NAMES.c_compile,
            tools = [tool(path = gcc)],
        ),
        action_config (
            action_name = ACTION_NAMES.assemble,
            tools = [tool(path = gcc)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [tool(path = ar)],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [tool(path = ld)],
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [tool(path = strip)],
        ),
    ]

    features = [
        # Deactivate standard gcc features
        feature(name = "no_legacy_features", enabled = True),

        # Feature for compiling sources files to object files - .c/.h -> .o
        feature(
            name = "avr_compiler",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.c_compile,
                    ],
                    flag_groups = [
                        # ---- General Compiler Flags ----- #
                        flag_group(
                            flags = AVR_COMPILER_FLAGS,
                        ),
                        # ---------- Custom Flags -------- #
                        flag_group(
                            flags = [
                                "-mmcu=" + mcu,
                                "-DF_CPU=" + f_cpu,
                            ]
                        ),
                    ],
                ),
            ],
        ),

        # Assembler step to convert .asm files into libraries
        feature(
            name = "avr_assembler",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.assemble,
                    ],
                    flag_groups = [
                        # ---- General Assembler Flags ----- #
                        flag_group(
                            flags = AVR_ASSEMBLER_FLAGS,
                        ),
                        # ---------- Custom Flags -------- #
                        flag_group(
                            flags = [
                                "-mmcu=" + mcu,
                                "-DF_CPU=" + f_cpu,
                            ]
                        ),
                    ],
                ),
            ],
        ),

        # Feature for archiving object files to static library - .o -> .lib
        # Used for cc_library
        # feature(
        #     name = "avr_archiver",
        #     enabled = True,
        #     flag_sets = [
        #         flag_set(
        #             actions = [
        #                 ACTION_NAMES.cpp_link_static_library,
        #             ],
        #             flag_groups = [
        #                 # ---------- Linker flags --------- #
        #                 flag_group(
        #                     flags = AVR_ARCHIVER_FLAGS_APP,
        #                 ),
        #                 # # ----- Libraries to be linked ---- #
        #                 # flag_group (
        #                 #     expand_if_available = "libraries_to_link",
        #                 #     iterate_over = "libraries_to_link",
        #                 #     flag_groups = [
        #                 #         # All object files .o
        #                 #         flag_group(
        #                 #             expand_if_equal = variable_with_value(
        #                 #                 name = "libraries_to_link.type",
        #                 #                 value = "object_file",
        #                 #             ),
        #                 #             flag_groups = [flag_group(flags = ["%{libraries_to_link.name}"])],
        #                 #         ),
        #                 #     ],
        #                 # ),
        #                 # Linker script add-on
        #                 # flag_groups = [
        #                 #     flag_group(
        #                 #         expand_if_available = "user_link_flags",
        #                 #         iterate_over = "user_link_flags",
        #                 #         flags = ["%{user_link_flags}"],
        #                 #     ),
        #                 # ],
        #             ],
        #         ),
        #     ],
        # ),

        # Feature for linking object files/static libraries to final executable - .o/.lib -> .out
        # Used for cc_binary
        feature(
            name = "avr_linker",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_executable,
                    ],
                    flag_groups = [
                        # ---------- Linker flags --------- #
                        flag_group(
                            flags = AVR_LINKER_FLAGS_APP,
                        ),
                        # ---------- Custom Flags -------- #
                        flag_group(
                            flags = [
                                "-m", p_arch,
                            ]
                        ),
                        # # ----- Libraries to be linked ---- #
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
                    ],
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "avr8-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = mcu,
        target_libc = "local",
        compiler = "avr-gcc",
        abi_version = "local",
        abi_libc_version = "local",
        tool_paths = tool_paths,
        builtin_sysroot = builtin_sysroot,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        action_configs = action_configs,
        artifact_name_patterns = artifact_name_patterns,
    )

avr_cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "mcu": attr.label(mandatory = True),
        "p_arch": attr.label(mandatory = True),
        "f_cpu": attr.label(mandatory = True),
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
