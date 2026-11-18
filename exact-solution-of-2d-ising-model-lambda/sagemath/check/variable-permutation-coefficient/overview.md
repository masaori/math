# SageMath Check: 変数を置換した多項式の係数

## 対象

**対象ラベル**: `claim_qbar_variable_permutation_coefficient`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 47087）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n}]$ の等号と係数は厳密に判定する。浮動小数点は使わない。
- 標本: $n=1,2,3$ の全ての置換 $\varrho$、係数に $1,-2,\sqrt2,\sqrt{-3},1+\sqrt2\sqrt{-3}$ を持つ多項式 $P$ 六個（各成分が $0,1,2$ の指数）、
  係数を読む指数 $a$ は各成分が $0,\dots,4$。

## 何を確かめるか

- 定義の値 $\mathrm{vs}_\varrho(X_k)=X_{\varrho(k)}$。
- 準備の一つ目の二つの等号（全単射による添字の付け替えと $\mathrm{mon}_n(b\circ\varrho^{-1})$）。
- 準備の二つ目 $\mathrm{mco}_a(\mathrm{mk}_n(d)\cdot\mathrm{mon}_n(e))$ の場合分け。
- $b\circ\varrho^{-1}=a\iff b=a\circ\varrho$。
- 本文の式変形の六つの等号と主張 $\mathrm{mco}_a(\mathrm{vs}_\varrho(P))=\mathrm{mco}_{a\circ\varrho}(P)$。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
