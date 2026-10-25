load(":repository.bzl", "llvm_toolchain_repository")

def _llvm_toolchain_extension_impl(module_ctx):
    llvm_toolchain_repository(name = "llvm_toolchain")
    return module_ctx.extension_metadata(
        root_module_direct_deps = ["llvm_toolchain"],
        root_module_direct_dev_deps = [],
    )

llvm_toolchain_extension = module_extension(
    implementation = _llvm_toolchain_extension_impl,
)
