py_test(
    name = "clang_format_check",
    srcs = ["clang_format_check.py"],
    main = "clang_format_check.py",
    python_version = "PY3",
    visibility = ["//visibility:public"],
    tags = [
        "format",
        "manual",  # Don't run automatically in wildcard builds
        "external",  # Accesses files outside the sandbox
    ],
    env = {
        "BUILD_WORKSPACE_DIRECTORY": "C:/_git/embedded-project_v1/embedded-project",
    },
)

py_binary(
    name = "clang_format_fix",
    srcs = ["clang_format_fix.py"],
    main = "clang_format_fix.py",
    python_version = "PY3",
    visibility = ["//visibility:public"],
    tags = [
        "format",
        "manual",  # Don't run automatically in wildcard builds
        "external",  # Accesses files outside the sandbox
    ],
    env = {
        "BUILD_WORKSPACE_DIRECTORY": "C:/_git/embedded-project_v1/embedded-project",
    },
)
