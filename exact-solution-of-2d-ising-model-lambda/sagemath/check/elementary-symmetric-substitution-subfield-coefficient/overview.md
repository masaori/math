# SageMath Check: 基本対称式への代入は部分体係数を保つ

## 対象

**対象ラベル**: `claim_subfield_coefficient_multivariate_constant`, `claim_subfield_coefficient_multivariate_variable`, `claim_subfield_coefficient_multivariate_finite_sum`, `claim_subfield_coefficient_multivariate_finite_product`, `claim_qbar_elementary_symmetric_subfield_coefficient`, `claim_elementary_symmetric_substitution_subfield_coefficient`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 921）
- 帰属: 係数環は `QQbar`。部分体 $F$ は $\mathbb{Q}$ と $\mathbb{Q}(\sqrt2)$。係数の所属は最小多項式と $\mathbb{Q}(\sqrt2)$ での根の厳密な比較で判定する。浮動小数点は使わない。
- 標本: $n=0,\dots,4$、各 $F$ について係数が $F$ に属する多項式を三〜六個。

## 何を確かめるか

- 定数 $\mathrm{mk}_n(c)$（$c\in F$）と変数 $X^{(n)}_k$ の係数が $F$ に属すること。
- 有限和・有限積: 標本を一つずつ足し・掛けていく帰納法の各段（空の和・空の積 $=\mathrm{mk}_n(1)$ を含む）で $F$ 係数であること、和の係数が係数の和であること。
- 基本対称式 $\mathrm{es}_{n,j}$（$j\le n+1$）が $F$ 係数であること。
- 主張: 各 $a\in A_Q$ で $\mathrm{mk}_n(\mathrm{mco}_a(Q))$・$\mathrm{ee}_n(k)^{a(k)}$・その積・$T_a$ が $F$ 係数であること、$\mathrm{se}_n(Q)=\sum_{a\in A_Q}T_a$、その所属。
- 対照: 係数 $\sqrt3\notin\mathbb{Q}(\sqrt2)$ を持つ $Q=\sqrt3\,X_0$ では $\mathrm{se}_2(Q)$ は $\mathbb{Q}(\sqrt2)$ 係数でない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
