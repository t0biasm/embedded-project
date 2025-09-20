load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

def cc_binary_c2000_impl(ctx):
    # Get toolchain configurations
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
    )

    # Step 1: Compile each source
    srcFileTypes = ["cc", "cpp", "cxx", "c++", "C", "cu", "cl", "c", "s", "asm", "cla", "Cla"]
    (c_compilation_context, c_output) = cc_common.compile(
        cc_toolchain = cc_toolchain,
        feature_configuration = feature_configuration,
        actions = ctx.actions,
        srcs = [f for f in ctx.files.srcs if f.extension in srcFileTypes],
        public_hdrs = [f for f in ctx.files.srcs if f.extension not in srcFileTypes],
        # compilation_contexts = [dep[CcInfo].compilation_context for dep in ctx.attr.deps],
        name = ctx.attr.output_name,
        user_compile_flags = ctx.fragments.cpp.copts + ctx.fragments.cpp.conlyopts + ctx.attr.copt,
        defines = ctx.attr.defines,
    )

    # user_link_flags = []
    # c_linking_context = cc_common.create_linking_context_from_compilation_outputs(
    #     cc_toolchain = cc_toolchain,
    #     feature_configuration = feature_configuration,
    #     actions = ctx.actions,
    #     name = ctx.attr.output_name,
    #     user_link_flags = user_link_flags,
    #     alwayslink = True,
    # )

    executable = ctx.actions.declare_file(ctx.attr.output_name)
    linking_outputs = cc_common.link(
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        compilation_outputs = c_output,
        name = ctx.attr.output_name,
        user_link_flags = [],
        output_type = "executable",
        link_deps_statically = True,
        stamp = 0,
    )

    return [DefaultInfo(files = depset([executable]))]


    # return [DefaultInfo(files = depset([ctx.attr.output_name]))]


cc_binary_c2000 = rule(
    cc_binary_c2000_impl,
    attrs = {
        "copt": attr.string_list(default = []),
        "defines": attr.string_list(default = []),
        "deps": attr.label_list(allow_files = True),
        "extension": attr.string(default = "*"),
        "output_name": attr.string(default = "out"),
        "srcs": attr.label_list(allow_files = True),
    },
    fragments = ["cpp"],
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)