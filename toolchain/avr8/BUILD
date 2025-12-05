"""AVR Toolchain BUILD file"""

load(":avr_toolchain_config.bzl", "avr_cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

# Toolchain config
avr_cc_toolchain_config(
    name = "avr_toolchain_config",
    cpu = "avr",
)

# Filegroup for all compiler files
filegroup(
    name = "all_files",
    srcs = [
        "@avr8_compiler//:compiler_files",
    ],
)

filegroup(name = "empty")

# CC Toolchain
cc_toolchain(
    name = "avr_cc_toolchain",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":empty",
    linker_files = ":all_files",
    objcopy_files = ":all_files",
    strip_files = ":all_files",
    supports_param_files = 0,
    toolchain_config = ":avr_toolchain_config",
    toolchain_identifier = "avr-toolchain",
)

# Toolchain type
toolchain(
    name = "avr8_toolchain_windows",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        ":avr",
    ],
    toolchain = ":avr_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# Constraint for AVR CPU
constraint_setting(name = "cpu")

constraint_value(
    name = "avr",
    constraint_setting = ":cpu",
)

# Platform definition for ATmega328p
platform(
    name = "atmega328p",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
        ":avr",
    ],
    exec_properties = {
        "mcu": "atmega328p",
        "f_cpu": "16000000UL",
    },
)

# Platform definition for ATmega32u4
platform(
    name = "atmega32u4",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
        ":avr",
    ],
    exec_properties = {
        "mcu": "atmega32u4",
        "f_cpu": "16000000UL",
    },
)
