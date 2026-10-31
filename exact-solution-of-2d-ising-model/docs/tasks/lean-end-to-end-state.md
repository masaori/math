# Lean の通しの証明と章立てへの組み直しの状態

手順は [lean-end-to-end-runbook.md](lean-end-to-end-runbook.md)。

## 現在地

- 2026-10-31（人間の指示。連続実行の回ではない）: 代表の指示で runbook と判定スクリプト
  `lean/scripts/check-end-to-end.sh` を作った。この時点で `lake build`（3026 ジョブ）と `check-no-sorry.sh` は通るが、
  最終定理 `Ising2D.onsager_exact_solution_unconditional` は次を仮定しており、`check-end-to-end.sh` は
  「通しの定理が無い」で落ちる。
  - `Z` が具体的な分配関数でなく、挟み撃ちを満たす任意の関数（`hZ1`, `hZ2`）
  - 双対関係 `hdual`（`IsingParam.K2star` が `K2` と独立）
  - `W` と `V^{(+)}` の橋渡し `bridge`
  - `tr(εV^{(+)}) > 0`（`htr`）
  - `W` の成分の正値性 `hWpos` と `ε` との可換性 `hWcomm`（具体的な `W` では形式化済みだが未接続）

## 次の一歩

runbook の「作業の順序」の 1：双対結合定数を $K_2$ から定め、`hdual` を証明して最終定理の仮定から外す。
