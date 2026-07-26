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

`content/` に実在するラベルは `tools/generate-index.ts` が集めて `labels.generated.ts`
（ラベル文字列のユニオン型 `Label`）へ書き出し、同時に `document.generated.ts`
（全ファイルを 1 本のタプル型へ連結する集約モジュール）を作る。`schema.ts` はこの型で参照を縛り、
集約モジュールはファイルを跨いだ一意性を主張するので、次の誤りは
**実行時の検証を待たずコンパイル時に落ちる**。

| 誤り | 検出 |
|---|---|
| `ref("存在しないラベル")` | 型検査（`tsc`）。近い綴りの候補まで出る |
| ノートの `targets` が存在しないラベル | 型検査 |
| ノートの `targets` が空 | 型検査（1件以上のタプル型） |
| ブロックが未登録のラベルを宣言（生成物の再生成漏れ） | 型検査 |
| 見出しブロックに本文（`statement`/`proof`）を書く | 型検査 |
| 本文ブロックに `notes` を書く | 型検査 |
| フィールド名の打ち間違い（`proof` → `proofs` 等） | 型検査（余剰プロパティ検査）＋実行時（未知キーで throw） |
| 定理型ブロックに `level`（見出し用フィールド）を書く | 型検査＋実行時 |
| 見出しの `level` が 1〜6 の範囲外 | 型検査 |
| タイトルが `text` も `tex` も持たない | 型検査 |
| `conversion.status` の綴り違い | 型検査（候補付き） |
| ブロック id・ノート id・ラベルの重複（同一ファイル内／**ファイル跨ぎ**とも） | 型検査 |
| ノート id とブロック id の衝突 | 型検査 |
| 未変換 Typst 記法の混入、`sourcePath` の実在 | 実行時（型では不可能。理由は下記 docs） |

**型が守るのは参照側**である点に注意する。`Label` はブロックの `labels` から生成されるので、
**ラベル自体の綴り間違いは、再生成した時点で「実在するラベル」として正当化される**
（型検査が落ちるのは、生成物を再生成するまでの間だけ）。ラベルを直すときは、
それを指す `ref` が一斉に型エラーになることで改名漏れが分かる、という守り方になる。

**何が型で落ち、何が型では落とせないのか（およびその根拠）は
[docs/type-coverage.md](../docs/type-coverage.md) に記録してある。**

この実証は `node tools/negative-type-test.ts` が行う（16 ケース）。存在しないラベルを使った一時ファイルで
実際に `tsc` を落とし、その診断が当該ラベルを指していることを確認する（正しいラベル版が
通ることも対にして確認するので、「設定不備で常に落ちている」状態とは区別できる）。
回帰テストは `type-tests/label-typing.test-d.ts`（`@ts-expect-error` の並び）と
`tools/schema-runtime-test.ts`（型を回避した値を実行時検証が拒むこと）。

### ソース形式は TypeScript に統一する

`schema` / `content` / `notes` / `tools` / 検証スクリプトはすべて `.ts` である。
**`.mjs` は使わない**（書き方が 2 種類あると、片方が型検査の網から漏れる）。
`content/` `notes/` に `.mjs` が現れたら `tools/content-modules.ts` がエラーで落とす。

過去に `.mjs` で書かれていたものは `tools/codemod-mjs-to-ts.ts` で変換した。
このツールは今後も同じ用途に使える（`--apply`。既定は dry-run。`--out-dir DIR` は
リポジトリを触らずに変換結果一式を DIR へ書き出し、`npx tsc -p DIR/tsconfig.json` で
変換後の型検査を先に試せる）。

## Model

- Source of truth here is TypeScript object data: `schema.ts` の型（コンパイル時）と
  同ファイルの検証関数（実行時）の二重で守る。
- Mathematical expressions are stored as LaTeX strings intended for KaTeX.
- Every block keeps its original Typst source path and ordinal.
- Web rendering should consume the exported objects directly and render math
  nodes with KaTeX.

### Block kinds

