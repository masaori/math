# SageMath Check: 部分体に元を代入した値の全体は部分体である

## 対象

**対象ラベル**: `claim_qbar_poly_constant_term_shift_decomposition`, `claim_subfield_coefficient_polynomials_ring_closed`, `claim_subfield_polynomial_values_contains_subfield`, `claim_subfield_polynomial_values_contains_element`, `claim_subfield_polynomial_values_ring_closed`, `claim_subfield_polynomial_values_evaluation_closed`, `claim_minimal_vanishing_polynomial_constant_term_nonzero`, `claim_subfield_polynomial_values_is_subfield`

- 実行日: 2026-11-18
- 結果: 全検査通過（$F=\mathbb Q(s)$、$s\cdot s=2$。$F$ 上の最小多項式が $t-s$、$t^2-s$、$t^2-3$、$t^3-2$、$t^2-st+1$ の五つの $\alpha$ について、無作為な多項式の組を各 40 個、計 200 個）
- 帰属: 数体 $\mathbb Q(s)$ とその相対拡大の厳密計算。浮動小数点を使わない。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 分解: 係数を一つずらした $p'$ について、$\mathrm{ac}_k(t\cdot p')$ の二つの鎖の各行と $p=\widehat{\mathrm{ac}_0(p)}+t\cdot p'$。
- $F[t]$ の閉性: 和・積・符号反転の係数の式と、係数の $F$ への所属。
- 値の全体: $\mathrm{aev}_\alpha(\widehat c)=c$、$\mathrm{aev}_\alpha(t)=\alpha$、和・積・符号反転の保存、冪 $y^k$ と $\mathrm{aev}_y(h)$ が $F[t]$ の元の $\alpha$ での値であること。
- 定数項: $y\ne0$ の $F$ 上の最小多項式の零でない定数倍 $p$ について、$1,y,\dots,y^{m-1}$ の一次独立（次数が $m$）、$\mathrm{ac}_0(p)\ne0$。定数項が零の零化多項式 $t\cdot p$ は係数の上界 $m$ を満たさないこと。
- 逆元: $0=c+y\cdot\mathrm{aev}_y(p')$、$y\cdot z$ の鎖の各行、$y\cdot z=1$、$z=y^{-1}$、$z$ が $F[t]$ の元 $(-c^{-1})\cdot(p'\circ f)$ の $\alpha$ での値であること。

## 実行方法

```sh
sage check.sage
```
