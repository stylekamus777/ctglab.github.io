#!/bin/bash

# Target directory where images are located
IMAGE_DIR="static/images"

echo "=== Starting WebP image conversion and cleanup ==="

# Find all JPG and PNG files recursively and convert them
find "$IMAGE_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | while read -r img; do
    # Get directory and filename without extension
    dir=$(dirname "$img")
    filename=$(basename "$img")
    name="${filename%.*}"
    
    output_webp="$dir/$name.webp"
    
    echo "Converting: $filename -> ${name}.webp"
    
    # Convert to WebP with 80% quality
    if cwebp -q 80 "$img" -o "$output_webp" >/dev/null 2>&1; then
        echo "[DELETE ORIGINAL] Removing old format: $img"
        rm "$img"
    else
        echo "[ERROR] Failed to convert $filename, keeping original."
    fi
done

echo "=== Updating references in data and content files ==="

# Automatically update image extensions to .webp in YAML, Markdown, and HTML files
find data content layouts -type f \( -name "*.yml" -o -name "*.toml" -o -name "*.md" -o -name "*.html" \) -exec sed -i 's/\.png/\.webp/g; s/\.jpg/\.webp/g; s/\.jpeg/\.webp/g' {} +

echo "=== Conversion, cleanup, and reference updates completed successfully ==="