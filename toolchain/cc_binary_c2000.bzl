load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

def cc_binary_c2000_impl(ctx):
    # Get toolchain configurations
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    # Step 1: Compile each source
    # srcFileTypes = ["cc", "cpp", "cxx", "c++", "C", "cu", "cl", "c", "s", "asm", "cla", "Cla"]
    # (c_compilation_context, c_output) = cc_common.compile(
    #     cc_toolchain = cc_toolchain,
    #     feature_configuration = feature_configuration,
    #     actions = ctx.actions,
    #     srcs = [f for f in ctx.files.srcs if f.extension in srcFileTypes],
    #     public_hdrs = [f for f in ctx.files.srcs if f.extension not in srcFileTypes],
    #     compilation_contexts = [dep[CcInfo].compilation_context for dep in ctx.attr.deps],
    #     name = ctx.attr.output_name,
    #     user_compile_flags = ctx.fragments.cpp.copts + ctx.fragments.cpp.conlyopts + ctx.attr.copt,
    #     defines = ctx.attr.defines,
    # )
    (compilation_contexts, compilation_outputs) = cc_common.compile(
        name = ctx.attr.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = ctx.files.srcs,
        public_hdrs = ctx.files.hdrs,
        compilation_contexts = [dep[CcInfo].compilation_context for dep in ctx.attr.deps],
    )

    # # ???
    # user_link_flags = []
    # user_link_flags.extend([ctx.expand_location(elem, ctx.attr.data) for elem in ctx.attr.linkopts])
    # for lsl_file in ctx.files.lsl:
    #     user_link_flags.append("--lsl-file=" + lsl_file.path)
    # for lsl_include in ctx.files.lsl_include:
    #     user_link_flags.append("-I" + lsl_include.dirname)
    # c_linking_context = cc_common.create_linking_context_from_compilation_outputs(
    #     cc_toolchain = cc_toolchain,
    #     feature_configuration = feature_configuration,
    #     actions = ctx.actions,
    #     name = ctx.attr.output_name,
    #     user_link_flags = user_link_flags,
    #     alwayslink = True,
    # )

    # Add compilation outputs into a linking_context
    (linking_contexts, linking_outputs) = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.attr.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        compilation_outputs = compilation_outputs,
        disallow_dynamic_library = True,
    )

    linking_outputs = cc_common.link(
        name = ctx.attr.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        compilation_outputs = compilation_outputs,
        cc_toolchain = cc_toolchain,
        linking_contexts = [dep[CcInfo].linking_context for dep in ctx.attr.deps],
    )

    executable = ctx.actions.declare_file(ctx.attr.name)
    # linking_outputs = cc_common.link(
    #     actions = ctx.actions,
    #     feature_configuration = feature_configuration,
    #     cc_toolchain = cc_toolchain,
    #     compilation_outputs = c_output,
    #     name = ctx.attr.output_name,
    #     user_link_flags = [],
    #     output_type = "executable",
    #     link_deps_statically = True,
    #     stamp = 0,
    # )

    # linker_path = cc_common.get_tool_for_action(
    #     feature_configuration = feature_configuration,
    #     action_name = ACTION_NAMES.cpp_link_executable,
    # )
    # # print(">>> linker path:", linker_path)
    # # Build up linker arguments/flags
    # args = ctx.actions.args()
    # args.add("-l")
    # args.add_joined([f.path for f in c_output.objects], join_with = ",")
    # args.add("-o")
    # args.add("bazel-out/x64_windows-fastbuild/bin/" + ctx.label.package + "/" + ctx.attr.output_name + ".out")
    # args.add_all(ctx.attr.linker_flags)
    # # ???
    # outputs = []
    # ctx.actions.run(
    #     executable = linker_path,
    #     arguments = [args],
    #     progress_message = "Linking {}".format(ctx.label.name),
    #     mnemonic = "CcLink",
    #     inputs = depset(
    #         direct = ctx.files.linker_files,
    #     ),
    #     outputs = [executable],
    # )

    return [
        CcInfo(
            compilation_context = compilation_contexts,
            linking_context = linking_contexts,
        ),
        DefaultInfo(
            files = depset([executable])
        ),
    ]

# Rule definition
cc_binary_c2000 = rule(
    cc_binary_c2000_impl,
    attrs = {
        # "copt": attr.string_list(default = []),
        # "defines": attr.string_list(default = []),
        "deps": attr.label_list(allow_files = True),
        # "extension": attr.string(default = "*"),
        # "linker_files": attr.label(allow_files = True),
        # "linker_flags": attr.string_list(default = []),
        # "linker_opts": attr.string_list(default = []),
        # "lsl": attr.label(allow_files = True),
        # "lsl_include": attr.label(allow_files = True),
        # "output_name": attr.string(default = "out"),
        "srcs": attr.label_list(allow_files = True),
        "hdrs": attr.label_list(allow_files = True),
    },
    fragments = ["cpp"],
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)