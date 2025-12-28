load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

# ---------------------- Rule implementation ---------------------- #
def _cc_binary_avr8_impl(ctx):
    ## Declare executable
    executable = ctx.actions.declare_file(ctx.attr.name)

    # Get tool for object dump
    objcopy = ctx.file.objcopy.dirname + "/" + ctx.file.objcopy.basename

    ## Fetch toolchain
    cc_toolchain = find_cpp_toolchain(ctx)

    ## Configure features
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    # ------------ Compile sources  ------------ #
    (compilation_contexts, compilation_outputs) = cc_common.compile(
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = ctx.files.srcs,
        compilation_contexts = [dep[CcInfo].compilation_context for dep in ctx.attr.deps],
        name = ctx.label.name,
    )

    # ------------ Add compilation outputs into a linking_context ------------ #
    (linking_contexts, linking_outputs) = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.attr.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        compilation_outputs = compilation_outputs,
        disallow_dynamic_library = True,
        alwayslink = True,
    )

    # ------------ Merge CC Infos ------------ #
    local_cc_info   = CcInfo(compilation_context = compilation_contexts,
                             linking_context     = linking_contexts)
    cc_info         = cc_common.merge_cc_infos(cc_infos = 
                                                   [local_cc_info] + 
                                                   [dep[CcInfo] for dep in ctx.attr.deps])

    # # ------------ Create object dump for all object files ------------ #
    # objects = []
    # cc_info = cc_common.merge_cc_infos(cc_infos = [dep[CcInfo] for dep in ctx.attr.deps])
    # for linker_input in cc_info.linking_context.linker_inputs.to_list():
    #     for library_to_link in linker_input.libraries:
    #         objects.extend(library_to_link.objects)
    
    # objdmp_files = []
    # for object in objects:
    #     objdmp = ctx.actions.declare_file("objdmp/" + object.basename.replace(".obj", ".objdmp"))
    #     objdmp_files.append(objdmp)
    #     ctx.actions.run(
    #         inputs = [object],
    #         outputs = [objdmp],
    #         executable = ofd2000,
    #         arguments =
    #             ["--output=" + objdmp.path] +
    #             [object.path],
    #         progress_message = "Running Object Dump for {}".format(object.basename),
    #     )

    # ------------ Link executable ------------ #
    linking_outputs = cc_common.link(
        name = ctx.attr.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        compilation_outputs = compilation_outputs,
        cc_toolchain = cc_toolchain,
        linking_contexts = [dep[CcInfo].linking_context for dep in ctx.attr.deps],
        # user_link_flags = [f.path for f in ctx.files.additional_linker_inputs],
        # additional_inputs = ctx.files.additional_linker_inputs,
    )

    # ------------ Create object dump for elf file ------------ #
    # Output is .txt file with the object dump (.elfdmp)
    elfdmp = ctx.actions.declare_file(ctx.attr.name + ".hex")
    # Run executable with specific command line arguments
    ctx.actions.run(
        inputs = [linking_outputs.executable],
        outputs = [elfdmp],
        executable = objcopy,
        arguments =
            ["-O"] + ["ihex"] +
            ["-R"] + [".eeprom"] +
            [linking_outputs.executable.path] +
            [elfdmp.path],
        progress_message = "Running Object Copy for {}".format(ctx.attr.name),
    )

    # Expose a DefaultInfo with the executable
    default_info = DefaultInfo(files = depset([elfdmp]),
                               executable = linking_outputs.executable)

    # Optionally, expose CcInfo including compilation outputs
    ccinfo = CcInfo(compilation_context = compilation_contexts,
                    linking_context = linking_contexts)

    return [default_info, ccinfo]

# ---------------------- Rule definition ---------------------- #
cc_binary_avr8 = rule(
    implementation = _cc_binary_avr8_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "deps": attr.label_list(cfg = "target", providers = [CcInfo]),
        # "additional_linker_inputs": attr.label_list(allow_files = True),
        "linkopts": attr.string_list(),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
        "objcopy": attr.label(
            default = Label("@avr8_compiler//:avr-objcopy"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    fragments = ["cpp"],
    executable = True,
)
