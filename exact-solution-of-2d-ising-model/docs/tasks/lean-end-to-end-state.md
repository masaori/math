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
  - `htr`: `tr(εV^{(+)}) > 0`（項目 4。4d で消える）
  - `hWpos`: 具体的な `W` の成分の正値性、`hWcomm`: `ε` と具体的な `W` の可換性（項目 5）
- 項目 4 は次の四つに割った。
  - 4a（済み）: 人手 `def_D0_open_chain_operator`・`def_G_boundary_operator`・`H1_plus_in_sigma_z_form`
    （`iH_1^{(+)} = D_0 + εG`）を `Part018/DefinitionOpenChainAndBoundaryOperators.lean`・`Part018/ClaimH1PlusInSigmaZForm.lean` で形式化した
    （`openChainD0`・`boundaryG`・`H1_plus_in_sigma_z_form`）。
  - 4b（済み）: 人手 `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action` を
    `Part018/ClaimEpsilonD0GCommuteAndDiagonalAction.lean` で形式化した（`epsilon_mul_openChainD0`・`epsilon_mul_boundaryG`・
    `openChainD0_mul_boundaryG`・`epsilon_mul_boundaryG_sq`・`openChainD0_mulVec_basisVec`・`boundaryG_mulVec_basisVec`）。
  - 4c（済み）: 人手 `def_open_chain_spin_energy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive` を
    `Part018/ClaimOpenChainSpinSums.lean` で形式化した（`openChainEnergy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・
    `open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos`）。`openChainEnergy` は `openChainD0_mulVec_basisVec` の係数と定義で一致する。
    両端のスピンは `s (lastSite M _) * s (firstSite M _)` の順で書いた（`boundaryG_mulVec_basisVec` の係数と同じ）。
    値は可換半環で足りるので、必要十分版 `NecSuf/OpenChainSpinSum.lean` を置き、具体版を `Part018/ClaimOpenChainSpinSumsFromNecSuf.lean` で系として導出した。
    4d で使う `D_0f_{ι(s)} = E(s)f_{ι(s)}` は `openChainD0_mulVec_basisVec_eq_energy`。二つの和は `ℝ` の `Real.exp` で書いてあるので、4d で `ℂ` へ移す。
  - 4d: 人手 `trace_of_epsilon_V_plus` の Step 1〜5 を `vPlusDataOf` の `V^{(+)}`（`VPlusOfTransfer_eq_VPlus` で人手の `V_2` の形へ戻す）について
    証明し、`EvenSectorClosureInput` から `htr` を外す。人手の Step の単位で次の三つに割った。
    - Step 1・Step 2 の形式化（済み）: Step 1（`tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`）と Step 2（`εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`）を
      `Part018/ClaimTraceEpsilonVPlusReduction.lean` で形式化した（`trace_epsilon_VPlusOfTransfer`・`epsilon_mul_V1plus`）。
      `exp(K_1εG)` の偶奇分解は必要十分版 `NecSuf/ExpOfInvolution.lean` を置き、系の導出を
      `Part018/ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` に置いた。
    - 成分の読み取りの形式化: Step 3。(a) `exp(K_1D_0)` は配置基底で対角で `exp(K_1E(s))`（`openChainD0_mulVec_basisVec_eq_energy` と
      `exp_of_diagonal_matrix`）、`G` は対角で `s(M_col)s(1)`、(b) `εf_{ι(s)} = f_{ι(-s)}`、(c) `(V_2)_{ι(s),ι(s')} = exp(K_2∑_m s(m)s'(m))`
      とその二つの特別な場合。
    - 二つのスピン和の代入と正値性の形式化: Step 4（トレースを二つのスピン和で書き、4c の `open_chain_partition_sum`・`open_chain_endpoint_product_sum` を代入して閉じた式にする）と
      Step 5（正値性）。`K1 = P.K1`、`vPlusDataOf_V` と `VPlusOfTransfer_eq_VPlus` で `vPlusDataOf` の `V^{(+)}` へ移し、
      `EvenSectorClosureInput` から `htr` を外す。
- 項目 6 で直すこと: `onsager_limit_in_N_row`（`Part018/Theorem010_OnsagerExactSolution.lean`）は `c(M) > 0` を
  挟み撃ち `Λ ≤ c(M)` から出しているが、人手 `limit_of_log_Z_in_N_row` は `def_rayleigh_sup` から出す。
  通しの定理では `rayleighSup_pos`（`Part011/Definition006_RayleighSup.lean`）と `physicalSymTransferR` の正定値性から出し、
  人手と 1 対 1 にする。
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。

## 次の一歩

項目 4d のうち「成分の読み取りの形式化」：人手 `trace_of_epsilon_V_plus` の Step 3（成分の読み取り (a)(b)(c)）を具体版で形式化する。
材料は 4b の `openChainD0_mulVec_basisVec`・`boundaryG_mulVec_basisVec`、4c の `openChainD0_mulVec_basisVec_eq_energy`、
`exp_of_diagonal_matrix` の具体版（`Part004/ClaimExpOfDiagonalMatrix.lean`）、`def_config_basis_iso`・`config_numbering_equals_kronecker_numbering`・
`def_transfer_matrix` の形式化（`Part004/DefinitionConfigBasisIso.lean`・`Part001`）である。
