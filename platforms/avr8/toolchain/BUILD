"""AVR Toolchain BUILD file"""
load("@bazel_skylib//rules:common_settings.bzl", "string_flag")
load(":cc_toolchain_config_avr8.bzl", "avr_cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

# --------------- Configuration strings ---------------- #
string_flag(
    name = "mcu",
    build_setting_default = "atmega32u4",
    visibility = ["//visibility:public"],
)

string_flag(
    name = "p_arch",
    build_setting_default = "avr5",
    visibility = ["//visibility:public"],
)

string_flag(
    name = "f_cpu",
    build_setting_default = "16000000UL",
    visibility = ["//visibility:public"],
)

# Toolchain config
avr_cc_toolchain_config(
    name = "cc_toolchain_config_avr8",
    mcu = ":mcu",
    p_arch = ":p_arch",
    f_cpu = ":f_cpu",
)

filegroup(
    name = "compiler_binaries",
    srcs = [
        "@avr8_compiler//:avr-gcc",
        "@avr8_compiler//:avr-ar",
        "@avr8_compiler//:avr-ld",
        "@avr8_compiler//:avr-cpp",
        "@avr8_compiler//:avr-objcopy",
        "@avr8_compiler//:all_files",  # Also include all other files
    ],
)

filegroup(name = "empty")

# CC Toolchain
cc_toolchain(
    name = "avr_cc_toolchain",
    all_files = ":compiler_binaries",
    ar_files = ":compiler_binaries",
    compiler_files = ":compiler_binaries",
    dwp_files = ":empty",
    linker_files = ":compiler_binaries",
    objcopy_files = ":compiler_binaries",
    strip_files = ":compiler_binaries",
    supports_param_files = 0,
    toolchain_config = ":cc_toolchain_config_avr8",
    toolchain_identifier = "avr-toolchain",
)

# Toolchain type
toolchain(
    name = "avr8_toolchain",
    exec_compatible_with = [
        # "@platforms//os:linux",
        # "@platforms//os:windows",
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

# Platform definition for ATmega32u4
platform(
    name = "avr8",
    constraint_values = [
        "@platforms//cpu:x86_64",
        ":avr",
    ],
    exec_properties = {
        "mcu": "atmega32u4",
        "f_cpu": "16000000UL",
    },
)
