# CTGLab Website

Official repository for the Computational and Translational Genomics Laboratory website (`ctglab.github.io`), built using the **Hugo** static site generator and the customized **Timer Hugo** theme.

## Repository Structure

* `content/`: Markdown files (`.md`) containing publications, pages, and main site sections.
* `data/`: Structured YAML data files (team members, collaborators, projects, and former members).
* `layouts/`: Custom HTML templates that modify or extend the default theme structure.
* `static/`: Global static assets (images, documents, and media). Main images are optimized in WebP format within `static/images/`.
* `themes/timer-hugo/`: Directory containing the visual theme of the website.
* `config.toml`: Main Hugo project configuration file.
* `netlify.toml`: Automated deployment configuration for Netlify.

## Automation and Maintenance Tools

The repository includes custom Bash scripts designed to streamline technical maintenance:

* **`convert_to_webp.sh`**: Mass-converts all images in the static directory to WebP format (with optimized 80% quality), removes old original formats, and automatically updates extension references across content, data, and layout files.
* **`audit_unused.sh`**: Audit utility that scans project files to detect potential orphaned or unused graphic assets, enabling a manual and secure review before cleaning up space.
  
### Running the Scripts

If you encounter a `Permission denied` error when running the scripts for the first time, grant execution permissions or invoke them via Bash directly:


### Option 1: Grant execution permissions (one-time setup)
`chmod +x convert_to_webp.sh audit_unused.sh`

### Option 2: Run directly using the Bash interpreter
`bash convert_to_webp.sh`
`bash audit_unused.sh`

## Deployment

The website is configured to compile and deploy automatically via continuous integration (CI/CD) upon pushing changes to the main branch (`main`).
