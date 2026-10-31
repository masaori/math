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
- 項目 3 は次の三つに割った。
  - 3a（済み）: `V^{(+)}` の実行列表示。人手 `c_plus_equals_Lambda_half_integer` Step 2 の「`V^{(+)}` の成分は実である」を
    `Part018/ClaimVPlusRealEntries.lean` の `VPlus_hasRealEntries` で形式化し、`EvenSectorBridge` の欄 `Vr`・`hVr` を
    `VPlusR P M`・`vPlusDataOf_V_eq_map` として与えた。
  - 3b: 人手 Step 0（`x ∈ 𝓕^{(+)}` なら `P^{(+)}x = x`、`Wx = V^{(+)}x`）を、`symmetrized_transfer_matrix_on_sectors`
    （`Part011/PhysicalSymTransferBridge.lean`、`2 ≤ M`・`0 < K_2`）と `VPlusOfTransfer_eq_VPlus`（`P.K2star = Kstar P.K2` は定義）から、
    実ベクトル上の `physicalSymTransferR M K1 K2 *ᵥ x = VPlusR P M *ᵥ x`（`epsilonR M *ᵥ x = x`）として立てる。
    複素化は `cvec`・`cvec_mulVec`（`Theorem009_CPlusEqualsLambda.lean`）と `epsilon_eq_ofReal_epsilonR` を使う。
  - 3c: `W` の実対称性（`symTransfer_isSymm`・`physicalV1halfR_isSymm`・`physicalV2R_isSymm`）と半正定値性
    （`symTransfer_posDef`、`x = 0` は自明）から、具体的な `W` についての `EvenSectorBridge` を構成し、
    最終定理の `In.bridge` と `hW` を外す（`EvenSectorClosureInput` から `bridge` を除き、`hWpos`・`hWcomm` の対象を
    `physicalSymTransferR` に替える）。
- `lake build`（3029 ジョブ）と `check-no-sorry.sh` は通り、`check-end-to-end.sh` は「通しの定理が無い」で落ちる。
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

項目 3b：人手 `c_plus_equals_Lambda_half_integer` Step 0 を、具体的な `W = physicalSymTransferR M P.K1 P.K2` と
`VPlusR P M` について実ベクトル上で立てる（上の 3b の欄）。新しいファイルを `Part018/` に置き、`Ising2D.lean` の import と
`lean/docs/ch018-formalization.md` の表を同じ回で直す。
