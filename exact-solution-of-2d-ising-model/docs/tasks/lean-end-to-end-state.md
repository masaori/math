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
- 項目 4 は済んでいる。`tr(εV^{(+)}) > 0` は `trace_epsilon_vPlusDataOf_pos`（`Part018/ClaimTraceEpsilonVPlusClosedForm.lean`）で証明し、
  当時の入力の構造 `EvenSectorClosureInput` から `htr` と、その型のために置いていた `hM` を外した（`M ≠ 0` は `2 ≤ M` から出す）。次の四つに割って進めた。
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
  - 4d（済み）: 人手 `trace_of_epsilon_V_plus` の Step 1〜5 を `vPlusDataOf` の `V^{(+)}`（`VPlusOfTransfer_eq_VPlus` で人手の `V_2` の形へ戻す）について
    証明し、`EvenSectorClosureInput` から `htr` を外す。人手の Step の単位で次の三つに割った。
    - Step 1・Step 2 の形式化（済み）: Step 1（`tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`）と Step 2（`εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`）を
      `Part018/ClaimTraceEpsilonVPlusReduction.lean` で形式化した（`trace_epsilon_VPlusOfTransfer`・`epsilon_mul_V1plus`）。
      `exp(K_1εG)` の偶奇分解は必要十分版 `NecSuf/ExpOfInvolution.lean` を置き、系の導出を
      `Part018/ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` に置いた。
    - 成分の読み取りの形式化（済み）: Step 3 (a)(b)(c) を `Part018/ClaimTraceEpsilonVPlusMatrixEntries.lean` で形式化した。
      (a) `exp(K_1D_0)` の対角性 `matExp_smul_openChainD0`（成分 `matExp_smul_openChainD0_apply`）、`G` の対角性 `boundaryG_eq_diagonal`（成分 `boundaryG_apply`）、
      (b) `εf_{ι(s)} = f_{ι(-s)}` は `epsilon_mulVec_basisVec_configBasisIso`（`-s` は `negSpinConf`）、Step 4 が使う行の形は `epsilon_mul_apply_configBasisIso`、
      (c) `V2_apply_configBasisIso`・`V2_apply_configBasisIso_self`・`V2_apply_configBasisIso_neg_self`。
    - 二つのスピン和の代入と正値性の形式化（済み）: Step 4・Step 5 と主張を `Part018/ClaimTraceEpsilonVPlusClosedForm.lean` で形式化した
      （`trace_epsilon_VPlusOfTransfer_split`・`trace_epsilon_VPlusOfTransfer_eq_spin_sums`・`trace_epsilon_VPlusOfTransfer_closed_form`・
      `trace_epsilon_VPlusOfTransfer_pos`・`trace_of_epsilon_V_plus`、`vPlusDataOf` へ移した `trace_epsilon_vPlusDataOf_pos`）。必要十分版は置かない。
- 項目 5 は済んでいる。`hWcomm` は `epsilon_commutes_with_W P.K1 P.K2_pos`（`Part011/ClaimEpsilonCommutesWithW.lean`）で埋めた。
  `hWpos` は人手 `W_has_positive_entries` の Step 1〜3 を具体的な `V_1^{1/2}`・`V_2` について
  `Part011/ClaimPhysicalWHasPositiveEntries.lean` で形式化して埋めた（`W_has_positive_entries_physical`、
  `ι` の全射性で全成分へ広げた `physicalSymTransferR_pos`）。Step 3 の必要十分版 `NecSuf/SandwichByDiagonal.lean`（添字は有限、係数は結合律・可換律を仮定しない半環）を置き、具体版をその特殊化として `Part011/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean` で導出した。
  欄が無くなったので `EvenSectorClosureInput` を消し、挟み撃ちを `rayleighSup_sandwich_LambdaM_physical` に改名した。
  **最終定理 `onsager_exact_solution_unconditional` の入力は結合定数の組 `P : IsingParam` だけである。**
