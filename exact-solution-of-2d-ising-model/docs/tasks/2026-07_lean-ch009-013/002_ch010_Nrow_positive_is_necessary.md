# 章 010 `partition_function_in_pauli_form`: `N_row ≥ 1` は必要（原文の仮定は正しい）

対象: `structured-latex/content/010_transfer_matrix_bridge.ts` の
`bridge_007_claim_partition_function_in_pauli_form`（ラベル `partition_function_in_pauli_form`）

## 確認したこと

原文は `N_row ∈ ℤ_{≥1}` を仮定している。この仮定は**落とせない**ことを確認した。

`N_row = 0` とすると

* 左辺 `Z(J,J')` は `𝔖 = Map(∅ × {1,…,M}, {-1,1})` 上の和になり、
  空の配置がただ 1 つあるので `Z = exp(0) = 1`。
* 右辺 `tr((V_1V_2)^0) = tr(I_{2^M}) = 2^M`。

`M ≥ 1` では一致しない。したがって原文の仮定は必要であり、誤りではない。

Lean 側でも `N_row = m + 1` の形（`m : ℕ`）で述べてある
（`Ising2D.partition_function_in_pauli_form`、
`lean/Ising2D/Part010/Claim007_PartitionFunction.lean`）。
抽象版のトレース公式 `Ising2D.Abstract.trace_pow_succ` も `A^(m+1)` の形で、
`m + 1 ≥ 1` が型のレベルで保証されている。

## ついでに確認した記号の対応（原文の訂正が正しいことの機械的裏づけ）

001 章 `def_transfer_matrix` の `conversion.notes` は
「原文どおりでは `J` と `J'` が入れ替わるので、`V_1, V_2` の側で入れ替えて訂正した」
と記録している。この訂正が正しいことを Lean で独立に確認した:

`Ising2D.partitionFunctionC_eq_trace` は、

* `Z` の指数の肩を `J·s(i,m)s(i+1,m) + J'·s(i,m)s(i,m+1)`（行間が `J`、行内が `J'`）
* `V_1` の対角成分を `exp(K_1 ∑_m μ(m)μ(m+1))`（`K_1 = J'`、行内）
* `V_2` の成分を `exp(K_2 ∑_m μ(m)μ'(m))`（`K_2 = J`、行間）

としたときに `Z = tr((V_1V_2)^{N_row})` が成り立つことを、
道の総和への展開（`Abstract.trace_pow_succ`）から証明している。
すなわち 010 章冒頭の対応表 `K_1 = J'`, `K_2 = J` は正しい。
