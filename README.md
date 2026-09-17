# CTG Lab Website (`ctglab.github.io`)

Development repository for the CTG Lab academic website. Built with **Hugo**, styled via **Bootstrap**, and enhanced with custom dark mode architecture, layout alignments, and automated image optimization scripts.

---

## 🚀 Key Improvements & Architectural Highlights

### 🌓 Persistent, Flicker-Free Dark Mode Architecture
- **Zero FOUC (Flash of Unstyled Content)**: Implemented an anti-flicker, synchronous inline script in `baseof.html` and `head.html` that executes prior to page paint, accounting for both `localStorage` state and system preferences (`prefers-color-scheme`).
- **Native Canvas Pre-Rendering**: Injected `<meta name="color-scheme" content="light dark">` and inline `:root.dark-mode` rules to prevent white canvas flashing across all routes (`Home`, `Publications`, `Projects`, `News`, `Contacts`).
- **Tailwind-Inspired Theme Toggle**: Lightweight, interactive UI switcher supporting seamless light/dark mode transitions.

### 🎨 Unified Visual Identity
- **Standardized Surface Palette**: Header navigation, card components, title banners, and address details share a unified surface tone (`#1e1e1e`) with consistent borders (`#333333`) and drop shadows (`0 4px 15px rgba(0,0,0,0.4)`).
- **Dark Mode Google Maps**: Embedded map `iframe`s automatically invert and adjust saturation/contrast in dark mode to seamlessly blend with the UI.

### 📐 Layout & Typography Refinements
- **Global News Alignment**: Standardized row alignment (`align-items-center`) and flexbox structures across `layouts/news/` to fix vertical text/image misalignment.
- **Fluid Image Framing**: Standardized image wrappers (`object-fit: cover`) to eliminate cropped images and layout shifts without breaking aspect ratios.

---

## ⚡ Image Optimization Pipeline (`optimize.sh`)

The repository includes an automated optimization script (`optimize.sh`) to keep repository size minimal and speed up page load performance.

### Script Workflow:
1. **WebP Conversion**: Scans the project for `.jpg`, `.jpeg`, and `.png` files (excluding `.git/`, `public/`, and `resources/`) and converts them to `.webp` at quality `82` using `cwebp`.
2. **Reference Replacement**: Updates local asset paths inside `content/*.md`, `layouts/*.html`, and Hugo configuration files (`hugo.*` / `config.*`), while strictly preserving external HTTP(S) image links.
3. **Automated Cleanup**: Deletes original heavy images (`.jpg`, `.jpeg`, `.png`) after conversion.

### Usage:
```bash
chmod +x optimize.sh
./optimize.sh
```

---

## 🛠️ Local Development & Contributing

### Prerequisites
- [Hugo](https://gohugo.io/) (Extended edition recommended)
- `cwebp` (WebP image encoder)

### Commands
```bash
# Clone the repository
git clone https://github.com/ctglab/ctglab.github.io.git
cd ctglab.github.io

# Start local server
hugo server

# Open local environment
# http://localhost:1313/
```

---

## 🔀 Branch & Merge Guidelines

When opening a Pull Request (PR) or merging changes into `main`:
1. Ensure all new assets are run through `./optimize.sh`.
2. Verify that `baseof.html` retains the inline anti-flicker script in the `<head>` section.
3. Test dark mode transitions across all navigation routes (`Home`, `Publications`, `Projects`, `News`, `Contacts`).
1. Ensure all new assets are run through `./optimize.sh`.
2. Verify that `baseof.html` retains the inline anti-flicker script in the `<head>` section.
3. Test dark mode transitions across all navigation routes (`Home`, `Publications`, `Projects`, `News`, `Contacts`).
