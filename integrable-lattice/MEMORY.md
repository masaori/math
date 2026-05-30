# MEMORY

## 決定事項

- **論文コーパス取得**: arXiv source 優先。metadata/abstract で粗くフィルタ → high potential 候補は LaTeX source DL。
- **分類**: 全工程 LLM-assisted。enum は閉じているが、ラベル粒度（YBE vs star-triangle 等）は文脈依存なので rule-based は採らない。
- **「未解決」判定**: 三段階。
  - `unchecked` → `auto_checked`（自動: 文字列マッチ + 引用グラフ）→ `human_checked`（人手）。
  - `outputs/candidates/` 入りは `auto_checked` 以上、`outputs/paper-plans/` 昇格は `human_checked` 必須。
- **harvest 規模**: seed フェーズなし。母集団は 1,500〜3,000 件オーダー。
- **multi-source**: arXiv + OpenAlex + Semantic Scholar + INSPIRE-HEP。Google Scholar は ToS 違反 + 不安定で除外、MathSciNet は有料で除外。
- **inputs/corpus 取り扱い**: jsonl サイズが小さい間（数 MB）は git track。tar.gz / pdf / sources/ 配下のみ ignore。
- **`skills/` 公開範囲**: 未決定（後回し）。

## 完了済み

- multi-source harvest:
  - arXiv 349 件（`manifest.jsonl`）
  - OpenAlex 1815 件（`manifest_openalex.jsonl`）
  - Semantic Scholar 577 件（`manifest_semantic_scholar.jsonl`、25 クエリ中 13 件は 429 失敗）
  - INSPIRE-HEP 156 件（`manifest_inspire.jsonl`）
- merge + 精度 filter: 4 source → 2687 unique → filter 後 **1504 件**（`manifest_filtered.jsonl`）。
- LLM 分類: arXiv 349 + 追加 1275 = 1504 件すべてに `model_hints / operation_hints / status_hints` 付与（`manifest_filtered_classified.jsonl`）。
  - status_hints 分布: open 72, solved 793, review 114, unknown 525
  - 高優先度サブセット: open+hints 28, open+hints+arxiv 18, solved+≥3hints 142, arxiv_id 持ち 591
- ドキュメント整備:
  - `inputs/seeds/open_problem_collections.md` 追加
  - `inputs/queries/seed-queries.md` に open-pattern + review クエリ追加
  - `skills/integrable-lattice-extract/SKILL.md` に open-problem pattern pass を明記
  - `pipeline/01_harvest/README.md` を multi-source 構成に更新
  - `docs/schemas.md` に ManifestRecord スキーマ追加

## 次回やること（優先度順）

### 1. 多数決 DL 判定（次セッションの最優先タスク）

abstract レベルの hints は代理指標に過ぎないので、3 LLM voter による多数決で `in_scope` / `dl_priority (high/medium/low/skip)` を直接判定する。

- 入力: `inputs/corpus/judge_input.jsonl`（1504 件、id/arxiv_id/year/title/abstract のみ抽出済み）
- 方式: 3 voter × 8 shard = 24 Agent 並列（各 ~190 件、前回 classification と同等負荷）
- 出力: `judged_agent_{a,b,c}.jsonl`（id, in_scope, dl_priority, priority_reason）
- 集計: id ごとに 3 票の多数決 → `manifest_dl_priority.jsonl`
- 判定基準は `src/integrable_lattice/` の docstring か `docs/judging_rubric.md`（未作成）に明文化したい。

### 2. source DL

多数決で `high` + `medium` になった arXiv 持ち論文の LaTeX source を `inputs/corpus/sources/<arxiv_id>/` に展開。
- arXiv e-print API（`https://arxiv.org/e-print/{id}`）、rate-limit 3s。
- tar.gz → 展開 → `.tex` ファイル抽出。

### 3. 02_extract 本文パス

source 取得後、`02_extract` SKILL.md に従って:
- open-problem pattern pass（"we conjecture", "remains open" 等を本文から抽出）
- 定理/命題/予想の statement fragment 抽出
- `inputs/corpus/fragments/<arxiv_id>.jsonl`

### 4. gap map + 候補生成 → 30 件

- 既解決断片で model × operation × boundary グリッドを埋める。
- 空白セルを `outputs/maps/000_gap_map.md` に列挙、自然な未解決ステートメント候補を `outputs/candidates/000_candidates.md` に 30 件以上。

### 補助タスク

- `inputs/seeds/canonical-papers.md` 作成（01_harvest README が参照、未作成）。
- S2 harvest 改善: API key 取得 or sleep を 5→10s で 429 失敗 13 件を回収。
- クエリ再設計: arXiv で 0-1 件しか返らなかったクエリの別表現再投。

## 未解決

- 「未解決」判定の自動化範囲のうち、引用グラフ部分の実装方針（OpenAlex citing API で十分か、S2 必要か）。
- `integrable-lattice/skills/` を Codex 自動発見対象にするか。
- `outputs/paper-plans/` → `outputs/papers/` 昇格基準（候補 30 件出してから判断）。
- 3 voter 多数決の tie-break ルール（1-1-1 split のとき）。
