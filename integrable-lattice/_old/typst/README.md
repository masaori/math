# _old/typst — 旧 Typst 原稿の温存退避先

**正本は構造化テキスト側（`integrable-lattice/structured-latex/`）である。** ここにあるものは
参照用の温存であり、証明の正本ではない。ここを編集しても最終成果物には反映されない。

リポジトリ直下 CLAUDE.md「証明の記述形式（全プロジェクト共通）」に従い、
移行が済んだ Typst は削除せずここへ退避している。**新規に Typst で証明を書かない。**

## 退避したもの（2026-07-26）

- `main.typ`（17 行）— 移行前の内容は、プロジェクトのタイトル・目的・出力目標を述べた
  **散文の枠組みだけ**である。具体的には `#set document(title: ...)` 1 行と、見出し
  「Integrable Lattice Statement Mining」／「目的」／「出力目標」の 3 つ、およびその下の
  説明文・箇条書きからなる。**定理・定義・主張・証明は 1 つも含まれていない**
  （内容は `integrable-lattice/README.md` の「目的」「成果物」節と重複する）。
- `parts/` — 空ディレクトリだった（`.gitkeep` のみ。証明の部品は 1 ファイルも無い）。

この確認の結果として、Ising 側にある `tools/verify-no-lost-proofs.ts`
（Typst 原本に証明があるのに構造化側が TODO のままである移行漏れを検出するツール）は
本プロジェクトへ移植していない。移植しない理由は
`integrable-lattice/structured-latex/README.md` に書いてある。
