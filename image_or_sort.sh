#!/bin/bash

# Image sort by orientation
# v0.2 - 10-08-2023


# Check if 'horizontal' and 'vertical' directories exist, if not create them
mkdir -p horizontal
mkdir -p vertical

# Loop through all image files
for file in *.jpg *.jpeg *.png; do
    # Check if the file exists (this avoids issues with no matches for the file extensions)
    if [[ ! -e $file ]]; then
        continue
    fi
    
    # Get image dimensions
    dimensions=$(identify -format "%wx%h" "$file")
    
    # Extract width and height
    width=${dimensions%x*}
    height=${dimensions#*x}

    # Compare dimensions to determine orientation
    if [[ $width -gt $height ]]; then
        mv "$file" horizontal/
    elif [[ $width -lt $height ]]; then
        mv "$file" vertical/
    fi
done
