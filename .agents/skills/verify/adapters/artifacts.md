# Adapter — Generated Artifacts

Use when verifying PDFs, DOCX, spreadsheets, slide decks, images, zips, builds, binaries, exports, or rendered outputs.

## Artifact checks

- Confirm artifact path exists.
- Confirm file size and modified timestamp.
- Open/inspect content using appropriate tooling.
- Validate format where possible.
- Compare against source claims or requirements.
- Check for stale copies with similar names.
- If packaged, list archive contents and inspect key files.

## Examples

- PDF: page count, text extraction, screenshots for visual/layout-critical pages.
- DOCX: unzip/read XML or use document tooling; inspect headings/tables if relevant.
- Spreadsheet: inspect sheets, formulas, styles, row/column counts.
- ZIP/repo bundle: list contents, compare expected tree, run tests where possible.
- Image: dimensions, visible content, metadata if relevant.

## Caution

Artifact existence is not content correctness. A generated file may be stale, empty, corrupted, or missing required sections.
