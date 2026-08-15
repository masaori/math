# SageMath Check: 開境界長方形の第二座標方向の反復接合不等式（正の有理点）

## 対象

**対象ラベル**: `claim_open_rectangle_iterated_gluing_second_rational`

- 実行日: 2026-08-16
- 結果: すべて通過（形 $(a,b,k)$ 14 通り × 正の有理点 9 点、126 組）
- 帰属: 配位・辺・破れボンド数・反復回数は有限集合と $\mathbb{N}$、評価点と
  分配多項式の値は $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない
  （主張は $\mathbb Q$ で閉じており、実数体は現れない）。

## 何を確かめるか

$(a,b,k)$ を $a\in\{1,2\}$、$b\in\{1,2,3\}$、$k\le4$ のうち接合後の頂点数が 8 以下の 14 通り、
$q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ の全組について、次を検査する。

- 値 $Z^{\mathrm{op}}_{a,b}(q)$ は $\mathbb Z[x]$ の分配多項式への $q$ の代入であり、
  配位ごとの和 $\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$ と一致し、正である
  （`def_open_rectangle_partition_value_at_positive_rational`・
  `claim_open_rectangle_value_at_rational_is_positive` との整合）。
- 本文の二場合の上下評価（$0<q\le1$ では $q^{(k-1)a}Z^{\mathrm{op}}_{a,b}(q)^k\le Z^{\mathrm{op}}_{a,kb}(q)
  \le Z^{\mathrm{op}}_{a,b}(q)^k$、$1\le q$ ではその逆向き。$q=1$ は両方に属し、両方を見る）。
- 帰納段（$k\ge2$）: $ka=a+(k-1)a$ の指数の等式、帰納法の仮定に $q^a$ と一枚の値を掛けた評価、
  第二座標の長さ $(k-1)b$ と $b$ の二長方形への接合不等式（正の有理点。
  `claim_open_rectangle_gluing_inequality_rational`）の各段が、本文の鎖の順に成り立つこと。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の有理数 $q$、任意の長方形、任意の反復回数についての証明ではない。
本文は、一回の接合不等式を反復回数について帰納的に適用して一般の場合を証明する。
一般の場合は Lean で検証済み（具体版
`openPartitionValueRat_iteratedGlueSecond_bounds_of_le_one/of_one_le`、必要十分版
`iterated_glue_pow_bounds_necSuf`（実数版と共有）、導出二定理。2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-iterated-gluing-second-rational/check.sage
```
