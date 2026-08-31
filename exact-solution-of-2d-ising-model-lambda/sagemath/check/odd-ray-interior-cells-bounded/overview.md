# SageMath Check: 右半直線との交差奇偶で定めた内側セルの有限性

**対象ラベル**: `claim_odd_ray_interior_cells_bounded`, `def_odd_ray_interior_cells`, `def_right_ray_vertical_crossing_count`

原点から始まる長さ $8$ 以下の閉じた単位格子歩をすべて列挙し、各歩について外接長方形を
各方向へ $2$ セル広げた範囲を走査する。単位正方形の中心から右へ延びる半直線と縦辺との
交差数が奇数なら、そのセルの添字が外接長方形
$\{r_{\min},\ldots,r_{\max}-1\}\times\{c_{\min},\ldots,c_{\max}-1\}$
に入ることを検査する。

- 実行: `sage sagemath/check/odd-ray-interior-cells-bounded/check.sage`
- 状態: PASS（2026-08-31。閉歩道 5,340 本・セル 166,232 個）
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法・奇偶だけ。浮動小数点は使わない。
