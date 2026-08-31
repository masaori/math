# SageMath Check: 穴のない辺連結セル集合の Euler 数

**対象ラベル**: `claim_hole_free_cell_set_euler_number_one`

頂点単純な閉じた非後退単位格子歩について、右半直線交差が奇数の内側セル集合を構成し、
頂点・辺・セルの個数から計算した Euler 数が $1$ であることを検査する。

- 実行: `sage sagemath/check/hole-free-cell-set-euler-number/check.sage`
- 状態: PASS（2026-08-31）。長さ $10$ 以下の頂点単純閉歩道 704 本、内側セル延べ 2,888 個を検査した。
- 計算: 有限集合の合併と `ZZ` の四則だけ。浮動小数点は使わない。
