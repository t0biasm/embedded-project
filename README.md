# Embedded Project
Repository for embedded software development

## Prerequisites
### Tools
Necessary tools
- Bazel version 8.1.1
- python 3.x

Recommended tools
- LLVM (e.g. clang-format, clang-tidy)

## Checks
### Source File Format
Checking Source files `.c/.h` format with clang-format
```
bazel run //tools/llvm:clang_format_check
bazel run //tools/llvm:clang_format_check -- machine/evalBoard/
```

Fixing Source files `.c/.h` format with clang-format
```
bazel run //tools/llvm:clang_format_fix
bazel run //tools/llvm:clang_format_fix -- machine/evalBoard/
```

### Source File Naming Convention

