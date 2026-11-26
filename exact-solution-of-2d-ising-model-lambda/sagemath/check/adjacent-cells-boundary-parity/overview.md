# SageMath Check: 上下に隣り合うセルの交差奇偶と共有横辺

**対象ラベル**: `claim_vertically_adjacent_cells_boundary_parity`, `def_horizontal_edge_traversal_count`, `def_right_ray_vertical_crossing_count`, `claim_horizontal_walk_edge_odd_boundary`

原点から始まり終点も原点である長さ $8$ 以下の閉じた単位格子歩（零巻き付きの平面持ち上げ）をすべて列挙し、外接長方形を各方向へ
$2$ セル広げた範囲で
$N_{r,c}^{\rightarrow}+N_{r+1,c}^{\rightarrow}\equiv H_{r+1,c}\pmod 2$
を定義から独立に数えて検査する。
奇数回通る共有横辺では上下のセルの交差奇偶がちょうど一方だけ奇数になることも検査する。

- 実行: `sage sagemath/check/adjacent-cells-boundary-parity/check.sage`
- 状態: PASS（2026-11-11 再実行。閉歩道 5,340 本・上下隣接セル対 166,232 組）。2026-11-26 に奇数回通る共有横辺の検査を足した。この実行マシンには sage が無いため、`ZZ` を Python の `int` に置き換えて実行し PASS（奇数回通る共有横辺 6,936 本）。sage での再実行は未了
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法・剰余だけ。浮動小数点は使わない。
