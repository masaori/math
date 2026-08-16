# SageMath Check: 周期境界と開境界の境界評価（正の有理点）

## 対象

**対象ラベル**: `claim_periodic_open_boundary_comparison_rational`

- 実行日: 2026-08-16
- 結果: すべて通過（一辺 $L\in\{1,2,3\}$ × 正の有理点 9 点、27 組）
- 帰属: 配位・辺・破れボンド数・境界横断辺の本数は有限集合と $\mathbb{N}$、評価点と
  分配多項式の値は $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない
  （主張は $\mathbb Q$ で閉じており、実数体は現れない）。

## 何を確かめるか

$L\in\{1,2,3\}$、$q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ の全組について、次を検査する。

- 周期境界の破れボンド数の分解 $b(r_L(\tau))=b^{\mathrm{op}}_{L,L}(\tau)+s^{\mathrm{bd}}_L(\tau)$ と
  $0\le s^{\mathrm{bd}}_L(\tau)\le2L$（全配位）。
- 周期境界の値 $Z_L(q)$ と開境界の値 $Z^{\mathrm{op}}_{L,L}(q)$ はともに $\mathbb Z[x]$ の分配多項式への
  $q$ の代入であり、配位ごとの和と一致し、正である（`claim_value_at_rational_is_positive`・
  `def_open_rectangle_partition_value_at_positive_rational`・
  `claim_open_rectangle_value_at_rational_is_positive` との整合）。
- 本文の鎖 $Z_L(q)=\sum_\tau q^{b^{\mathrm{op}}_{L,L}(\tau)}q^{s^{\mathrm{bd}}_L(\tau)}$、境界因子の順序
  （$0<q\le1$: $q^{2L}\le q^{s^{\mathrm{bd}}}\le1$、$1\le q$: $1\le q^{s^{\mathrm{bd}}}\le q^{2L}$）、
  および主張の二場合の上下評価（$q=1$ は両方に属し、両方を見る）。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の有理数 $q$、任意の一辺 $L$ についての証明ではない。
一般の場合は Lean で検証済み（具体版
`partitionValueRat_periodicOpen_bounds_of_le_one/of_one_le`、必要十分版
`sum_pow_reindex_bounds_necSuf`（実数版と共有）、導出二定理。2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/periodic-open-boundary-comparison-rational/check.sage
```
