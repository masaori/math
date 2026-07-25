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

### 本文とノートの使い分け（重要）

`content/` は**出版物（論文・書籍）の本体**である。最終成果物の生成は `content/` だけを
読むので、`notes/` に置いたものは構造上いっさい出版物に混入しない。

- **正しさに必要ならそれは注記ではない。** 定義が意味をもつ条件、主張の適用範囲、
  well-defined 性、主張から従う数学的帰結など、**それが無いと定義・主張・証明の正しさが
  崩れる／主張の意味が変わる**ものは、注記ではなくブロックの `statement`（証明中の事柄なら
  `proof`）に書く。
- **`notes/` に置くのは参照用の素材だけ。** 補足計算、具体例、参考公式、原文由来のメモ、
  物理的解釈、先行研究との比較など、出版の本文には必須でないが、証明以外の部分
  （動機・背景・読み方の説明）を書くときに参照しうるもの。

各ノートは `targets` で紐づけ先の定理・主張を**ラベル**で参照する（パス非依存）。
紐づけ先にラベルが無ければ、まず対象ブロックにラベルを付けてから参照する。
`tools/validate-content.mjs` は `targets` が `content/` の実在ラベルへ解決できることを検査し、
解決できなければ落ちる（未解決 `ref` と同じ扱い）。

ブロック側の `notes` フィールドはスキーマ上まだ存在するが、このリポジトリの `content/` では
使っていない（すべて `statement` への格上げか `notes/` への移設で解消済み）。

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

- `schema.mjs` - Runtime validators and small helpers (`defineBlocks` / `defineNotes`).
- `schema.d.ts` - TypeScript declarations for the content model.
- `tools/extract-source-blocks.mjs` - Repository-specific source index extractor.
- `tools/validate-content.mjs` - Runtime validation for converted content and notes.
- `content/` - Converted block modules (the publication body).
- `notes/` - Reference-only notes attached to blocks by label; never part of the output.

## Validation

Run from the project directory:

```sh
node structured-latex/tools/extract-source-blocks.mjs
node structured-latex/tools/validate-content.mjs
```
