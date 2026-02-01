# toolchains/arm_toolchain_repository.bzl
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "read_user_netrc", "use_netrc")

def _c2000_toolchain_repository_impl(ctx):
    """
    Lädt ARM-GCC Toolchain und generiert plattformspezifische BUILD-Datei.
    """
    
    os_name = ctx.os.name
    os_arch = ctx.os.arch
    
    # Platform-Erkennung und Download (wie vorher)       
    if os_name.startswith("windows"):
        url = "https://artifactory.maierei.synology.me/artifactory/tools-local/compiler/cl2000/windows/ti-cgt-c2000_25.11.0.LTS.zip"
        sha256 = "6c8017bca7e1d18fce08403a42ed1a14a9bcead26df7dced3780ecd74ab21847"
        strip_prefix = "ti-cgt-c2000_25.11.0.LTS"
        platform_type = "windows"
        binary_extension = ".exe"

    elif os_name == "linux":
        url = "https://artifactory.maierei.synology.me/artifactory/tools-local/compiler/cl2000/linux/ti-cgt-c2000_25.11.0.LTS.tar.gz"
        sha256 = "90c9f281f91ccf6ebc712d445f0fa31e4460fad2b3268693842a79fbec2bf82a"
        strip_prefix = "ti-cgt-c2000_25.11.0.LTS"
        platform_type = "linux"
        binary_extension = ""
        
    else:
        fail("Unsupported OS: %s" % os_name)

    # Get .netrc authentification
    netrc = read_user_netrc(ctx)
    auth = use_netrc(netrc, [url], ctx.attr.auth_patterns)
    
    # Download artifact
    ctx.download_and_extract(
        url = url,
        sha256 = sha256,
        stripPrefix = strip_prefix,
        auth = auth,
    )
    
    # Plattformspezifische BUILD-Datei generieren
    if platform_type == "windows":
        # Windows braucht .exe Extensions
        build_content = """
filegroup(
    name = "ar2000",
    srcs = ["bin/ar2000.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "cl2000",
    srcs = ["bin/cl2000.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "include",
    srcs = glob(["include/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib",
    srcs = glob(["lib/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lnk2000",
    srcs = ["bin/lnk2000.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "ofd2000",
    srcs = ["bin/ofd2000.exe"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "strip2000",
    srcs = ["bin/strip2000.exe"],
    visibility = ["//visibility:public"],
)

"""
    
    elif platform_type == "linux":  # Linux
        build_content = """
filegroup(
    name = "ar2000",
    srcs = ["bin/ar2000"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "cl2000",
    srcs = ["bin/cl2000"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "include",
    srcs = glob(["include/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib",
    srcs = glob(["lib/**"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lnk2000",
    srcs = ["bin/lnk2000"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "ofd2000",
    srcs = ["bin/ofd2000"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "strip2000",
    srcs = ["bin/strip2000"],
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
    
    ctx.file("BUILD.bazel", build_content)
    
    # Platform-Info für Debugging
    ctx.file("PLATFORM_INFO.txt", """
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

c2000_toolchain_repository = repository_rule(
    implementation = _c2000_toolchain_repository_impl,
    local = False,
    environ = ["PATH"],
    attrs = {
        "auth_patterns": attr.string_dict(
        ),
    },
)
