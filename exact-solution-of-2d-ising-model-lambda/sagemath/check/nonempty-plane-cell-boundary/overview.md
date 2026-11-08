# SageMath Check: 空でない有限セル集合の境界辺

**対象ラベル**: `claim_nonempty_plane_cell_set_has_boundary_edge`

行・列座標をそれぞれ $-1,0,1$ とする格子の非空部分集合全 $511$ 件について、最大行のセルの上辺が境界辺集合に属することを整数座標の集合演算で検査する。

- 実行: `sage sagemath/check/nonempty-plane-cell-boundary/check.sage`
- 状態: 2026-11-08、`ZZ=int` とした Python 3 で全 511 件を実行し PASS。実行環境に `sage` コマンドがないため、SageMath 本体での実行は未了。
- 計算: `ZZ` と有限集合だけ。浮動小数点は使わない。
