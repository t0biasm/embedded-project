filegroup(
    name = "linker_scripts_app",
    srcs = ["app.ldscript"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "linker_cmd_app",
    srcs = [
        "app.ldscript",
    ],
    outs = ["linker_app.cmd"],
    cmd = "cat $(SRCS) > $@",
    visibility = ["//visibility:public"],
)
