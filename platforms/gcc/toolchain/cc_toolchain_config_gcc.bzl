load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
    "with_feature_set")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

all_cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
]

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):

    # Adjust bazel default file formats/endings to TI specific formats/endings
    artifact_name_patterns = [
        artifact_name_pattern(
            category_name = "executable",
            prefix = "",
            extension = ".exe",
        ),
    ]

    tool_paths = [
        tool_path(
            name = "ar",
            path = "C:/msys64/mingw64/bin/ar.exe",
        ),
        tool_path(
            name = "cpp",
            path = "C:/msys64/mingw64/bin/cpp.exe",
        ),
        tool_path(
            name = "gcc",
            path = "C:/msys64/mingw64/bin/g++.exe",
        ),
        tool_path(
            name = "gcov",
            path = "C:/msys64/mingw64/bin/gcov.exe",
        ),
        tool_path(
            name = "ld",
            path = "C:/msys64/mingw64/bin/ld.exe",
        ),
        tool_path(
            name = "nm",
            path = "C:/msys64/mingw64/bin/nm.exe",
        ),
        tool_path(
            name = "objcopy",
            path = "C:/msys64/mingw64/bin/objcopy.exe",
        ),
        tool_path(
            name = "objdump",
            path = "C:/msys64/mingw64/bin/objdump.exe",
        ),
        tool_path(
            name = "strip",
            path = "C:/msys64/mingw64/bin/strip.exe",
        ),
    ]

    default_compile_flags = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-fno-canonical-system-headers",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_cpp_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=c++17",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_link_flags = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-lstdc++",  # C++ standard library
                            "-lgcc_s",   # GCC support library
                            "-lm",       # Math library
                        ],
                    ),
                ],
            ),
        ],
    )

    opt_feature = feature(
        name = "opt",
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = ["-O2", "-DNDEBUG"],
                    ),
                ],
            ),
        ],
    )

    dbg_feature = feature(
        name = "dbg",
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = ["-g"],
                    ),
                ],
            ),
        ],
    )

    features = [
        default_compile_flags,
        default_link_flags,
        opt_feature,
        dbg_feature,
    ]

    # Get GCC version to determine include paths
    # For GCC 14.x in MSYS2
    cxx_builtin_include_directories = [
        "C:/msys64/mingw64/include",
        "C:/msys64/mingw64/include/c++/15.2.0",
        "C:/msys64/mingw64/include/c++/15.2.0/x86_64-w64-mingw32",
        "C:/msys64/mingw64/include/c++/15.2.0/backward",
        "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include",
        "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include-fixed",
        # "C:/msys64/mingw64/x86_64-w64-mingw32/include",
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        artifact_name_patterns = artifact_name_patterns,
        toolchain_identifier = "local_mingw",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "x64_windows",
        target_libc = "local",
        compiler = "mingw-gcc",
        abi_version = "local",
        abi_libc_version = "local",
        tool_paths = tool_paths,
    )

cc_toolchain_config_gcc = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
