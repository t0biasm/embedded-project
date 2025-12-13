load(":clang_format.bzl", "clang_format_check")

# genrule(
#     name = "clang_format",
#     srcs = ["//machine/evalBoard/arduinoLeonardo:app"],
#     outs = ["//machine/evalBoard/tmdscncd28p65x/swe/app/main.c"],
#     cmd = """
#         for src in $(SRCS); do
#             out=$$(echo $$src | sed 's|.*/||')
#             clang-format -style=Google $$src > $(RULEDIR)/$$out
#         done
#     """,
#     tools = ["@llvm_toolchain//:clang-format"],  # if using external clang-format
# )

# genrule(
#     name = "clang_format",
#     srcs = ["//machine/evalBoard/tmdscncd28p65x/swe/app/main.c"],
#     srcs = glob(["*.cpp", "*.h"]),
#     outs = ["format.stamp"],
#     cmd = """
#         clang-format -i -style=LLVM $(SRCS)
#         touch $@
#     """,
#     local = 1,  # Must run locally to modify source files
# )

# genrule(
#     name = "clang_format",
#     srcs = [],
#     outs = ["clang_format.txt"],
#     cmd = "clang-format -i machine/evalBoard/tmdscncd28p65x/swe/app/main.c",
#     tags = ["manual", "no-sandbox"],
# )

# genrule(
#     name = "clang_format_check",
#     srcs = [],
#     outs = ["clang_format_check.txt"],
#     cmd = "clang-format --dry-run --Werror machine/evalBoard/tmdscncd28p65x/swe/app/main.c",
#     tags = ["manual", "no-sandbox"],
# )

clang_format_check(
    name = "format_check",
)
