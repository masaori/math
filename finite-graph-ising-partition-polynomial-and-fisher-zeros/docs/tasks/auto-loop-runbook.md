# 自動 tick Runbook

## 一 tick のゴール

既存成果をレビューした後、`auto-loop-state.md` の実行待ちの先頭から、構造化本文の一つの
定義・主張・定理だけを完成方向へ進める。複数の数学的主張を一ブロックへ束ねない。

## 読むもの

- リポジトリ直下の `AGENTS.md`、`CLAUDE.md`、`docs/context/` の全ファイル
- `.codex/skills/math-prover/SKILL.md`
- このプロジェクトの `README.md`、`MEMORY.md`
- この runbook、`auto-loop-state.md`、`task-dependency-graph.md`

## 実行手順

- remote default branch を特定して fetch し、遅れを安全に取り込む。
- 本文、ラベル依存、対応 SageMath をレビューし、欠陥を新規追加より先に直す。
- 一 tick につき一つの定義・主張・定理だけを進め、必要な一行ごとの SageMath 検算を追加する。
- `math-prover` の一ステップ一定理、ラベル参照、記号の所属、`R/C` 脱出規則を守る。
- README に記載した全検証と、変更した `.sage` の実行を通す。
- `auto-loop-state.md` と `MEMORY.md` を更新し、Lean 未着手を完了と書かない。
- commit 前に再度 fetch し、成果を remote default branch へ push して ancestry を確認する。
- `slack-notification` skill で、公開本文
  `https://hexcomp-artifacts.web.app/math/finite-graph-ising-partition-polynomial/` を付けて通知する。
  話題名は「有限グラフのイジング分配多項式とFisher零点」とする。
  commit URL は人間へ本文を見せる URL として使わない。
- 一つの主張を進めたら終了し、次は次回 tick へ残す。
