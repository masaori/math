# SageMath Check: 開境界正方形のブロック敷き詰め評価（正の有理点）

## 対象

**対象ラベル**: `claim_open_square_block_tiling_rational`

- 実行日: 2026-08-16
- 結果: すべて通過（形 $(a,k)$ 5 通り × 正の有理点 9 点、45 組）
- 帰属: 配位・辺・破れボンド数・ブロック数は有限集合と $\mathbb{N}$、評価点と
  分配多項式の値は $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない
  （主張は $\mathbb Q$ で閉じており、実数体は現れない）。

## 何を確かめるか

$(a,k)\in\{(1,1),(1,2),(1,3),(2,1),(2,2)\}$（一辺 $ka\le4$）、
$q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ の全組について、次を検査する。

- 値 $Z^{\mathrm{op}}_{a,b}(q)$ は $\mathbb Z[x]$ の分配多項式への $q$ の代入であり、
  配位ごとの和 $\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$ と一致し、正である
  （`def_open_rectangle_partition_value_at_positive_rational`・
  `claim_open_rectangle_value_at_rational_is_positive` との整合）。
- 本文の鎖を段ごとに: 第一座標方向の反復接合評価（`claim_open_rectangle_iterated_gluing_first_rational`、
  $b=a$）、その両辺の $k$ 乗（準備: 正の底の自然数冪は順序を保つ）、第二座標方向の反復接合評価
  （`claim_open_rectangle_iterated_gluing_second_rational`、第一座標の長さ $ka$）、
  それらを合成した主張の二場合の上下評価（$q=1$ は両方に属し、両方を見る）。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の有理数 $q$、任意の一辺、任意のブロック数についての証明ではない。
一般の場合は Lean で検証済み（具体版
`openPartitionValueRat_squareBlockTiling_bounds_of_le_one/of_one_le`、必要十分版
`two_direction_pow_bounds_necSuf`（実数版と共有）、導出二定理。2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-block-tiling-rational/check.sage
```
