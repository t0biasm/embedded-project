C2000_COMPILER_FLAGS = [
    ## Input sources files .c/.h
    "%{source_file}",
    ## Output file .o
    "--output_file=%{output_file}",
    ## Processor Options
    "-v28",                                     # Specifies TMS320C28x architecture.  The default and only value accepted.
    "--abi=eabi",                               # Selects application binary interface.
    "--float_support=fpu32",                    # Defines the __TMS320C28XX_FPU32__ to 1.
    "--unified_memory",                         # -mt, Generates code for the unified memory model
    # "--div_support=idiv0",                      # Enables support for fast integer division using hardware extensions
    ## Optimization options
    "--opt_level=off",                          # Optimization Level                                 
    ## Debug Options
    "--symdebug:dwarf",                         # -g, Enables symbolic debugging.
    ## Control Options
    "--compile_only",                           # Only compile (without linking) 
    ## Language Options
    "--c99",                                    # Processes C files according to the ISO C99 standard.
    ## Parser Preprocessing Options
    "--preproc_dependency=%{dependency_file}",  # Invoke file with preprocessed dependencies
    "--preproc_with_compile",                   # Continues compilation after preprocessing with any of the -pp<x> options that normally disable compilation.
    ## Predefined Macro Options
    "--define=__TMS320C2000__",                 # Defined for C28x processor
    "--define=__TMS320C28XX__",                 # Defined if target is C28x
    ## Diagnostic Message Options
    "--display_error_number",                   # Displays a diagnostic's identifiers along with its text.
    # "--display_wrap=off",                       # Wrap diagnostic messages (default is on).
    "--verbose_diagnostics",                    # Provides verbose diagnostic messages that display the original source with line-wrap.
    ## Run-Time Model Options
    "--gen_data_subsections=on",                # Place all aggregate data (arrays, structs, and unions) into subsections.
    "--gen_func_subsections=on",                # Puts each function in a separate subsection in the object file.
    ## Assembler Options
    # "--keep_asm",                               # Keeps the assembly language (.asm) file.
    # "--preproc_asm",                            # Preprocesses assembly source, expands assembly macros.
]

C2000_ASSEMBLER_FLAGS = [
    ## Input sources files .c/.h
    "%{source_file}",
    ## Output file .o
    "--output_file=%{output_file}",
    ## Processor Options
    "-v28",                                     # Specifies TMS320C28x architecture.  The default and only value accepted.
    "--abi=eabi",                               # Selects application binary interface.
    "--float_support=fpu32",                    # Defines the __TMS320C28XX_FPU32__ to 1.
    "--unified_memory",                         # -mt, Generates code for the unified memory model
    # "--div_support=idiv0",                      # Enables support for fast integer division using hardware extensions
    ## Optimization options
    "--opt_level=off",                          # Optimization Level                                 
    ## Debug Options
    "--symdebug:dwarf",                         # -g, Enables symbolic debugging.
    ## Control Options
    "--compile_only",                           # Only compile (without linking) 
    ## Language Options
    "--c99",                                    # Processes C files according to the ISO C99 standard.
    ## Parser Preprocessing Options
    "--preproc_with_compile",                   # Continues compilation after preprocessing with any of the -pp<x> options that normally disable compilation.
    ## Predefined Macro Options
    "--define=__TMS320C2000__",                 # Defined for C28x processor
    "--define=__TMS320C28XX__",                 # Defined if target is C28x
    ## Diagnostic Message Options
    "--display_error_number",                   # Displays a diagnostic's identifiers along with its text.
    # "--display_wrap=off",                       # Wrap diagnostic messages (default is on).
    "--verbose_diagnostics",                    # Provides verbose diagnostic messages that display the original source with line-wrap.
    ## Run-Time Model Options
    "--gen_data_subsections=on",                # Place all aggregate data (arrays, structs, and unions) into subsections.
    "--gen_func_subsections=on",                # Puts each function in a separate subsection in the object file.
    ## Assembler Options
    # "--keep_asm",                               # Keeps the assembly language (.asm) file.
    # "--preproc_asm",                            # Preprocesses assembly source, expands assembly macros.
]

C2000_ARCHIVER_FLAGS_APP = [
    # "-a", # Adds the specified files to the library
    "-r", # Replaces the specified members in the library.
    "%{output_execpath}",
]

C2000_LINKER_FLAGS_APP = [
    ## Basic Options
    "--abi=eabi",                               # Selects application binary interface. Must be specified before the --run_linker option
    "--run_linker",                             # Run linker
    "--output_file=%{output_execpath}",         # Generate output executable
    "--map_file=%{output_execpath}.map",        # Generate map file
    ## File Search Path Options
    "--disable_auto_rts",                       #
    ## Diagnostic Options
    "--display_error_number",                   # Display error/warning numbers of linker issues
    "--warn_sections",                          #
    ## Linker Output Options
    "--xml_link_info=%{output_execpath}_linkInfo.xml",
    "--mapfile_contents=sym_defs",              # Mechanism to control information within map file. Defined symbols per file
    ## Runtime Environment Options
    "--rom_model",                              # Select ROM for code placement?
]

C2000_LINKER_OPTIONS_APP = [
    "--opt_level=4",
]