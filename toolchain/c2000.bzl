C2000_COMPILER_FLAGS = [
    "--define=CPU1",
    "--float_support=fpu32",
    "--output_file=%{output_file}",
    "--preproc_dependency=%{dependency_file}",
    "--preproc_with_compile",
    "--run_linker",
    "%{source_file}", 
]

C2000_LINKER_FLAGS = [
    "--output_file=%{output_execpath}",
]