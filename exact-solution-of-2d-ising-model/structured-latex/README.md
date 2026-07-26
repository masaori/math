# Structured LaTeX Content

This directory is the first migration target away from Typst as the editable
source format.

All theorem-like blocks under `parts/**/*.typ` are covered, together with the
chapter headings that used to live only in `main.typ`.
The original `.typ` files remain untouched.

## 型検査で何を捕まえるか（TypeScript 化）

スキーマとツールは TypeScript（`schema.ts` / `tools/*.ts`）で書かれている。
**Node 22.18 以降の型ストリップにより、これらの `.ts` はビルドせずそのまま実行できる**
（`dist/` のようなビルド成果物は作らない。`tsc` は検査専用 = `noEmit`）。

`content/` に実在するラベルは `tools/generate-labels.ts` が集めて `labels.generated.ts`
（ラベル文字列のユニオン型 `Label`）へ書き出す。`schema.ts` はこの型で参照を縛るので、
次の誤りは**実行時の検証を待たずコンパイル時に落ちる**。

| 誤り | 検出 |
|---|---|
| `ref("存在しないラベル")` | 型検査（`tsc`）。近い綴りの候補まで出る |
| ノートの `targets` が存在しないラベル | 型検査 |
| ノートの `targets` が空 | 型検査（1件以上のタプル型） |
| ブロックが未登録のラベルを宣言（生成物の再生成漏れ） | 型検査 |
| 見出しブロックに本文（`statement`/`proof`）を書く | 型検査 |
| 本文ブロックに `notes` を書く | 型検査 |
| id・ラベルの重複、未変換 Typst 記法の混入 | 実行時（`tools/validate-content.ts`） |

この実証は `node tools/negative-type-test.ts` が行う。存在しないラベルを使った一時ファイルで
実際に `tsc` を落とし、その診断が当該ラベルを指していることを確認する（正しいラベル版が
通ることも対にして確認するので、「設定不備で常に落ちている」状態とは区別できる）。
回帰テストは `type-tests/label-typing.test-d.ts`（`@ts-expect-error` の並び）。

### 移行状況

`content/` と `notes/` は現在まだ `.mjs`（型検査の対象外。誤りは実行時検証で捕まる）。
`.ts` への一括変換は `tools/codemod-mjs-to-ts.ts` で行う（`--apply`。既定は dry-run）。
変換が済むまでの互換のため `schema.mjs` が `schema.ts` を再エクスポートしている
（実体は持たない。全変換後に削除する）。

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

- `schema.ts` - 型 + 実行時検証の正本（`defineBlocks` / `defineNotes` とノード生成ヘルパ）。
- `labels.generated.ts` - 自動生成。実在ラベルのユニオン型 `Label`（直接編集しない）。
- `schema.mjs` - 未変換の `.mjs` 向け互換入口（`schema.ts` の再エクスポート）。
- `tools/generate-labels.ts` - `content/` からラベルを集めて `labels.generated.ts` を生成（`--check` で検査のみ）。
- `tools/validate-content.ts` - 変換済み content / notes の実行時検証（`.mjs` 入口も同名で残す）。
- `tools/verify-no-lost-proofs.ts` - Typst 原本からの証明の移行漏れ検出。
- `tools/extract-source-blocks.ts` - Typst 原本（`_old/typst/`）の索引抽出。
- `tools/codemod-mjs-to-ts.ts` - `content/` `notes/` の `.mjs` → `.ts` 一括変換。
- `tools/negative-type-test.ts` - 「存在しないラベルは tsc が拒否する」ことの実証テスト。
- `content/` - Converted block modules (the publication body).
- `notes/` - Reference-only notes attached to blocks by label; never part of the output.

## Validation

初回のみ依存をインストールする（型検査に `typescript` を使う）。

```sh
cd structured-latex && pnpm install
```

変更したら `structured-latex/` で一括検査する（生成物の鮮度 → 型検査 → 実行時検証 → 負テスト）。

```sh
npm run check
```

個別に回す場合（プロジェクトディレクトリから）:

```sh
node structured-latex/tools/generate-labels.ts        # ラベルのユニオン型を再生成
node structured-latex/tools/validate-content.mjs      # 実行時検証（実体は .ts）
node structured-latex/tools/verify-no-lost-proofs.mjs # 移行漏れ検出
```

Node は 22.18 以降が必要（`.ts` を型ストリップで直接実行するため）。
