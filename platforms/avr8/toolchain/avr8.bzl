AVR_COMPILER_FLAGS = [
    "-c",
    ## Input sources files .c/.h
    "%{source_file}",
    ## Output file .o
    "-o",
    "%{output_file}",
    ## Options
    "-MD",
    "-Os",  # Optimize for size
    "-Wall",
    "-ffunction-sections",
    "-fdata-sections",
    "-fno-exceptions",
    "-std=c99",  # For C files
    "-O2",  # For C files
]

AVR_ASSEMBLER_FLAGS = [
    "-Os",  # Optimize for size
    "-Wall",
    "-ffunction-sections",
    "-fdata-sections",
    "-fno-exceptions",
    "-std=gnu11",  # For C files
    "-O2",  # For C files
]

AVR_ARCHIVER_FLAGS_APP = [
    # r - Replace/insert object files into the archive (creates if doesn't exist)
    # c - Create the archive without warning if it doesn't exist
    # s - Create/update symbol index (equivalent to running avr-ranlib)
    "rcs", # Adds the specified files to the library
    # Path including .a filename
    "%{output_execpath}",
]

AVR_LINKER_FLAGS_APP = [
    # "-m", "avr5",                       # Emulation mode for ATmega32U4 architecture (16-64KB flash devices)
    "-o", "%{output_execpath}",         # Generate elf file"
    "-Map=%{output_execpath}.map",      # Generate map file"
    "-static",
]

AVR_LINKER_OPTIONS_APP = [
    "--opt_level=4",
]