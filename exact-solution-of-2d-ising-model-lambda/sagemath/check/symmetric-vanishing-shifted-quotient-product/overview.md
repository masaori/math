# SageMath Check: 零代入で消える対称多項式の商

## 対象

**対象ラベル**: `claim_symmetric_vanishing_last_variable_shifted_quotient_product`, `claim_qbar_full_elementary_symmetric_is_all_ones_monomial`, `def_qbar_all_ones_shift`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 18908）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n+1}]$ の等号と係数は厳密に判定する。浮動小数点は使わない。
- 標本: 変数の個数 $n+1=1,2,3,4$ で、全変数の積と対称化した多項式の積に代数的数 $1,-2,\sqrt2,\sqrt{-3}$ を掛けた
  対称で $\mathrm{lz}_n(P)=0$ の多項式四個。係数を読む指数 $c$ は各成分が $0,\dots,4$ の全て。

## 何を確かめるか

- 変数の個数と同じ次数の基本対称式: $\mathbb N_{<n+1}$ の $n+1$ 元部分集合は $\mathbb N_{<n+1}$ だけであること、本文の三つの等号。
- 指数を一つ下げた多項式の定義 $\mathrm{mco}_d(\mathrm{sd}_{n+1}(P))=\mathrm{mco}_{d+\mathbf 1}(P)$。
- 標本が仮定（対称、$\mathrm{lz}_n(P)=0$）を満たすこと。
- 本文の式変形の五つの等号（$\mathbf 1\le c$ でない場合は右辺の場合分けの値 $0$ と $\mathrm{mco}_c(P)$ の一致）と主張 $P=\mathrm{es}_{n+1,n+1}\cdot\mathrm{sd}_{n+1}(P)$。
- 対照: 零代入で消えない対称多項式では $P\ne\mathrm{es}_{n+1,n+1}\cdot\mathrm{sd}_{n+1}(P)$ であること（仮定 $\mathrm{lz}_n(P)=0$ が効いていること）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
