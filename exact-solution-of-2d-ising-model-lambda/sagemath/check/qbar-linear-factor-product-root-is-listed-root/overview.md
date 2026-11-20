# SageMath Check: 一次因子の積の根

## 対象

**対象ラベル**: `claim_qbar_linear_factor_product_root_is_listed_root`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 463）
- 帰属: 値は円分体 $\mathbb{Q}(\zeta_8)$（Sage の `CyclotomicField(8)`）と、$x^3-2$ の $\mathbb{Q}$ 上の分解体（数体）の元。どちらも $\overline{\mathbb{Q}}$ の部分体。浮動小数点は使わない。
- 標本: 根の列 $\beta_{<N}$ は空列（$N=0$）、$(\zeta_8)$、$(\sqrt2,-\sqrt2,\frac13)$、$(1,1,1,-i)$（重複を含む）、$(\zeta_8,\zeta_8^3,\zeta_8^5,\zeta_8^7)$、$(0,\sqrt2+i)$、$x^3-2$ の三根、それに $u^2+u+1$ の二根を足した五根、二根の和と積。点 $z$ は列の根と列に無い元の両方を取る。

## 何を確かめるか

- 第一の式鎖の五つの値の一致（$\mathrm{aev}_z(P)$、$P$ の置き方、値は積を保つ、値は和と逆元を保つ、$\mathrm{aev}_z(t)=z$ と $\mathrm{aev}_z(\widehat a)=a$）。
- $\mathrm{aev}_z(P)=0$ の点で、零の因子 $z-\beta(r_0)$ があること、第二の式鎖の三つの等号、結論 $r_0<N$ かつ $z=\beta(r_0)$。
- 対照: $\mathrm{aev}_z(P)\ne0$ の点は列のどの根とも等しくない。$N=0$ の空積の値は $1\ne0$。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
