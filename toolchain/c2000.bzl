C2000_COMPILER_FLAGS = [
    "--c99",
    "--compile_only",
    "%{source_file}", 
    "--define=CPU1",
    "--define=__TMS320C2000__",
    "--define=__TMS320C28XX__",
    "--float_support=fpu32",
    # "-I=%{include_paths}",
    "--output_file=%{output_file}",
    "--preproc_dependency=%{dependency_file}",
    "--preproc_with_compile",
]

C2000_ARCHIVER_FLAGS_APP = [
    "-a", # Adds the specified files to the library
    "%{output_execpath}",
    # "%{output_assembly_file}",
]


C2000_LINKER_FLAGS_APP = [
    "--run_linker",
    "--output_file=%{output_execpath}",
]

C2000_LINKER_OPTIONS_APP = [
    "--opt_level=4",
]