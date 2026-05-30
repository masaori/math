# 01_harvest

## 目的

候補論文を広めに集める。dedup と粗い精度フィルタまで含む。

## 入力

- `inputs/queries/seed-queries.md`
- `inputs/seeds/{models,operations,axes,open_problem_collections}.md`
- `inputs/seeds/canonical-papers.md`（TODO 未作成）

## 出力

`inputs/corpus/` 配下:

- `manifest.jsonl` — arXiv harvest
- `manifest_openalex.jsonl` — OpenAlex harvest
- `manifest_semantic_scholar.jsonl` — Semantic Scholar harvest
- `manifest_inspire.jsonl` — INSPIRE-HEP harvest
- `manifest_merged.jsonl` — 4-source dedup（canonical key: arxiv_id > doi > normalized_title）
- `manifest_filtered.jsonl` — precision filter 通過分（model/operation hints、physics arxiv category、concepts/title keyword）
- `manifest_classified.jsonl` — arxiv 分の LLM 分類（model_hints/operation_hints/status_hints）
- `manifest_filtered_classified.jsonl` — filter 通過分の LLM 分類版

## 実装

- `pipeline/01_harvest/run.py` — arXiv 単体 harvest
- `pipeline/01_harvest/run_multi.py` — OpenAlex / Semantic Scholar / INSPIRE-HEP harvest
- `pipeline/01_harvest/merge.py` — dedup + 精度 filter

ライブラリ:
- `src/integrable_lattice/harvest.py` — arXiv Atom API
- `src/integrable_lattice/harvest_openalex.py` — OpenAlex Works API
- `src/integrable_lattice/harvest_semantic_scholar.py` — Semantic Scholar Graph API（429 retry/backoff あり）
- `src/integrable_lattice/harvest_inspire.py` — INSPIRE-HEP Literature API
- `src/integrable_lattice/dedup.py` — canonical key + マージ
- `src/integrable_lattice/filter_relevance.py` — 精度フィルタ

## 方針

- title/abstract/metadata で粗分類してから、本文 source DL は次工程（02_extract）に任せる。
- Google Scholar は API なし & ToS で除外。
- Semantic Scholar は unauthenticated rate-limit（~100/5min）が厳しい → API key 取得 or sleep 延長で改善余地。

