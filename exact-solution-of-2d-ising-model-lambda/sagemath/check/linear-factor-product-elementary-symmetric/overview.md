# SageMath Check: 一次因子の積の係数と根の基本対称式

## 対象

**対象ラベル**: `def_qbar_multivariate_point_value`, `claim_point_value_elementary_symmetric_last_split`, `claim_linear_factor_product_coefficient_elementary_symmetric`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 26037）
- 帰属: 値は円分体 $\mathbb{Q}(\zeta_{12})$（Sage の `CyclotomicField(12)`。$\overline{\mathbb{Q}}$ の部分体）の元。浮動小数点は使わない。
- 標本: 値の集まり $\{0,1,-2,\frac13,\zeta,\zeta^2-1,2\zeta^3+\zeta,-\zeta^5+\frac12\}$ から作った点。末尾の分割は $n=0,\dots,4$、$j=0,\dots,n+1$。一次因子の積は $n=0,\dots,5$ の全ての $j\le n$、帰納法の一歩は $n=0,\dots,4$。

## 何を確かめるか

- 点での値: 定義の式で計算した値が和と積を保ち、定数 $\mathrm{mk}_n(c)$ を $c$ へ、変数 $X^{(n)}_k$ を $\alpha(k)$ へ送ること（標本）。
- 末尾の分割: 準備の式（定義どおりの多項式 $\mathrm{es}_{m,i}$ の点での値が部分集合の積の和に等しいこと）、添字の集合が $\mathcal{A}$ と $\mathcal{B}$ に分かれること、$\mathcal{A}$ が $\mathbb{N}_{<n}$ の $j+1$ 元部分集合の全体であること、$\iota(T)=T\cup\{n\}$ が全単射であること、本体の式鎖の六つの等号。
- 一次因子の積の係数: 準備の二つの係数の式、$\Pi_{w,n+1}=\Pi_{w,n}\cdot(t-\widehat{w(n)})$、係数の上界 $\mathrm{ac}_{n+1}(\Pi_{w,n})=0$、帰納法の一歩の三つの場合（$j=0$、$1\le j\le n$、$j=n+1$）の式鎖の各行、$\mathrm{es}_{n,n+1}$ の値が零であること、主張の等式そのもの。
- 対照: $(t-1)(t-2)(t-3)$ の $t^2$ の係数は、符号 $(-1)^j$ を落とした $\mathrm{es}_{3,1}$ の値と一致しない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
