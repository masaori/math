# SageMath Check: 根の対の整数倍のずらしの基本対称式

## 対象

**対象ラベル**: `def_pair_shift_values`, `claim_pair_shift_elementary_symmetric_is_symmetric`, `claim_pair_shift_elementary_symmetric_subfield_coefficient`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 103200）
- 帰属: 係数は円分体 $\mathbb{Q}(\zeta_8)$（Sage の `CyclotomicField(8)`。$\overline{\mathbb{Q}}$ の部分体）の元。部分体 $F$ は $\mathbb{Q}$ と $\mathbb{Q}(\sqrt2)=\mathbb{Q}(\zeta_8+\zeta_8^{-1})$（自己同型 $\zeta_8\mapsto\zeta_8^{-1}$ の固定体として判定）。浮動小数点は使わない。
- 標本: $d=0,\dots,4$（$N=|\mathrm{Pr}_d|=0,\dots,6$）、全単射 $\nu$ は辞書式順とその逆順の二つ、$c\in\{0,1,-2,\frac13,\sqrt2,\zeta_8\}$、$k=0,\dots,N+1$、$\varrho$ は $\mathfrak{P}_d$ の全ての元。

## 何を確かめるか

- 定義: $\nu$ が $\mathrm{Pr}_d$ への全単射であること、$\mathrm{ps}_{c,\nu}(r)$ を定義どおりに作ること、定義どおりの代入 $\mathrm{ms}$ が Sage の代入と一致すること。
- 対称性: 第一の準備（$\mathrm{pp}_\varrho(p)\in\mathrm{Pr}_d$、$\mathrm{pp}_{\varrho^{-1}}\circ\mathrm{pp}_\varrho$ と $\mathrm{pp}_\varrho\circ\mathrm{pp}_{\varrho^{-1}}$ が恒等写像）、第二の準備（$\mathrm{ip}_\varrho$ が $\mathbb{N}_{<N}$ の置換で $\nu(\mathrm{ip}_\varrho(r))=\mathrm{pp}_\varrho(\nu(r))$）、第三の準備の五つの式、第四の準備、本体の式鎖の七つの値の一致（$\mathrm{vs}_{\mathrm{ip}_\varrho}(\mathrm{es}_{N,k})=\mathrm{es}_{N,k}$ を含む）、主張の等式そのもの。
- 部分体係数: $c\in\mathbb{Q}$ のとき各 $T_a$ と $\mathrm{ms}_{\mathrm{ps}}(\mathrm{es}_{N,k})$ の係数が $\mathbb{Q}$ に、$c\in\mathbb{Q}(\sqrt2)$ のとき $\mathbb{Q}(\sqrt2)$ に入ること、$\sum_{a\in A_k}T_a=\mathrm{ms}_{\mathrm{ps}}(\mathrm{es}_{N,k})$。
- 対照: $c=\zeta_8\notin\mathbb{Q}(\sqrt2)$ なら $d=2$、$k=1$ の多項式の係数 $\zeta_8$ は $\mathbb{Q}(\sqrt2)$ に入らない。対で対称でない値 $X_i+2X_j$ を代入すると、$d=3$、$k=1$ で対称でない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
