#!/usr/bin/env python3
"""
Clang-format checker for C/C++ source files.
Recursively checks all .c and .h files in the specified path.
"""

import os
import sys
import subprocess
import argparse
from pathlib import Path


def get_workspace_root():
    """Get the workspace root directory."""
    # Bazel sets these environment variables
    workspace = os.environ.get('BUILD_WORKSPACE_DIRECTORY')
    if workspace:
        return Path(workspace)
    
    # Fallback: try to find workspace root from TEST_SRCDIR
    test_srcdir = os.environ.get('TEST_SRCDIR')
    if test_srcdir:
        # Look for _main or workspace name
        for entry in Path(test_srcdir).iterdir():
            if entry.is_dir() and entry.name != '_main':
                continue
            if entry.name == '_main':
                return entry
        return Path(test_srcdir)
    
    # Last fallback: current directory
    return Path.cwd()


def find_source_files(root_path):
    """Recursively find all .c and .h files in the given path."""
    source_files = []
    extensions = ('.c', '.h')
    
    for root, dirs, files in os.walk(root_path):
        # Skip common build/cache directories
        dirs[:] = [d for d in dirs if d not in ['bazel-out', 'bazel-bin', 
                                                  'bazel-testlogs', 'bazel-genfiles',
                                                  'bazel-workspace', '.git', 'output']]
        
        for file in files:
            if file.endswith(extensions):
                source_files.append(os.path.join(root, file))
    
    return sorted(source_files)


def check_clang_format(file_path):
    """
    Check if a file is properly formatted using clang-format.
    Returns True if formatted correctly, False otherwise.
    """
    try:
        # Run clang-format with --dry-run and --Werror
        # This will return non-zero if formatting changes are needed
        result = subprocess.run(
            ['clang-format', '--dry-run', '--Werror', file_path],
            capture_output=True,
            text=True,
            check=False
        )
        
        if result.returncode != 0:
            print(f"FAIL: {file_path}")
            if result.stderr:
                print(f"  {result.stderr.strip()}")
            return False
        
        return True
        
    except FileNotFoundError:
        print("ERROR: clang-format not found in PATH")
        print("Please install clang-format and ensure it's in your PATH")
        sys.exit(1)
    except Exception as e:
        print(f"ERROR checking {file_path}: {e}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description='Check C/C++ files with clang-format'
    )
    parser.add_argument(
        'path',
        nargs='?',
        default=None,
        help='Path to check relative to workspace root (default: entire workspace)'
    )
    
    args = parser.parse_args()
    
    # Get workspace root
    workspace_root = get_workspace_root()
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
    
    print(f"Checking clang-format in: {check_path}")
    print("-" * 60)
    
    # Find all source files
    source_files = find_source_files(str(check_path))
    
    if not source_files:
        print("No .c or .h files found in the specified path")
        sys.exit(0)
    
    print(f"Found {len(source_files)} source file(s)")
    print("-" * 60)
    
    # Check each file
    failed_files = []
    for file_path in source_files:
        if not check_clang_format(file_path):
            failed_files.append(file_path)
    
    print("-" * 60)
    
    # Summary
    if failed_files:
        print(f"\nFAILED: {len(failed_files)} file(s) need formatting:")
        for file_path in failed_files:
            # Show path relative to workspace for readability
            try:
                rel_path = Path(file_path).relative_to(workspace_root)
                print(f"  - {rel_path}")
            except ValueError:
                print(f"  - {file_path}")
        print("\nTo fix, run:")
        print("  clang-format -i <file>")
        sys.exit(1)
    else:
        print(f"\nSUCCESS: All {len(source_files)} file(s) are properly formatted")
        sys.exit(0)


if __name__ == '__main__':
    main()
