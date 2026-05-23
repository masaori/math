# Structured LaTeX Content

This directory is the first migration target away from Typst as the editable
source format.

The current scope is the first 30 theorem-like blocks from
`parts/000_計算公式/000_*.typ` through `parts/000_計算公式/029_*.typ`.
The original `.typ` files remain untouched.

## Model

- Source of truth here is JavaScript object data validated at runtime.
- Mathematical expressions are stored as LaTeX strings intended for KaTeX.
- Every block keeps its original Typst source path and ordinal.
- Web rendering should consume the exported objects directly and render math
  nodes with KaTeX.

## Files

- `schema.mjs` - Runtime validators and small helpers.
- `schema.d.ts` - TypeScript declarations for the content model.
- `tools/extract-source-blocks.mjs` - Repository-specific source index extractor.
- `tools/validate-content.mjs` - Runtime validation for converted content.
- `content/` - Converted block modules.

## Validation

Run from the project directory:

```sh
node structured-latex/tools/extract-source-blocks.mjs
node structured-latex/tools/validate-content.mjs
```
