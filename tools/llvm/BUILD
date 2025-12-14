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
    # Run outside the sandbox to access workspace files
    local = True,
    # data = ["//:.clang-format"],  # Optional: include .clang-format config
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
    # data = ["//:.clang-format"],  # Optional: include .clang-format config
)
