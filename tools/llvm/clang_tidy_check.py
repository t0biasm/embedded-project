#!/usr/bin/env python3
"""
clang-tidy checker for C/C++ source files.
Recursively checks all .c and .h files in the specified path.
"""

import os
import sys
import re
import subprocess
import argparse
from pathlib import Path


class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    RESET = '\033[0m'

def find_source_files(root_path):
    """Recursively find all .c and .h files in the given path."""
    source_files = []
    extensions = ('.c', '.h')
    
    for root, dirs, files in os.walk(root_path):
        # Skip common build/cache directories
        dirs[:] = [d for d in dirs if d not in ['bazel-out', 
                                                'bazel-bin', 
                                                'bazel-embedded-project',
                                                'bazel-testlogs', 
                                                'bazel-genfiles',
                                                'bazel-workspace', 
                                                '.git', 
                                                'output']]
        
        for file in files:
            if file.endswith(extensions):
                source_files.append(os.path.join(root, file))
    
    return sorted(source_files)

def check_clang_tidy(file_path, checks, compile_flags):
    """Run clang-tidy on a single file and return filtered output."""
    cmd = [
        'clang-tidy',
        file_path,
        f'-checks={checks}',
        '--warnings-as-errors=readability-*',
        '--quiet',
        '--'
    ] + compile_flags
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout + result.stderr, result.returncode
    
        # if result.returncode != 0:
        #     print(f"{Colors.RED}FAIL:{Colors.RESET} {file_path}")
        #     if result.stderr:
        #         print(f"  {result.stderr.strip()}")
        #     return False
        
        # return True
    
    except FileNotFoundError:
        print("ERROR: clang-tidy not found in PATH")
        print("Please install clang-tidy and ensure it's in your PATH")
        sys.exit(1)
    except Exception as e:
        print(f"ERROR checking {file_path}: {e}")
        return False



# def check_clang_tidy(file_path):
#     """
#     Check if a file is properly formatted using clang-tidy.
#     Returns True if formatted correctly, False otherwise.
#     """
#     try:
#         # Run clang-tidy with --dry-run and --Werror
#         # This will return non-zero if formatting changes are needed
#         result = subprocess.run(
#             ['clang-tidy', '--dry-run', '--Werror', file_path],
#             capture_output=True,
#             text=True,
#             check=False
#         )
        
#         if result.returncode != 0:
#             print(f"{Colors.RED}FAIL:{Colors.RESET} {file_path}")
#             if result.stderr:
#                 print(f"  {result.stderr.strip()}")
#             return False
        
#         return True

def should_filter_line(line, filter_patterns):
    """Check if a line should be filtered out."""
    for pattern in filter_patterns:
        if re.search(pattern, line):
            return True
    return False

def filter_blocks(output, filter_checks):
    """
    Filter entire blocks based on check types in brackets.
    A block starts with a line containing 'error:' or 'warning:' and a check in brackets.
    The block continues until a blank line or the start of a new block.
    
    Args:
        output: The full clang-tidy output string
        filter_checks: List of check patterns to filter (e.g., ['clang-diagnostic-error'])
    
    Returns:
        Filtered output string with matching blocks removed
    """
    lines = output.split('\n')
    filtered_lines = []
    i = 0
    
    while i < len(lines):
        line = lines[i]
        
        # Check if this line starts a new block (contains ': error: ' or ': warning: ' with check in brackets)
        is_block_start = False
        should_filter_block = False
        
        if (': error: ' in line or ': warning: ' in line):
            # Look for check pattern in brackets at the end of the line
            bracket_match = re.search(r'\[([^\]]+)\]\s*', line)
            if bracket_match:
                is_block_start = True
                check_name = bracket_match.group(1)
                
                # Check if this block should be filtered
                for filter_pattern in filter_checks:
                    if re.search(filter_pattern, check_name):
                        should_filter_block = True
                        break
        
        if is_block_start:
            if should_filter_block == False:
                # Skip this entire block (skip lines until blank line or next block)
                i += 1
                while i < len(lines):
                    next_line = lines[i]
                    # Stop if we hit a blank line
                    # if not next_line.strip():
                    #     i += 1  # Also skip the blank line
                    #     break
                    # Stop if we hit the start of a new block
                    if ((': error:' in next_line or ': warning:' in next_line) and 
                        re.search(r'\[([^\]]+)\]\s*', next_line)):
                        break
                    i += 1
            else:
                # print(f"Keep: {check_name}")
                # Keep this block
                filtered_lines.append(line)
                i += 1
                # Continue adding lines until blank line or next block
                while i < len(lines):
                    next_line = lines[i]
                    if not "generated." in next_line:
                        filtered_lines.append(next_line)
                    if not next_line.strip():
                        i += 1
                        break
                    # Check if next line starts a new block
                    if (i + 1 < len(lines) and 
                        ('error:' in lines[i + 1] or 'warning:' in lines[i + 1]) and 
                        re.search(r'\[([^\]]+)\]\s*', lines[i + 1])):
                        i += 1
                        break
                    i += 1
        else:
            # Not a block start, keep the line
            filtered_lines.append(line)
            i += 1
    
    return '\n'.join(filtered_lines)


