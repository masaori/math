# SageMath Check: 基本対称式への代入は対称である

## 対象

**対象ラベル**: `claim_qbar_multivariate_substitution_composition`, `claim_qbar_elementary_symmetric_is_symmetric`, `def_elementary_symmetric_substitution`, `claim_elementary_symmetric_substitution_symmetric`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 1640）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n}]$ の等号は厳密に判定する。浮動小数点は使わない。
- 代入 $\mathrm{ms}_y$ は本文の定義どおりの有限和 $\sum\mathrm{mk}(\mathrm{mco}_a(Q))\prod y(k)^{a(k)}$ で計算する。
- 標本: 変数の個数 $0,\dots,4$、係数に $\sqrt2$ と有理数を含む多項式五〜六個。

## 何を確かめるか

- 代入の合成: $(n,m,p)=(1,2,1),(2,2,3),(3,2,2),(2,3,1)$ の写像 $e$・$y$ と各標本 $Q$ で、証明の五つの等号を一行ずつ。
- 基本対称式の対称性: $n=0,\dots,4$、全ての置換 $\varrho$、$j=0,\dots,n+1$ で、第一の準備（積の添字の付け替え）、
  第二の準備（$S\mapsto\varrho(S)$ が $j$ 元部分集合の全単射で、逆が $T\mapsto\varrho^{-1}(T)$）、六つの等号。
- 基本対称式への代入の対称性: $n=1,\dots,4$、全ての置換、各標本 $Q$ で、準備の $\mathrm{ms}_{\mathrm{xv}_{n,\varrho}}\circ\mathrm{ee}_n=\mathrm{ee}_n$ と四つの等号。
- 対照: 基本対称式でない値（$X_0, X_0X_1$）を代入した $X_0$ は対称でない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
