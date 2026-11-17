# SageMath Check: 最小次数の零化多項式による整除と、代入した値の全体の表示

## 対象

**対象ラベル**: `def_subfield_polynomial_values`, `claim_vanishing_polynomial_below_degree_is_zero`, `claim_minimal_vanishing_polynomial_leading_coefficient_nonzero`, `claim_minimal_vanishing_polynomial_divides`, `claim_subfield_polynomial_values_reduced_representation`

- 実行日: 2026-11-18
- 結果: 全検査通過（$F=\mathbb Q(s)$、$s\cdot s=2$。$F$ 上の最小多項式が $t-s$、$t^2-s$、$t^2-3$、$t^3-2$、$t^2-st+1$ の五つの $\alpha$ について、無作為な多項式の組を各 60 個、計 300 個）
- 帰属: 数体 $\mathbb Q(s)$ とその相対拡大の厳密計算。浮動小数点を使わない。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 次数: 相対拡大の次数から $1,\alpha,\dots,\alpha^{n-1}$ が $F$ 上一次独立であり、$\deg_F(\alpha)=n$ であること。係数の上界が $n$ 未満の零でない多項式の値が零でないこと。
- 番号 $n$ の係数: 最小多項式の零でない定数倍 $p$ について、$p$ が $\alpha$ を根とし、係数の上界が $n$ で、$\mathrm{ac}_n(p)\ne0$ であること。
- 整除: $\alpha$ を根とする $f=u_0\cdot p$ を $p$ で割った余り $r$ について、値の鎖の各行と $r=0$、$f=u\cdot p$。
- 値の表示: 無作為な $f\in F[t]$ を $p$ で割り、$\mathrm{aev}_\alpha(f)$ から $\mathrm{aev}_\alpha(r)$ へ至る鎖の各行と、$r$ の係数の上界と所属。

## 実行方法

```sh
sage check.sage
```
