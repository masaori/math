# SageMath Check: 末尾に変数を足す持ち上げ

## 対象

**対象ラベル**: `def_last_variable_extension`, `claim_last_variable_zero_of_extension`, `claim_last_variable_extension_subfield_coefficient`, `claim_last_variable_extension_weighted_degree_bound`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 12850）
- 帰属: 係数環は `QQbar`、部分体は $F=\mathbb{Q}$ と $F=\mathbb{Q}(\sqrt2)$（所属は最小多項式の根の比較で判定）、次数は非負整数。持ち上げ $\mathrm{ex}_n(Q)$ は係数の辞書で作り、重み付き次数は係数が零でない指数の集合から定義どおりに数える。浮動小数点は使わない。
- 標本: $n=0,\dots,3$、$F$ を係数とする $n$ 変数の多項式を二〜七個ずつ。

## 何を確かめるか

- 定義: 各成分が $0,\dots,4$ の全ての指数 $a\in\mathrm{Ex}_{n+1}$ で、$\mathrm{mco}_a(\mathrm{ex}_n(Q))$ が場合分けの式に等しいこと。係数が零でない $a$ が $a(n)=0$、$a|_{<n}\in\mathrm{spt}_n(Q)$、$a=\mathrm{ez}_n(a|_{<n})$ を満たすこと。
- 零代入で元に戻ること: $\mathrm{ez}_n(b)(n)=0$ と $\mathrm{ez}_n(b)|_{<n}=b$、式鎖の三つの等号の各辺の値が等しいこと（台の内外の $b$）、結論 $\mathrm{lz}_n(\mathrm{ex}_n(Q))=Q$（零代入は Sage の環準同型で計算）。
- 部分体係数: $a(n)=0$ と $a(n)\ne0$ の二つの場合の係数の値と所属、$\mathrm{ex}_n(Q)$ の全ての係数が $F$ に属すること。
- 重み付き次数: 台の元の $a(n)=0$、準備（$\mathrm{mco}_{a|_{<n}}(Q)=\mathrm{mco}_a(\mathrm{ex}_n(Q))\ne0$）、式鎖の六つの等号と最後の不等号、結論 $\mathrm{wdeg}_{n+1}(\mathrm{ex}_n(Q))\le\mathrm{wdeg}_n(Q)$。
- 対照: $X^{(2)}_0+X^{(2)}_1$ も零代入で $X^{(1)}_0$ になるので、零代入は単射でなく、持ち上げは末尾の指数が零の係数だけに置く必要がある。末尾の変数 $X^{(2)}_1$ の重み付き次数は $2$ で、$X^{(1)}_0$ の $1$ より大きい。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