- Theorem-like: `theorem` / `definition` / `claim` / `remark` / `note`.
  These carry `statement` and optionally `proof`.
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
`tools/validate-content.ts` は `targets` が `content/` の実在ラベルへ解決できることを検査し、
解決できなければ落ちる（未解決 `ref` と同じ扱い）。

ブロック側に `notes` フィールドは書けない（型でも実行時でも拒否される）。

### Document order

**The array order is the canonical document order**: the document is
`content/*.ts` sorted by file name, each file's exported array in order.
This sequence reproduces the `#include` order of `main.typ` exactly.

`sourceOrdinal` is *not* the document order — it is the ordinal of the block's
source file inside its `parts/` chapter. The two differ because the `#include`
order of `main.typ` does not follow the `parts/` file numbering (e.g. chapter
`002` is included as 000, 001, 003, 002; chapter `008` places `036` between
`017` and `018`). For that reason `008_TV1_hatZ_hatY_part{1,2}.ts` are named by
document-order part instead of by a source-number range.

Work notes at the end of the old `main.typ` (`= 全体のノリ`, `= メモ`, the
"次回やること" scratchpad and its embedded SageMath snippet) are deliberately
**not** migrated: they are working memos, not part of the proof.

## Files

- `schema.ts` - 型 + 実行時検証の正本（`defineBlocks` / `defineNotes` とノード生成ヘルパ）。
- `labels.generated.ts` - 自動生成。実在ラベルのユニオン型 `Label`（直接編集しない）。
- `document.generated.ts` - 自動生成。全 content / notes を連結し、ファイル跨ぎの一意性を型で主張する。
- `tools/generate-index.ts` - 生成物 2 種を作る（`--check` で鮮度検査のみ）。
- `tools/validate-content.ts` - content / notes の実行時検証。
- `tools/verify-no-lost-proofs.ts` - Typst 原本からの証明の移行漏れ検出。
- `tools/extract-source-blocks.ts` - Typst 原本（`_old/typst/`）の索引抽出。
- `tools/codemod-mjs-to-ts.ts` - `.mjs` → `.ts` 一括変換（過去の移行に使用。以後の保険）。
- `tools/build-latex.ts` - **最終成果物の生成器**（content のみ → LaTeX → PDF）。
- `tools/verify-no-notes-in-output.ts` - 生成物へノートが混入していないことの検査。
- `tools/negative-type-test.ts` - 「存在しないラベルは tsc が拒否する」ことの実証テスト。
- `tools/schema-runtime-test.ts` - 実行時検証（未知フィールド等）のテスト。
- `content/` - 証明ブロック群（出版物の本体）。
- `notes/` - 参照用ノート（ラベルで紐づく。最終成果物には載らない）。

## 最終成果物の生成（LaTeX / PDF）

`content/` **だけ**を入力に LaTeX を組み、PDF まで作る（`tools/build-latex.ts`）。
`notes/` は読まない。混入していないことは `tools/verify-no-notes-in-output.ts` が検査する。

```sh
npm run build:tex   # build/document.tex を生成
npm run build:pdf   # 生成 → PDF ビルド → ノート混入の検査
```

PDF 化には tectonic が要る（未導入なら `brew install tectonic`）。日本語は xeCJK ＋ ヒラギノ。
出力は `build/`（git 管理外）。現在の実測: **175 ページ / 相互参照 945 件すべて解決 / 未解決参照 0**。
変換規則と数式の互換性の実測結果は [docs/publication-output.md](../docs/publication-output.md)。

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
node structured-latex/tools/generate-index.ts         # 生成物（ラベル型・集約モジュール）を再生成
node structured-latex/tools/build-latex.ts --pdf      # 最終成果物（PDF）を生成
node structured-latex/tools/validate-content.ts       # 実行時検証
node structured-latex/tools/verify-no-lost-proofs.ts  # 移行漏れ検出
node sagemath/tools/verify-check-linkage.ts           # 数値検証 ↔ 証明の対応
```

Node は 22.18 以降が必要（`.ts` を型ストリップで直接実行するため）。
