# SageMath Check: 零点と係数データによる多項式の決定

**対象ラベル**: `claim_distinct_roots_do_not_determine_polynomial`

**対象ラベル**: `claim_roots_leading_coefficient_multiplicities_determine_polynomial`

本文の二つの反例（$A=X-1$ と $B=2X-2$、$C=X-1$ と $D=(X-1)^2$）と、
零点・代数的重複度・最高次係数からの有限積表示による一意性を、$\overline{\mathbb Q}[X]$ の厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 一次係数 $1\ne2$ から $A\ne B$、$A(1)=B(1)=0$、相異なる零点集合はどちらも $\{1\}$ | `QQbar[X]` の係数比較・代入・`roots(QQbar)` | PASS |
| 次数 $1\ne2$ から $C\ne D$、$C(1)=D(1)=0$、相異なる零点集合はどちらも $\{1\}$ | 同上 | PASS |
| $F=3(X-1)^2(X-\sqrt2)(X+\sqrt2)^3$ について、各因子 $(X-r)^{\mu(r)}$ と有限積の最高次係数が $1$、$c\prod(X-r)^{\mu(r)}=F$ | `leading_coefficient` と有限積の等式 | PASS |
| 同じ $(R,\mu,c)$ から順序を変えて組み立てた多項式が等しい | 有限積の等式 | PASS |

すべて `QQbar`・`QQbar[X]` の厳密計算であり、浮動小数点、実対数、指数関数、無限和は使わない。

```sh
sage sagemath/check/root-data-determine-polynomial/check.sage
```

**2026-08-15 実行: 13 件すべて通過。**
