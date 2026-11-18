# SageMath Check: 指数を一つ下げた多項式の対称性

## 対象

**対象ラベル**: `claim_qbar_all_ones_shift_preserves_symmetry`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 360753）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n}]$ の等号と係数は厳密に判定する。浮動小数点は使わない。
- 標本: 変数の個数 $n=1,2,3,4$ で、五つの種を対称化して代数的数 $1,-2,\sqrt2,\sqrt{-3},1+\sqrt2\sqrt{-3}$ を掛け、定数を足した
  対称多項式五個（零代入で消えないものを含む）。置換 $\varrho$ は $\mathfrak P_n$ の全て、係数を読む指数 $d$ は各成分が $0,\dots,3$ の全て。

## 何を確かめるか

- 標本が対称であること、指数を一つ下げた多項式の定義 $\mathrm{mco}_d(\mathrm{sd}_n(P))=\mathrm{mco}_{d+\mathbf 1_n}(P)$。
- 準備の五つの等号（各成分 $k$ で）と $(d+\mathbf 1_n)\circ\varrho=d\circ\varrho+\mathbf 1_n$。
- 本文の式変形の六つの等号と主張 $\mathrm{vs}_\varrho(\mathrm{sd}_n(P))=\mathrm{sd}_n(P)$。
- 対照: $n\ge2$ で、対称でない $\mathrm{mon}_n(\mathbf 1_n)\cdot(X_0^2X_1+X_0X_1^3)$ の $\mathrm{sd}_n$ は対称でないこと（仮定の対称性が効いていること）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
