load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

def cc_binary_c2000_impl(ctx):
    # Get tool for object dump
    objdmp = ctx.file._objdmp.dirname + "/" + ctx.file._objdmp.basename

    # Output is .txt file with the object dump (.elfdmp)
    elfdmp = ctx.actions.declare_file(ctx.files.srcs[0].basename + ".elfdmp")

    # Run executable with specific command line arguments
    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [elfdmp],
        executable = objdmp,
        arguments =
            ["--output=" + elfdmp.path] +
            [f.path for f in ctx.files.srcs],
        progress_message = "Running Object Dump",
    )

    return DefaultInfo(files = depset([elfdmp]))

# Rule definition
cc_binary_c2000 = rule(
    cc_binary_c2000_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "_objdmp": attr.label(
            default = Label("@ti_cgt_c2000//:ofd2000"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)