# 命題 C″ (1) のしきい値の最良性の反例探索（cycle 40 step 3）

対象ラベル: `paper_prop_C_trace_ladder`

## 何を測ったか

本文は「しきい値 $w^*+1$ は最良である（$k\le w^*$ では偽）」と主張するだけで、
反例を挙げていなかった。反例が無いと形式化できないので、総当たりで探した。

探索範囲は、成分が $-4$ から $4$ までの $2\times2$ 整数行列（$9^4=6561$ 通り）と
$p\in\{2,3,5\}$ である。各組について次を厳密に計算した（浮動小数点は使っていない）。

- Gram 行列 $G=(\operatorname{Tr}S^{i+j})_{0\le i,j<2}$ の単因子（小行列式の最大公約数の比）と、
  その $p$ 進付値の最大値 $w^*$。
- レベル $k$ のトレース周期 $t_k$（$\operatorname{Tr}(S^N(S^t-I))$ が全ての $N<r$ で $p^k$ で割れる最小の $t$）。

## 結果

$w^*\ge1$ かつ、ある $k\le w^*$ で $t_{k+1}\nmid p\,t_k$ となる組は **394 件**あった。
そのうち成分が最も小さいものは次である。

$$
S=\begin{pmatrix}-2&-1\\-1&0\end{pmatrix},\qquad p=2,\qquad
w^*=2,\qquad t_1=t_2=1,\quad t_3=t_4=4.
$$

$k=2\le w^*$ で $t_3=4$ は $p\,t_2=2$ を割らない。

## 形式化との対応

`lean/IntegrableLattice/TracePeriodThresholdSharp.lean` がこの反例を形式化している
（`ladder_fails_at_two`）。本文（日英）にもこの反例を書き足した。

## 実行

```sh
python3 search_counterexample.py
```

厳密計算のみ（整数演算と最大公約数）。実行結果は上のとおりで、
先頭 6 件と件数が印字される。
