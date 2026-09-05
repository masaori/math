# 自動 tick Runbook

## tick のモデルと利用上限

停止中も起動設定は Codex の `gpt-6-astra`、reasoning `medium` に揃える。
正規起動口が起動前に選んだ `CODEX_HOME` とモデル名を起動時に明示する。
利用上限・認証失敗・モデル利用不可は非ゼロ終了としてログへ残し、未コミット成果を保持する。
実行途中で別モデル・別 CLI・別アカウントへ切り替えない。
次回の起動前のアカウント選定は正規起動口が行う。`CODEX_HOME` が未設定・空なら起動前に失敗する。
モデルの変更は停止解除を意味しない。下の停止条件と再開条件を維持する。

プログラミングによる検証は、リポジトリ直下で `python3 scripts/test-research-tick-models.py` を実行する。
実際の起動部分へ偽 CLI を渡し、固定モデル・起動口が渡したアカウント・非ゼロ終了の伝播を判定する。
この試験は実モデルの応答確認を代替しない。

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

## 監督で具体化した次の対象（2026-09-05）

[次の有限な研究対象](next-research-target.md) に、READMEの既存目的から導いた入力・採否・完了条件を記録した。
現時点では未着手であり、本文の新しい数学的成果ではない。停止実体の変更と研究の進展は別に記録する。
