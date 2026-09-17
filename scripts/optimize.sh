#!/bin/bash
# Script para optimizar imágenes del proyecto a formato WebP

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR" || exit

echo "Optimizing local images..."

# 1. Convertir imágenes locales a WebP usando cwebp
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
  -not -path "*/.git/*" \
  -not -path "*/public/*" \
  -not -path "*/resources/*" -print0 | while IFS= read -r -d '' img; do
    cwebp -q 82 "$img" -o "${img%.*}.webp"
done

# 2. Reemplazar extensiones en Markdown, layouts y configuración (respetando URLs externas)
echo "Updating local img references in content, layouts, and config..."
find content/ layouts/ -type f \( -name "*.md" -o -name "*.html" \) -exec sed -i -E \
  '/https?:\/\//!s/\.png/.webp/g; /https?:\/\//!s/\.jpg/.webp/g; /https?:\/\//!s/\.jpeg/.webp/g' {} +

# Actualizar referencias si existen en la configuración de Hugo
find . -maxdepth 1 -type f \( -name "hugo.*" -o -name "config.*" \) -exec sed -i -E \
  '/https?:\/\//!s/\.png/.webp/g; /https?:\/\//!s/\.jpg/.webp/g; /https?:\/\//!s/\.jpeg/.webp/g' {} +

# 3. Eliminar imágenes originales pesadas
echo "Deleting original img (png, jpg)..."
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
  -not -path "*/.git/*" \
  -not -path "*/public/*" \
  -not -path "*/resources/*" -delete

echo "Successfully completed optimization!"