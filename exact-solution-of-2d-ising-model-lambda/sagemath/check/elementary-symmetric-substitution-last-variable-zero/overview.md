# SageMath Check: 基本対称式への代入は末尾の変数への零代入と入れ替わる

## 対象

**対象ラベル**: `claim_elementary_symmetric_substitution_last_variable_zero`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 53）
- 帰属: 係数環は `QQbar`。多項式環 $\overline{\mathbb Q}[X_{<n}]$ の等号は厳密に判定する。浮動小数点は使わない。
- 代入 $\mathrm{ms}_y$ は本文の定義どおりの有限和 $\sum\mathrm{mk}(\mathrm{mco}_a(Q))\prod y(k)^{a(k)}$ で計算する。
- 標本: $n=0,\dots,4$（$Q$ は $n+1$ 変数）、係数に $\sqrt2$ と有理数を含み、末尾の変数を含む多項式を含む五〜七個。

## 何を確かめるか

- 準備: $j<n$ と $j=n$ のそれぞれで式鎖の値が一行ずつ等しいこと、写像として $\mathrm{ms}_{z_n}\circ\mathrm{ee}_{n+1}=\mathrm{ms}_{\mathrm{ee}_n}\circ z_n$。
- 主張: 各標本 $Q$ で七つの等号（左辺から右辺まで）。
- 対照: 末尾の値を零でなく $1$ にした代入（$n=1$、$Q=X_1$）では入れ替わらない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
