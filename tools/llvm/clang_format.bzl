"""Bazel rule for recursive clang-format checking with runtime path argument."""

def _clang_format_check_impl(ctx):
    """Implementation of the clang_format_check rule."""
    
    # Get the clang-format file
    clang_format_file = ctx.file._clang_format
    
    # Determine if we're on Windows
    is_windows = ctx.configuration.host_path_separator == ";"
    
    if is_windows:
        # Create batch script for Windows
        script = ctx.actions.declare_file(ctx.label.name + "_check.bat")
        script_content = """@echo off
setlocal enabledelayedexpansion

REM Store the original directory (execroot) where clang-format is accessible
set EXECROOT=%CD%
set CLANG_FORMAT=%EXECROOT%\\{clang_format}

set TARGET_PATH=%~1
if "%TARGET_PATH%"=="" set TARGET_PATH=.

REM Change to workspace root
cd /d "%BUILD_WORKSPACE_DIRECTORY%"
if errorlevel 1 (
    echo ERROR: Could not change to workspace directory
    exit /b 1
)

REM Verify clang-format exists
if not exist "!CLANG_FORMAT!" (
    echo ERROR: clang-format not found at !CLANG_FORMAT!
    exit /b 1
)

set EXIT_CODE=0
set FILES_FOUND=0

REM Validate that target path exists
if not exist "%TARGET_PATH%" (
    echo ERROR: Path '%TARGET_PATH%' does not exist in workspace
    exit /b 1
)

echo Searching for C/C++ files in: %TARGET_PATH%

REM Check if target is a file or directory
if exist "%TARGET_PATH%\\*" (
    REM It's a directory - recursively find files
    for /r "%TARGET_PATH%" %%f in (*.c *.cc *.cpp *.cxx *.C *.h *.hpp *.hxx *.H) do (
        set /a FILES_FOUND+=1
        call :check_file "%%f"
    )
) else if exist "%TARGET_PATH%" (
    REM It's a file - check it directly
    set /a FILES_FOUND+=1
    call :check_file "%TARGET_PATH%"
) else (
    echo ERROR: Path '%TARGET_PATH%' does not exist
    exit /b 1
)

if !FILES_FOUND! EQU 0 (
    echo WARNING: No C/C++ files found in %TARGET_PATH%
    exit /b 0
)

echo.
echo Checked !FILES_FOUND! file(s)

if !EXIT_CODE! EQU 0 (
    echo [32m✓ All files are correctly formatted![0m
) else (
    echo [31m✗ Some files need formatting. Run clang-format to fix them.[0m
)

exit /b !EXIT_CODE!

:check_file
set FILE=%~1
set FILE_DIR=%~dp1

REM Find .clang-format config
call :find_config "%FILE_DIR%"
set CONFIG_FILE=!CONFIG_RESULT!

if "!CONFIG_FILE!"=="" (
    echo Checking %FILE% with default style
    "!CLANG_FORMAT!" --dry-run -Werror "%FILE%" 2>&1
) else (
    echo Checking %FILE% with config !CONFIG_FILE!
    "!CLANG_FORMAT!" --style=file:"!CONFIG_FILE!" --dry-run -Werror "%FILE%" 2>&1
)

if errorlevel 1 (
    echo ERROR: %FILE% is not formatted correctly
    set EXIT_CODE=1
)
exit /b 0

:find_config
set SEARCH_DIR=%~1
:find_config_loop
if exist "%SEARCH_DIR%.clang-format" (
    set CONFIG_RESULT=%SEARCH_DIR%.clang-format
    exit /b 0
)
REM Move up one directory
for %%I in ("%SEARCH_DIR%..") do set SEARCH_DIR=%%~fI\\
if "%SEARCH_DIR%"=="%SEARCH_DIR:~0,-1%" (
    set CONFIG_RESULT=
    exit /b 1
)
if "%SEARCH_DIR%"==":\\" (
    set CONFIG_RESULT=
    exit /b 1
)
if "%SEARCH_DIR%"==":/" (
    set CONFIG_RESULT=
    exit /b 1
)
goto find_config_loop
""".format(clang_format = clang_format_file.path.replace("/", "\\"))
    else:
        # Create bash script for Unix-like systems
        script = ctx.actions.declare_file(ctx.label.name + "_check.sh")
        script_content = """#!/bin/bash
set -e

# Store the original directory (execroot) where clang-format is accessible
EXECROOT=$(pwd)
CLANG_FORMAT="$EXECROOT/{clang_format}"

TARGET_PATH="${{1:-.}}"
EXIT_CODE=0

# Change to workspace root
cd "$BUILD_WORKSPACE_DIRECTORY"
if [ $? -ne 0 ]; then
    echo "ERROR: Could not change to workspace directory"
    exit 1
fi

# Verify clang-format exists
if [ ! -x "$CLANG_FORMAT" ]; then
    echo "ERROR: clang-format not found at $CLANG_FORMAT"
    exit 1
fi

# Validate that target path exists
if [ ! -e "$TARGET_PATH" ]; then
    echo "ERROR: Path '$TARGET_PATH' does not exist in workspace"
    exit 1
fi

# Function to find the appropriate .clang-format file for a given source file
find_clang_format_config() {{
    local src_file="$1"
    local src_dir=$(dirname "$src_file")
    
    # Search upward from the file's directory
    local current_dir="$src_dir"
    while [ "$current_dir" != "." ] && [ "$current_dir" != "/" ] && [ -n "$current_dir" ]; do
        if [ -f "$current_dir/.clang-format" ]; then
            echo "$current_dir/.clang-format"
            return 0
        fi
        current_dir=$(dirname "$current_dir")
    done
    
    # Check root directory
    if [ -f ".clang-format" ]; then
        echo ".clang-format"
        return 0
    fi
    
    return 1
}}

# Find all C/C++ files in the target path
echo "Searching for C/C++ files in: $TARGET_PATH"
FILES_FOUND=0

# Check if target is a file or directory
if [ -f "$TARGET_PATH" ]; then
    # It's a file - check it directly
    FILES_FOUND=1
    
    CONFIG=$(find_clang_format_config "$TARGET_PATH")
    if [ $? -eq 0 ]; then
        echo "Checking $TARGET_PATH with config $CONFIG"
        if ! "$CLANG_FORMAT" --style=file:"$CONFIG" --dry-run -Werror "$TARGET_PATH" 2>&1; then
            echo "ERROR: $TARGET_PATH is not formatted correctly"
            EXIT_CODE=1
        fi
    else
        echo "Checking $TARGET_PATH with default style"
        if ! "$CLANG_FORMAT" --dry-run -Werror "$TARGET_PATH" 2>&1; then
            echo "ERROR: $TARGET_PATH is not formatted correctly"
            EXIT_CODE=1
        fi
    fi
elif [ -d "$TARGET_PATH" ]; then
    # It's a directory - recursively find files
    while IFS= read -r -d '' src_file; do
        FILES_FOUND=$((FILES_FOUND + 1))
        
        CONFIG=$(find_clang_format_config "$src_file")
        if [ $? -eq 0 ]; then
            echo "Checking $src_file with config $CONFIG"
            if ! "$CLANG_FORMAT" --style=file:"$CONFIG" --dry-run -Werror "$src_file" 2>&1; then
                echo "ERROR: $src_file is not formatted correctly"
                EXIT_CODE=1
            fi
        else
            echo "Checking $src_file with default style"
            if ! "$CLANG_FORMAT" --dry-run -Werror "$src_file" 2>&1; then
                echo "ERROR: $src_file is not formatted correctly"
                EXIT_CODE=1
            fi
        fi
    done < <(find "$TARGET_PATH" -type f \\( -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cxx" -o -name "*.C" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" -o -name "*.H" \\) -print0)
else
    echo "ERROR: Path '$TARGET_PATH' does not exist in workspace"
    exit 1
fi

if [ $FILES_FOUND -eq 0 ]; then
    echo "WARNING: No C/C++ files found in $TARGET_PATH"
    exit 0
fi

echo ""
echo "Checked $FILES_FOUND file(s)"

if [ $EXIT_CODE -eq 0 ]; then
    echo "✓ All files are correctly formatted!"
else
    echo "✗ Some files need formatting. Run clang-format to fix them."
fi

exit $EXIT_CODE
""".format(clang_format = clang_format_file.path)
    
    # Write the script
    ctx.actions.write(
        output = script,
        content = script_content,
        is_executable = True,
    )
    
    # Create runfiles with clang-format binary
    runfiles = ctx.runfiles(files = [clang_format_file])
    
    return [DefaultInfo(
        executable = script,
        runfiles = runfiles,
    )]

clang_format_check = rule(
    implementation = _clang_format_check_impl,
    attrs = {
        "_clang_format": attr.label(
            default = Label("@llvm_toolchain//:clang-format"),
            allow_single_file = True,
            cfg = "exec",
            doc = "The clang-format binary",
        ),
    },
    executable = True,
    doc = """
    Checks C/C++ source files with clang-format, respecting .clang-format files in subdirectories.
    
    Usage:
        bazel run //:format_check                           # Check current directory
        bazel run //:format_check -- path/to/directory      # Check specific directory
        bazel run //:format_check -- path/to/file.cpp       # Check specific file
    """,
)
