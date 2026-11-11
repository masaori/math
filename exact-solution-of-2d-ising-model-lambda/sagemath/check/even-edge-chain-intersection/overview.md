# 正方形境界と基本周回の交差数

**対象ラベル**: `claim_even_edge_chain_intersection`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_square_boundary.sage` | 正方形境界の二方向の展開と偶次数による消去 | PASS（2026-11-11 再実行） |
| `check_basic_cycles.sage` | 基本周回の四つの組の交差数 | PASS（2026-11-11 再実行） |
| `check_normal_form.sage` | 辺長一から三の全偶辺鎖の交差形式 | PASS（2026-11-11 再実行） |

有限検算は一般の辺長の本文証明を代用しない。係数は整数の偶奇だけで計算する。

Lean: 具体版 `Ising2DLambda.KacWard.coefficientIntersection_eq_cutParity`（`lean/Ising2DLambda/KacWard/EvenEdgeChainIntersectionValue.lean`）と必要十分版 `Ising2DLambda.NecSuf.KacWard.ringCoefficientIntersection_eq_cutParity`。
