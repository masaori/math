# SageMath Check: 穴のない辺連結セル集合の Euler 数

**対象ラベル**: `claim_hole_free_cell_set_euler_number_one`

頂点単純な閉じた非後退単位格子歩について内側セル集合の Euler 数を検査する。
また、辺長二の正方形内の空でない辺連結・穴なしセル集合について、セルの部分集合数と
偶辺集合数と $2^{E_S+1-V_S}$ が一致することを厳密に数え上げる。

- 実行: `sage sagemath/check/hole-free-cell-set-euler-number/check.sage`
- 状態: PASS（2026-11-11 再実行）。長さ $10$ 以下の頂点単純閉歩道 704 本、内側セル延べ 2,888 個、および辺長二のセル集合 13 個を検査した。
- 計算: 有限集合の合併と `ZZ` の四則だけ。浮動小数点は使わない。
