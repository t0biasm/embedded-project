"""Host-aware LLVM toolchain repository (clang-format, clang-tidy)."""

_RELEASE = "https://github.com/llvm/llvm-project/releases/download/llvmorg-21.1.7/"

def _llvm_toolchain_repository_impl(ctx):
    os_name = ctx.os.name
    arch = ctx.os.arch

    if os_name.startswith("windows"):
        archive = "clang+llvm-21.1.7-x86_64-pc-windows-msvc.tar.xz"
        sha256 = "70a2b73f2f14f787557f90abf380e7170b54e97b893218999144de5284b4f8f8"
        strip_prefix = "clang+llvm-21.1.7-x86_64-pc-windows-msvc"
        ext = ".exe"
    elif os_name == "linux" and arch in ["amd64", "x86_64"]:
        archive = "LLVM-21.1.7-Linux-X64.tar.xz"
        sha256 = "621ab8424178ffc28db0facc5aefd3fc11f5dea339aac171b36fa0b8d4b368cb"
        strip_prefix = "LLVM-21.1.7-Linux-X64"
        ext = ""
    else:
        fail("Unsupported host for LLVM toolchain: %s/%s" % (os_name, arch))

    ctx.download_and_extract(
        url = _RELEASE + archive,
        sha256 = sha256,
        stripPrefix = strip_prefix,
    )

    ctx.file("BUILD.bazel", """
filegroup(
    name = "clang-format",
    srcs = ["bin/clang-format{ext}"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "clang-tidy",
    srcs = ["bin/clang-tidy{ext}"],
    visibility = ["//visibility:public"],
)
""".format(ext = ext))

llvm_toolchain_repository = repository_rule(
    implementation = _llvm_toolchain_repository_impl,
)
