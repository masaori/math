# SageMath Check: 反転対と単純通過を固定した偶部分グラフ対の全単射

**対象ラベル**: `claim_even_subgraph_pair_fiber_bijection`

一辺 $L=2$ の周期正方格子で、互いに素な辺集合 $D,E\subseteq E_L$ のうち
$E$ が偶部分グラフであるものを全列挙する。各 $(D,E)$ について、

- $A,B$ が偶部分グラフ、$A\cap B=D$、$A\mathbin\triangle B=E$ を満たす順序対 $(A,B)$、
- $C\subseteq E$ かつ $D\cup C$ が偶部分グラフである部分集合 $C$

を独立に列挙し、本文の写像 $\Theta(A,B)=A\setminus D$ と逆写像
$C\mapsto(D\cup C,D\cup(E\setminus C))$ が往復し、個数が一致することを検査する。

- 実行: `sage sagemath/check/even-subgraph-pair-fiber/check.sage`
- 状態: PASS（2026-09-01）
- 結果: 条件を満たす互いに素な $(D,E)$ は $881$ 組、両側で数えた元はともに
  合計 $1{,}024$ 個であり、すべての組で写像と逆写像の往復および個数の一致を確認した。

すべて有限集合の列挙と自然数の偶奇による厳密計算であり、浮動小数点は使わない。
