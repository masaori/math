# SageMath Check: 開境界正方形のブロック敷き詰め評価の対数化（Λ の鎖）

## 対象

**対象ラベル**: `claim_open_square_block_tiling_log`

- 実行日: 2026-08-16
- 状態: PASS（形 $(a,k)\in\{(1,1),(1,2),(1,3),(2,1),(2,2)\}$ × 正の有理点 9 点。
  各組で準備の第一 1 件・第二 6 件・第三 3 件・本体 4 件（$q=1$ は両場合で 8 件）、合計 650 件）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書の厳密計算。浮動小数点は使わない（主張は $\Lambda$ で閉じている）。

## 検査内容

形 $(a,k)$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $Z^{\mathrm{op}}_{a,a}(q),Z^{\mathrm{op}}_{ka,ka}(q)\in\mathbb Q_{>0}$
  （$\mathbb Z[x]$ の開境界分配多項式への代入が配位ごとの和と一致することも見る）、
  両側の評価の値 $q^{(k-1)(ka)}(q^{(k-1)a}Z^{\mathrm{op}}_{a,a}(q)^k)^k$ と $(Z^{\mathrm{op}}_{a,a}(q)^k)^k$ が $\mathbb Q_{>0}$ の元であること。
- 準備の第二: $\log\bigl(q^{(k-1)(ka)}(q^{(k-1)a}Z^{\mathrm{op}}_{a,a}(q)^k)^k\bigr)
  =2k(k-1)a\log q+k^2\log Z^{\mathrm{op}}_{a,a}(q)$ の六段（対数の加法性・冪・整数倍の分配則と結合則）を
  $\Lambda$ の有限台辞書の等号で一段ずつ。
- 準備の第三: $\log\bigl((Z^{\mathrm{op}}_{a,a}(q)^k)^k\bigr)=k^2\log Z^{\mathrm{op}}_{a,a}(q)$ の三段。
- 本体: $0<q\le1$ で $2k(k-1)a\log q+k^2\log Z^{\mathrm{op}}_{a,a}(q)\le_\Lambda\log Z^{\mathrm{op}}_{ka,ka}(q)\le_\Lambda k^2\log Z^{\mathrm{op}}_{a,a}(q)$、
  $1\le q$ でその反転（$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ を通した $\mathbb Q$ の比較で判定。
  `claim_rational_log_order_iff` の移送＝ $\mathbb Q$ の比較と一致することも各段で見る）。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `logRat_blockTilingLowerValue_eq`（準備の第二）・`logRat_blockTilingUpperValue_eq`（準備の第三）・
`logOrderLE_openSquareBlockTilingLog_bounds_of_le_one`／`_of_one_le`（本体の二場合）
（`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`。
`claim_open_square_block_tiling_rational` の Lean と `logRat_le_iff`・`logRat_mul`・`logRat_pow` から組む）。
必要十分版・導出版は未着手（次の tick）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-block-tiling-log/check.sage
```
