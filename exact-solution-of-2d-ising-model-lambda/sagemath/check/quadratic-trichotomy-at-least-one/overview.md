# SageMath Check: 二次体の三分律（少なくとも一つ）

## 対象

**対象ラベル**: `claim_quadratic_trichotomy_at_least_one`

- 実行日: 2026-08-13
- 結果: 通過（少なくとも一つの判定 1458 組、場合分けの網羅 729 組、
  加法逆元の表示 1458 組、混合符号の鎖 338 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、
$\xi\in P_s$、$\xi=0$、$-\xi\in P_s$ の少なくとも一つが成り立つ」。

- **main**: 全標本（分子 $-6..6$、分母 $1..3$ の有理数の組 $(a,b)$）と
  $t^2-2$ の両方の根 $s$ で、三つの場合の少なくとも一つが成り立つ。
  正錐の判定は表示 $(a,b)$ だけに依存する（`claim_quadratic_representation_unique`）ので、
  $\xi\in P_s$ は三条件を $(a,b)$ に、$-\xi\in P_s$ は $(-a,-b)$ に当てて判定する。
  $\xi=0$ は `QQbar` の厳密等号で判定する。
- **cover**: 証明の四つの場合（$0\le a\wedge0\le b$、$a\le0\wedge b\le0$、
  $0<a\wedge b<0$、$a<0\wedge0<b$）がすべての標本を覆う（場合分けの網羅性の裏取り）。
- **neg**: $-(a+b\cdot s)=(-a)+(-b)\cdot s$ が `QQbar` の厳密等号で成り立つ
  （`claim_quadratic_negation_representation` の表示の裏取り）。
- **mixed**: 符号が混合する標本では $b\ne0$ かつ $a\cdot a\ne2\cdot(b\cdot b)$
  （`claim_rational_square_ne_double_square` の再確認）。さらに証明の二本の鎖の各段
  （$(-a)\cdot(-a)=a\cdot a$、$2\cdot(b\cdot b)=2\cdot((-b)\cdot(-b))=2\cdot(-b)\cdot(-b)$）と、
  大小の向きごとに正錐の第二・第三条件が実際に成り立つことを検査する。

## 実行方法

```sh
sage check.sage
```
