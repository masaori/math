# SageMath Check: 開境界正方形と部分正方形の値の比較（正の有理点。q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_subsquare_comparison_rational_le_one`

- 実行日: 2026-08-16
- 結果: すべて通過（形 $(a,L)$ 3 通り × 正の有理点 6 点、270 検査。所要 4 秒）
- 帰属: 配位・辺・破れボンド数は有限集合と $\mathbb{N}$、評価点と分配多項式の値は
  $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない
  （主張は $\mathbb{Q}$ で閉じており、実数体は現れない）。

## 何を確かめるか

$(a,L)\in\{(1,2),(1,3),(2,3)\}$、$q\in\{1/10,1/3,1/2,2/3,9/10,1\}$ の全組について、次を検査する。

- 値 $Z^{\mathrm{op}}_{a,b}(q)$ は $\mathbb{Z}[x]$ の分配多項式への $q$ の代入であり、
  配位ごとの和 $\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$ と一致し、正である
  （`def_open_rectangle_partition_value_at_positive_rational`・
  `claim_open_rectangle_value_at_rational_is_positive` との整合）。
- 準備の第一（$c=L-a$、$L=a+c$）と第二（$ac+cL=L^2-a^2$）。
- 本文の下からの評価の鎖 7 段（冪の指数法則・$1\le Z^{\mathrm{op}}_{a,c}$・第二座標方向の接合の下側・
  $a+c=L$・$1\le Z^{\mathrm{op}}_{c,L}$・第一座標方向の接合の下側・$a+c=L$）を段ごとに。
- 本文の上からの評価の鎖 8 段（$L=a+c$・第一座標方向の接合の上側・$L=a+c$・第二座標方向の接合の上側・
  $Z^{\mathrm{op}}_{a,c}\le2^{ac}(1+q)^{2ac}$・$Z^{\mathrm{op}}_{c,L}\le2^{cL}(1+q)^{2cL}$・
  冪の指数法則・$ac+cL=L^2-a^2$）を段ごとに。
- 主張そのもの $q^{a+L}Z^{\mathrm{op}}_{a,a}(q)\le Z^{\mathrm{op}}_{L,L}(q)\le2^{L^2-a^2}(1+q)^{2(L^2-a^2)}Z^{\mathrm{op}}_{a,a}(q)$。

一辺 $4$ 以上の正方形は含めない（$4\times4$ の総当たりは 10 分を超えた実測があるため。
`open-square-block-tiling-density` の overview を参照）。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の有理数 $q\le1$、任意の $a<L$ についての証明ではない。
一般の場合は Lean で検証済み（具体版 `openPartitionValueRat_square_subsquare_bounds_of_le_one`、
必要十分版 `split_twice_bounds_necSuf`（実数版と共有。可換半環の順序と非負元の乗法単調性・二段の分割の
上下・余りの下界 $1$ と上界だけ）、導出版 `openPartitionValueRat_square_subsquare_bounds_of_le_one_from_necSuf`。
2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-subsquare-comparison-rational/check.sage
```
