# Embedded Project
Repository for embedded software development

## Checks

clang format check
```
bazel test //tools/llvm:clang_format_check
bazel test //tools/llvm:clang_format_check --test_arg=machine/evalBoard
bazel test //tools/llvm:clang_format_check --test_env=BUILD_WORKSPACE_DIRECTORY=C:/_git/embedded-project_v1/embedded-project
```

clang format fix
```
bazel run //tools/llvm:clang_format_fix
```

## Prerequisites
- Bazel version 8.1.1
