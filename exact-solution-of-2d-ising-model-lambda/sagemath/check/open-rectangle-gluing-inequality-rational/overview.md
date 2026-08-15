# SageMath Check: 開境界長方形の接合不等式（正の有理点）

## 対象

**対象ラベル**: `claim_open_rectangle_gluing_inequality_rational`

- 実行日: 2026-08-16
- 結果: すべて通過（形 $(a,b,c)$ 23 通り × 正の有理点 9 点、第一・第二の座標方向を合わせて 414 組）
- 帰属: 配位・辺・破れボンド数は有限集合と $\mathbb{N}$、評価点と分配多項式の値は
  $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない
  （主張は $\mathbb Q$ で閉じており、実数体は現れない）。

## 何を確かめるか

$a,b,c\in\{1,2,3\}$ のうち接合後の頂点数が 12 以下の形と、
$q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ の全組について、次を独立に検査する。

- 値 $Z^{\mathrm{op}}_{a,b}(q)$ は $\mathbb Z[x]$ の分配多項式への $q$ の代入であり、
  配位ごとの和 $\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$ と一致し、正である
  （`def_open_rectangle_partition_value_at_positive_rational`・
  `claim_open_rectangle_value_at_rational_is_positive` との整合）。
- 二つの配位を第一の座標方向または第二の座標方向に接ぐ写像が、接合後の全配位を重複なく
  列挙する。
- 接合後の破れボンド数が、二つの長方形の破れボンド数と接合面の破れ辺数の和に等しい。
- 接合面の破れ辺数は、第一の座標方向では $0$ 以上 $b$ 以下、第二の座標方向では
  $0$ 以上 $a$ 以下であり、$0<q\le1$ では $q^b\le q^s\le1$、$1\le q$ では $1\le q^s\le q^b$
  （第二方向は $b$ を $a$ に置く）。
- $0<q\le1$ と $1\le q$ のそれぞれについて、本文の上下二つの不等式が成り立つ
  （$q=1$ は両方の場合に属し、両方を見る）。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の有理数 $q$ や任意の長方形についての証明ではない。不等式は、
本文が正の底の自然数冪の順序と有限和の順序から証明する。Lean 具体版・必要十分版
（実数版と共有）・導出版が、この普遍量化と人手証明の対応を担う。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-gluing-inequality-rational/check.sage
```
