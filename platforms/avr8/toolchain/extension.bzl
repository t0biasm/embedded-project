# toolchains/extensions.bzl

load(":repository.bzl", "avr8_toolchain_repository")

def _avr8_toolchain_extension_impl(module_ctx):
    """
    Module Extension für avr8 Toolchain.
    Wird einmal pro Bazel-Invocation ausgeführt.
    """
    
    # Erstelle das Repository
    # Die Repository Rule erkennt automatisch die Host-Platform
    avr8_toolchain_repository(
        name = "avr8_compiler",
    )
    
    return module_ctx.extension_metadata(
        root_module_direct_deps = ["avr8_compiler"],
        root_module_direct_dev_deps = [],
    )

avr8_toolchain_extension = module_extension(
    implementation = _avr8_toolchain_extension_impl,
)
