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
- 項目 3 は済んでいる。具体的な `W = physicalSymTransferR M P.K1 P.K2` と `vPlusDataOf` の `V^{(+)}` についての
  `EvenSectorBridge` を `physicalEvenSectorBridge`（`Part018/PhysicalEvenSectorBridge.lean`）で構成した。
  欄は `W_is_real_symmetric_positive_definite` の具体版 `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`
  （`Part011/PhysicalPartitionFunctionSandwich.lean`）、Step 2 の `VPlusR`・`vPlusDataOf_V_eq_map`
  （`Part018/ClaimVPlusRealEntries.lean`）、Step 0 の `hWV_physical`（`Part018/ClaimWEqVPlusOnEvenSector.lean`）である。
  最終定理の入力から `bridge` と `hW` を外した。
- `lake build` と `check-no-sorry.sh` は通り、`check-end-to-end.sh` は「通しの定理が無い」で落ちる。
- 最終定理 `onsager_exact_solution_unconditional` に残る仮定は `In m hm : EvenSectorClosureInput P m`（`2 ≤ m`）の中身だけである。
  - `hM : m ≠ 0`（`2 ≤ m` から従う。`htr` の型が `vPlusDataOf P hM _` を含むので欄に残っている）
  - `htr`: `tr(εV^{(+)}) > 0`（項目 4）
  - `hWpos`: 具体的な `W` の成分の正値性、`hWcomm`: `ε` と具体的な `W` の可換性（項目 5）
- 項目 6 で直すこと: `onsager_limit_in_N_row`（`Part018/Theorem010_OnsagerExactSolution.lean`）は `c(M) > 0` を
  挟み撃ち `Λ ≤ c(M)` から出しているが、人手 `limit_of_log_Z_in_N_row` は `def_rayleigh_sup` から出す。
  通しの定理では `rayleighSup_pos`（`Part011/Definition006_RayleighSup.lean`）と `physicalSymTransferR` の正定値性から出し、
  人手と 1 対 1 にする。
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。

## 次の一歩

項目 4：`htr`（`tr(εV^{(+)}) > 0`、人手 `trace_of_epsilon_V_plus`）を具体版で証明する。
`Part018/Theorem007_MaxEigenvectorEvenSector.lean` には人手 `open_chain_partition_sum`・`open_chain_endpoint_product_sum`・
`open_chain_spin_sums_positive`・`def_open_chain_spin_energy`・`H1_plus_in_sigma_z_form` のラベルが既に現れ、
`def_D0_open_chain_operator`・`def_G_boundary_operator`・`epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・
`D0_G_diagonal_action` は Lean に現れない。まずこの既存の形式化が `vPlusDataOf` の `V^{(+)}` についての主張かを確かめ、
足りない人手ブロックを補題の単位で割り直してこの欄に書き、先頭の一つだけを行う。
