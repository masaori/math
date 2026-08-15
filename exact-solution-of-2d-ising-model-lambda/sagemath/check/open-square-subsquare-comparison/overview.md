# SageMath Check: 開境界正方形と部分正方形の値の比較

## 対象

**対象ラベル**: `claim_open_square_subsquare_comparison_le_one`

- 実行日: 2026-08-15
- 状態: PASS（24 件）
- 帰属: すべて `ZZ` / `QQ` の厳密計算。浮動小数点・ball 算術は使わない。

## 検査内容

- $(a,L)$ 6 組（$1\le a<L\le4$）と $0<t\le1$ の有理点 4 点について、$c=L-a$ と
  $ac+cL=L^2-a^2$ を確かめたうえで、証明の下からの評価の各行（冪の指数法則、$1\le Z^{\mathrm{op}}_{a,c}$、
  第二座標方向の接合の下側、$1\le Z^{\mathrm{op}}_{c,L}$、第一座標方向の接合の下側）と上からの評価の各行
  （第一・第二座標方向の接合の上側、配位数による上界二回、指数の整理）を有理数の等式・不等式として検査し、
  最後に主張 $t^{a+L}Z^{\mathrm{op}}_{a,a}(t)\le Z^{\mathrm{op}}_{L,L}(t)\le2^{L^2-a^2}Z^{\mathrm{op}}_{a,a}(t)$
  を検査する（24 件）。

## Lean

具体版 `openPartitionValue_square_subsquare_bounds_of_le_one`、必要十分版 `split_twice_bounds_necSuf`、
導出版を `lean/Ising2DLambda/ThermodynamicLimit/OpenSquareSubsquareComparison.lean`、
`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/OpenSquareSubsquareComparison.lean`、
`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareSubsquareComparisonFromNecSuf.lean` に置く（2026-08-15）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-subsquare-comparison/check.sage
```
