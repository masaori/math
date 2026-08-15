# SageMath Check: 開境界長方形の値は 1 以上である

## 対象

**対象ラベル**: `def_open_rectangle_constant_plus_configuration` `claim_open_rectangle_constant_plus_breaks_no_bond` `claim_open_rectangle_value_at_least_one`

- 実行日: 2026-08-15
- 状態: PASS（56 件）
- 帰属: すべて `ZZ` / `QQ` の厳密計算。浮動小数点・ball 算術は使わない。

## 検査内容

- 形 $(a,b)$ 8 通りについて、全て正の定数配位 $\tau_{+}$ が配位（頂点集合上の写像）であること、破れボンド数が零であることを検査する（8 件）。
- 同じ 8 通りと $t\in\{1,3/4,1/2,1/5,2,7/3\}$ の 48 組で、$\tau_{+}$ の項が $t^0=1$、残りの項が正、$Z^{\mathrm{op}}_{a,b}(t)=1+(\text{残りの和})$、よって $1\le Z^{\mathrm{op}}_{a,b}(t)$ を有理数で厳密に検査する（48 件）。

## Lean

具体版 `one_le_openPartitionValue`、必要十分版 `one_le_sum_pow_by_separating_zero_exponent_term_necSuf`、導出版を
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleValueAtLeastOne.lean` と
`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/OpenRectangleValueAtLeastOne.lean` に置く（2026-08-15）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-value-at-least-one/check.sage
```
