#!/bin/bash

# Check if folder is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/folder"
  exit 1
fi

TARGET="$1"

# Check if folder exists
if [ ! -d "$TARGET" ]; then
  echo "Error: $TARGET is not a directory"
  exit 1
fi

# Run dot_clean recursively
echo "Running dot_clean on $TARGET..."
dot_clean "$TARGET"

echo "Finished cleaning ._ files in $TARGET"

