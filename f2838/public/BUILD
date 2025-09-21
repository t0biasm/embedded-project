load("//toolchain:debug.bzl", "debug_rule")

cc_library(
    name = "public_types_h",
    srcs = [],
    hdrs = glob(["*.h"]),
    includes = ["."],
    visibility = ["//f2838:__subpackages__"],
)

debug_rule(
    name = "check_includes",
    dep = "//f2838/public:public_types_h",
)