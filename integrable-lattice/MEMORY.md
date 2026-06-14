# MEMORY

## 次回やること

- 収集結果から `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` を作る。
- その map の `unknown` / `needs_review` セルから `outputs/candidates/000_seed_candidates.md` に候補を追加する。
- `outputs/paper-plans/` から `outputs/papers/` へ昇格させる判断基準を作る。
- `six_vertex_dwbc_determinant` の first pass では reflecting / partial / symmetry-class / triangular boundary variants に絞る。

## 未解決

- 論文コーパス取得を arXiv source 優先にするか、metadata/abstract 優先にするか。
- 初期分類を rule-based にするか、LLM-assisted にするか。
- 「未解決」の判定をどこまで自動化するか。
- `integrable-lattice/skills/` を Codex の自動発見対象にするか、プロジェクトローカル運用に留めるか。

## 完了

- プロジェクト雛形を作成した。
- `outputs/papers/` を最終論文の置き場として追加した。
- `integrable-lattice-` prefix のプロジェクト専用 skill を7つ作成した。
- `inputs/seeds/` に seed taxonomy と初期クエリを追加した。
- `docs/schemas.md` に候補ステートメントの最小スキーマを追加した。
- `inputs/seeds/canonical-papers.md` を追加し、MVPの代表文献アンカーを seed 化した。
- `inputs/seeds/canonical-papers.md` に mvp_role / operation_type / gap_axes と追加アンカーを入れて補強した。
- 補強後の subagent review で「harvestへ進む」と判定され、minor 指摘の first-pass axis を反映した。
- `six_vertex_dwbc_determinant` の first-pass query log と curated corpus を追加した。
