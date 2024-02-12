#!/bin/bash

# Check if the file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILENAME=$1

# Check if the file exists
if [ ! -f "$FILENAME" ]; then
    echo "File not found!"
    exit 1
fi

# Install each package listed in the file
while IFS= read -r package; do
    echo "Installing Julia package: $package"
    julia -e "using Pkg; Pkg.add(\"$package\")"
done < "$FILENAME"

echo "All packages installed."
