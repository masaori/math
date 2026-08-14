# SageMath Check: 正の根の特定（x_c = −1+s）

**対象ラベル**: `def_critical_point`

（同じ検証で `claim_self_dual_root_plus_mem`・`claim_self_dual_root_plus_representation`・
`claim_self_dual_root_minus_mem`・`claim_self_dual_root_minus_representation`・
`claim_self_dual_root_plus_positive`・`claim_self_dual_root_minus_not_positive`・
`claim_self_dual_positive_root_unique` の内容も見る。）

- 実行日: 2026-08-14
- 結果: PASS（s·s=2 を満たす 2 つの s の両方で全段を検査。表示の一意性の照合 98 組）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

- 根 $-1+s$ の所属と表示: $-1+s=(-1)+1\cdot s$ の鎖の各段と、表示 $(-1,1)$。
- 根 $-1-s$ の所属と表示: $-1-s=(-1)+(-1)\cdot s$ の鎖の各段と、表示 $(-1,-1)$。
- $-1+s\in P_s$: 正錐の第三条件の各比較（$a=-1<0$、$0<1=b$、
  $a\cdot a=1<2=2\cdot(b\cdot b)$。すべて `QQ` の順序）。
- $-1-s\notin P_s$: 三条件がすべて破れること（第一・第二は $0\le a$／$0<a$、第三は $0<b$ が破れる）。
- 正の根の一意性: 自己双対方程式 $\xi^2+2\xi-1=0$ の根の全体が $\{-1+s,\ -1-s\}$ で、
  正錐に属するのは $-1+s$ だけであること。
- 臨界点 $x_c:=-1+s$ が自己双対方程式を満たすこと。実数の平方根 $\sqrt2-1$ との照合は
  参考としてのみ行う（定義には使わない）。
