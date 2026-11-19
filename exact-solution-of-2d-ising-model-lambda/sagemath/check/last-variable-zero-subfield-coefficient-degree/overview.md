# SageMath Check: 末尾の変数への零代入は部分体係数を保ち全次数を増やさない

## 対象

**対象ラベル**: `claim_last_variable_zero_subfield_coefficient`, `claim_last_variable_zero_total_degree_bound`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 632）
- 帰属: 係数環は `QQbar`、部分体は $F=\mathbb{Q}$ と $F=\mathbb{Q}(\sqrt2)$（所属は最小多項式の根の比較で判定）、次数は非負整数。全次数は係数が零でない指数の集合から定義どおりに数える（Sage の `degree()` は使わない）。浮動小数点は使わない。
- 標本: $n=0,\dots,3$、$F$ を係数とする $n+1$ 変数の多項式を五〜九個ずつ。

## 何を確かめるか

- 部分体係数: $\mathrm{spt}_n(\mathrm{lz}_n(P))$ の各 $b$ で $\mathrm{mco}_b(\mathrm{lz}_n(P))=\mathrm{mco}_{\mathrm{ez}_n(b)}(P)$ と、この係数が $F$ に属すること、$\mathrm{lz}_n(P)$ の全ての係数が $F$ に属すること。
- 全次数: 準備（$\mathrm{mco}_{\mathrm{ez}_n(b)}(P)=\mathrm{mco}_b(\mathrm{lz}_n(P))\ne0$、$\mathrm{ez}_n(b)\in\mathrm{spt}_{n+1}(P)$）、式鎖の六つの等号の各辺の値が等しいこと、最後の不等号、結論 $\mathrm{tdeg}_n(\mathrm{lz}_n(P))\le\mathrm{tdeg}_{n+1}(P)$。
- 対照: $P=X^{(2)}_0+(X^{(2)}_1)^3$ では $\mathrm{tdeg}_1(\mathrm{lz}_1(P))=1<3=\mathrm{tdeg}_2(P)$ で等号は一般に成り立たない。$\sqrt2\,X^{(2)}_0$ の係数 $\sqrt2$ は零代入の後も残り、$\mathbb{Q}$ に属さない。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
