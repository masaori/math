# SageMath Check: 零代入で消える対称多項式の係数

## 対象

**対象ラベル**: `claim_symmetric_vanishing_last_variable_coefficient_support`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 10180）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n+1}]$ の等号と係数は厳密に判定する。浮動小数点は使わない。
- 標本: 変数の個数 $n+1=1,2,3,4$ で、全変数の積と対称化した多項式の積に代数的数 $1,-2,\sqrt2,\sqrt{-3},1+\sqrt2\sqrt{-3}$ を掛けた
  対称で $\mathrm{lz}_n(P)=0$ の多項式四個。係数を読む指数 $a$ は各成分が $0,\dots,3$ で、$a(k)=0$ となる全ての $k$ を取る。

## 何を確かめるか

- 標本が仮定（対称、$\mathrm{lz}_n(P)=0$）を満たすこと。
- 互換 $\tau=(k\ n)$ が $\tau\circ\tau=\mathrm{id}$ を満たすこと。
- 準備の三つの等号 $(a\circ\tau)(n)=a(\tau(n))=a(k)=0$ と $a\circ\tau=\mathrm{ez}_n(b)$。
- 本文の式変形の六つの等号と主張 $\mathrm{mco}_a(P)=0$。
- 対照: 零代入で消えない対称多項式では、成分に零を持つ指数にも非零の係数が現れること（仮定 $\mathrm{lz}_n(P)=0$ が効いていること）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
