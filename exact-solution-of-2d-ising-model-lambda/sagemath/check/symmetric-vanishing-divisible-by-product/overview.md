# SageMath Check: 部分体を係数とする多変数多項式と全次数

## 対象

**対象ラベル**: `claim_symmetric_vanishing_last_variable_divisible_by_product`, `claim_symmetric_vanishing_last_variable_shift_total_degree`, `claim_qbar_all_ones_shift_subfield_coefficient`, `def_subfield_coefficient_multivariate_polynomials`, `def_qbar_multivariate_total_degree`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 2449）
- 帰属: 係数環は `QQbar`、部分体 $F$ は $\mathbb Q(\sqrt2)$。多項式環 $\overline{\mathbb Q}[X_{<n+1}]$ の等号と係数、
  係数の $F$ への所属（最小多項式の次数と判別式）は厳密に判定する。浮動小数点は使わない。
- 標本: 変数の個数 $n+1=1,2,3,4$ で、全変数の積と五つの種を対称化した多項式の積に $F$ の元
  $1,-2,\sqrt2,1+\sqrt2/3$ を掛けた、$F$ 係数・対称・$\mathrm{lz}_n(P)=0$・$P\ne0$ の多項式五個。

## 何を確かめるか

- 標本が仮定（$F$ 係数、対称、$\mathrm{lz}_n(P)=0$、$P\ne0$）を満たすこと。
- 部分体係数の主張: $\mathrm{mco}_d(\mathrm{sd}_{n+1}(P))=\mathrm{mco}_{d+\mathbf 1}(P)\in F$ と $\mathrm{sd}_{n+1}(P)\in F[X_{<n+1}]$。
- 全次数の主張: 第一の準備の六つの等号（各成分が $0,\dots,3$ の全ての $d$）、第二の準備（台の元 $c$ で $\mathbf 1\le c$ と三行の鎖）、
  第三の準備、上からの評価の三行、下からの評価の三行（$d_*$ は商の台で指数の総和が最大の元）、主張の等号。
- まとめの主張: $Q=\mathrm{sd}_{n+1}(P)$ が対称で $P=\mathrm{es}_{n+1,n+1}\cdot Q$。
- 対照: $P=0$ では全次数の等号が成り立たないこと（$P\ne0$ の仮定が効いている）。係数に $\sqrt3$ を持つ $P$ では
  $\mathrm{sd}_{n+1}(P)$ も $F$ 係数でないこと。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
