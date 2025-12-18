# Embedded Project
Repository for embedded software development

## Checks

clang format check
```
bazel run //tools/llvm:clang_format_check
bazel run //tools/llvm:clang_format_check -- machine/evalBoard/
```

clang format fix
```
bazel run //tools/llvm:clang_format_fix
bazel run //tools/llvm:clang_format_fix -- machine/evalBoard/
```

## Prerequisites
- Bazel version 8.1.1
