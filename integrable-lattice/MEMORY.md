# MEMORY

## 次回やること

- `inputs/seeds/` に seed taxonomy を追加する。
- `inputs/queries/` に arXiv/OpenAlex/Semantic Scholar 用の初期クエリを追加する。
- `docs/schemas.md` に候補ステートメントの最小スキーマを固める。
- MVPとして、既存ノート `docs/research/可積分格子モデル一覧.md` から模型と解法を seed 化する。
- `outputs/paper-plans/` から `outputs/papers/` へ昇格させる判断基準を作る。

## 未解決

- 論文コーパス取得を arXiv source 優先にするか、metadata/abstract 優先にするか。
- 初期分類を rule-based にするか、LLM-assisted にするか。
- 「未解決」の判定をどこまで自動化するか。
- `integrable-lattice/skills/` を Codex の自動発見対象にするか、プロジェクトローカル運用に留めるか。

## 完了

- プロジェクト雛形を作成した。
- `outputs/papers/` を最終論文の置き場として追加した。
- `integrable-lattice-` prefix のプロジェクト専用 skill を7つ作成した。
