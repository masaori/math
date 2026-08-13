# SageMath Check: 二次体の三分律（高々一つ）

## 対象

**対象ラベル**: `claim_quadratic_trichotomy_at_most_one`

- 実行日: 2026-08-13
- 結果: 通過（高々一つの判定 1458 組、零表示が三条件を満たさないこと 3 件、
  書き直しの同値 729 組、九つの組み合わせの排他 6561 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、
$\xi\in P_s$、$\xi=0$、$-\xi\in P_s$ のうち同時に成り立つものは高々一つ」。

- **main**: 全標本（分子 $-6..6$、分母 $1..3$ の有理数の組 $(a,b)$）と
  $t^2-2$ の両方の根 $s$ で、三つの場合のうち成り立つものが 1 個以下である。
  正錐の判定は表示 $(a,b)$ だけに依存する（`claim_quadratic_representation_unique`）ので、
  $\xi\in P_s$ は三条件を $(a,b)$ に、$-\xi\in P_s$ は $(-a,-b)$ に当てて判定する。
  $\xi=0$ は `QQbar` の厳密等号で判定する。
- **zero**: 組 $(0,0)$ は正錐の三条件のどれも満たさない（証明の準備の裏取り）。
- **trans**: 証明が使う「$(-a,-b)$ の三条件の $(a,b)$ の言葉への書き直し」が全標本で同値
  （第一 $\iff a\le0\wedge b\le0\wedge(a,b)\ne(0,0)$、
  第二 $\iff a<0\wedge0<b\wedge2\cdot(b\cdot b)<a\cdot a$、
  第三 $\iff 0<a\wedge b<0\wedge a\cdot a<2\cdot(b\cdot b)$）。
- **pairs**: $(a,b)$ が満たす条件と $(-a,-b)$ が満たす条件の九つの組み合わせのどれも、
  同時に満たす標本が存在しない（証明の九つの場合の矛盾の裏取り）。

## 実行方法

```sh
sage check.sage
```
