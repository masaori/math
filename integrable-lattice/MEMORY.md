# MEMORY

## 次回やること

### 1. 候補の検証 / verify（次の主作業）

- 生成済み候補 U1-corr / U1-efp / U3-corr（`outputs/candidates/000_seed_candidates.md`）の `resolved_risk` / `novelty_risk` を `06_verify` で確定する。
- 特に U3-corr: half-turn 分配関数の有限行列式が Kuperberg 2002 / Bleher-Liechty 2017 で既出か精査（既出なら新規性は相関部分に限定）。
- small_case_experiment を `sagemath/` で実装し小サイズ数値検証（U1: n≤2,N≤3 / U3: N∈{2,4}）。

### 2. 残り unknown の候補化

- U2 / U4 / U5（reflecting 系の相関/EFP）は needs_review 振り分け後に候補化。
- U6（triangular DWBC）は corpus 未収集由来 → 追加 harvest するか needs_review 相当で扱うか要判断。

### 3. needs_review の振り分け

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

### Candidate generation（05_generate, first pass）

- gap map の unknown 最有力セル U1 / U3 を `outputs/candidates/000_seed_candidates.md` に StatementCandidate 形式で起こした。
- U1-corr（partial DWBC 境界1点相関 det）/ U1-efp（partial DWBC EFP det）/ U3-corr（half-turn 一般パラメータ境界相関 det）の3件。いずれも known anchor 付き・小サイズ検証可能。
