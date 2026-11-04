# SageMath Check: 単一セルの境界の向き付き切断線横断数

**対象ラベル**: `claim_cell_boundary_winding_zero`

辺長 1〜8 の全セルで、四辺の向き付き横・縦切断線寄与がそれぞれ零になることを整数で検算する。辺長 1 でも四つの通過を重複を保って数える。

- 実行: `micromamba run -n sage sage sagemath/check/cell-boundary-winding-zero/check.sage`
- 状態: PASS（2026-11-04、204 セル）
- 計算: 整数の有限和のみ。
