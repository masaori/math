# SageMath Check: 開境界長方形の値の配位数による上からの評価

## 対象

**対象ラベル**: `claim_open_rectangle_value_upper_bound_le_one` `claim_open_rectangle_value_upper_bound_one_le`

- 実行日: 2026-08-15
- 状態: PASS（64 件）
- 帰属: すべて `ZZ` / `QQ` の厳密計算。浮動小数点・ball 算術は使わない。

## 検査内容

- 形 $(a,b)$ 8 通りと $0<t\le1$ の有理点 4 点について、各項が 1 以下であり、配位数が $2^{ab}$、したがって $Z^{\mathrm{op}}_{a,b}(t)\le2^{ab}$ であることを検査する（32 件）。
- 同じ 8 形状と $1\le t$ の有理点 4 点について、辺数 $2ab-a-b\le2ab$、各項が $t^{2ab}$ 以下、したがって $Z^{\mathrm{op}}_{a,b}(t)\le2^{ab}t^{2ab}$ であることを検査する（32 件）。

## Lean

具体版二本、既存の必要十分版 `sum_pow_le_uniform_bound_necSuf` からの導出版二本を
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleValueUpperBound.lean` と
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleValueUpperBoundFromNecSuf.lean` に置く（2026-08-15）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-value-upper-bound/check.sage
```
