# MEMORY（structured-latex-renderer）

引き継ぎメモ。次回やること・未解決問題・完了済み作業を書く。

## 次回やること

1. **依頼者へ M1 の承認を求める。** [docs/domain-model.md](./docs/domain-model.md) §13 の 5 論点。
   このうち **A（書籍のコラムの出どころ）と C（公開サイトの公開範囲）は M2 の型に影響する**ので、
   M2 に着手する前に判断を得る。B / D / E はそれぞれ M4 / M3 / M6 の着手前でよい。
2. 承認が取れたら **M2「入力契約の確定」**へ。実装するのは domain-model.md §14 の範囲。

## 未解決問題

- **図表ノードが存在しない。** 先行 2 プロジェクトのどのスキーマにも図表のノードが無く、
  `tools/build-latex.ts` は `graphicx` を読み込んでいるのに使うノードが無い。
  正本に 1 件も実例が無いため形を一次情報から決められず、M1 では埋めなかった（domain-model.md §7.5）。
  M2 で「入れるか、入れずに済ませるか」を決める。
- **リポジトリの CI（`build` ワークフロー）が main で失敗し続けている。**
  `exact-solution-of-2d-ising-model/main.typ` を typst でコンパイルしようとするが、
  Typst からの移行でこのファイルは既に存在しない。本プロジェクトとは無関係だが、
  すべての PR が赤くなるので、どこかで直す必要がある。

## 完了済み

- **M0**: テンプレート（software-development-docs-template）から `docs/` を複製、README、milestones。
- **M1（提案まで）**: [docs/domain-model.md](./docs/domain-model.md) を作成。
  - 一次情報として先行 3 実装を読んだ: `exact-solution-of-2d-ising-model/structured-latex/`、
    `integrable-lattice/structured-latex/`（同じスキーマを複製して分岐した実例）、`realtime-web-preview/`。
  - 境界づけられた文脈は 2 つ（`document` / `live-site`）。集約ルートは文書と公開サイト。
  - 3 つの設計判断を確定: 正本は意味だけを持つ（数式の LaTeX 方言だけが残余）／
    体裁は宣言と閉じたスロットに限って開き意味は開かない／
    アップロードはセグメント単位・確定と配信は文書全体の版単位。
  - 根拠の詳細は `docs/design-notes/` の 3 本。3 本は独立に書かれ、同じ結論に達している。
  - 併せて、M0 で複製した `docs/api-contract-aggregates.md` と `docs/authorization-strategy.md` の
    末尾に混入していた `</content>` / `</invoke>` を除去した（複製時の事故）。
