load("//platforms/avr8/toolchain:cc_binary_avr8.bzl", "cc_binary_avr8")

# Example AVR binary
cc_binary_avr8(
    name = "app",
    srcs = ["main.c"],
    # copts = [
    #     "-mmcu=atmega32u4",
    #     "-DF_CPU=16000000UL",
    # ],
    linkopts = [
        "-mmcu=atmega32u4",
    ],
    deps = [],
)
