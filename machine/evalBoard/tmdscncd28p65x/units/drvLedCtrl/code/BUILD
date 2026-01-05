filegroup(
    name = "srcs",
    srcs = glob(["*.c"]),
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)

filegroup(
    name = "hdrs",
    srcs = glob(["*.h"]),
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)

cc_library(
    name = "drvLedCtrl",
    srcs = [":srcs"],
    hdrs = [":hdrs"],
    deps = [
        "//platforms/c2000/mcal/f28p65/code:mcal_f28p65x",
    ],
    includes = ["."],
    visibility = ["//machine/evalBoard/tmdscncd28p65x:__subpackages__"],
)