- 項目 6 は済んでいる。通しの定理 `Ising2D.onsager_exact_solution_end_to_end`（`Part018/TheoremOnsagerExactSolutionEndToEnd.lean`）は
  `check-end-to-end.sh` が固定する型をそのまま持ち、`onsager_exact_solution_unconditional ⟨K1, K2, hK1, hK2⟩` から
  `f M := (1/M) log c(M)` として得る。閉形式の被積分関数は `gammaFn_eq_arcosh_Kstar`（`gammaFn_eq` と `IsingParam.K2star := Kstar K2`）で書き直した。
  `c(M) > 0` は人手 `limit_of_log_Z_in_N_row` と同じく `def_rayleigh_sup` から出すよう、Step 1 を
  `onsager_limit_in_N_row_physical`（`Part018/Theorem013_OnsagerUnconditional.lean`。`rayleighSup_pos` と
  `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`）にし、`onsager_exact_solution_unconditional` の第 1 成分をそれで与えた。
  `onsager_limit_in_M` は人手 `onsager_exact_solution` の Step 3（挟み撃ち）と同じく `Λ ≤ c(M)` から正値性を出す。必要十分版は置かない（新しい計算を含まない）。
- `lake build`、`check-no-sorry.sh`、`check-end-to-end.sh` はすべて通る（通しの定理は `sorryAx` に依存しない）。
- Part020 に人手の定義と別表示の `KStar`（`arsinh(1/sinh 2K)/2`）が残っている。`Kstar_eq_KStar` で
  人手の `Kstar` へ接続したが、二重定義の解消は項目 7 の章ごとの移動のときに行う。
