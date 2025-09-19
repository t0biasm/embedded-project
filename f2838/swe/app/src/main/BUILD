# constraint_value(
#     name = "f2838",
#     constraint_setting = "@platforms//cpu:cpu",
# )

# platform(
#     name = "c2000_f2838",
#     constraint_values = [
#         # "@platforms//os:windows",
#         "f2838",
#     ],
# )

cc_binary(
    name = "main",
    srcs = [
        "main.c",
    ],
    # linkopts = [
    #     "//f2838/swe/app/linker:linker_script",
    # ]
    # deps = [
    #     "//f2838/swe/app/linker:linker_script",
    # ]
    # target_compatible_with = [":c2000_f2838"]
)