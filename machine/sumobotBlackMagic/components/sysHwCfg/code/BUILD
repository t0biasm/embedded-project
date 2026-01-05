filegroup(
    name = "sources",
    srcs = glob(["*.c"]),
    visibility = ["//machine/sumobotBlackMagic:__subpackages__"],
)

filegroup(
    name = "headers",
    srcs = glob(["*.h"]),
    visibility = ["//machine/sumobotBlackMagic:__subpackages__"],
)

cc_library(
    name = "sysHwCfg_init",
    srcs = [":sources"],
    hdrs = [":headers"],
    deps = [],
    includes = ["."],
    visibility = ["//machine/sumobotBlackMagic:__subpackages__"],
)
