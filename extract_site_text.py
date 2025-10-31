#!/usr/bin/env python
"""Extract text content from HTML files in the site directory.

This script walks through all HTML files in the site/ directory,
parses them with BeautifulSoup to extract text content (stripping
JavaScript, CSS, and HTML tags), and writes the text to corresponding
.txt files in the site_text/ directory while preserving the directory
structure.
"""

from pathlib import Path

from bs4 import BeautifulSoup


def extract_text_from_html(html_path: Path) -> str:
    """Extract text content from an HTML file.

    Args:
        html_path: Path to the HTML file

    Returns:
        Extracted text content with JavaScript, CSS, and navigation removed
    """
    with open(html_path, encoding="utf-8") as f:
        soup = BeautifulSoup(f, "html.parser")

    # Find the main content area (Material for MkDocs structure)
    # The actual page content is in <article class="md-content__inner md-typeset">
    content_area = soup.find("article", class_="md-content__inner")

    if not content_area:
        # Fallback to finding main element if article not found
        content_area = soup.find("main", class_="md-main")

    if not content_area:
        # Last resort: use the whole body but this shouldn't happen
        content_area = soup

    # Remove script and style elements from the content area
    for script in content_area(["script", "style"]):
        script.decompose()

    # Get text and clean up whitespace
    text = content_area.get_text()

    # Break into lines and remove leading/trailing space on each
    lines = (line.strip() for line in text.splitlines())

    # Break multi-headlines into a line each
    chunks = (phrase.strip() for line in lines for phrase in line.split("  "))

    # Drop blank lines
    text = "\n".join(chunk for chunk in chunks if chunk)

    return text


def main() -> None:
    """Extract text from all HTML files in site/ to site_text/."""
    site_dir = Path("site")
    output_dir = Path("site_text")

    if not site_dir.exists():
        print(f"Error: {site_dir} directory does not exist. Run 'pixi run build' first.")
        return

    # Find all HTML files
    html_files = list(site_dir.rglob("*.html"))

    if not html_files:
        print(f"No HTML files found in {site_dir}")
        return

    print(f"Found {len(html_files)} HTML files to process")

    for html_path in html_files:
        # Calculate relative path from site_dir
        rel_path = html_path.relative_to(site_dir)

        # Create corresponding .txt path in site_text/
        txt_path = output_dir / rel_path.with_suffix(".txt")

        # Create parent directories if needed
        txt_path.parent.mkdir(parents=True, exist_ok=True)

        # Extract and write text
        text_content = extract_text_from_html(html_path)
        txt_path.write_text(text_content, encoding="utf-8")

        print(f"✓ {rel_path} -> {txt_path.relative_to(output_dir)}")

    print(f"\n✅ Successfully extracted text from {len(html_files)} HTML files to {output_dir}/")


if __name__ == "__main__":
    main()
