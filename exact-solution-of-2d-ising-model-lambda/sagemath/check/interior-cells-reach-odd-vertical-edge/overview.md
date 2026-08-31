# SageMath Check: 内側セルは行に沿って奇数回通過の縦辺まで届く

**対象ラベル**: `claim_interior_cells_reach_odd_vertical_edge`, `def_odd_ray_interior_cells`, `def_vertical_edge_traversal_count`

原点から始まる長さ $8$ 以下の閉じた単位格子歩をすべて列挙し、各歩の各内側セル $(r,c)$
（右半直線交差数が奇数）について、最小の $g>c$ で $(r,g)$ が外側になるものを取り、
$(r,c),\ldots,(r,g-1)$ がすべて内側であること、共有縦辺の通過回数 $V_{r,g}$ が奇数
（したがって $1$ 以上）であることを検査する。

- 実行: `sage sagemath/check/interior-cells-reach-odd-vertical-edge/check.sage`
- 状態: PASS（2026-08-31。閉歩道 5,340 本・内側セル 3,912 個）
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法・剰余だけ。浮動小数点は使わない。
