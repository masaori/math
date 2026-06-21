# MEMORY

## MVP の方針（是正済み）

- MVP = 固定成果物（「30件」）ではなく、**広く薄く集めて観察し方向を絞るサイクルを1周回すこと**。詳細は `README.md`「MVP の意味（サイクル）」/ `docs/architecture.md`「サイクル」。
- 幅/深さ・操作型や模型の取捨・投資量は事前決定しない。cycle 0 の 07_rank 観察で cycle 1 の方向を決める。

## 自動ループ（daily）

- cycle 0 を daily cron で広く薄く自動進行する。手順 `docs/tasks/auto-loop-runbook.md`、状態 `docs/tasks/auto-loop-state.md`。
- 各 step 完了ごとに MVP コンセプトマッチ点検 → main へ差分 push → 次 step。
- 下の「次回やること」は runbook の step 列の人間向け要約（実体は state ファイル）。

## 次回やること（cycle 0 を広く薄く1周）

### 1. 残り3 slice を浅く通す（最優先）

- `rsos_character_identity` / `tl_loop_finitized_character` / `dimer_pfaffian_boundary` を 01_harvest → 04_gap_map → 05_generate まで **浅く** 回す。
- 候補は anchor 付きの粗い形でよい。`resolved_risk`/`novelty_risk` は `unchecked` のまま、06_verify・sagemath はこの周ではやらない。

### 2. 観察パス（07_rank）

- 4 slice 出揃ったら 07_rank を回し、「どの 模型 × 操作型 × 境界 が筋良いか・なぜか」を `outputs/reports/` に出す。
- これが cycle 0 の成功条件（件数ではない）。

### 3. cycle 1 の方向決定（観察後）

- 操作型 slice の追加（star-triangle / transfer-matrix は anchor 有・即可、T-system は anchor 収集が1段必要）や特定家族への深掘りを、観察結果に基づいて決める。

## 保留（cycle 0 ではやらない）

- slice 1 の候補 U1-corr / U1-efp / U3-corr は cycle 0 に対し深掘りしすぎた先行サンプル。verify・sagemath 検証・残り unknown(U2/U4/U5/U6) の候補化・needs_review(NR1-4) 振り分けは、観察で六頂点 det 方向が選ばれてから後続サイクルで実施。
- Paper planning（`outputs/paper-plans/`→`outputs/papers/` 昇格基準）も方向確定後。

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
