# SageMath Check: 奇数次の元を付け足した体では正錐を係数とする平方和が負の単位元にならない

## 対象

**対象ラベル**: `claim_odd_degree_weighted_square_sum_avoids_minus_one`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 910。$F=\mathbb Q$ の 6 個の $\alpha$ で各 60 例、$F=\mathbb Q(s)$（$s\cdot s=2$）の 4 個の $\alpha$ で各 40 例、番号の算術の段 190 件、積の最高次の係数の段 200 件。$P$ の $F$ 上の既約因子の次数の検査 348 件）
- 帰属: $\mathbb Q$・数体 $\mathbb Q(s)$・それらの上の剰余体 $F[t]/(p)$ の厳密計算。正錐の所属の判定だけに埋め込み $s\mapsto+\sqrt2$ の区間演算を使い、等号は数体の中で判定する。
- 読み替え: $\alpha$ は $F$ 上の奇数次の既約多項式 $p$ の根とし、$\mathrm{Val}_F(\alpha)$ を剰余体 $F[t]/(p)$ で表す（$\deg_F(\alpha)$ は $p$ の次数）。$\alpha$ に取った多項式: $F=\mathbb Q$ では $t-5/3$、$t^3-2$、$t^3-3t-1$、$t^5-t-1$、$t^5-4t+2$、$t^7-3$。$F=\mathbb Q(s)$ では $u-(1+s)$、$u^3-s$、$u^3+su+1$、$u^5-2u+s$。

## 何を確かめるか

本文の証明は「$-1$ が平方和である」という仮定から矛盾を導くので、その仮定が成り立つ例は無い。そこで、仮定に依らない段を行ごとに確かめ、主張そのものは実例で確かめる。普遍量化された主張の証明ではない。

- 簡約した表示: 係数が番号 $n$ 以上で零の $g(i)$ を取る。
- $\mathrm{aev}_\alpha(P)=1+\sum c(i)\cdot(\mathrm{aev}_\alpha(g(i))\cdot\mathrm{aev}_\alpha(g(i)))=1+\sum c(i)\cdot(y(i)\cdot y(i))$ の鎖。
- 主張の実例: $\sum c(i)\cdot(y(i)\cdot y(i))\ne-1$、すなわち $\mathrm{aev}_\alpha(P)\ne0$。
- 偶数次の段: $P\ne0$、最高次の番号が偶数 $2m$、$\mathrm{ac}_{2m}(P)\in C_F$、$m<n$。背理の段の「$2m>2(n-1)$ なら $\mathrm{ac}_{2m}(g(i)\cdot g(i))=0$」。
- 番号の算術: $n=2j+1$、$m+1\le n$、$e+n=2m$ から $m\ge j+1$、$e=(e+n)-n=2m-(2j+1)=2(m-j-1)+1$、$e+2\le n$。$n=1$ では条件を満たす $m$ が無いこと。
- 積の最高次の係数: $\mathrm{ac}_{e+n}(h\cdot p)=\mathrm{ac}_e(h)\cdot\mathrm{ac}_n(p)\ne0$、$k>e+n$ で係数が零。
- 帰納法の段の帰結: $P$ の $F$ 上の既約因子はすべて偶数次である（奇数次の既約因子があれば、その根 $\beta$ で $-1\in\mathrm{Sq}(C_F;\mathrm{Val}_F(\beta))$ となり、主張に反する）。

## 実行方法

```sh
sage check.sage
```