def main():
    parser = argparse.ArgumentParser(
        description='Check C/C++ files with clang-tidy'
    )
    parser.add_argument(
        'path',
        nargs='?',
        default=None,
        help='Path to check relative to workspace root (default: entire workspace)'
    )
    
    args = parser.parse_args()
    
    # Get workspace root
    workspace_root = Path(os.environ.get('BUILD_WORKSPACE_DIRECTORY'))
    print(f"Workspace root: {workspace_root}")
    
    # Determine the path to check
    if args.path:
        check_path = workspace_root / args.path
    else:
        check_path = workspace_root
    
    # Resolve to absolute path
    check_path = check_path.resolve()
    
    if not check_path.exists():
        print(f"ERROR: Path does not exist: {check_path}")
        print(f"  Workspace root: {workspace_root}")
        print(f"  Requested path: {args.path}")
        sys.exit(1)
    
    if not check_path.is_dir():
        print(f"ERROR: Path is not a directory: {check_path}")
        sys.exit(1)
    
    print(f"Checking clang-tidy in: {check_path}")
    print("-" * 60)
    
    # Find all source files
    source_files = find_source_files(str(check_path))
    
    if not source_files:
        print("No .c or .h files found in the specified path")
        sys.exit(0)
    
    print(f"Found {len(source_files)} source file(s)")
    print("-" * 60)

    # Filter patterns (regex)
    filter_patterns = [
        # Add check patterns that should be kept
        r'readability-identifier-naming,-warnings-as-errors',
    ]

    path_exceptions = [
        r'os',
        r'platforms',
        r'tools',
    ]
    
    # Check each file    
    all_output = []
    failed_files = []
    error_count = 0
    checks = '-*,readability-identifier-naming'
    # Compile flags (these should ideally come from your build system)
    compile_flags = [
        # '-iquote', '.',
        # '-iquote', 'bazel-out/x64_windows-fastbuild/bin',
        '-std=c99',
        '-x', 'c',
        # Add all your other flags here
    ]
    
    # ------------------------- Run check for all files ----------------------- #
    for file_path in source_files:
        skip_path = False
        # Check if this file_path should be checked
        for path in path_exceptions:
            if re.search(path, file_path):
                skip_path = True
                break
                
        if skip_path == True:
            break

        output, returncode = check_clang_tidy(
            file_path,
            checks, 
            compile_flags
        )
        
        if output:
            # Filter output
            filtered_output = filter_blocks(output, filter_patterns)
            # Add filtered output to common output
            if filtered_output:
                failed_files.append(file_path)
                all_output.append(filtered_output)
                # Increment file error count
                if returncode != 0:
                    error_count += 1

    # ------------------------------- Print Log -------------------------------- #
    # Check if errors were found
    if all_output or failed_files:
        # Print errors
        if all_output:
            print(f"\n\n{Colors.RED}ERROR:{Colors.RESET} Following naming convention errors were found:")
            print("-" * 60)
            print('\n'.join(all_output))

        # Print Summary
        if failed_files:
            print(f"\n{Colors.RED}FAILED:{Colors.RESET} {error_count} file(s) need formatting of names:")
            print("-" * 60)
            # Print each failed file path relative to workspace
            if failed_files:
                for file_path in failed_files:
                    # Show path relative to workspace for readability
                    try:
                        rel_path = Path(file_path).relative_to(workspace_root)
                        print(f"  - {rel_path}")
                    except ValueError:
                        print(f"  - {file_path}")

        # Return error
        sys.exit(1)

    # No errors were found    
    else:
        print(f"\n{Colors.GREEN}SUCCESS:{Colors.RESET} All {len(source_files)} file(s) are properly named")
        sys.exit(0)


if __name__ == '__main__':
    main()
