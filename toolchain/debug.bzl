def _debug_impl(ctx):
    ccinfo = ctx.attr.dep[CcInfo]
    defaultinfo = ctx.attr.dep[DefaultInfo]
    # cccompout = ccinfo.compilation_outputs
    # print(">>> Libraries:", cccompout)
    # ccctx = ccinfo.compilation_context
    # for p in ccctx.includes.to_list():
    #     print(">>> include path:", p)
    # for p in ccctx.quote_includes.to_list():
    #     print(">>> quote include path:", p)
    # for p in ccctx.system_includes.to_list():
    #     print(">>> system include path:", p)

    clctx = ccinfo.linking_context
    # print(">>> Libraries:", clctx)

    # cc_infos = [dep[CcInfo] for dep in ctx.attr.deps if CcInfo in dep]
    # cc_infos = ctx.attr.dep[CcInfo]
    # # for cc in cc_infos:
    #     for lib in cc_infos.linking_context.linker_inputs.to_list():
    #         print("Lib:", lib)

debug_rule = rule(
    implementation = _debug_impl,
    attrs = {"dep": attr.label(providers = [CcInfo])},
)
