# SageMath Check: 根の対の整数倍のずらしを根とする多項式

## 対象

**対象ラベル**: `claim_qbar_multivariate_point_value_of_substitution`, `claim_subfield_coefficient_multivariate_point_value_mem`, `claim_pair_shift_root_polynomial_subfield_coefficient`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 3196）
- 帰属: 係数は円分体 $\mathbb{Q}(\zeta_8)$（Sage の `CyclotomicField(8)`）と、$x^3-2$ の $\mathbb{Q}$ 上の分解体（数体）の元。どちらも $\overline{\mathbb{Q}}$ の部分体。部分体 $F$ は $\mathbb{Q}$ と $\mathbb{Q}(\sqrt2)=\mathbb{Q}(\zeta_8+\zeta_8^{-1})$（自己同型 $\zeta_8\mapsto\zeta_8^{-1}$ の固定体として判定）。浮動小数点は使わない。
- 標本: $F=\mathbb{Q}(\sqrt2)$ で根 $\varnothing$、$\{\sqrt2\}$、$\{\zeta_8,\zeta_8^7\}$、$\{\zeta_8,\zeta_8^3,\zeta_8^5,\zeta_8^7\}$、$\{\zeta_8^3,\zeta_8^5,\frac12\}$、$c\in\{0,1,-2,\frac13,\sqrt2\}$。$F=\mathbb{Q}$ で根 $\{\zeta_8,\zeta_8^3,\zeta_8^5,\zeta_8^7\}$、$\{\pm i\}$、$\{\pm\sqrt2,3\}$、$x^3-2$ の三根、$c\in\{0,1,-2,\frac13\}$ または $\{0,1,-3\}$。全単射 $\nu$ は辞書式順とその逆順、$k=0,\dots,N$。

## 何を確かめるか

- 代入してから値を取る主張: 四組の $(n,m)$ で、式鎖の五つの値（左辺、代入の定義の有限和、値を通した和、定数の値、右辺）の一致。
- 本体の主張: 第一の準備 $\mathrm{mev}_{d,\alpha_{<d}}(\mathrm{ps}(r))=\beta(r)$、第二の準備 $\mathrm{mev}_{d,\alpha_{<d}}(\mathrm{es}_{d,i+1})=(-1)^{i+1}\mathrm{ac}_{d-(i+1)}(f)$ とその $F$ への所属、番号が $N$ より大きい係数が零、式鎖の六つの値の一致（$Q_k$ は Sage の対称関数で $\mathrm{ms}_{\mathrm{ps}}(\mathrm{es}_{N,k})=\mathrm{se}_d(Q_k)$ を満たすものを作り、等式も確かめる）、$Q_k$ の係数・値の各項・値の $F$ への所属、$g$ の全係数の $F$ への所属。
- 対照: 根が共役で閉じない $\{\zeta_8,\zeta_8^3\}$（$F=\mathbb{Q}(\sqrt2)$）、$\{\sqrt2\}$（$F=\mathbb{Q}$）、$x^3-2$ の二根では $f\notin F[t]$ であること。$c=\zeta_8\notin\mathbb{Q}(\sqrt2)$ なら $d=2$ の $g$ が $\mathbb{Q}(\sqrt2)$ 係数にならないこと。

値の所属の主張（`claim_subfield_coefficient_multivariate_point_value_mem`）は、本体の式鎖の最後の行（$Q_k$ の各項と値の所属）として確かめている。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
