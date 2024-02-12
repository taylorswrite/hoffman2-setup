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

# Load R module, if necessary
module load R

# Define a personal library path
LIBRARY_PATH="$HOME/R/library"

# Ensure the library directory exists
mkdir -p "$LIBRARY_PATH"

# Install each package listed in the file
while IFS= read -r package; do
    echo "Installing R package: $package into $LIBRARY_PATH"
    Rscript -e ".libPaths('$LIBRARY_PATH'); install.packages('$package', repos='http://cran.rstudio.com/', lib='$LIBRARY_PATH')"
done < "$FILENAME"

echo "All packages installed."
exit 0