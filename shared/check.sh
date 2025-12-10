#!/bin/bash

# Check if a file argument is provided
if [ -n "$1" ]; then
    # Single file mode
    if [ -f "$1" ]; then
        echo "Running checks on: $1"
        isort "$1"
        black "$1"
        flake8 --max-line-length=120 "$1"
        ruff format "$1"
        echo ""
        echo "Done!"
    else
        echo "Error: File '$1' does not exist."
        exit 1
    fi
else
    # Modified files mode (original behavior)
    # Get all modified Python files (both staged and unstaged)
    modified_files=$(git diff --name-only --diff-filter=ACMR HEAD | grep '\.py$')
    staged_files=$(git diff --cached --name-only --diff-filter=ACMR | grep '\.py$')

    # Combine and remove duplicates
    all_files=$(echo -e "$modified_files\n$staged_files" | sort -u | grep -v '^$')

    if [ -z "$all_files" ]; then
        echo "No modified Python files found."
        exit 0
    fi

    echo "Running checks on modified Python files:"
    echo "$all_files"
    echo ""

    # Run checks on each file
    for file in $all_files; do
        if [ -f "$file" ]; then
            echo "Processing: $file"
            isort "$file"
            black "$file"
            flake8 --max-line-length=120 "$file"
            ruff format "$file"
            echo ""
        fi
    done

    echo "Done!"
fi
