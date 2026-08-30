# SageMath Check: 符号付き偶部分グラフ多項式のセクター和

**対象ラベル**: `claim_signed_even_subgraph_sector_sum`

一辺 $L=1,2,3$ のトーラスで、偶部分グラフを全列挙し、符号付き偶部分グラフ多項式
$Q^{a,b}_L=\sum_{A}(-1)^{(1+a)\varepsilon_{L,\mathrm h}(A)+(1+b)\varepsilon_{L,\mathrm v}(A)+\varepsilon_{L,\mathrm h}(A)\varepsilon_{L,\mathrm v}(A)}x^{|A|}$
の直接計算と、セクター生成多項式の符号付き和
$\sum_{(c,d)}(-1)^{(1+a)c+(1+b)d+cd}G^{c,d}_L$ を、
四つのスピン構造 $(a,b)$ のすべてについて $\mathbb Z[x]$ で比較して一致を検査する。

- 実行: `sage sagemath/check/signed-even-subgraph-sector-sum/check.sage`
- 状態: PASS（2026-08-31、$L=1,2,3$、スピン構造 $4$ 件）
- 浮動小数点: 不使用
