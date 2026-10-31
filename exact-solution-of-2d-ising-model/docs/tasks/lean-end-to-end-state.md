# Lean の通しの証明と章立てへの組み直しの状態

手順は [lean-end-to-end-runbook.md](lean-end-to-end-runbook.md)。

## 現在地

- runbook の「作業の順序」の 1 と 2 は済んでいる。
  - 1: `IsingParam.K2star := Kstar K2` で、双対関係は定理 `IsingParam.c2_mul_s2star_eq_c2star` になり、最終定理の仮定に `hdual` は無い。
  - 2: 最終定理 `Ising2D.onsager_exact_solution_unconditional`（`Part018/Theorem013_OnsagerUnconditional.lean`）の
    `Z` は具体的な `partitionFunction N m P.K1 P.K2`、`c(M)` は `rayleighSup (physicalSymTransferR m P.K1 P.K2)` である。
    挟み撃ちは `partition_function_sandwich_physical`（`Part011/PhysicalPartitionFunctionSandwich.lean`）で与えた。
    人手 `partition_function_sandwich`・`limit_of_log_Z_in_N_row` に合わせ、`limit_of_log_Z_in_N_row`・`onsager_exact_solution`・
    `onsager_exact_solution_isoParam` の挟み撃ちの仮定は `1 ≤ N` の範囲だけで受け取る。
- `lake build`（3028 ジョブ）と `check-no-sorry.sh` は通り、`check-end-to-end.sh` は「通しの定理が無い」で落ちる。
- 最終定理に残る仮定:
  - `In m hm : EvenSectorClosureInput P m` の中身: `W` と `V^{(+)}` の橋渡し `bridge`、`tr(εV^{(+)}) > 0`（`htr`）、
    `W` の成分の正値性 `hWpos` と `ε` との可換性 `hWcomm`
  - `hW`: `bridge.W = physicalSymTransferR m P.K1 P.K2`（項目 3 で `bridge` を具体的な `W` について作れば消える）
- 項目 6 で直すこと: `onsager_limit_in_N_row`（`Part018/Theorem010_OnsagerExactSolution.lean`）は `c(M) > 0` を
  挟み撃ち `Λ ≤ c(M)` から出しているが、人手 `limit_of_log_Z_in_N_row` は `def_rayleigh_sup` から出す。
  通しの定理では `rayleighSup_pos`（`Part011/Definition006_RayleighSup.lean`）と `physicalSymTransferR` の正定値性から出し、
  人手と 1 対 1 にする。
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。

## 次の一歩

項目 3：`EvenSectorBridge`（`Part018/Theorem009_CPlusEqualsLambda.lean`）を、具体的な `W = physicalSymTransferR M P.K1 P.K2` と
`vPlusDataOf` の `V^{(+)}` について構成する。まず `EvenSectorBridge` の欄を読み、補題の単位（`V^{(+)}` の実行列表示、
`symmetrized_transfer_matrix_on_sectors` から実ベクトル上の `hWV` への変換、`W` の対称性・半正定値性）に割り直して
この台帳に書き、先頭の一つだけを行う。
