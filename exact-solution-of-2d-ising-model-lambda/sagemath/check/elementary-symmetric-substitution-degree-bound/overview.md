# SageMath Check: 基本対称式への代入の全次数は重み付き次数以下

## 対象

**対象ラベル**: `def_qbar_multivariate_weighted_degree`, `claim_qbar_total_degree_constant`, `claim_qbar_total_degree_finite_sum_bound`, `claim_qbar_total_degree_product_bound`, `claim_qbar_total_degree_finite_product_bound`, `claim_qbar_elementary_symmetric_total_degree_bound`, `claim_elementary_symmetric_substitution_degree_bound`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 6436）
- 帰属: 係数環は `QQbar`、次数は非負整数。全次数 $\mathrm{tdeg}_n$ と重み付き次数 $\mathrm{wdeg}_n$ は、係数が零でない指数の集合から定義どおりに数える（Sage の `degree()` は使わない）。浮動小数点は使わない。
- 標本: $n=0,\dots,4$、係数に $\sqrt2$ を含む多項式を三〜九個。

## 何を確かめるか

- 定数: $\mathrm{mk}_n(c)$ の台が零写像だけで、全次数が $0$ であること。
- 重み付き次数: 台の各元で $\mathrm{wsz}_n(a)\le\mathrm{wdeg}_n(Q)$。
- 有限和: 標本の三つまでの和について、和の係数が係数の和、和の台の元が或る項の台にあること、上界が保たれること。
- 二元の積: 積の台の元が台の元の和 $b+c$ で書けること、$\mathrm{sz}_n(b+c)=\mathrm{sz}_n(b)+\mathrm{sz}_n(c)$、本文の式鎖の各不等号、結論。
- 有限積: 空の積 $\mathrm{mk}_n(1)$ の全次数が $0$、標本を一つずつ掛ける帰納法の各段の二つの不等号。
- 基本対称式: $\mathrm{spt}_n(X^{(n)}_k)=\{\delta_k\}$、$\mathrm{tdeg}_n(X^{(n)}_k)\le1$、各項 $\prod_{k\in S}X^{(n)}_k$ の式鎖、$\mathrm{tdeg}_n(\mathrm{es}_{n,j})\le j$（$j\le n+1$）。
- 主張: 冪の準備（$e\le3$）、$\mathrm{tdeg}_n(\mathrm{ee}_n(k))\le k+1$、各 $a\in A_Q$ で $T_a$ の式鎖の九つの値が単調に並び等号の行が等しいこと、$\mathrm{se}_n(Q)=\sum_{a\in A_Q}T_a$、結論。
- 対照: $Q=X^{(2)}_1$ では $\mathrm{se}_2(Q)=\mathrm{es}_{2,2}$ で等号 $\mathrm{tdeg}_2=\mathrm{wdeg}_2=2$ が成り立ち、重みを付けない全次数 $1$ では上界にならない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
