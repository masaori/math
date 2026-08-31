# SageMath Check: 横に隣り合うセルの交差数の差は間の縦辺の通過回数である

**対象ラベル**: `claim_adjacent_cells_ray_crossing_difference`, `def_vertical_edge_traversal_count`, `def_right_ray_vertical_crossing_count`

原点から始まる長さ $8$ 以下の閉じた単位格子歩をすべて列挙し、各歩について外接長方形を
各方向へ $2$ セル広げた範囲の各セル $(r,c)$ で、右半直線交差数の恒等式
$N_{r,c}^{\rightarrow}=N_{r,c+1}^{\rightarrow}+V_{r,c+1}$
（$V_{r,c+1}$ は縦辺 $\{(r,c+1),(r+1,c+1)\}$ の通過回数）を検査する。

- 実行: `sage sagemath/check/adjacent-cells-ray-crossing-difference/check.sage`
- 状態: PASS（2026-08-31。閉歩道 5,340 本・隣接セル対 166,232 組）
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法だけ。浮動小数点は使わない。
