# toolchains/arm_toolchain_repository.bzl

def _avr8_toolchain_repository_impl(repository_ctx):
    """
    Lädt ARM-GCC Toolchain und generiert plattformspezifische BUILD-Datei.
    """
    
    os_name = repository_ctx.os.name
    os_arch = repository_ctx.os.arch
    
    # Platform-Erkennung und Download (wie vorher)       
    if os_name.startswith("windows"):
        url = "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/avr8-gnu-toolchain-4.0.0.52-win32.any.x86_64.zip"
        sha256 = "ccc9712ca20edc713dcf101013f80ba245b418ebfb02fc98e9f44f7733fe086a"
        strip_prefix = "avr8-gnu-toolchain-win32_x86_64"
        platform_type = "windows"
        binary_extension = ".exe"

    elif os_name == "linux":
        url = "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/avr8-gnu-toolchain-4.0.0.52-linux.any.x86_64.tar.gz"
        sha256 = "cc8682bb15f26428597499bf6e120832624a25b1062034a49fe0c77e4731cd33"
        strip_prefix = "avr8-gnu-toolchain-linux_x86_64"
        platform_type = "linux"
        binary_extension = ""
        
    else:
        fail("Unsupported OS: %s" % os_name)
    
    repository_ctx.download_and_extract(
        url = url,
        sha256 = sha256,
        stripPrefix = strip_prefix,
    )
    
    # Plattformspezifische BUILD-Datei generieren
    if platform_type == "windows":
        # Windows braucht .exe Extensions
        build_content = """
filegroup(
    name = "intrinsic_files",
    srcs = glob([
        "lib/gcc/avr/**",
        "avr/include/**",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "include",
    srcs = glob(["avr/include/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib",
    srcs = glob(["lib/gcc/avr/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-gcc",
    srcs = ["bin/avr-gcc.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-ld",
    srcs = ["bin/avr-ld.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-ar",
    srcs = ["bin/avr-ar.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-cpp",
    srcs = ["bin/avr-cpp.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-gcov",
    srcs = ["bin/avr-gcov.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-nm",
    srcs = ["bin/avr-nm.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-objcopy",
    srcs = ["bin/avr-objcopy.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-objdump",
    srcs = ["bin/avr-objdump.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-strip",
    srcs = ["bin/avr-strip.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "compiler_components",
    srcs = glob([
        "bin/**",
        "libexec/**/*",  # CRITICAL: Include all helper programs
        "lib/gcc/**",
        "avr/include/**",
        "avr/lib/**",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "all_files",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

"""
    
    elif platform_type == "linux":  # Linux
        build_content = """
filegroup(
    name = "intrinsic_files",
    srcs = glob([
        "lib/gcc/avr/**",
        "avr/include/**",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "include",
    srcs = glob(["avr/include/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib",
    srcs = glob(["lib/gcc/avr/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-gcc",
    srcs = ["bin/avr-gcc"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-ld",
    srcs = ["bin/avr-ld"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-ar",
    srcs = ["bin/avr-ar"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-cpp",
    srcs = ["bin/avr-cpp"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-gcov",
    srcs = ["bin/avr-gcov"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-nm",
    srcs = ["bin/avr-nm"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-objcopy",
    srcs = ["bin/avr-objcopy"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-objdump",
    srcs = ["bin/avr-objdump"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "avr-strip",
    srcs = ["bin/avr-strip"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "compiler_components",
    srcs = glob([
        "bin/**",
        "libexec/**/*",  # CRITICAL: Include all helper programs
        "lib/gcc/**",
        "avr/include/**",
        "avr/lib/**",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "all_files",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

"""
    
    else:  # Should not appear
        build_content = """

"""
    
    repository_ctx.file("BUILD.bazel", build_content)
    
    # Platform-Info für Debugging
    repository_ctx.file("PLATFORM_INFO.txt", """
Host OS: {os}
Host Architecture: {arch}
Platform Type: {platform}
Binary Extension: {ext}
Toolchain URL: {url}
""".format(
        os = os_name,
        arch = os_arch,
        platform = platform_type,
        ext = binary_extension if binary_extension else "(none)",
        url = url,
    ))

avr8_toolchain_repository = repository_rule(
    implementation = _avr8_toolchain_repository_impl,
    local = False,
    environ = ["PATH"],
)
