# toolchains/extensions.bzl

load(":repository.bzl", "c2000_toolchain_repository")

def _c2000_toolchain_extension_impl(module_ctx):
    """
    Module Extension für c2000 Toolchain.
    Wird einmal pro Bazel-Invocation ausgeführt.
    """
    
    # Erstelle das Repository
    # Die Repository Rule erkennt automatisch die Host-Platform
    c2000_toolchain_repository(
        name = "ti_cgt_c2000",
    )
    
    return module_ctx.extension_metadata(
        root_module_direct_deps = ["ti_cgt_c2000"],
        root_module_direct_dev_deps = [],
    )

c2000_toolchain_extension = module_extension(
    implementation = _c2000_toolchain_extension_impl,
)
