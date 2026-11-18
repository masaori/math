# SageMath Check: 単項式の係数と末尾の変数への零代入の係数

## 対象

**対象ラベル**: `claim_qbar_monomial_multiplication_coefficient`, `claim_last_variable_zero_coefficient`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 30817）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n}]$ の等号と係数は厳密に判定する。浮動小数点は使わない。
- 標本: 単項式の主張は $n=1,2,3$、各成分が $0,1,2$ の指数 $a,c$、係数に $1,-2,\sqrt2,\sqrt{-3},1+\sqrt2\sqrt{-3}$ を持つ多項式 $Q$ 六個。
  零代入の主張は $n=1,2$、同じ作り方の多項式 $P\in\overline{\mathbb Q}[X_{<n+1}]$ 六個と、各成分が $0,\dots,3$ の指数 $b$。

## 何を確かめるか

単項式の主張:

- 準備の三つの等号（積の係数の定義、$b=\delta_k$ の項だけが残る、$\delta_k\le c$ での一項）。
- 零の段 $\mathrm{mon}_n(0)=1$ と、段の分解 $\mathrm{mon}_n(a)=X_k\cdot\mathrm{mon}_n(a-\delta_k)$（$k$ は $a(k)\ge1$ の最小の添字）。
- 帰納法の段の四つの等号と主張そのもの。

零代入の主張:

- $A_1$ の項の積が零であること、$A_0$ の項の積が $\mathrm{mon}_n(a|_{<n})$ であること。
- 本文の式変形の各等号と主張 $\mathrm{mco}_b(\mathrm{lz}_n(P))=\mathrm{mco}_{\mathrm{ez}_n(b)}(P)$。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
