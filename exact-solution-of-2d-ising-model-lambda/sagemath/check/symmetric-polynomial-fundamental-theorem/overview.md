# SageMath Check: 対称式の基本定理

## 対象

**対象ラベル**: `claim_symmetric_polynomial_fundamental_theorem`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 7521、標本 54 個）
- 帰属: 係数は二次体 $\mathbb{Q}(\sqrt2)$（Sage の `QuadraticField(2)`。$\overline{\mathbb{Q}}$ の部分体）と、その部分体 $\mathbb{Q}$。次数は非負整数。浮動小数点は使わない。
- 標本: 変数の個数 $m=0,\dots,4$（本文の $n+1$ 変数の段は $m=n+1$）で、零・定数・冪和・基本対称式の多項式と、無作為な多項式を全ての置換で対称化したもの。係数の部分体 $F$ は、有理数だけの標本では $\mathbb{Q}$、$\sqrt2$ を含む標本では $\mathbb{Q}(\sqrt2)$。

## 何を確かめるか

証明の構成（零変数では $Q:=P$、帰納の段では $P_0:=\mathrm{lz}(P)$、外側の帰納法の仮定による $Q_0$、$Q_1:=\mathrm{ex}(Q_0)$、$R:=P+\mathrm{mk}(-1)\cdot\mathrm{se}(Q_1)$、$R$ を全変数の積で割った商 $S$、内側の帰納法の仮定による $Q_2$、$Q:=Q_1+X_n\cdot Q_2$）を再帰でそのまま実行し、再帰の各回で次を確かめる。

- 零変数: $P=\mathrm{mk}_0(\mathrm{mco}_0(P))$、$\mathrm{se}_0(\mathrm{mk}_0(c))=\mathrm{mk}_0(c)$、$\mathrm{wdeg}_0(P)=0$。
- $P_0$ の所属・対称性・全次数の上界と、外側の帰納法の仮定の結論。
- $Q_1$ の所属と、重み付き次数の三つの不等号の鎖。
- $R$ の所属、全ての置換について $R$ の対称性の式鎖の五つの等号、$\mathrm{lz}(R)=0$ の式鎖の九つの等号、全次数の式鎖（不等号・等号・不等号・不等号）と $\mathrm{tdeg}(R)\le d$、$P=\mathrm{se}(Q_1)+R$ の式鎖の六つの等号。
- 割り切れ（$S$ の所属・対称性、$R=\mathrm{es}\cdot S$）、$R\ne0$ のとき $\mathrm{tdeg}(S)+m=\mathrm{tdeg}(R)$ と $\mathrm{tdeg}(S)<d$。
- $R=0$ の場合の結論、$R\ne0$ の場合の内側の帰納法の仮定の結論、$Q$ の所属、$P=\mathrm{se}(Q)$ の式鎖の六つの等号、$\mathrm{wdeg}(Q)$ の式鎖（四つの不等号と二つの等号）。
- 結論: $Q\in F[X]$、$P=\mathrm{se}(Q)$、$\mathrm{wdeg}(Q)\le\mathrm{tdeg}(P)$。
- 対照: $X_0^2+X_1^2$ から得る $Q$ が $X_0^2-2X_1$（$=e_1^2-2e_2$ の形）に一致すること。係数 $-2$ は $\mathbb{Q}$ にあり $\mathbb{N}$ には無いので、係数の集合に $-1$ を要する例でもある。

$F=\mathbb{Q}(\sqrt2)$ の標本では係数がすべて $\mathbb{Q}(\sqrt2)$ の元として計算されるので、所属の検査は自明に通る。所属の検査が意味を持つのは $F=\mathbb{Q}$ の標本である。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
