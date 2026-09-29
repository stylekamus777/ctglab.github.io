#!/bin/bash

# Target directories to audit
IMAGE_DIR="static/images"
DOCS_DIR="static/docs"
SEARCH_DIRS="content layouts data themes config.toml"

echo "=== Starting project asset audit for unused files ==="

unused_count=0

# Audit function for files in a given directory
audit_assets() {
    local target_dir="$1"
    local asset_type="$2"
    
    if [ -d "$target_dir" ]; then
        echo "--- Scanning $asset_type in $target_dir ---"
        
        find "$target_dir" -type f | while read -r asset; do
            filename=$(basename "$asset")
            
            # Search for exact filename reference across project files
            if grep -rnw "$SEARCH_DIRS" -e "$filename" >/dev/null 2>&1; then
                echo "[IN USE] $asset"
            else
                echo "[ORPHAN - UNUSED] $asset"
                # Uncomment the line below to allow automatic deletion during scan:
                # rm "$asset"
                ((unused_count++))
            fi
        done
    else
        echo "--- Directory $target_dir not found, skipping $asset_type audit. ---"
    fi
}

# Run audit for images
audit_assets "$IMAGE_DIR" "Images"

# Run audit for documents/PDFs (uncomment if you use static/docs)
# audit_assets "$DOCS_DIR" "Documents"

echo "=== Audit completed. Total potential orphan assets found: $unused_count ==="