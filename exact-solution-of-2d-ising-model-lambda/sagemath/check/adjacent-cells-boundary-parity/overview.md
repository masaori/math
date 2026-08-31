# SageMath Check: 上下に隣り合うセルの交差奇偶と共有横辺

**対象ラベル**: `claim_vertically_adjacent_cells_boundary_parity`, `def_horizontal_edge_traversal_count`, `def_right_ray_vertical_crossing_count`

原点から始まり終点も原点である長さ $8$ 以下の閉じた単位格子歩（零巻き付きの平面持ち上げ）をすべて列挙し、外接長方形を各方向へ
$2$ セル広げた範囲で
$N_{r,c}^{\rightarrow}+N_{r+1,c}^{\rightarrow}\equiv H_{r+1,c}\pmod 2$
を定義から独立に数えて検査する。

- 実行: `sage sagemath/check/adjacent-cells-boundary-parity/check.sage`
- 状態: PASS（2026-08-31。閉歩道 5,340 本・上下隣接セル対 166,232 組）
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法・剰余だけ。浮動小数点は使わない。
