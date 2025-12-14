py_test(
    name = "clang_format_check",
    srcs = ["clang_format.py"],
    main = "clang_format.py",
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
