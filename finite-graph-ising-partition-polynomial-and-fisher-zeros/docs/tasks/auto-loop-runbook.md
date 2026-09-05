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
- `slack-notification` skill で、公開本文
  `https://hexcomp-artifacts.web.app/math/finite-graph-ising-partition-polynomial/` を付けて通知する。
  話題名は「有限グラフのイジング分配多項式とFisher零点」とする。
  commit URL は人間へ本文を見せる URL として使わない。
- 全項目が閉じたら成果追加を止めて、次の対象は共通監督と所有repoの評価へ戻す。冪数や頂点数を自動で増やさない。

## 次の対象

[next-research-target.md](next-research-target.md)に入力・採否・完了条件を固定した。
2026-09-05に固定範囲の全件探索と証明書の検算を完了した。現在の研究対象の未達はない。
追加探索を行わず、次の対象は共通監督と所有repoの評価へ戻す。停止実体の変更と研究の進展は別に記録する。
