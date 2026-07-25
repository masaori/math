# Structured LaTeX Content

This directory is the first migration target away from Typst as the editable
source format.

All theorem-like blocks under `parts/**/*.typ` are covered, together with the
chapter headings that used to live only in `main.typ`.
The original `.typ` files remain untouched.

## Model

- Source of truth here is JavaScript object data validated at runtime.
- Mathematical expressions are stored as LaTeX strings intended for KaTeX.
- Every block keeps its original Typst source path and ordinal.
- Web rendering should consume the exported objects directly and render math
  nodes with KaTeX.

### Block kinds

- Theorem-like: `theorem` / `definition` / `claim` / `remark` / `note`.
  These carry `statement` and optionally `proof` / `notes`.
- Structural: `heading`. A heading carries `level` (1 = topmost, matching Typst
  `=`; `==` is 2) and a required `title`, and carries no body. Headings come
  from `main.typ` (`sourcePath: "main.typ"`, `sourceOrdinal` = 1-based position
  among that file's headings).

### Document order

**The array order is the canonical document order**: the document is
`content/*.mjs` sorted by file name, each file's exported array in order.
This sequence reproduces the `#include` order of `main.typ` exactly.

`sourceOrdinal` is *not* the document order — it is the ordinal of the block's
source file inside its `parts/` chapter. The two differ because the `#include`
order of `main.typ` does not follow the `parts/` file numbering (e.g. chapter
`002` is included as 000, 001, 003, 002; chapter `008` places `036` between
`017` and `018`). For that reason `008_TV1_hatZ_hatY_part{1,2}.mjs` are named by
document-order part instead of by a source-number range.

Work notes at the end of the old `main.typ` (`= 全体のノリ`, `= メモ`, the
"次回やること" scratchpad and its embedded SageMath snippet) are deliberately
**not** migrated: they are working memos, not part of the proof.

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