- 項目 7 は章ごとに進めている。置き場の規則は runbook の項目 7 に書いた。
  - 部「分配関数」の章「転送行列による表示」（済み）: 14 ファイルを `Ising2D/PartitionFunction/TransferMatrixRepresentation/` へ移した
    （旧 `Part001/` の 6 本は全部、旧 `Part004/` から `DefinitionConfigBasisIso`・`ClaimConfigNumberingEqualsKroneckerNumbering`・`ClaimSigmaZDiagonalAction`・
    `ClaimFirstTransferMatrixPauliForm`・`DefinitionSecondDualCouplingConstant`・`ClaimTwoByTwoTransferIdentity`・`ClaimSecondTransferMatrixPauliForm`・
    `ClaimPartitionFunctionViaPauliTransferMatrices`）。`Part001/` は無くなった。
    この章の項目のうち `def_site_pauli_matrices` は `PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`（多数決で次の章へ置いた）の中にあり、
    `def_real_logarithm_positive`・`def_first_dual_coupling_constant` は形式化されていない。
  - 部「分配関数」の章「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」（済み）: 16 ファイルを `Ising2D/PartitionFunction/ProjectionAndJordanWigner/` へ移した。
    旧 `Part004/` から `DefinitionTransferMatrixSymbols`（旧 `Definition000_TransferMatrixSymbols`）・`ClaimEpsilonSquareFromNecSuf`・
    `ClaimGlobalSpinFlipJordanWignerRepresentationFromNecSuf`・`ClaimSecondDualCouplingRelation`（と `FromNecSuf`）・`ClaimV1InZYEpsilon`・`ClaimV2InZY`・
    `ClaimV1RestrictionToEigenspaces`・`DefinitionH1H2V1V2`（旧 `Definition010_H1H2V1V2`）・`EvenEigenvectors`、
    旧 `Part010/` から `ClaimEpsilonProjectors`（旧 `Claim009_EpsilonProjectors`）・`ClaimEpsilonCommutes`（旧 `Claim010_EpsilonCommutes`）・`DefinitionV1PlusSquareRoot`、
    旧 `Part011/` から `ClaimSymmetrizedTransferMatrixOnSectorExponentialForm`・`PhysicalSymTransferBridge`・
    `DefinitionSymmetrizedTransferMatrix`（旧 `Definition001_SymmetrizedTransferMatrix`）である。章のフォルダへ移すときにファイル名の番号を外した。
    `DefinitionSymmetrizedTransferMatrix` は、この章の `def_transfer_matrix_square_root`・`def_symmetrized_transfer_matrix` と
    「N→∞ の極限と最大固有値 c(M)」の章の `Z_equals_trace_of_W`・`W_is_real_symmetric_positive_definite` が 2 対 2 の同数なので、並びで先のこの章へ置いた。
    `Part010/` に残る `Claim011_SectorReplacement`・`Claim012_SectorDecomposition` と `Part004/OddEigenvectors` は (−) セクターの記録なので、
    `RoutesNotAdopted/MinusSector/` へ移すときに扱う。旧 `Part014/Definition001_VPlus` は「A(θ̃_μ) への帰着」の章の項目が多いので、この章へは移さなかった。
  - 部「固有値問題」の章「離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着」（済み）: 22 ファイルを `Ising2D/EigenvalueProblem/ReductionToATheta/` へ移した。
    旧 `Part004/` から `ClaimExpSum`（と `FromNecSuf`）・`DefinitionExpPhase`、旧 `Part006/` の 2 本（`ClaimAnticommutatorZY` と `FromNecSuf`）、
    旧 `Part008/` から `ClaimExpConjugation`・`ClaimDualityC2StarEqS2StarC2`・`DefinitionThetaGamma`、
    旧 `Part013/` から `ClaimAntiperiodicExpSum`（と `FromNecSuf`）・`ClaimCommutatorHCheckZY`・`DefinitionHalfIntegerModes`・`DefinitionCheckIndexSet`、
    旧 `Part014/` の 9 本全部である。`Part006/`・`Part014/` は無くなった。章のフォルダへ移すときにファイル名の番号を外した。
    `ClaimExpConjugation` は `exp_X_Y_exp_-X` だけを形式化している（`adPow` は主張の式に出る n 重の入れ子交換子の定義で、1 回の `ad_X` を定める `def_ad_X_matrix` や `ad_binomial` の主張の形式化ではなく、`matrix_exp_conjugation` は参照だけ）のでこの章へ置いた。
    `DefinitionThetaGamma` が形式化する人手の項目のうち棚卸しにあるのは `def_A_theta` だけ（`θ_μ`・`γ_2` の性質は整数運動量の経路のノート）なのでこの章へ置いた。
    人手の項目を持たない `DefinitionExpPhase` は、import する 2 本（`ClaimExpSum` とまだ動かさない `Part004/Definition009_HatZHatY`）が同数なので、この章へ置いた。
    整数運動量の経路の記録（`Part004/` の `hat(Z), hat(Y)` の 4 本、`Part007/`、`Part008/` の `Claim001_CommutatorHZY`・`Claim012_TVActions`・`Claim027_EigenATheta`、
    `Part013/Claim001_WhyMinusOnly`）は数えず、`RoutesNotAdopted/IntegerMomentum/` へ移すときに扱う。
    `Part008/Definition016_TV` は数学的道具立て「可逆行列・線型写像との対応・共役変換」の `def_T_g`・`linearity_of_T` を形式化しているので残した。
    `Part013/Claim007_H1H2ViaCheck`（`H1_H2_via_check_Z_Y`）は未割り当てなので残した。
  - 未割り当ての項目だけを形式化していて動かさないファイル: `Part004/ClaimEpsilonActionEigenvalues.lean`（`epsilon_action_eigenvalues_are_signs`）と、
    その必要十分版の導出、`Part013/Claim007_H1H2ViaCheck.lean`（`H1_H2_via_check_Z_Y`）。割り当ては構成再編の連続実行を待つ。

## 次の一歩

項目 7 の 4 番目の章、部「固有値問題」の「A(θ̃_μ) の対角化と V^{(+)} の指数表示」（フォルダ `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/`）を移す。
棚卸しの `chapterKey` が `chapter_organization_goal_diagonalization_and_exponential_form` の項目を形式化したファイルを、runbook の置き場の規則で選ぶ
（候補は `Part013/` の `Claim003b_ConjugateIndex`・`Claim005_AnticommutatorCheckZY`・`Claim006_RecoverZY`（と各 `FromNecSuf`）、`Part015/`・`Part016/` の全部、
`Part004/Claim014_ZYGenerateAlgebra`（と `FromNecSuf`）、`Part012/Claim001_Gamma1LowerBound` など。整数運動量の経路の記録は数えない）。
`Ising2D.lean` の import、コメントのパス、`lean/README.md`・`lean/docs/` の対応表を同じ回で直す。
