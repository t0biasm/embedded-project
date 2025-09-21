C2000_COMPILER_FLAGS = [
    "--c99",
    "--compile_only",
    "%{source_file}", 
    "--define=CPU1",
    "--define=__TMS320C2000__",
    "--float_support=fpu32",
    # "-I=%{include_paths}",
    "--output_file=%{output_file}",
    "--preproc_dependency=%{dependency_file}",
    "--preproc_with_compile",
    # "--run_linker",
]

C2000_LINKER_FLAGS_APP = [
    "--opt_level=4",
    # "%{output_file}",
    # "%{linker_input_files}",
    # "%{libraries_to_link}",
    # "--output_file=%{output_execpath}",
]

C2000_LINKER_OPTIONS_APP = [
    "--opt_level=4",
    # "%{output_file}",
    # "%{linker_input_files}",
    # "%{libraries_to_link}",
    # "--output_file=%{output_execpath}",
]