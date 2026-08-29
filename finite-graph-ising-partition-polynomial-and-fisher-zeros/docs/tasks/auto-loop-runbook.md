# 自動 tick Runbook

## 現在の停止条件

上位の研究ゴールと次の具体的な研究対象が未選定であるため、新しい定義・主張・定理を追加しない。
既存成果の二章構成への整理は完了している。人間が上位ゴールを定めるまで自動 tick は停止する。

## 読むもの

- リポジトリ直下の `AGENTS.md`、`CLAUDE.md`、`docs/context/` の全ファイル
- `.codex/skills/math-prover/SKILL.md`
- このプロジェクトの `README.md`、`MEMORY.md`
- この runbook、`auto-loop-state.md`、`task-dependency-graph.md`

## 実行手順

- remote default branch を特定して fetch し、遅れを安全に取り込む。
- 新しい定義・主張・定理を追加せず、停止条件を報告して終了する。
- `math-prover` の一ステップ一定理、ラベル参照、記号の所属、`R/C` 脱出規則を守る。
- README に記載した全検証と、変更した `.sage` の実行を通す。
- `auto-loop-state.md` と `MEMORY.md` を更新し、Lean 未着手を完了と書かない。
- commit 前に再度 fetch し、成果を remote default branch へ push して ancestry を確認する。
- `slack-notification` skill で、公開本文
  `https://hexcomp-artifacts.web.app/math/finite-graph-ising-partition-polynomial/` を付けて通知する。
  話題名は「有限グラフのイジング分配多項式とFisher零点」とする。
  commit URL は人間へ本文を見せる URL として使わない。
- 上位ゴールが台帳へ明記されるまで成果追加を再開しない。
