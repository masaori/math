# Lean の通しの証明と章立てへの組み直しの状態

手順は [lean-end-to-end-runbook.md](lean-end-to-end-runbook.md)。

## 現在地

- runbook の「作業の順序」の 1 は済んでいる。`IsingParam.K2star := Kstar K2` で、双対関係は定理
  `IsingParam.c2_mul_s2star_eq_c2star` になり、最終定理の仮定に `hdual` は無い。
- 項目 2 のうち、具体的な `Z` についての挟み撃ちまでは済んでいる。人手 `partition_function_via_transfer_matrix` は
  `Part001/ClaimPartitionFunctionViaTransferMatrix.lean`、人手 `partition_function_sandwich` を具体的な
  `partitionFunction` と `c(M) := rayleighSup (physicalSymTransferR M K1 K2)` について述べた
  `partition_function_sandwich_physical`（`1 ≤ Nrow`、`0 < K2`）は `Part011/PhysicalPartitionFunctionSandwich.lean` にある。
- `lake build` と `check-no-sorry.sh` は通り、`check-end-to-end.sh` は「通しの定理が無い」で落ちる。
- 最終定理 `Ising2D.onsager_exact_solution_unconditional` に残る仮定:
  - `Z` が具体的な分配関数でなく、挟み撃ちを満たす任意の関数（`hZ1`, `hZ2`）。しかも全ての `N`（`N = 0` を含む）で要求する
  - `W` と `V^{(+)}` の橋渡し `bridge`
  - `tr(εV^{(+)}) > 0`（`htr`）
  - `W` の成分の正値性 `hWpos` と `ε` との可換性 `hWcomm`（具体的な `W` では形式化済みだが未接続）
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。

## 次の一歩

項目 2 の残り：最終定理の `Z` と `hZ1`, `hZ2` を、具体的な `partitionFunction N m K1 K2` と
`partition_function_sandwich_physical` に置き換える。`onsager_exact_solution`（`Part018/Theorem010_OnsagerExactSolution.lean`）は
`hZ1`, `hZ2` を全ての `N` で要求するが、人手は `N_row ≥ 1` である。`limit_of_log_Z_in_N_row` が `N ≥ 1` だけで足りるかを
読み、足りるならそちらの仮定を `1 ≤ N` に弱めて人手に合わせる（`N = 0` の主張を人手に無いまま足さない）。
`hcM` の `W` は項目 3 の接続で具体的な `W` にするので、この段では `cM m := rayleighSup (physicalSymTransferR m K1 K2)` と置いて
`bridge.W` との一致を仮定に残してよい。
