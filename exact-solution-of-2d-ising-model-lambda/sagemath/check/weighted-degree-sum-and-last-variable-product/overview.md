# SageMath Check: 重み付き次数の和と末尾の変数倍の上界

## 対象

**対象ラベル**: `claim_qbar_weighted_degree_sum_bound`, `claim_qbar_weighted_degree_last_variable_product_bound`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 4031）
- 帰属: 係数環は `QQbar`、次数は非負整数。重み付き次数は係数が零でない指数の集合から定義どおりに数える。浮動小数点は使わない。
- 標本: 和の上界は $n=0,\dots,3$ で $\sqrt2$ を含む係数の多項式を三〜十一個ずつ、その全ての組。変数倍の上界は $n=0,1,2$（$n+1$ 変数）で同じ標本。

## 何を確かめるか

- 和の上界: 台の元 $a$ で和の係数の式、$\mathrm{mco}_a(A)\ne0$ と $\mathrm{mco}_a(A)=0$ の二つの場合の式鎖の二つの不等号、結論 $\mathrm{wdeg}_n(A+B)\le\max(\mathrm{wdeg}_n(A),\mathrm{wdeg}_n(B))$。
- 変数倍の上界: 準備 $\mathrm{mon}_{n+1}(\delta_n)=X^{(n+1)}_n$ の式鎖の四つの値、各成分が $0,\dots,4$ の全ての $a$ で単項式を掛けた係数の場合分け、台の元の $\delta_n\le a$ と $a-\delta_n\in\mathrm{spt}_{n+1}(S)$、各点の分解 $a(k)=\delta_n(k)+(a-\delta_n)(k)$、式鎖の五つの等号と最後の不等号、結論。
- 対照: 和では打ち消しで真に小さくなる例（$X_{n-1}^2+X_0$ と $-X_{n-1}^2$）。変数倍では $\overline{\mathbb{Q}}$ 上で $S\ne0$ のとき等号になること（主張は上界だけを述べる）と、末尾でない変数を掛けると増分がその変数の重みになること。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
