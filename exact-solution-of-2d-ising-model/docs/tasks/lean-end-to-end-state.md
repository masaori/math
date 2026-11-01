# Lean の通しの証明と章立てへの組み直しの状態

手順は [lean-end-to-end-runbook.md](lean-end-to-end-runbook.md)。

## 現在地

- runbook の「作業の順序」の 1 と 2 は済んでいる。
  - 1: `IsingParam.K2star := Kstar K2` で、双対関係は定理 `IsingParam.c2_mul_s2star_eq_c2star` になり、最終定理の仮定に `hdual` は無い。
  - 2: 最終定理 `Ising2D.onsager_exact_solution_unconditional`（`ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerUnconditional.lean`）の
    `Z` は具体的な `partitionFunction N m P.K1 P.K2`、`c(M)` は `rayleighSup (physicalSymTransferR m P.K1 P.K2)` である。
    挟み撃ちは `partition_function_sandwich_physical`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`）で与えた。
    人手 `partition_function_sandwich`・`limit_of_log_Z_in_N_row` に合わせ、`limit_of_log_Z_in_N_row`・`onsager_exact_solution`・
    `onsager_exact_solution_isoParam` の挟み撃ちの仮定は `1 ≤ N` の範囲だけで受け取る。
- 項目 3 は済んでいる。具体的な `W = physicalSymTransferR M P.K1 P.K2` と `vPlusDataOf` の `V^{(+)}` についての
  `EvenSectorBridge` を `physicalEvenSectorBridge`（`ThermodynamicLimit/ColumnLimitAndClosedForm/PhysicalEvenSectorBridge.lean`）で構成した。
  欄は `W_is_real_symmetric_positive_definite` の具体版 `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`
  （`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`）、Step 2 の `VPlusR`・`vPlusDataOf_V_eq_map`
  （`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimVPlusRealEntries.lean`）、Step 0 の `hWV_physical`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimWEqVPlusOnEvenSector.lean`）である。
  最終定理の入力から `bridge` と `hW` を外した。
- 項目 4 は済んでいる。`tr(εV^{(+)}) > 0` は `trace_epsilon_vPlusDataOf_pos`（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusClosedForm.lean`）で証明し、
  当時の入力の構造 `EvenSectorClosureInput` から `htr` と、その型のために置いていた `hM` を外した（`M ≠ 0` は `2 ≤ M` から出す）。次の四つに割って進めた。
  - 4a（済み）: 人手 `def_D0_open_chain_operator`・`def_G_boundary_operator`・`H1_plus_in_sigma_z_form`
    （`iH_1^{(+)} = D_0 + εG`）を `EigenvalueProblem/EigenvectorOfMaxEigenvalue/DefinitionOpenChainAndBoundaryOperators.lean`・`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean` で形式化した
    （`openChainD0`・`boundaryG`・`H1_plus_in_sigma_z_form`）。
  - 4b（済み）: 人手 `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action` を
    `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonD0GCommuteAndDiagonalAction.lean` で形式化した（`epsilon_mul_openChainD0`・`epsilon_mul_boundaryG`・
    `openChainD0_mul_boundaryG`・`epsilon_mul_boundaryG_sq`・`openChainD0_mulVec_basisVec`・`boundaryG_mulVec_basisVec`）。
  - 4c（済み）: 人手 `def_open_chain_spin_energy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive` を
    `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSums.lean` で形式化した（`openChainEnergy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・
    `open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos`）。`openChainEnergy` は `openChainD0_mulVec_basisVec` の係数と定義で一致する。
    両端のスピンは `s (lastSite M _) * s (firstSite M _)` の順で書いた（`boundaryG_mulVec_basisVec` の係数と同じ）。
    値は可換半環で足りるので、必要十分版 `NecSuf/OpenChainSpinSum.lean` を置き、具体版を `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSumsFromNecSuf.lean` で系として導出した。
    4d で使う `D_0f_{ι(s)} = E(s)f_{ι(s)}` は `openChainD0_mulVec_basisVec_eq_energy`。二つの和は `ℝ` の `Real.exp` で書いてあるので、4d で `ℂ` へ移す。
  - 4d（済み）: 人手 `trace_of_epsilon_V_plus` の Step 1〜5 を `vPlusDataOf` の `V^{(+)}`（`VPlusOfTransfer_eq_VPlus` で人手の `V_2` の形へ戻す）について
    証明し、`EvenSectorClosureInput` から `htr` を外す。人手の Step の単位で次の三つに割った。
    - Step 1・Step 2 の形式化（済み）: Step 1（`tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`）と Step 2（`εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`）を
      `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReduction.lean` で形式化した（`trace_epsilon_VPlusOfTransfer`・`epsilon_mul_V1plus`）。
      `exp(K_1εG)` の偶奇分解は必要十分版 `NecSuf/ExpOfInvolution.lean` を置き、系の導出を
      `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` に置いた。
    - 成分の読み取りの形式化（済み）: Step 3 (a)(b)(c) を `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean` で形式化した。
      (a) `exp(K_1D_0)` の対角性 `matExp_smul_openChainD0`（成分 `matExp_smul_openChainD0_apply`）、`G` の対角性 `boundaryG_eq_diagonal`（成分 `boundaryG_apply`）、
      (b) `εf_{ι(s)} = f_{ι(-s)}` は `epsilon_mulVec_basisVec_configBasisIso`（`-s` は `negSpinConf`）、Step 4 が使う行の形は `epsilon_mul_apply_configBasisIso`、
      (c) `V2_apply_configBasisIso`・`V2_apply_configBasisIso_self`・`V2_apply_configBasisIso_neg_self`。
    - 二つのスピン和の代入と正値性の形式化（済み）: Step 4・Step 5 と主張を `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusClosedForm.lean` で形式化した
      （`trace_epsilon_VPlusOfTransfer_split`・`trace_epsilon_VPlusOfTransfer_eq_spin_sums`・`trace_epsilon_VPlusOfTransfer_closed_form`・
      `trace_epsilon_VPlusOfTransfer_pos`・`trace_of_epsilon_V_plus`、`vPlusDataOf` へ移した `trace_epsilon_vPlusDataOf_pos`）。必要十分版は置かない。
