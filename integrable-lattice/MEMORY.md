# MEMORY

## 次回やること

### 1. Candidate generation（次の主作業）

- `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` の unknown セル U1–U6 から `outputs/candidates/000_seed_candidates.md` に候補を追加する。
- 最有力は U1（partial DWBC 相関/EFP 行列式）と U3（対称類の一般パラメータ相関/EFP 行列式）。corpus hint「correlation formulas under partial/reflecting/symmetry-class boundaries」に対応。
- U6（triangular DWBC）は corpus 未収集由来の unknown。候補化前に追加 harvest するか needs_review 相当で扱うか要判断。

### 2. needs_review の振り分け

- NR1（非対角 reflecting、出版状態）/ NR2（partially reflecting、有限行列式形か）/ NR3（half-turn 漸近、有限記号該当性）/ NR4（reflecting 境界相関の被覆範囲）を検証し known/unknown へ確定。
- 結果により U2/U4/U5 の anchor 確度が更新される。

### 3. Paper planning

- `outputs/paper-plans/` から `outputs/papers/` へ昇格させる判断基準を作る。

## 未解決

### Harvest policy

- 論文コーパス取得を arXiv source 優先にするか、metadata/abstract 優先にするか。

### Classification / verification policy

- 初期分類を rule-based にするか、LLM-assisted にするか。
- 「未解決」の判定をどこまで自動化するか。

### Tooling

- `integrable-lattice/skills/` を Codex の自動発見対象にするか、プロジェクトローカル運用に留めるか。

## 完了

### Project setup

- プロジェクト雛形を作成した。
- `outputs/papers/` を最終論文の置き場として追加した。
- `integrable-lattice-` prefix のプロジェクト専用 skill を7つ作成した。

### Seeds / schema

- `inputs/seeds/` に seed taxonomy と初期クエリを追加した。
- `docs/schemas.md` に候補ステートメントの最小スキーマを追加した。
- `inputs/seeds/canonical-papers.md` を追加し、MVPの代表文献アンカーを seed 化した。
- `inputs/seeds/canonical-papers.md` に mvp_role / operation_type / gap_axes と追加アンカーを入れて補強した。
- 補強後の subagent review で「harvestへ進む」と判定され、minor 指摘の first-pass axis を反映した。

### Harvest

- `six_vertex_dwbc_determinant` の first-pass query log と curated corpus を追加した。

### Gap map

- 案A（curated corpus 内の Immediate Map Hints を分類成果物として扱い、02_extract/03_classify の独立成果物を作らず直接 gap map）で `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` を作成した。
- known 7 / probably_known 1 / needs_review 4 / unknown 6（U1–U6）でセル化。
