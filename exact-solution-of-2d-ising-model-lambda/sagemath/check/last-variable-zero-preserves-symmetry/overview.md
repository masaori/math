# SageMath Check: 末尾の変数への零代入は対称性を保つ

## 対象

**対象ラベル**: `def_last_fixed_permutation_extension`, `claim_last_fixed_permutation_extension_is_bijection`, `claim_last_variable_zero_commutes_with_variable_permutation`, `claim_last_variable_zero_preserves_symmetry`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 347）
- 帰属: 添字は自然数の有限集合、係数環は `QQbar`。浮動小数点は使わない。
- 標本: 延長の定義と逆写像の準備は $n=0,\dots,3$ の全ての写像（の組）、置換であることは $n=0,\dots,4$ の全ての置換。入れ替わりと対称性は $n=0,\dots,3$ の全ての $\varrho\in\mathfrak{P}_n$ と、$\sqrt2$ を係数に含む多項式三〜七個（対称性はその対称化）。

## 何を確かめるか

- 定義: $\mathrm{pe}_n(f)$ の値が $\mathbb{N}_{<n+1}$ にあり、$k<n$ で $f(k)$、末尾で $n$ であること。
- 置換であること: 準備の二つの式鎖（$j<n$ と $j=n$）の各辺の値、$\mathrm{pe}_n(\varrho)$ が全単射で $\mathrm{pe}_n(\varrho^{-1})$ が両側の逆写像であること。
- 入れ替わり: 準備の二つの式鎖（$j<n$ の九辺、$j=n$ の八辺）と、本体の式鎖の八辺（合成した値の写像による代入を直接作ったものを含む）が全て等しいこと。
- 対称性の保存: 標本が対称であること（前提）、式鎖の三辺が等しいこと。
- 対照: 対称でない $P=(X^{(3)}_0)^2+X^{(3)}_1$ の $\mathrm{lz}_2(P)$ は対称でない。末尾を固定しない置換では入れ替わりが崩れる。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
