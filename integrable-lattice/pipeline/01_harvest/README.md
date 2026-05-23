# 01_harvest

## 目的

候補論文を広めに集める。

## 入力

- `inputs/queries/seed-queries.md`
- `inputs/seeds/canonical-papers.md`

## 出力

- paper metadata
- abstract
- source availability
- citation metadata

## 実装方針

- まずは arXiv metadata と OpenAlex metadata を対象にする。
- PDF本文より先に title/abstract/metadata で粗分類する。
- arXiv source が取れるものは後段の式抽出で優先する。

