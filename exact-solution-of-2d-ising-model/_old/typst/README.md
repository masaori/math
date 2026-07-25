# Typst 版（温存アーカイブ・削除候補ではない）

2026-07 に証明の正本を **構造化TeX（`structured-latex/content/`）へ全面移行**したため、
Typst 版一式をここへ退避した。

**これは削除候補ではない。** 新パイプライン（構造化TeX + ビューア + Lean）に十分な確信が
得られるまで、参照用に温存する。破棄する場合は改めて判断する。

## 中身

| パス | 内容 |
| --- | --- |
| `main.typ` | 旧・文書構成（`#include` 順が文書順の正本だった） |
| `theorem.typ` | `#definition` / `#claim` / `#theorem` / `#proof` / `#ref` のスタイル定義 |
| `parts/**/*.typ` | 証明本体 130 ファイル |

## 現在の正本

- **証明本体**: `structured-latex/content/*.mjs`（142 ブロック）。
  文書順は「ファイル名昇順 → 各ファイル内の配列順」。旧 `main.typ` の `#include` 順と
  一致することを移行時に機械照合済み。
- **閲覧**: リポジトリ直下の `realtime-web-preview`（React + KaTeX）。
- **機械的証明**: `lean/`（Lean 4 + mathlib4）。
- **数値検証**: `sagemath/`。証明との対応は**ラベル**で張っており
  （`sagemath/tools/verify-check-linkage.mjs` が機械検証）、Typst の所在に依存しない。

## 注意

- ここのファイルは**もう更新されない**。内容を直しても正本（構造化TeX）には反映されない。
  修正は必ず `structured-latex/content/` 側に入れること。
- 構造化TeX の各ブロックが持つ `sourcePath` は、移行元をたどるための出自情報として
  このディレクトリ配下のパスを指す。
- Typst でのビルドが必要になった場合は、このディレクトリを作業ディレクトリにして
  `typst compile main.typ` を実行する（`parts` への相対パスがそのまま効く）。
