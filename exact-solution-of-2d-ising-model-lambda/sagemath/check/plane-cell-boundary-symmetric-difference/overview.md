# SageMath Check: 平面の有限セル集合の境界と対称差

**対象ラベル**: `claim_plane_cell_boundary_preserves_symmetric_difference`

行・列座標をそれぞれ $0,1$ とするセル集合の全 $16^2=256$ 対について、横辺・縦辺の所属判定を各行で検算し、境界辺集合の対称差等式を検査する。

- 実行: `/home/masaori/.cache/masaori-math/sage-env/bin/sage sagemath/check/plane-cell-boundary-symmetric-difference/check.sage`
- 状態: 2026-11-08、SageMath 本体で全 256 対を実行し PASS（`PASS: cell-set pairs=256, boundary preserves symmetric difference`）。
- 計算: `ZZ` と有限集合・真偽値のみ。浮動小数点は使わない。
