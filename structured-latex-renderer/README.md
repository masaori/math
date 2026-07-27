# structured-latex-renderer

構造化テキスト（TypeScript で書かれたブロック列）を、**単一のソースから複数の出力形式へ**変換するレンダラー。

## 何を解くのか

証明・論文の正本を構造化テキストとして 1 つだけ持ち、そこから用途の異なる成果物を生成する。
正本が 1 つなので、出力形式ごとに内容が食い違う事故が構造的に起きない。

| 出力形式 | 用途 |
| --- | --- |
| 純粋な LaTeX | arXiv 等へ投稿できる形式 |
| PDF | 印刷・配布 |
| インタラクティブな Web サイト | Web 公開。閲覧者が操作できる |
| 書籍形式 | 段組・コラムを差し挟みながら読み物として提供する |

加えて次を満たす。

- **デザイン・レイアウトは利用者側でカスタマイズできる。** 出力の見た目を変えるのに
  レンダラー本体を書き換えなくてよい。
- **インフラは Terraform で構築する。** インタラクティブサイトをホスティングできる状態にする。
- **構造化テキストを部分的にアップロードして画面を更新できる。**
  論文をリアルタイムに更新しながら、同じサイトを複数人が同時に見る使い方を想定する。

## 開発の思想

`docs/` は [software-development-docs-template](https://github.com/masaori/software-development-docs-template)
から複製したものであり、**開発はこれに厳密に従う**。特に次を前提とする。

- エントロピー（選択肢の多さ）の最小化を最優先する（`docs/programming-philosophy.md`）
- 原理主義的な DDD。ドメインモデルを BE から FE の UI 構造まで一貫して貫く
- 依存関係のコントロール（Clean Architecture / FSD）を厳密に運用する
- 型安全を絶対条件とする（`docs/language-selection.md`）
- インフラは Terraform による IaC（`docs/infrastructure.md`）

プロダクト固有の設計（ドメインモデル、ワークフロー、UI デザインシステム）はテンプレートには無いので、
本リポジトリで作る。まずドメインモデルから始める。

## 関連する既存実装（先行事例として読むこと）

| 場所 | 何か |
| --- | --- |
| `../exact-solution-of-2d-ising-model/structured-latex/` | 構造化テキストの実装。スキーマ、ラベルの型生成による参照検査、検証ツール群、LaTeX 生成器 |
| `../realtime-web-preview/` | 構造化テキストの LAN 内リアルタイムプレビュー。`domain-model/` を持つ TypeScript ワークスペース |

いずれも本プロジェクトの入力契約・要件の一次情報である。既存実装を無視して設計しない。

## マイルストーン

[docs/milestones.md](docs/milestones.md) を参照。

## ドメインモデル

[docs/domain-model.md](docs/domain-model.md) が本プロジェクトのドメインモデル（M1）。
文書・セグメント・ブロック・参照・版・出力ターゲット・テーマの定義と、
境界づけられた文脈・集約・不変条件を定める。個別の設計判断の根拠は
[docs/design-notes/](docs/design-notes/) に分けてある。

引き継ぎメモは [MEMORY.md](MEMORY.md)。
