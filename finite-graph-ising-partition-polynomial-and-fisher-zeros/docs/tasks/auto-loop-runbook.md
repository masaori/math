# 自動 tick Runbook

## 現在の研究対象

既存成果の二章構成への整理を終え、READMEの分配多項式の識別能力を調べるため、
[next-research-target.md](next-research-target.md) の頂点数一から五の有限探索を採用した。
元の条件付き成果整理指示とエージェントが加えた許可待ちは、共通の研究停止の元指示と復旧条件で区別する。

## 読むもの

- リポジトリ直下の `AGENTS.md`、`CLAUDE.md`、`docs/context/` の全ファイル
- `.codex/skills/math-prover/SKILL.md`
- このプロジェクトの `README.md`、`MEMORY.md`
- この runbook、`auto-loop-state.md`、`task-dependency-graph.md`

## 実行手順

- remote default branch を特定して fetch し、遅れを安全に取り込む。
- 「現在の研究対象」の最初の未達項目を一つだけ進める。入力範囲と否定結果を含む終了条件を守る。
- `math-prover` の一ステップ一定理、ラベル参照、記号の所属、`R/C` 脱出規則を守る。
- README に記載した全検証と、変更した `.sage` の実行を通す。
- `auto-loop-state.md` と `MEMORY.md` を更新し、Lean 未着手を完了と書かない。
- commit 前に再度 fetch し、成果を remote default branch へ push して ancestry を確認する。
- 全項目が閉じたら成果追加を止めて、次の対象は共通監督と所有repoの評価へ戻す。冪数や頂点数を自動で増やさない。
- 現在のように全項目が閉じている場合は、終了済み探索の再レビューを台帳やMEMORYへ追記せず、
  本文検査・コミットも行わず終了する。

## 次の対象

[next-research-target.md](next-research-target.md)に入力・採否・完了条件を固定した。
2026-09-05に固定範囲の全件探索と証明書の検算を完了した。現在の研究対象の未達はない。
追加探索を行わず、次の対象は共通監督と所有repoの評価へ戻す。停止実体の変更と研究の進展は別に記録する。
