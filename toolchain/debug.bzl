def _debug_impl(ctx):
    ccinfo = ctx.attr.dep[CcInfo]
    ccctx = ccinfo.compilation_context
    for p in ccctx.includes.to_list():
        print(">>> include path:", p)
    for p in ccctx.quote_includes.to_list():
        print(">>> quote include path:", p)
    for p in ccctx.system_includes.to_list():
        print(">>> system include path:", p)

debug_rule = rule(
    implementation = _debug_impl,
    attrs = {"dep": attr.label(providers = [CcInfo])},
)