- 項目 5 は済んでいる。`hWcomm` は `epsilon_commutes_with_W P.K1 P.K2_pos`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonCommutesWithW.lean`）で埋めた。
  `hWpos` は人手 `W_has_positive_entries` の Step 1〜3 を具体的な `V_1^{1/2}`・`V_2` について
  `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean` で形式化して埋めた（`W_has_positive_entries_physical`、
  `ι` の全射性で全成分へ広げた `physicalSymTransferR_pos`）。Step 3 の必要十分版 `NecSuf/SandwichByDiagonal.lean`（添字は有限、係数は結合律・可換律を仮定しない半環）を置き、具体版をその特殊化として `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean` で導出した。
  欄が無くなったので `EvenSectorClosureInput` を消し、挟み撃ちを `rayleighSup_sandwich_LambdaM_physical` に改名した。
  **最終定理 `onsager_exact_solution_unconditional` の入力は結合定数の組 `P : IsingParam` だけである。**
- 項目 6 は済んでいる。通しの定理 `Ising2D.onsager_exact_solution_end_to_end`（`ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerExactSolutionEndToEnd.lean`）は
  `check-end-to-end.sh` が固定する型をそのまま持ち、`onsager_exact_solution_unconditional ⟨K1, K2, hK1, hK2⟩` から
  `f M := (1/M) log c(M)` として得る。閉形式の被積分関数は `gammaFn_eq_arcosh_Kstar`（`gammaFn_eq` と `IsingParam.K2star := Kstar K2`）で書き直した。
  `c(M) > 0` は人手 `limit_of_log_Z_in_N_row` と同じく `def_rayleigh_sup` から出すよう、Step 1 を
  `onsager_limit_in_N_row_physical`（`ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerUnconditional.lean`。`rayleighSup_pos` と
  `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`）にし、`onsager_exact_solution_unconditional` の第 1 成分をそれで与えた。
  `onsager_limit_in_M` は人手 `onsager_exact_solution` の Step 3（挟み撃ち）と同じく `Λ ≤ c(M)` から正値性を出す。必要十分版は置かない（新しい計算を含まない）。
- `lake build`、`check-no-sorry.sh`、`check-end-to-end.sh` はすべて通る（通しの定理は `sorryAx` に依存しない）。
- 人手の定義と別表示だった `KStar`（`arsinh(1/sinh 2K)/2`）は、臨界点の章を移したときに消し、`Kstar`（人手 `def_second_dual_coupling_constant`）に一本化した。
- 項目 7 は済んでいる（旧番号のフォルダは残っていない）。置き場の規則は runbook の項目 7 に書いた。
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
    人手の項目を持たない `DefinitionExpPhase` は、import する 2 本（`ClaimExpSum` と整数運動量の経路の `DefinitionHatZHatY`）が同数なので、この章へ置いた。
    整数運動量の経路の記録は数えなかった（のちに `RoutesNotAdopted/IntegerMomentum/` へ移した）。
    `Part008/Definition016_TV` は数学的道具立て「可逆行列・線型写像との対応・共役変換」の `def_T_g`・`linearity_of_T` を形式化しているので残した。
    `Part013/Claim007_H1H2ViaCheck`（`H1_H2_via_check_Z_Y`）は未割り当てなので残した。
  - 部「固有値問題」の章「A(θ̃_μ) の対角化と V^{(+)} の指数表示」（済み）: 26 ファイルを `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/` へ移した。
    旧 `Part004/` から `ClaimZYGenerateAlgebra`（と `FromNecSuf`）、旧 `Part012/` から `ClaimGamma1LowerBound`、
    旧 `Part013/` から `ClaimConjugateIndex`・`ClaimAnticommutatorCheckZY`（と `FromNecSuf`）・`ClaimRecoverZYFromCheckZY`（と `FromNecSuf`）、
    旧 `Part015/` の 6 本全部、旧 `Part016/` の 10 本全部、旧 `Part017/` から `TheoremMaxEigenvalueSimple`・`ClaimEigenvaluesCheckVprime` である。
    `TheoremMaxEigenvalueSimple` は `max_eigenvalue_of_V_plus_simple`（「V^{(+)} の固有値」の章）と `gamma_theta_tilde_mu_positive`（この章）を 1 対 1 で形式化し、`ClaimEigenvaluesCheckVprime` は `eigenvalues_of_check_Vprime`（同）と `def_check_number_operator` (2) の `X̌`・`def_check_Vprime` の `V̌'`（この章）を形式化しているので、同数以上で並びの先のこの章へ置いた。
    名前は内容から `DefinitionGamma1Gamma2OfThetaTilde`（旧 `Definition001_GammaTilde`）・`ClaimTVPlusEqTCheckVprime`（旧 `Claim008_TEq`）・`ClaimTVPlusEqTCheckVprimeOnCheckZY`（旧 `Claim007_TEqOnCheckZY`）とした。`Part015/`・`Part016/` は無くなった。章のフォルダへ移すときにファイル名の番号を外し、
    旧 `Claim010_UnconditionalViaPart015` は、章の対角化の結果で仮定を落とす内容から `ClaimCheckFermiResultsUnconditional` とした。
    `ClaimZYGenerateAlgebra` は `tensor_basis`（数学的道具立て）を引くだけで形式化していないので、この章の 1 項目だけで数えた。
    `Part017/Definition001_CheckNumberOperator` は `def_check_number_operator`（この章）1 つと `check_number_operator_idempotent`・`check_number_operators_commute`（「V^{(+)} の固有値」の章）2 つを形式化しているので残した。
    `Part018/Claim011_CheckFermiFromPart016` は `check_number_operator_is_hermitian` (3)（「M→∞ の極限と閉形式」の章）だけを新しく証明し、`def_check_fermi`・`anticommutator_of_check_psi` は既存の定理を使うだけなので残した。
    人手の `def_arccosh`・`arccosh_properties` は mathlib の `Real.arcosh` を使い（必要十分版 `NecSuf/Arcosh.lean`）、`V_plus_factors_invertible`・`T_V_plus_is_conjugation` は `ReductionToATheta/DefinitionVPlus.lean` にある（前の章で多数決により置いた）。
  - 部「固有値問題」の章「V^{(+)} の固有値」（済み）: 12 ファイルを `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/` へ移した。
    旧 `Part017/` の 9 本全部（`ClaimTraceCheckNumberOperatorProduct`・`ClaimCheckJointEigenspace`・`ClaimDirectSumAndDiagonalization`・`ClaimTraceCheckVprime`・
    `ClaimVPlusPositiveDefinite`・`ClaimConstantCEvenSector`・`ClaimVPlusEigenvaluesWithCValueAndStrictMaximum`・`DefinitionCheckNumberOperator`・`TheoremEigenvaluesVPlus`）、
    旧 `Part009/Claim016_SignFlip`（`ClaimSignFlipConjugation`。`sign_flip_conjugation` だけを形式化）、旧 `Part012/Theorem005_OnsagerFreeEnergy`（`TheoremOnsagerFreeEnergy`）、
    旧 `Part018/Claim012_VPlusDataFromPart017`（`ClaimVPlusDataFromEigenvaluesOfVPlus`）である。`Part017/` は無くなった。
    `TheoremOnsagerFreeEnergy` が形式化するのは `def_Lambda_delta_M`（この章）と `onsager_free_energy_expression`（「M→∞ の極限と閉形式」の章）の 1 対 1 で
    （`def_Theta_delta_M` に当たる `tagPoint` は `Part012/Theorem004_RiemannSumToIntegral.lean` にある）、並びで先のこの章へ置いた。
    `ClaimVPlusDataFromEigenvaluesOfVPlus` は、添字が `Fin M` の `eigenvalues_of_check_Vprime`（`checkVprime_mul_Qproj`）と `eigenvalues_of_V_plus` の固有関係（`vPlusDataOf`）を
    新しく証明しているのでこの章へ置いた（`constant_c_value_even_sector`・`gamma_theta_tilde_mu_positive` は既存の定理を使うだけで数えない）。
    `ClaimVPlusPositiveDefinite` の `V_plus_inverse_*` の 2 項は参照用ノートへ退避された主張なので数えない。
    `Part009/Claim013_PositiveDefinite` は数学的道具立て「トレース・共役転置・正定値性」の 3 項とこの章の `iH_is_real_symmetric` 1 項なので残した。
  - 部「固有値問題」の章「V^{(+)} の最大固有値に属する固有ベクトル」（済み）: 15 ファイルを `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/` へ移した。
    旧 `Part018/` から `ClaimEpsilonAnticommutesWithCheckZY`（旧 `Claim001_EpsilonAnticommutes`）・`ClaimEpsilonEigenvalueOnCheckQ`（旧 `Claim002_EpsilonEigenvalueOnQ`）・
    `ClaimTraceEpsilonVPlusViaCheckEigenvalues`（旧 `Claim003_TraceEpsilonVPlus`）・`TheoremMaxEigenvectorInEvenSector`（旧 `Theorem007_MaxEigenvectorEvenSector`）・
    `ClaimMaxEigenvectorInEvenSectorViaTraceOfEpsilonVPlus`・`DefinitionOpenChainAndBoundaryOperators`・`ClaimH1PlusInSigmaZForm`・`ClaimEpsilonD0GCommuteAndDiagonalAction`・
    `ClaimOpenChainSpinSums`（と `FromNecSuf`）・`ClaimTraceEpsilonVPlusReduction`（と `FromNecSuf`）・`ClaimTraceEpsilonVPlusMatrixEntries`・`ClaimTraceEpsilonVPlusClosedForm`、
    補助のファイル `CheckFermiInput`（旧 `Setup`）である。
    `Setup` は runbook が人手の項目を持たない補助のファイルの例に挙げているので、import 元の多数決で置いた（import 元はこの章の `ClaimEpsilonEigenvalueOnCheckQ` と
    「M→∞ の極限と閉形式」の章の `Part018/Claim008_CheckQHermitian` の 1 対 1 で、並びで先のこの章）。
    この章の `V1_plus_square_root_property` は `PartitionFunction/ProjectionAndJordanWigner/DefinitionV1PlusSquareRoot.lean` にあり、そのファイルは前の章の
    `def_V1_plus_square_root`・`def_V_plus` が 2 対 1 で多いので残した。`Part011/ClaimEpsilonIsRealSymmetric.lean` は `trace_of_epsilon_V_plus` の Step 3 (b) に説明で触れるだけで、
    形式化しているのは `epsilon_is_real_symmetric`（「M→∞ の極限と閉形式」の章）なので動かさなかった。`Part018/` に残ったファイルは「M→∞ の極限と閉形式」の章の項目だけを形式化している。
  - 部「熱力学極限」の章「N→∞ の極限と最大固有値 c(M)」（済み）: 8 ファイルを `Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/` へ移した。
    旧 `Part011/` から `ClaimOperatorBound`（旧 `Claim007_OperatorBound`）・`ClaimTracePowerSandwich`（旧 `Claim008_TracePowerSandwich`）・
    `ClaimPartitionFunctionSandwich`（旧 `Claim009_PartitionFunctionSandwich`）・`DefinitionRayleighSup`（旧 `Definition006_RayleighSup`）・`PhysicalPartitionFunctionSandwich`・`TraceBound`、
    旧 `Part012/` から `ClaimLimitInNRow`（旧 `Claim003_LimitInNRow`）・`ClaimPartitionFunctionSandwichAndLimitInNRow` である。
    `PhysicalPartitionFunctionSandwich` は `def_transfer_matrix_square_root`（前の章）1 項と `W_is_real_symmetric_positive_definite`・`partition_function_sandwich`（この章）2 項なのでこの章へ置いた。
    `TraceBound` は `trace_power_sandwich` の Step 3 の補題で、import 元も `DefinitionRayleighSup` だけなのでこの章へ置いた。
    `Part011/Basic.lean` は人手の項目を持たない補助のファイルで、import 元は数学的道具立て「トレース・共役転置・正定値性」の `Claim005_PsdCauchySchwarz` と
    `NecSuf/PermMatrix`（置き場に数えない）なので、数学的道具立てへ移すときに扱う。`Part011/` と `Part018/` に残る項目付きのファイルは「M→∞ の極限と閉形式」の章の項目が多い。ただし `Part011/Claim005_PsdCauchySchwarz.lean`（`psd_cauchy_schwarz`）は数学的道具立て「トレース・共役転置・正定値性」、`Part011/Claim010_SectorDecomposition.lean`（参照用ノートへ退避した `sector_decomposition_of_rayleigh_sup`）は `RoutesNotAdopted/MinusSector/` の置き場なので、次の章では移さない。
  - 部「熱力学極限」の章「M→∞ の極限と閉形式」（済み）: 19 ファイルを `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/` へ移した。
    旧 `Part011/` から `ClaimCPlusLeC`・`ClaimEpsilonCommutesWithW`・`ClaimEpsilonIsRealSymmetric`・`ClaimPhysicalWHasPositiveEntries`（と `FromNecSuf`）・`DefinitionSectorRayleighSup`、
    旧 `Part012/` から `ClaimGammaContinuous`（旧 `Claim002_GammaContinuous`）、旧 `Part004/` から `ClaimZYLinearlyIndependent`（旧 `Claim001_ZYLinearlyIndependent`。と `FromNecSuf`）、
    旧 `Part018/` の 10 本全部（`ClaimCheckQHermitian`（旧 `Claim008_CheckQHermitian`）・`ClaimCheckFermiFromDiagonalizationAndExponentialForm`（旧 `Claim011_CheckFermiFromPart016`）・
    `ClaimCPlusValueCSandwichAndDoubleLimitOfLogZ`・`ClaimVPlusRealEntries`・`ClaimWEqVPlusOnEvenSector`・`PhysicalEvenSectorBridge`・`TheoremCPlusEqualsLambda`（旧 `Theorem009_CPlusEqualsLambda`）・
    `TheoremOnsagerExactSolution`（旧 `Theorem010_OnsagerExactSolution`）・`TheoremOnsagerUnconditional`（旧 `Theorem013_OnsagerUnconditional`）・`TheoremOnsagerExactSolutionEndToEnd`）である。`Part018/` は無くなった。
    `ClaimZYLinearlyIndependent` は `Z_Y_linearly_independent` だけを形式化しており、その項は棚卸しでこの章に割り当てられているのでこの章へ置いた。
    `ClaimCheckFermiFromDiagonalizationAndExponentialForm` は前の章で判断したとおり `check_number_operator_is_hermitian` (3) だけを新しく証明しているのでこの章へ置いた。
    この章の `even_eigenspace_is_complex_subspace` は `PartitionFunction/ProjectionAndJordanWigner/EvenEigenvectors.lean`、`onsager_free_energy_expression` は
    `EigenvalueProblem/EigenvaluesOfVPlus/TheoremOnsagerFreeEnergy.lean` にあり、どちらも前の章で多数決により置いた。
    `Part011/` に残るのは `Basic`（補助）・`Claim005_PsdCauchySchwarz`（数学的道具立て）・`Claim010_SectorDecomposition`（(−) セクターの記録）、
    `Part012/` に残るのは `Theorem004_RiemannSumToIntegral`（`riemann_sum_to_integral`）である。
  - 部「臨界点」の章「臨界点 K_c と d²f/dK² の対数発散」（済み）: 6 ファイルを `Ising2D/CriticalPoint/CriticalPointAndLogDivergence/` へ移した。
    旧 `Part020/` から `DefinitionKappaAndCritical`（旧 `Definition002_KappaAndCritical`）・`ClaimKappaOfKBasic`（旧 `Claim006_KappaOfK`）・
    `ClaimGammaDerivativesInKappa`（旧 `Claim007_GammaDerivatives`）・`TheoremSecondDerivativeLogDivergence`（旧 `Theorem011_SecondDerivativeLogDivergence`）・
    `TheoremSpecificHeatLogDivergence`（旧 `Theorem012_SpecificHeatLogDivergence`）・`ClaimCriticalPointSinhKcAndSecondDerivativeLogDivergence` である。
    `Part020/` に残る `Claim001_CoshAddHalfAngle`（`cosh_addition_and_half_angle`。数学的道具立て「実数の平方根・指数関数・双曲線関数」）と
    `Claim008`〜`Claim010`（数学的道具立て「三角関数の評価・有限和・積分」）は数学的道具立てへ移すときに扱う。
    同じ回で `KStar` の二重定義を解消した。`kappaK K := 2K - 2·Kstar K` とし、`critical_point_iff_kappa_zero`・`isoParam_K2star`（`rfl`）・`AP_isoParam` を `Kstar` で書き直した
    （`sinh 2K sinh 2K^* = 1` は `s2star_eq_inv_s2` から `sinh_two_mul_sinh_two_Kstar`）。`ClaimKappaOfKBasic` の arsinh 形の `kappaK_eq` を消し、
    人手 `kappa_of_K_basic` (1) の証明どおり `(tanh)' = 1/cosh²`（`hasDerivAt_tanh_real`）と `dK^*/dK = -1/sinh 2K`（`hasDerivAt_Kstar`）から `κ'` を出し、
    (2) は `critical_point_iff_kappa_zero` の (1) ⟺ (3) と `sinh` の単射性で示すようにした。`check-no-sorry.sh` の対象も入れ替えた。
    人手 (1) の `κ' > 0` と (2) の `κ(K)=0 ⟺ sinh² 2K = 1` は独立した定理として置いていない（以前からの差。後退ではない）。
  - 部「数学的道具立て」のまとまり「実数の平方根・指数関数・双曲線関数」（済み）: 旧 `Part020/Claim001_CoshAddHalfAngle` を
    `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAdditionAndHalfAngle.lean` へ移した（`cosh_addition_and_half_angle` だけを形式化）。
    棚卸しの先頭のまとまり「集合記号と複素数の直交座標計算」の項目（`set_and_algebra_notation`・`definition_of_cc`・`def_complex_conjugate` など）を形式化したファイルは無かった。
    このまとまりのほかの項目（`def_cosh_sinh`・`cosh_sinh_basic_properties`・平方根の 4 項目）を形式化したファイルも無い。
  - 部「数学的道具立て」のまとまり「角度・極座標・複素数の積と商」「絶対値・偏角・複素平方根」: 形式化したファイルは無い（`RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` は `def_sqrt_cc` に説明で触れるだけで、形式化しているのは整数運動量の経路の `ψ_μ` である）。
  - 部「数学的道具立て」のまとまり「クロネッカー積と多因子基底」（済み）: 旧 `Part002/Theorem000_TensorBasis`（と `FromNecSuf`）を
    `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean`（と `TheoremTensorBasisFromNecSuf.lean`）へ移した（`tensor_basis` だけを形式化）。
    このまとまりのほかの項目（`def_kronecker`・`kronecker_product_rule`・`kronecker_multilinear`・`kronecker_transpose`）を形式化したファイルは旧フォルダに無い（`Representation.lean` は全章の土台なので動かさない）。
  - 部「数学的道具立て」のまとまり「有限行列・Pauli行列・交換子」（済み）: 旧 `Part000/Claim046_CommutatorViaAnticommutators`（`commutator_via_anticommutators`）・
    `Part002/Lemma001_ScalarIdentityCommutes`（`scalar_identity_commutes`）・`Part002/Lemma003_CentralizerIsScalar`（`centralizer_is_scalar`）を
    `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/` へ番号を外した名前（`ClaimCommutatorViaAnticommutators`・`LemmaScalarIdentityCommutes`・`LemmaCentralizerIsScalar`）で移した。
    3 本とも形式化している人手の項目はこのまとまりの 1 項目だけである。`Part002/` は無くなった。
    このまとまりの `pauli_matrix_products` に当たる定理は `PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`、
    `tensor_anticommutation_from_single_site` と同じ主張の `siteProd_anticomm_of_single_site` は `EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean` にある。
    どちらのファイルも冒頭が宣言する人手の項目は章の項目だけなので、runbook の数え方（冒頭の宣言で数える）で今の置き場のままにした。
  - 部「数学的道具立て」のまとまり「数ベクトル・行列の長さと収束」: 形式化したファイルは無い（`def_matrix_norm` は `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReduction.lean` が説明で触れるだけで、ほかの 5 項目はどのファイルにも出ない）。
  - 部「数学的道具立て」のまとまり「行列指数関数と交換子計算」（済み）: 旧 `Part004/ClaimExpOfDiagonalMatrix`（`exp_of_diagonal_matrix` だけを形式化）を
    `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfDiagonalMatrix.lean` へ移した（必要十分版は `NecSuf/ExpDiagonal.lean` のまま）。
    このまとまりの `ad_binomial`・`matrix_exp_conjugation` は `EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`・`ClaimNestedCommutator.lean` が参照するだけで（前の章で判断したとおり、`ClaimExpConjugation` が形式化するのは章の `exp_X_Y_exp_-X`）、
    `theorem_exp_product`・`def_exp` は章のファイルが根拠として引くだけである。ほかの項目を形式化したファイルは旧フォルダに無い。
  - 部「数学的道具立て」のまとまり「可逆行列・線型写像との対応・共役変換」（済み）: 旧 `Part000/Claim045_ConjugationIsRingHom`（と `FromNecSuf`。`conjugation_is_ring_homomorphism` だけを形式化）と
    旧 `Part008/Definition016_TV` を `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/` へ番号を外した名前（`ClaimConjugationIsRingHom`・`ClaimConjugationIsRingHomFromNecSuf`・`DefinitionTgAndTV`）で移した。`Part000/` は無くなった。
    `DefinitionTgAndTV` が形式化する人手の項目は、このまとまりの `def_T_g`（`TConj`）・`linearity_of_T`（`TConj_linear`）の 2 項と、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した
    整数運動量の経路の `def_T_V`（`TV`）・`T_V_hatZ_hatY`（仮定つき版 `TV_hatZ_hatY_of_action`）の 2 項である（`ホロノミック量子場_p142下段_1` は仮定に取るだけ、`def_A_theta` は `DefinitionThetaGamma` の定義を使うだけで数えない）。
    整数運動量の 2 項を数えなければ数学的道具立てだけ、`RoutesNotAdopted/IntegerMomentum/` の置き場として数えれば 2 対 2 の同数で、どちらでも数学的道具立てを先とする規則でこのまとまりへ置いた。のちに仮定つき版 `TV_hatZ_hatY_of_action` を `RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean` へ移したので（ゴールラインの確認の十個目）、いまの `DefinitionTgAndTV` は 2 対 1 で数学的道具立ての項目が多い。
    このまとまりのほかの項目（`def_ad_X_matrix`・`def_end_iso`・`end_is_algebra_isomorphism`・`end_preserves_matrix_exponential`・`end_acts_on_kronecker_products`・`def_invertible_elements_of_R`）を冒頭で宣言するファイルは旧フォルダに無い
    （`def_ad_X_matrix` は `EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean` が参照として触れるだけ）。

  - 部「数学的道具立て」のまとまり「トレース・共役転置・正定値性」（済み）: 旧 `Part009/Definition001_Trace`・`Part009/Claim013_PositiveDefinite`・`Part011/Claim005_PsdCauchySchwarz` と補助の `Part011/Basic` を
    `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/` へ番号を外した名前（`DefinitionTrace`・`ClaimPositiveDefinite`・`ClaimPsdCauchySchwarz`、補助は中身から `RealMatrixBilinearFormAndNorm`）で移した。`Part011/` に残るのは `Claim010_SectorDecomposition`（(−) セクターの記録）だけである。
    `DefinitionTrace` はこのまとまりの `def_trace`・`trace_basic_properties`・`trace_of_idempotent` の 3 項だけを形式化している。
    `ClaimPositiveDefinite` が冒頭で宣言する項目は、このまとまりの `def_hermitian_positive_definite`・`star_preserves_norm_and_limits`（(1) だけ）・`exp_hermitian_is_positive_definite` の 3 項、
    「V^{(+)} の固有値」の章の `iH_is_real_symmetric` 1 項、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路の `V_is_positive_definite`（`Vmat_posDef`・`trace_Vmat_pos`）1 項である。
    前の 2 項は mathlib の定義・補題を使うと書くだけで独自の定義・定理を持たないので、定義・定理を持つ項だけで数えるとこのまとまり 1 項・章 1 項・整数運動量の経路 1 項になる。
    どちらで数えても、同数のときは数学的道具立てを先とする規則でこのまとまりへ置く。
    `ClaimPsdCauchySchwarz` は `psd_cauchy_schwarz` だけを形式化している。補助の `Basic` を import するのは `ClaimPsdCauchySchwarz` と `NecSuf/PermMatrix`（置き場に数えない）なので、このまとまりへ置いた。
    `check-no-sorry.sh` では 4 本と必要十分版 `NecSuf/PsdCauchySchwarz.lean` の対象をこのまとまりの区切りへ移した。
    このまとまりのほかの項目（`def_frobenius_inner_product`・`frobenius_inner_product_axioms`）を形式化したファイルは無い。

  - 部「数学的道具立て」のまとまり「三角関数の評価・有限和・積分」（済み）: 旧 `Part012/Theorem004_RiemannSumToIntegral`・`Part020/Claim008_ElementarySineBounds`・`Part020/Claim009_ClosedFormLogIntegral`・`Part020/Claim010_SineIntegralTwoSided` を
    `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/` へ番号を外した名前（`TheoremRiemannSumToIntegral`・`ClaimElementarySineBounds`・`ClaimClosedFormLogIntegral`・`ClaimSineIntegralTwoSided`）で移した。`Part012/`・`Part020/` は無くなった。
    4 本が冒頭で宣言する人手の項目は、このまとまりの `riemann_sum_to_integral`・`elementary_sine_bounds`・`closed_form_log_integral`・`sine_integral_two_sided` の 1 項ずつである。
    `TheoremRiemannSumToIntegral` の `tagPoint` は人手 `riemann_sum_to_integral` の主張の中で定める代表点で、集合 `Θ^{(δ)}_M` を定める `def_Theta_delta_M` の形式化としては数えない
    （数えても「V^{(+)} の固有値」の章 1 項との同数で、数学的道具立てを先とする規則により置き場は同じ）。
    `check-no-sorry.sh` では 4 本の具体版の対象をこのまとまりの区切りへ移した（必要十分版 `NecSuf/RiemannSum.lean`・`LogDivergentIntegral.lean`・`HyperbolicBounds.lean` の対象は元の区切りのまま）。
    これで部「数学的道具立て」の項目を形式化したファイルはすべて `MathematicalTools/` にある。

  - 本文から退避した整数運動量の経路（済み）: 19 ファイルを `Ising2D/RoutesNotAdopted/IntegerMomentum/` へ番号を外し中身の分かる名前で移した。
    旧 `Part004/` の `hat(Z), hat(Y)` の 6 本（`DefinitionHatZHatY`・`ClaimH1H2ViaHatZHatY`・`ClaimHatZHatYPeriodicity`（と `FromNecSuf`）・`ClaimRecoverZYFromHatZHatY`（と `FromNecSuf`））、
    旧 `Part007/` の 2 本（`ClaimAnticommutatorHatZHatY` と `FromNecSuf`）、旧 `Part008/` の 5 本（`ClaimCommutatorHAndHatZHatY`・`ClaimTVActionsOnHatZHatY`・
    `ClaimEigenvectorsAndDiagonalizationOfATheta`・`DefinitionFermiPsi`・`ClaimAnticommutatorPsiFromNecSuf`）、旧 `Part009/` の 5 本（`DefinitionNumberOperator`・`ClaimJointEigenspaceDecomposition`・
    `ClaimEigenvaluesAndTraceOfVprime`・`ClaimDirectSumAndDiagonalizationOfV`・`ClaimConstantCAndEigenvaluesOfV`）、旧 `Part013/Claim001_WhyMinusOnly`（`ClaimWhyIntegerMomentumOnlyMinusSector`）である。
    19 本とも、冒頭が宣言する人手の項目はすべて参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した項目だった（`def_A_theta` は定義を使うだけで数えない）。`Part007/`・`Part008/`・`Part009/` は無くなった。
    `check-no-sorry.sh` では、これらのファイルの定理 187 件を新しい区切り「本文から参照用ノートへ退避した整数運動量の経路の形式化の記録」へ集めた（件数は変えていない）。
    本文の章のファイル 13 本（`DefinitionH1H2V1V2`・`DefinitionHalfIntegerModes`・`ClaimCommutatorHCheckZY`・`ClaimTActionsOnCheck`・`ClaimAnticommutatorCheckZY`・`DefinitionGamma1Gamma2OfThetaTilde`・
    `DefinitionCheckFermi`・`ClaimCommutationVPlusCheckPsi`・`DefinitionCheckNumberOperator`・`ClaimVPlusPositiveDefinite`・`DefinitionOpenChainAndBoundaryOperators`・`ClaimOpenChainSpinSums`・`CheckFermiInput`）が
    このフォルダのファイルを import している（共有の定義・補題を使うため。名前空間は変えていないので主張は変わらない）。runbook のゴールラインはフォルダの対応だけを求めるので、依存の切り離しは差に数えない。

  - 本文から退避した (−) セクター（済み）: 8 ファイルを `Ising2D/RoutesNotAdopted/MinusSector/` へ番号を外し中身の分かる名前で移した。
    旧 `Part010/Claim011_SectorReplacement`（`ClaimSectorReplacementOfV1`）・`Part010/Claim012_SectorDecomposition`（`ClaimPartitionFunctionSectorDecomposition`）、
    旧 `Part011/Claim010_SectorDecomposition`（`ClaimRayleighSupSectorDecomposition`）、旧 `Part004/OddEigenvectors`（`DefinitionOddEigenvectors`）、
    旧 `Part019/` の 4 本（`ClaimEpsilonIsSignFlipPermutation`・`ClaimAbsVectorMovesToEvenSector`・`TheoremCMinusLeCPlus`・`TheoremCEqualsCPlus`）である。
    8 本とも、冒頭が宣言する人手の項目（`sector_replacement_of_V1`・`sector_replacement_pow`・`partition_function_sector_decomposition`・`sector_decomposition_of_rayleigh_sup`・
    `def_odd_eigenvectors_of_epsilon`・`odd_eigenspace_is_complex_subspace`・`epsilon_is_sign_flip_permutation`・`abs_vector_moves_to_even_sector`・`c_minus_le_c_plus`・`c_equals_c_plus`）は
    すべて参照用ノート `minus_sector_not_adopted.ts` へ退避した項目で、棚卸しには無い。`Part010/`・`Part011/`・`Part019/` は無くなった。
    `check-no-sorry.sh` では、これらのファイルの定理を新しい区切り「本文から参照用ノートへ退避した (−) セクターの形式化の記録」へ集めた
    （同じ定理が 2 か所に書かれていた `sector_replacement_pow`・`partition_function_sector_decomposition` は 1 行にした。対象の集合は変えていない）。
    本文の章のファイルでこのフォルダを import するものは無い（import するのは必要十分版 `NecSuf/PermSector.lean` だけ）。

  - 本文から退避した、どの章のゴールの主張からも使われない主張（済み）: 3 ファイルを `Ising2D/RoutesNotAdopted/ClaimsUnusedByChapterGoals/` へ番号を外し中身の分かる名前で移した。
    runbook の項目 7 の置き場の規則に、参照用ノート `claims_unused_by_chapter_goals_not_adopted.ts` の項目の置き場としてこのフォルダを足した。
    旧 `Part004/ClaimEpsilonActionEigenvalues`（と `FromNecSuf`。`epsilon_action_eigenvalues_are_signs`）、旧 `Part013/Claim007_H1H2ViaCheck`（`ClaimH1H2ViaCheckZY`。`H1_H2_via_check_Z_Y`）である。
    3 本とも、冒頭が宣言する人手の項目はそのノートへ退避した項目で、棚卸しには無い。`Part004/`・`Part013/` は無くなり、**旧番号のフォルダ（`Part000`〜`Part020`）は残っていない。**
    `check-no-sorry.sh` では、これらのファイルの定理 6 件（必要十分版 `NecSuf/InvolutionEigenvalue.lean` の 1 件を含む）を新しい区切りへ集めた（対象の集合は変えていない）。
    本文の章のファイル `EigenvalueProblem/ReductionToATheta/ClaimCommutatorHCheckZY.lean`（人手 `commutator_of_H_and_check_Z_Y`）が `ClaimH1H2ViaCheckZY` を import し、
    `H1Plus_eq_check_sum`・`H2_eq_check_sum`（退避した `H1_H2_via_check_Z_Y`）を使って証明している。人手の証明はサイトごとの交換関係（Step 1）から出しており、退避した主張を使わない。
    フォルダの対応の差ではないが、ゴールラインの「通しの証明の各段は人手証明と 1 対 1」に関わるので、次の一歩で確かめる。

  - ゴールラインの確認の一つ目（済み、2026-10-31）: 通しの定理 `Ising2D.onsager_exact_solution_end_to_end` が推移的に使う定数のうち、`Ising2D.RoutesNotAdopted.*` のモジュールで
    宣言されたものを、Lean のメタプログラム（定数の `getUsedConstants` を辿り、宣言モジュールが `Ising2D.RoutesNotAdopted` で始まるものを列挙）で洗い出した。
    `ClaimCommutatorHCheckZY.lean`（人手 `commutator_of_H_and_check_Z_Y`）は退避した `H1_H2_via_check_Z_Y` の形式化（`H1Plus_eq_check_sum`・`H2_eq_check_sum`）を使っていたので、
    人手の Step 1〜4 どおりに書き直した（サイトごとの交換関係 `lie_H2_Z`・`lie_H2_Y`・`lie_H1Plus_Z`・`lie_H1Plus_Y`、反周期的な延長 `Yflat`・`Zflat`、境界の二項の等式）。
    (A)〜(D) の 4 定理の主張の型は変えていない。`RoutesNotAdopted/` の import は無くなった。レビューで指摘なしになるまで直した。
    書き直した後、`RoutesNotAdopted/ClaimsUnusedByChapterGoals/` への依存は 0 である。残る依存は `RoutesNotAdopted/IntegerMomentum/` の次の 31 定数（補題・補助定義）で、
    本文の章のファイルが共有の補題として import して使っている:
    `ClaimAnticommutatorHatZHatY` の `acomm_Y_Y_clifford`・`acomm_Z_Z_clifford`・`acomm_sum_smul_clifford`・`acomm_sum_smul_zero`、
    `ClaimCommutatorHAndHatZHatY` の `firstSite`・`lastSite`、
    `ClaimConstantCAndEigenvaluesOfV` の `VmatInv`・`VmatInv_mul_Vmat`・`Vmat_eq_smul`・`matExp_neg_mul`・`tauTrace`・`trace_Vmat`・`trace_VmatInv`・`trace_exp_neg_eq_tau`、
    `ClaimEigenvectorsAndDiagonalizationOfATheta` の `AMat_mulVec_eigen`・`det_AMat`・`det_AMat_eq_one`・`gamma2_mul_gamma2_neg`、
    `ClaimH1H2ViaHatZHatY` の `H1`（`H1plus` の定義の展開）、
    `ClaimTVActionsOnHatZHatY` の `B1mat_eq_twoDimConjMat`・`B2mat_eq_twoDimConjMat`・`actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits`、
    `DefinitionFermiPsi` の `sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`、`DefinitionNumberOperator` の `tensorPow_two_torsion_free`（`.eq_1` は数えていない）。
    `commutator_of_H_and_check_Z_Y` の必要十分版は未作成である（既存の `NecSuf/CommutatorClifford.lean` は退避した別経路の一般化で、新しい具体版の手順と対応しない）。

  - ゴールラインの確認の二つ目（済み、2026-10-31）: 上の定数のうち `ClaimAnticommutatorHatZHatY` の 4 定数を判定した。
    `acomm_sum_smul_clifford`・`acomm_sum_smul_zero` は経路に依らない汎用補題で、本文 `ClaimAnticommutatorCheckZY.lean`（人手 `anticommutator_of_check_Z_Y`）は
    人手の 3 行（双線型性・`anticommutator_of_Z_and_Y`・`δ^M_{(j,k)} = 1 ⟺ j = k`）を束ねてこれで済ませていた。第 1〜3 式の証明を人手の式変形と 1 行ずつ対応する `calc` に書き直し
    （`δ` が `j = k` の項だけを残す行は新しい補題 `sum_sum_smul_two_deltaM_smul_one`）、この 2 補題を使わないようにした。
    `acomm_Z_Z_clifford`・`acomm_Y_Y_clifford` は `anticommutator_of_Z_and_Y` の言い換えなので、その形式化 `EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean` へ移した（主張・証明は不変）。
    主張の型は変えていない。レビューで指摘なしになるまで直した。通しの定理から `ClaimAnticommutatorHatZHatY` への依存は 0 になった（同じメタプログラムで確かめた）。
    残る `RoutesNotAdopted/IntegerMomentum/` への依存は 23 定数（ほかに非公開の補助 `neg_mul_V1pmHalf`）である。前回「31」と書いた数は数え違いで、ファイルごとの内訳どおりに数えると 27 だった。
    `ClaimAnticommutatorCheckZY.lean` は推移的にはまだ `RoutesNotAdopted/` を import している（`ReductionToATheta/DefinitionHalfIntegerModes.lean` が `ClaimH1H2ViaHatZHatY` を、
    `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean` が `DefinitionHatZHatY` を直接 import する）。

  - ゴールラインの確認の三つ目（済み、2026-10-31）: `ClaimCommutatorHAndHatZHatY` の `firstSite`・`lastSite` を判定した。人手のサイト添字 `1`・`M_col` を `Fin M` の `0`・`M-1` で表すだけの補助定義で、
    整数運動量の経路の主張には依らない（使うのは本文の `def_D0_open_chain_operator`・`def_G_boundary_operator` の形式化など）。
    巡回添字 `nextSite` と同じ `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean` の節「site 添字の巡回と端点」へ移した（名前空間・定義は不変）。
    本文の `EigenvectorOfMaxEigenvalue/DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimOpenChainSpinSums.lean` から `ClaimCommutatorHAndHatZHatY` の import を外した。レビューで指摘なし。
    同じメタプログラムで数え直すと、通しの定理が使う `RoutesNotAdopted/IntegerMomentum/` の公開の定数は次の 20 個（ほかに非公開の補助 `neg_mul_V1pmHalf`）で、`ClaimH1H2ViaHatZHatY` の `H1` はもう使われていない:
    `ClaimConstantCAndEigenvaluesOfV` の 8 個（`VmatInv`・`VmatInv_mul_Vmat`・`Vmat_eq_smul`・`matExp_neg_mul`・`tauTrace`・`trace_Vmat`・`trace_VmatInv`・`trace_exp_neg_eq_tau`）、
    `ClaimEigenvectorsAndDiagonalizationOfATheta` の 4 個、`ClaimTVActionsOnHatZHatY` の 4 個、`DefinitionFermiPsi` の 3 個、`DefinitionNumberOperator` の `tensorPow_two_torsion_free`。
    本文の章のファイルで `RoutesNotAdopted/` を直接 import するのは次の 9 本である: `ReductionToATheta/ClaimTActionsOnCheck`・`ReductionToATheta/DefinitionHalfIntegerModes`・
    `EigenvaluesOfVPlus/DefinitionCheckNumberOperator`・`EigenvaluesOfVPlus/ClaimVPlusPositiveDefinite`・`DiagonalizationAndExponentialForm/DefinitionGamma1Gamma2OfThetaTilde`・
    `DiagonalizationAndExponentialForm/ClaimCommutationVPlusCheckPsi`・`DiagonalizationAndExponentialForm/DefinitionCheckFermi`・`EigenvectorOfMaxEigenvalue/CheckFermiInput`・
    `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`（`DefinitionHatZHatY` を import）。

  - ゴールラインの確認の四つ目（済み、2026-10-31）: `ClaimConstantCAndEigenvaluesOfV` の 8 定数（`VmatInv`・`VmatInv_mul_Vmat`・`Vmat_eq_smul`・`matExp_neg_mul`・`tauTrace`・`trace_Vmat`・`trace_VmatInv`・`trace_exp_neg_eq_tau`）と非公開の `neg_mul_V1pmHalf` を判定した。
    どれも整数運動量の `V`（符号 `η` を引数に持つ一般形）の逆と `τ` の補題で、本文の `EigenvaluesOfVPlus/ClaimVPlusPositiveDefinite.lean`・`ClaimConstantCEvenSector.lean` は `η = -1` を代入して借りていた。
    人手 `V_plus_is_positive_definite`（statement の表示 `VPlus_eq_smul` と Step 2〜3 の `VPlus_posDef`）・`V_plus_is_invertible`（`R^{(+)}` を係数 `(2s_2)^{-M/2}` のまま `VPlusInv` とし、Step 1 の 4 つの左右逆・Step 2〜3 の `calc`、`a^{-1} = (2s_2)^{-M/2}` は `rpow_neg_half_M_eq_inv`）・
    `constant_c_value_even_sector` の Step 1〜2（`tauPlus`・`trace_VPlus`・`trace_expNegS1plus_expNegS2_eq_tauPlus`・`trace_VPlusInv`）を `S_1^{(+)}` について人手の式変形どおりに書き直した。
    `VPlus_posDef` は整数運動量の `V_is_positive_definite` の形式化 `Vmat_posDef` の系だったので、同じく人手の Step どおりに直し、`VPlus_eq_Vmat`・`star_neg_one` を消した。
    `trace_VPlusInv` の主張は人手どおり `(2s_2)^{-M/2} τ` にし、必要十分版 `NecSuf.const_eq_of_trace_ratio` へ渡すところで `a^{-1}` へ直す（`constant_c_value_even_sector` の主張の型は不変）。
    `ClaimVPlusPositiveDefinite.lean` から `RoutesNotAdopted/` の import を外した。本文の章のファイルで `RoutesNotAdopted/` を直接 import するのは残り 8 本である。レビューで指摘なしになるまで直した。
    同じメタプログラムで数え直すと、通しの定理が使う `RoutesNotAdopted/IntegerMomentum/` の公開の定数は次の 12 個である:
    `ClaimEigenvectorsAndDiagonalizationOfATheta` の 4 個（`AMat_mulVec_eigen`・`det_AMat`・`det_AMat_eq_one`・`gamma2_mul_gamma2_neg`）、`ClaimTVActionsOnHatZHatY` の 4 個（`B1mat_eq_twoDimConjMat`・`B2mat_eq_twoDimConjMat`・`actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits`）、
    `DefinitionFermiPsi` の 3 個（`sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`）、`DefinitionNumberOperator` の `tensorPow_two_torsion_free`
    （ほかに `lastSite.eq_1`・`H1.eq_1` の等式補題が退避先のモジュールに数えられるが、定義の本体は本文側にあり、等式補題が最初に使われたモジュールへ置かれるためである）。
    レビューで、`constant_c_value_even_sector` Step 2 の行「`U exp(S) U^{-1} = exp(U S U^{-1})`」の `Uflip_conj_matExp`（`EigenvaluesOfVPlus/ClaimSignFlipConjugation.lean`）が
    `matExp_units_conj`（`Representation.lean`）すなわち mathlib の `Matrix.exp_units_conj` に委ねていることが分かった。人手は行列ノルムの劣乗法性・`US^kU^{-1} = (USU^{-1})^k`・`def_exp` から導いている。
    この 8 定数の外の既存の補題なので、下の「この後に残る確認」に載せた。それまでこの 2 ファイルは、この 1 行について人手証明と 1 対 1 になっていない。

  - ゴールラインの確認の五つ目（済み、2026-10-31）: `ClaimEigenvectorsAndDiagonalizationOfATheta` の 4 定数（`AMat_mulVec_eigen`・`det_AMat`・`det_AMat_eq_one`・`gamma2_mul_gamma2_neg`）を判定した。
    どれも整数運動量の `A(θ_μ)` の固有ベクトル・行列式の補題（任意の実数 `θ` の形）で、本文の `DiagonalizationAndExponentialForm/ClaimEigenATildeDiag.lean`・`ClaimDetATilde.lean`・`ClaimCommutationVPlusCheckPsi.lean` が `θ := θ~_μ` を代入して借りていた。
    人手 `eigenvector_of_A_theta_tilde`（Step 1 の準備の恒等式と `det(A(θ)-λI)` の鎖 `charPoly_factor_thetaTilde`、Step 2 の成分ごとの鎖 `AMat_mulVec_eigen_pos`・`_neg`、`v_± ≠ 0`・`c` 倍）、
    `diagonalization_check_P_D`（Step 2 の `cb = 1/(2√M)` と列ごとの `A P̌ = P̌ Ď`、Step 3 の `det P̌` の鎖、Step 4 の右乗の鎖）、
    `det_A_theta_tilde`（Step 1 の `det_AMat_eq_gamma1_sq_add`、Step 2 の `exp(iθ)exp(-iθ) = 1` と実部表示、Step 3〜5 の展開と (iii) による `c_2` の消去、Step 6 と最後の `γ_1^2 = 1 + r^2`）を人手の式変形どおりに書き直した。
    `ClaimCommutationVPlusCheckPsi.lean` は `AMat_mulVec_eigen` の代わりに `eigenvector_of_A_theta_tilde` Step 2 の形式化を使うようにした。
    主張の型は、`charPoly_factor_thetaTilde` を人手 Step 1 の形（多項式の等式から `det(A(θ)-λI)` の等式）にした以外は変えていない。整数運動量の `Pmat` を経由していた `checkT`・`checkT_sq`・`checkPmat_eq_Pmat`・`checkDmat_eq_Dmat` は消した。
    `ClaimCommutationVPlusCheckPsi.lean`・`DefinitionGamma1Gamma2OfThetaTilde.lean`（使っていなかった）から `RoutesNotAdopted/` の import を外した。本文の章のファイルで `RoutesNotAdopted/` を直接 import するのは残り 6 本である
    （`ReductionToATheta/ClaimTActionsOnCheck`・`ReductionToATheta/DefinitionHalfIntegerModes`・`DiagonalizationAndExponentialForm/DefinitionCheckFermi`・`EigenvaluesOfVPlus/DefinitionCheckNumberOperator`・`EigenvectorOfMaxEigenvalue/CheckFermiInput`・`PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`）。
    レビューで指摘なしになるまで直した。同じメタプログラムで数え直すと、通しの定理が使う `RoutesNotAdopted/IntegerMomentum/` の公開の定数は次の 8 個である:
    `ClaimTVActionsOnHatZHatY` の 4 個（`B1mat_eq_twoDimConjMat`・`B2mat_eq_twoDimConjMat`・`actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits`）、`DefinitionFermiPsi` の 3 個（`sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`）、`DefinitionNumberOperator` の `tensorPow_two_torsion_free`
    （ほかに `lastSite.eq_1`・`H1.eq_1` の等式補題と `sqrtM` の等式補題・simp 補題が退避先のモジュールに数えられる）。
    レビューで分かった、今回の差分より前からある差は下の「この後に残る確認」に載せた。

  - ゴールラインの確認の六つ目（済み、2026-10-31）: `ClaimTVActionsOnHatZHatY` の 4 定数（`B1mat_eq_twoDimConjMat`・`B2mat_eq_twoDimConjMat`・`actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits`）を判定した。
    4 つとも運動量の取り方に依らない補題で、本文の `ReductionToATheta/ClaimTActionsOnCheck.lean` は、人手 `calc_of_TxT_check_Z_Y` の 2 式をこれらで必要十分版から直接出し、そこから `T_actions_on_check_Z_Y` の 4 式を読み取っていた（人手と逆の向き）。
    人手どおり、4 式を `def_T_g` → `def_V1_plus_square_root`（`V_2` は `V2_exponential_representation` と `V_2^{-1}` の表示、前因子を打ち消す 2 行 `smul_conj_smul_inv_eq`）→ `exp(X)^{-1} = exp(-X)` → `exp_X_Y_exp_-X` → `extract_taylor_coefficient_of_check_Z_Y` の `calc` で示し、
    `calc_of_TxT_check_Z_Y` はその 4 式を 2 列に並べて `def_B1_theta_B2` の成分と突き合わせるようにした。人手の `V_2` で述べた `actsBy_TConj_V2_check` を足した。主張の型は変えていない。
    4 定数と、必要十分版 `NecSuf.exp_conj_two_dim_actsBy` の特殊化としての導出（`actsBy_TConj_V1plusHalf_fromNecSuf`・`actsBy_TConj_V2H2Form_check_fromNecSuf`）は新しいファイル `ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean` へ置き、退避先はそこから使う。
    本文 `ReductionToATheta/ClaimTVPlusAction.lean` の末尾にあった整数運動量版の比較定理 `TV_hatZ_hatY_via_sandwich` は退避先 `ClaimTVActionsOnHatZHatY.lean` へ移した。`ClaimTActionsOnCheck.lean` から `RoutesNotAdopted/` の import を外した。
    レビューで指摘なしになるまで直した。同じメタプログラムで数え直すと、通しの定理が使う `RoutesNotAdopted/IntegerMomentum/` の公開の定数は次の 4 個である:
    `DefinitionFermiPsi` の 3 個（`sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`）、`DefinitionNumberOperator` の `tensorPow_two_torsion_free`（ほかに `lastSite.eq_1`・`H1.eq_1` と `sqrtM` の等式補題・simp 補題）。
    本文の章のファイルで `RoutesNotAdopted/` を直接 import するのは残り 5 本である（`ReductionToATheta/DefinitionHalfIntegerModes`・`DiagonalizationAndExponentialForm/DefinitionCheckFermi`・`EigenvaluesOfVPlus/DefinitionCheckNumberOperator`・`EigenvectorOfMaxEigenvalue/CheckFermiInput`・`PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`）。

  - ゴールラインの確認の七つ目（済み、2026-10-31）: `DefinitionFermiPsi` の 3 定数（`sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`）を判定した。`√M`（`M ∈ ℕ`）を ℂ の元として置くだけの、運動量の取り方に依らない補助で、
    本文では人手 `def_check_fermi` の係数 `-r/(2√M b)`・`1/(2√M)` の分母に使う。定義・主張・証明を変えずに本文 `DiagonalizationAndExponentialForm/DefinitionCheckFermi.lean` の `checkP`・`checkQ` の直前へ移し、退避先はそこから使うようにした。
    `DefinitionCheckFermi.lean` から `RoutesNotAdopted/` の import を外し、それまで退避先を通して届いていた `gamma1`・`gamma2`（`ReductionToATheta/DefinitionThetaGamma`）と、`ClaimCommutationVPlusCheckPsi.lean` が使う `ActsBy`（数学的道具立て `DefinitionTgAndTV`）を直接 import した。
    `check-no-sorry.sh` の対象 3 件を本文の `ψ̌` の区切りへ移した（対象の数は 1628 件のまま）。レビューで指摘なし。
    同じメタプログラムで数え直すと、通しの定理が使う `RoutesNotAdopted/IntegerMomentum/` の公開の定数は `DefinitionNumberOperator` の `tensorPow_two_torsion_free` 1 個である（ほかに `lastSite.eq_1`・`H1.eq_1` の等式補題）。
    本文の章のファイルで `RoutesNotAdopted/` を直接 import するのは残り 4 本である（`ReductionToATheta/DefinitionHalfIntegerModes`・`EigenvaluesOfVPlus/DefinitionCheckNumberOperator`・`EigenvectorOfMaxEigenvalue/CheckFermiInput`・`PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`）。
    `DefinitionCheckFermi.lean` は `ClaimRecoverZYFromCheckZY` を通して、間接にはまだ `DefinitionHatZHatY`・`ClaimH1H2ViaHatZHatY` を読み込む。直接の 4 本を外せば、間接の読み込みも消える見込みだが、消えたかは外した後に推移的な import で確かめる。

  - ゴールラインの確認の八つ目（済み、2026-10-31）: `DefinitionNumberOperator` の `tensorPow_two_torsion_free`（`Mat(2^M, ℂ)` で `x + x = 0 → x = 0`）を判定した。運動量の取り方に依らない補題で、
    本文では人手 `check_number_operator_idempotent` (1) の「`2 ≠ 0` なので両辺を 2 で割る」に当たる。本文 `EigenvaluesOfVPlus/DefinitionCheckNumberOperator.lean` の `CheckFermiSetup` の直前へ移し、
    証明を人手の鎖 `x = ½·2x = ½·(x+x) = ½·0 = 0` の `calc` に書き直した（主張の型は同じ）。退避先はそこから使う。
    `DefinitionCheckNumberOperator.lean`・`EigenvectorOfMaxEigenvalue/CheckFermiInput.lean` から `RoutesNotAdopted/` の import を外し、それまで退避先を通して届いていた
    `NecSuf.NumberOperator`・`NecSuf.JointEigenspace`・数学的道具立て `DefinitionTrace` を直接 import した（`ClaimTraceCheckNumberOperatorProduct.lean` にも `DefinitionTrace` を足した）。
    `check-no-sorry.sh` の対象を本文の `ň_μ` の区切りへ移し、`lean/docs/ch017-formalization.md` に行を足した。レビューで指摘 2 件（コメントの記述）を直し、指摘なしになった。
    通しの定理が推移的に使う定数を Lean のメタプログラムで数え直すと、`RoutesNotAdopted/` のモジュールで宣言された定数は 0 個である（等式補題を含む）。
    本文の章のファイル（と必要十分版）で `RoutesNotAdopted/` を直接 import するのは残り 3 本である（`ReductionToATheta/DefinitionHalfIntegerModes`（`ClaimH1H2ViaHatZHatY`）・
    `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`（`DefinitionHatZHatY`）・`NecSuf/PermSector`（`MinusSector/ClaimRayleighSupSectorDecomposition`））。

  - ゴールラインの確認の九つ目（済み、2026-10-31）: `ReductionToATheta/DefinitionHalfIntegerModes.lean` から退避先 `ClaimH1H2ViaHatZHatY` の import を外した。
    外して落ちた名前は `Z`・`Y`（本文 `DefinitionTransferMatrixSymbols` を直接 import した）と `expPhase_congr` である。`expPhase_congr` を使っていたのは合同形の補題
    `checkPhase_congr`・`checkZ_congr`・`checkY_congr` だけで、これらに対応する人手の項目は無く、使っていたのは人手 `conjugate_index_of_check_Z_Y` (3) の
    `checkZ_conj`・`checkY_conj` だけだった。人手 (3) は添字を `(1-μ)+M` と書き直して `half_integer_checkZ_periodicity`・`half_integer_checkY_periodicity` を
    添字 `1-μ` に当てるので、その 2 行どおりの `calc` に直し（主張の型は同じ）、合同形の 3 補題を消した（`check-no-sorry.sh` の対象と `lean/docs/ch013-formalization.md` の行も直した）。
    間接に読み込んでいた `DefinitionH1H2V1V2` は、使っている本文の 3 本（`DefinitionCheckVprime`・`ClaimTraceCheckVprime`・`ClaimCommutatorHCheckZY`）に直接 import させ、
    退避先の記録 `ClaimsUnusedByChapterGoals/ClaimH1H2ViaCheckZY` には退避先 `ClaimH1H2ViaHatZHatY` を import させた。レビューは指摘なし。
    本文の章のファイルと必要十分版で `RoutesNotAdopted/` を直接 import するのは残り 2 本（`PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2`（`DefinitionHatZHatY`）・
    `NecSuf/PermSector`（`MinusSector/ClaimRayleighSupSectorDecomposition`））である。`DefinitionH1H2V1V2` は本文の多くが import するので、推移的にはまだ本文が退避先を読み込む。

  - ゴールラインの確認の十個目（済み、2026-10-31）: `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean` から退避先 `DefinitionHatZHatY` の import を外し、
    本文 `DefinitionTransferMatrixSymbols`（`Z`・`Y` の定義）を直接 import した。外して落ちたのは 3 本である。
    数学的道具立て `DefinitionTgAndTV.lean` は、整数運動量の `hat(Z)^{(-)}, hat(Y)` を主張に持つ仮定つき版 `TV_hatZ_hatY_of_action`・`TV_hatZ_hatY_of_action'` だけが退避先の量を使っていたので、
    この 2 定理を主張・証明を変えずに退避先 `RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`（無条件版 `TV_hatZ_hatY` の直前）へ移した。
    本文 `EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean` には `siteProd_smul_family` の置き場 `ReductionToATheta/ClaimAnticommutatorZY` を、
    退避先 `ClaimH1H2ViaHatZHatY.lean` には `DefinitionHatZHatY` を直接 import させた。`check-no-sorry.sh` の対象 2 件を整数運動量の経路の区切りへ移し、`lean/README.md` の行に置き場を書いた。
    レビューの指摘 4 件（コメントの時制・記述の過不足、状態台帳の置き場の数え）を直し、指摘なしになった。
    import のグラフを辿ると、`RoutesNotAdopted/` を推移的に読み込む本文・必要十分版のファイルは `NecSuf/PermSector`（`MinusSector/ClaimRayleighSupSectorDecomposition` を直接 import）の 1 本だけである。
  - ゴールラインの確認の十一個目（済み、2026-11-01）: 必要十分版 `NecSuf/PermSector.lean` から退避先 `MinusSector/ClaimRayleighSupSectorDecomposition` の import は外せないと判定し、残した。
    退避先から届く名前は、(−) セクターの定義（符号つきの `𝓡_±`・`c_±(M)`。`sectorSet`・`sectorRayleighSup`）、その補題 `sectorSet_bddAbove`・`sector_smul`、
    退避した主張 `sector_decomposition_of_rayleigh_sup`（`c(M) = max(c_+, c_-)`）と、本文の `rayleighSup` である。
    `c_-(M)` を含む主張は本文の名前へ置き換えられない。`sector_smul` は (−) セクター固有の `sectorSet_nonempty_of_mem` だけが使う。`rayleighSup` は直接 import すれば足りる。
    退避先へ `PermSector` を移す案は、runbook の「必要十分版は `Ising2D/NecSuf/` から動かさない」と、`lean/README.md` の (−) セクターの記録の一覧（`NecSuf/PermSector.lean` を含める）に反するので採らない。
    整数運動量の経路の必要十分版（`NecSuf/DiscreteFourier.lean` など）が `NecSuf/` に残っているのと同じ扱いである。理由を `PermSector` の冒頭の「必要十分版がなぜ本文と退避先の定義の上に乗っているか」の節に書いた（レビューの指摘 4 件を直した）。
    import のグラフでは、`RoutesNotAdopted/` 以外で `RoutesNotAdopted/` を推移的に読み込むファイルは `NecSuf/PermSector` だけで、それを import するのはライブラリの入口 `Ising2D.lean` を除けば `RoutesNotAdopted/MinusSector/` のファイルだけである。
    本文（`NecSuf/` と `RoutesNotAdopted/` 以外）の Lean は、推移的にも退避先を読み込まない。
  - ゴールラインの確認の十二個目（済み、2026-11-01）: 人手 `conjugate_index_of_check_Z_Y` (2) の Lean（`DiagonalizationAndExponentialForm/ClaimConjugateIndex.lean`）を人手どおりに直した。
    以前は `2M` 乗根の周期 `ξ^{2M} = 1` で示していたので、人手の 4 行（(1) `θ~_{M+1-μ} = 2π - θ~_μ` → 指数法則 `theorem_exp_product` (`n = 1`) → Euler の公式 `euler_formula_cos_sin` → `cos(2πj) = 1, sin(2πj) = 0`）と
    1 行ずつ対応する `calc` を `checkPhase_conj'`（右辺 `e^{ijθ~_μ} = checkPhase M (-j) μ`）に置き、両端は `checkPhase_eq_exp` で開いた。
    使う側の `checkPhase_conj`（右辺を `2M` 乗根の位相因子で書いた形）はその系にした。主張の型は 2 つとも変えていない。`check-no-sorry.sh` に `checkPhase_conj'` を足し、`lean/docs/ch013-formalization.md` の行を分けた。
    レビューは必須の指摘なし。任意の指摘 2 件（Euler の公式の行の向き、人手の `j` と Lean の `k`）はコメントに書いた。
  - ゴールラインの確認の十三個目（済み、2026-11-01）: 人手 `extract_taylor_coefficient_of_check_Z_Y` の 4 式の Lean（`ReductionToATheta/ClaimExtractTaylor.lean`）を人手どおりに直した。
    4 式それぞれの `HasSum` 版（`hasSum_extract_taylor_H1Plus_checkZ` ほか 4 本）を、人手の 4 行（`conversion_*_even`・`_odd` → `HasSum.even_add_odd` → `smul_const`・`mul_left` → `Complex.hasSum_cosh`・`Complex.hasSum_sinh`）どおりに置き、
    `∑'` 版 4 本はその和の値にした。`∑'` 版の名前と型は変えていない（呼び出し側 `ClaimTActionsOnCheck.lean` はそのまま）。
    既存の `NecSuf.exp_conj_two_dim_z/y` は指数共役と級数の和を束ねていたので、級数の和の部分を位相 ℂ 加群上の必要十分版 `NecSuf.hasSum_two_dim_series` として切り出し、`exp_conj_two_dim_z/y` はそれを使う形にした。
    具体版をその特殊化として導く `hasSum_extract_taylor_*_of_necSuf` 4 本を `ReductionToATheta/ClaimExtractTaylorFromNecSuf.lean` に置いた。`check-no-sorry.sh`・`lean/docs/ch014-formalization.md` を直した。
    レビューの指摘 9 件を直し、指摘が無くなった。
  - ゴールラインの確認の十四個目（済み、2026-11-01）: 章の結論 `TVPlus_checkZ_checkY`（`ReductionToATheta/ClaimTVPlusAction.lean`、人手 `T_V_plus_check_Z_Y`）を人手どおりに直した。
    以前は必要十分版 `NecSuf.actsBy_TV_sandwich` を直接呼んでいた。人手の (z)・(y) の 6 行の鎖（`def_T_V_plus` → `T_actions_on_check_Z_Y` → `linearity_of_T_V2` → `calc_of_TxT_check_Z_Y`（`B_2`）→ `linearity_of_T_on_check_Z_Y` → `calc_of_TxT_check_Z_Y`（`B_1(θ~)`））を
    `TVPlus_apply_checkZ`・`TVPlus_apply_checkY` の `calc` に 1 行ずつ置き、最後の 2 行（列が `B_1(θ~)` の列であること `B1mat_col_zero/one`・`mulVec_mulVec_col` → `factorization_of_A_thetaTilde`）で結論を出した。主張の型は変えていない。
    旧証明は必要十分版からの導出 `TVPlus_checkZ_checkY_of_necSuf`（`ReductionToATheta/ClaimTVPlusActionFromNecSuf.lean`）へ移した。
    `linearity_of_T_V1plusHalf`・`linearity_of_T_V2`・`linearity_of_T_V2H2Form` から未使用の仮定（`2 ≤ M`・`CheckIndex M μ`）を外した（強める向き。呼び出し元は無かった）。
    具体版と必要十分版の両方の冒頭に行の対応表を書き、`check-no-sorry.sh`・`lean/docs/ch014-formalization.md`・整数運動量の経路の記録のコメントを直した。レビューの指摘 4 件と軽い指摘 1 件を直した。

  - ゴールラインの確認の十五個目（済み、2026-11-01）: 人手 `nesting_of_commutator_of_H_and_check_Z`（`ReductionToATheta/ClaimNestedCommutator.lean`）と
    `cosh_sinh_coefficient_conversion_for_check`（`ReductionToATheta/ClaimCoefficientConversion.lean`）の Lean を人手どおりに直した。
    以前はどちらも、`ad X` が `span{check(Z), check(Y)}` を保つことを直接示して必要十分版 `NecSuf.adCLM_pow_*` へ渡していた（変換の方はスカラー倍した生成子を渡し、人手の補題 1・補題 2 を通らなかった）。
    入れ子交換子は、人手の帰納法の基底段階・帰納段階 1・帰納段階 2 を 4 式それぞれの `calc`（`nesting_*_step_even_to_odd`・`_step_odd_to_even`）に置き、交換子の双線型性を人手の 4 行どおり `comm_smul_smul` に置いた。
    変換は、補題 1（`ad_smul_left`・`ad_smul_right`・`adPow_smul_left`）と補題 2（`I_pow_even`・`I_pow_odd`）を置き、4 式を人手の鎖（補題 1 → 入れ子交換子の代入 → `(i/2)^n = i^n2^{-n}` → … → 補題 2 → 符号の整理）どおりの `calc` にした。
    16 本の主張の型は変えていない。必要十分版は、具体版と同じ帰納段階をたどる `NecSuf/NestedCommutatorTwoDim.lean`（`[h,z] = 2py`・`[h,y] = -2qz`・`pq = 1`、スカラーは可換環、台は引き算と積だけ）と、
    補題 1 の `NecSuf/IteratedCommutatorSmul.lean`（スカラーはモノイド）を新しく置き、導出を `ClaimNestedCommutatorFromNecSuf.lean`・`ClaimCoefficientConversionFromNecSuf.lean` に置いた。
    `adCLM_pow_*` 経路の導出は外した（`adCLM_pow_*` は `exp_conj_two_dim_*` の中で使われ続ける）。`check-no-sorry.sh`・`lean/docs/ch014-formalization.md` を直した。レビューの指摘（必須 3 件・任意 4 件）を直した。

  - ゴールラインの確認の十六個目（済み、2026-11-01）: 人手 `constant_c_value_even_sector` Step 2 の `U exp(S) U^{-1} = exp(USU^{-1})`（`EigenvaluesOfVPlus/ClaimSignFlipConjugation.lean` の `Uflip_conj_matExp`）を、`Matrix.exp_units_conj` に委ねる形から人手どおりに直した。
    `US^kU^{-1} = (USU^{-1})^k`（`Uflip_conj_pow`）→ 部分和の共役（`Uflip_conj_expPartialSum`）→ `‖U(X-W)U^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`（`matrix_norm_submultiplicativity`。値が一致する Frobenius ノルムの `Matrix.frobenius_norm_mul`）による極限との交換 → 極限の一意性、の順の証明である。主張の型は変えていない。
    `def_exp` の `matExp_hasSum` を `ClaimTraceEpsilonVPlusReduction.lean` から `Representation.lean` へ移し、使われなくなった `matExp_units_conj` と `UflipUnits` を消した。
    必要十分版 `NecSuf/ConjugationOfExpSeries.lean`（台は半環、`u` の両側の逆、`x ↦ uxv` の連続性と T2 だけ）と導出 `ClaimSignFlipConjugationFromNecSuf.lean` を置いた。
    人手 Step 2 の「共役は行列の積とスカラー倍を保ち」に、部分和の共役が使う「和」を足した。レビューの指摘（必須 3 件・任意 6 件）を直した。

  - ゴールラインの確認の十七個目（済み、2026-11-01）: 人手 `commutation_V_plus_check_psi`（`DiagonalizationAndExponentialForm/ClaimCommutationVPlusCheckPsi.lean`）の Lean を人手どおりに直した。
    以前は `P̌` の列が固有ベクトルであることを `ActsBy.eigen` へ直接渡していた。いまは、行ベクトルと `2×2` 行列の積 `rowMul`・行ベクトルへの作用 `rowApply`
    （`DefinitionTgAndTV.lean`）の上で、proof 冒頭の結合律 `rowMul_rowMul`、Step 1 の `rowApply_rowMul`、Step 2 の 9 行の鎖 `rowApply_checkPsi_row`
    （`A = P̌ĎP̌^{-1}` と `P̌^{-1}P̌ = I` を経る）、列の比較と `λ_{±,μ} = e^{±γ}` の代入、の順に示す。
    対角化の定理が `P : IsingParam` を取るので、`TVPlus_eq_TCheckVprime_on_checkZY`・`TVPlus_eq_TCheckVprime`・`VPlus_eq_smul_checkVprime` も `K : IsingConst` と `hga` の組から `P` へ替え、
    仮定 `hlamPlus`/`hlamMinus` を `λ_{±,μ} = e^{±g}` の形にした（埋める定理は `lambdaPlusR_eq_exp_gammaTildeC`・`lambdaMinusR_eq_exp_gammaTildeC`）。
    仮定を埋めた主張 `TVPlus_checkPsiDag_checkPsi`（`ClaimCheckFermiResultsUnconditional.lean`）を足した。必要十分版は置かない（理由は `lean/docs/ch016-formalization.md` の 2 節）。
    `checkPsiDag_eq_checkPmat_col`・`checkPsi_eq_checkPmat_col`・`checkR_eq_absGamma2` を `ClaimCheckFermiResultsUnconditional.lean` から交換関係のファイルへ移した。レビューの指摘（必須 2 件・任意 5 件）を直した。

  - ゴールラインの確認の十八個目（済み、2026-11-01）: 人手 `eigenvector_of_A_theta_tilde` の statement「`A(θ̃_μ)` の固有値は `λ_{±,μ}` の 2 つ」を
    `eigenvalue_AMat_iff`（`DiagonalizationAndExponentialForm/ClaimEigenATildeDiag.lean`。固有値は `A(θ)v = λv` となる `v ≠ 0` があること）として立てた。
    Step 1 の鎖「固有値 ⟺ `det(A(θ) - λI) = 0` ⟺ `λ = λ_{±,μ}`」の 1 つ目の同値は、2×2 の複素行列の成分計算 `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` で示した
    （mathlib の `Matrix.exists_mulVec_eq_zero_iff` は分数体への持ち上げを経る一般論なので使わない）。
    必要十分版 `NecSuf/TwoByTwoKernelAndDeterminant.lean`（可換環。「⇒」に零因子が無いこと、「⇐」に `1 ≠ 0`）と導出 `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf` を置いた。
    レビューの指摘（mathlib の一般論への委任、古いコメント、必要十分版の欠如、検査一覧の漏れ、`Nontrivial` の理由、対応表の行）を直した。
  - ゴールラインの確認の十九個目（済み、2026-11-01）: 人手 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`（`DiagonalizationAndExponentialForm/ClaimTVPlusEqTCheckVprimeOnCheckZY.lean`）の Lean を、
    `ψ̌^† ∓ ψ̌` の直接計算で `Ž, Y̌` を書き直す形から、人手 Step 1 の 3 行の鎖 `(Ž, Y̌) = (Ž, Y̌)(P̌P̌^{-1}) = ((Ž, Y̌)P̌)P̌^{-1} = (ψ̌^†, ψ̌)P̌^{-1}`
    （`checkZY_row_eq_rowMul_checkPmat_inv`。`det_checkPmat_ne_zero` と `rowMul_one`・`rowMul_rowMul`）と「すなわち」の 2 式、Step 2 の 2 つの鎖、Step 3 の 5 行の鎖 2 本どおりに直した。
    主張 `TVPlus_eq_TCheckVprime_on_checkZY` の型は不変。旧補題 `checkZ_eq_smul`・`checkY_eq_smul`・`checkPsiDag_sub_checkPsi`・`checkPsiDag_add_checkPsi`・`checkP_ne_zero`・`checkQ_ne_zero` は消した。
    必要十分版 `NecSuf/RowVectorRightInverse.lean`（係数は可換半環、可逆性は `G H = I` の形でだけ使う）と導出 `ClaimTVPlusEqTCheckVprimeOnCheckZYFromNecSuf.lean` を置いた。
    レビューの指摘（必要十分版の欠如、人手 proof 冒頭の線型性の段落の扱い、根拠コメント、`rowMul_one` の置き場、必要十分版の知見の言い過ぎ、`ch016-formalization.md` の古い記述、Step 1 の導出の欠け）を直した。

  - ゴールラインの確認の二十個目（済み、2026-11-01）: 人手 `eigenvector_of_A_theta_tilde` Step 1 が「固有値」を定義せず「固有値 ⟺ `det(A(θ) - λI) = 0`」を証明なしに使っていたので、
    数学的道具立て（`structured-latex/content/000_calculation_formulae_45_46.ts`、棚卸しのまとまり「有限行列・Pauli行列・交換子」）に
    `def_eigenvector`・`def_eigenvalue`・`def_det_two_by_two` と主張 `nonzero_kernel_iff_det_zero_two_by_two`（2×2 の成分計算。「⇒」2 本の鎖と `v_i ≠ 0` の `i`、「⇐」3 つの場合）を足し、
    Step 1 を定義から `det(A(θ) - λI) = 0` までの同値の鎖にした。本文の「2×2 行列の行列式の定義」の 4 か所を `def_det_two_by_two` へのラベル参照にした。
    Lean は `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` に `IsEigenvector`・`IsEigenvalue`・`det_two_by_two_def` と人手の行ごとの鎖を置き、
    `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` と導出をここへ移した（`ClaimEigenATildeDiag.lean` から）。`eigenvalue_AMat_iff` の型を `IsEigenvalue (AMat K θ) lam ↔ …`（定義を展開すれば以前と同じ式）にし、人手の同値の鎖どおりの `calc` にした。
    statement の「`c v_{±,μ}`（`c ∈ ℂ^×`）は固有ベクトル」を `isEigenvector_smul_eigen_pos`・`_neg` として立てた。必要十分版 `NecSuf/TwoByTwoKernelAndDeterminant.lean` の「⇒」を具体版と同じ手順（`v_i ≠ 0` の `i` を取る）にした。
    SageMath `sagemath/check/nonzero_kernel_iff_det_zero_two_by_two/`（厳密計算のみ）。棚卸しの分類規則 `tools/build-flat-inventory.ts` に `^finite_matrix_` を足した。
    レビューの指摘（一ステップ一定理に反する 5 行、状態台帳、行列式の Lean 側の定義の置き方の説明、添字の対応、`n = 0`、statement の固有ベクトルの主張）を直した。

## 次の一歩

runbook のゴールラインの確認を続ける。先頭の一つだけを行う。

- 必要十分版 `NecSuf/TwoByTwoSkew.lean` の `skew2_mulVec`・`skew2_charPoly_factor` から具体版を導く定理（README の必要十分版の要件 4）が無い。導出を置くか、具体版の Step 2 が `b = -ā` と `a ā = r^2` の 2 段を経由することとの対応をコメントに書く。
- `commutator_of_H_and_check_Z_Y` の必要十分版を、具体版と同じ手順（サイトごとの交換関係から和へまとめる）で `NecSuf/` に置く。
- `ClaimEigenATildeDiag.lean` の `sqrtM_cast_ne_zero` は `sqrtM_ne_zero` を展開した形と同じ主張である。`DefinitionCheckFermi` の `sqrtM` へまとめられるかを確かめる（ファイルの import の向きを先に見る）。
- `lean/README.md` と `lean/docs/` の対応表が新しい配置と一致しているかを、全ファイルのパスについて機械的に確かめる（存在しないパスが書かれていないか）。
- `exp_smul_pauliX`（`PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentity.lean`、人手 `two_by_two_transfer_identity` の「`exp(tσ^x)` の閉じた形」）: 人手は指数級数を偶数項・奇数項に分けて `cosh`・`sinh` の級数と突き合わせるが、Lean は `σ^x` を対角化して `Matrix.exp_units_conj` と `matrixExp_diagonal` で計算している。`(σ^x)^2 = I` なので、人手どおりに `NecSuf/ExpOfInvolution.lean` と同じ偶奇分解で直せるかを確かめる。
- 人手 `eigenvector_of_A_theta_tilde` Step 3（固有空間が 1 次元）は「階数」「固有空間」「次元」を定義せずに使い、「`B ≠ 0` かつ `det B = 0` なら核は 1 次元」を証明なしに使っている（Lean も未形式化）。
  `nonzero_kernel_iff_det_zero_two_by_two` と同じ 2×2 の成分計算で「`Bv = 0` なら `v` は `(B_{12}, -B_{11})` などのスカラー倍」と示せる。後段が Step 3 を使わないなら本文から外すか、使うなら本文と Lean を足す。本文を触るので回の先頭で fetch する。
- 本文に単位行列 `I`・行列の差・行列のスカラー倍と `Iv = v` を定義するブロックが無い（`eigenvector_of_A_theta_tilde` Step 1 の同値の鎖が名前だけで根拠に挙げている）。数学的道具立てに足すかを判断する。
