# MEMORY

## 収集対象の再定義（2026-06-21, ユーザー合意）

- 集める statement = **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」**。整理軸は決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）＋四軸（帰属／計算可能性／複雑性／可解性）。定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`。
- 旧アプローチ（文献の exact 分類＝determinant/character で集めた cycle 0）は**全削除**。文献分類に引きずられて帰属と可解性を混同していたため。**復元点 918af09**（全 intact）／削除コミット c7fe283。
- 探索方向 A–F（A 零点∈ℚ̄ / B 臨界点代数性・双対 / C ℝ脱出隔離・自由フェルミオン / D Massieu Φ∈Λ / E 複雑性×可解性分類 / F 形式検証可能性）は **絞らず広く** 探す（ユーザー指示）。

## 自動ループ（daily）

- 手順 `docs/tasks/auto-loop-runbook.md`、状態 `docs/tasks/auto-loop-state.md`。各 step 完了ごとに点検 → main 差分 push（マージ結果を必ず報告）→ 次 step。
- cron は session-only（Claude 起動中のみ・7日失効）。次回やること＝state の cycle 0 step 列（explore:A_zeros から）。

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
