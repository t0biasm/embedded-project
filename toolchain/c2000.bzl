C2000_COMPILER_FLAGS = [
    # "--compile_only",
    "--c99",
    "%{source_file}", 
    "--define=CPU1",
    "--float_support=fpu32",
    "--output_file=%{output_file}",
    "--preproc_dependency=%{dependency_file}",
    "--preproc_with_compile",
    "--run_linker",
]

C2000_LINKER_FLAGS_APP = [
    "--opt_level=4",
    # "%{output_file}",
    # "%{linker_input_files}",
    # "%{libraries_to_link}",
    # "--output_file=%{output_execpath}",
]