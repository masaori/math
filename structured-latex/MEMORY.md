# MEMORY（structured-latex）

引き継ぎメモ。次回やること・未解決問題・完了済み作業を書く。

## 次回やること

1. **各プロジェクトのスキーマ定義をこのシステムへ集約する**（依頼者の指示により実施が確定している）。
   同じ入力言語が 3 箇所で定義されている状態を解消する。
   - `exact-solution-of-2d-ising-model/structured-latex/schema.ts`
   - `integrable-lattice/structured-latex/schema.ts`（住処・ℝ 脱出・検証紐づけはメタデータとして宣言する）
   - `realtime-web-preview/domain-model/src/block.ts`
   移行後、各プロジェクトの検査（`npm run check` / PDF 生成 / ビューア）が通ることを確認する。
2. **M3（レンダリングコアと LaTeX / PDF 出力）**へ。
   `resolve` の出力から `.tex` を組み、tectonic で PDF まで通す。
   数式が LaTeX ∩ KaTeX の共通部分集合であることの機械検査（論点 D-1）もここで実装する。

## 未解決問題

- **資産（画像ファイル）の受け入れと配信が未設計。** 正本は `assetKey` だけを持ち、実体への解決は
  ターゲットごとの資産解決器が担う、というところまで決めた（domain-model.md §7.5）。
  実際の受け入れ経路とストレージは M5 / M7 で決める。
- **リポジトリの CI（`build` ワークフロー）が main で失敗し続けている。**
  `exact-solution-of-2d-ising-model/main.typ` を typst でコンパイルしようとするが、
  Typst からの移行でこのファイルは既に存在しない。本プロジェクトとは無関係だが、
  すべての PR が赤くなるので、どこかで直す必要がある。

## 完了済み

- **M0**: テンプレート（software-development-docs-template）から `docs/` を複製、README、milestones。
- **M1**: [docs/domain-model.md](./docs/domain-model.md)。境界づけられた文脈は 2 つ（`document` / `live-site`）。
  集約ルートは文書と公開サイト。3 つの設計判断（正本は意味だけを持つ／体裁は宣言と閉じたスロットに
  限って開く／アップロードはセグメント単位・確定と配信は文書全体の版単位）。
  **依頼者の承認により 5 論点すべて確定**（A-3 / B-2 / C-2 / D-1 / E-1）。
- **M2**: 入力契約の確定と実装。
  - **名称を `structured-latex` に変更**（旧 `structured-latex-renderer`）。ドメインモデルが中心で、
    レンダラーはその上に載るモジュール、という整理を依頼者と確定した。
  - **入力言語の正本はこのシステムが 1 つだけ持つ**ことを確定（各プロジェクトへの集約は次回）。
  - 実装: `domain-model/structured-text/`（L1）、`domain-model/resolved/`（L3）、
    `domain-model/entities/` + `api-contract/`（L2）、`codegen/structured-text-index/`（ラベル型・
    文書集約モジュールの生成器）、`codegen/entity-definitions/`（ER 定義の生成器）、
    `examples/minimal-document/`（実証対象）、`tools/`（負テスト・依存方向検査）。
  - **図表を語彙に追加**: `figure` ブロック（名前を持ち・指され・数えられるのでブロック）と
    `image` ノード（参照も番号も持たない挿絵用）。キャプションはノード列（ノートではない。
    ノートにすると出版物から消えるため）。画像の実体は `assetKey` で参照し、ターゲットごとに解決する。
  - **「LaTeX を正本にしてレンダー時にパースする」案は不採用**（domain-model.md §7.5 に根拠）。
    LaTeX を書き味として使う要求は、正本ではなく入力経路で満たす（§16.2 に将来要求として記録）。
  - 先行実装から意図的に変えた点: 文書順のキーをファイル名から切り離した／`defineBlocks` は
    実行時に throw しない（検証は 1 か所へ集約し Result で返す）／由来（`origin`）を任意にした／
    `ResolveError` に 3 種を追加した（I1 の取りこぼしを埋めた）。
  - **将来要求を記録**: ゼミ形式の共同執筆（編集権の受け渡し。E-1 の楽観ロックと全置換の契約を
    壊さずに加算だけで満たせることを §16.1 に示した）、LaTeX 入力経路（§16.2）。
