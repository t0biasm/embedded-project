load("//platforms/avr8/toolchain:cc_binary_avr8.bzl", "cc_binary_avr8")
load("@doxygen//:doxygen.bzl", "doxygen")

# Example AVR binary
cc_binary_avr8(
    name = "app",
    srcs = ["main.c"],
    # linkopts = [
    #     "-mmcu=atmega32u4",
    # ],
    deps = [
        "//machine/sumobotBlackMagic/components/sysHwCfg/code:sysHwCfg_init",
    ],
)

doxygen(
    name = "doxygen",

    configurations = [
        "PROJECT_NAME = Arduino Leonardo SW",
        "GENERATE_HTML = YES",
        "GENERATE_LATEX = NO",
        "USE_MDFILE_AS_MAINPAGE = machine/sumobotBlackMagic/README.md",
        "EXTRACT_ALL = YES",
        "EXTRACT_PRIVATE = YES",
        "EXTRACT_STATIC = YES",
        "RECURSIVE = YES",
        "SOURCE_BROWSER = YES",
        "GENERATE_HTML = YES",
        "GENERATE_LATEX = NO",
        "HAVE_DOT = YES",
        "INCLUDE_GRAPH = YES",
        "INCLUDED_BY_GRAPH = YES",
        "CALL_GRAPH = YES",
        "CALLER_GRAPH = YES",
        "GRAPHICAL_HIERARCHY = YES",
        "DIRECTORY_GRAPH = YES",
        "DOT_IMAGE_FORMAT = svg",
        "INTERACTIVE_SVG = YES",
        "DOT_GRAPH_MAX_NODES = 150",
        "MAX_DOT_GRAPH_DEPTH = 0",
        "JAVADOC_BANNER = YES",
    ],

    # The output of the genrule will be included in the documentation.
    # The genrule will be executed when the documentation is generated.
    srcs = [
        # WARNING: By adding this, the main target will be built
        # and only the output files `libmain.so` and `libmain.a`
        # will be passed to Doxygen, which is likely not what you want.
        # ":main"
    ],

    # The sources of the main target and its dependencies will be included.
    # No compilation will be performed, so compile error won't be reported.
    deps = [
        "//machine/sumobotBlackMagic:app"
    ],
)
