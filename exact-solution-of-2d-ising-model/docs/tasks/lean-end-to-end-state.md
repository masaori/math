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
    `commutator_of_H_and_check_Z_Y` の必要十分版は未作成である（既存の `NecSuf/CommutatorClifford.lean` は退避した別経路の一般化で、新しい具体版の手順と対応しない）。二十二個目で `NecSuf/CommutatorSiteSum.lean` として作った。

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
  - ゴールラインの確認の二十一個目（済み、2026-11-01）: 必要十分版 `NecSuf/TwoByTwoSkew.lean`（人手 `eigenvector_of_A_theta_tilde`・`diagonalization_check_P_D`）を、具体版 `ClaimEigenATildeDiag.lean` の段と 1 つずつ対応する形に書き直し、
    具体版をその特殊化として導く定理 12 本を `DiagonalizationAndExponentialForm/ClaimEigenATildeDiagFromNecSuf.lean` に置いた（README の必要十分版の要件 4）。仮定は `s^2 = -(ab)` から具体版と同じ `ab = -s^2` にした。
    対応のない旧補題 `skew2_mul_col`・`skew2_det_col` は消し、`skew2_mulVec` を `skew2_mulVec_pos`・`skew2_mulVec_neg` に分け、因数分解の恒等式・固有値の同値の鎖・`λ_+ ≠ λ_-`・`c` 倍・列からの `AP = PD`・`det P` の段を足した。
    知見: `λ_+ ≠ λ_-` と `det P ≠ 0` に効くのは `2s ≠ 0`（具体版は `r > 0`。`ZMod 2` で崩れる）、人手 Step 2 の第 1 成分の `b = -ā` と `aā = r^2` は合成 `ab = -r^2` だけが効き、第 2 成分は仮定なしで閉じる。
    二回のレビューの指摘（必須 9 件・任意 6 件）を直した。

  - ゴールラインの確認の二十二個目（済み、2026-11-01）: 人手 `commutator_of_H_and_check_Z_Y` の必要十分版 `NecSuf/CommutatorSiteSum.lean` を、具体版 `ClaimCommutatorHCheckZY.lean` と同じ手順
    （サイトごとの交換関係 8 式 → 和へまとめる 4 式 → (C)(D) → 境界の二項と (A)(B)）で置き、具体版 4 式をその特殊化として導く `ClaimCommutatorHCheckZYFromNecSuf.lean` を置いた。
    仮定は `R`-代数の族 `z, y` の反交換関係 5 つ、位相 `p` の加法性と `p(0) = 1`、境界の符号 `η` について (A) は `η = p(M)`、(B) は `p(M)η = 1`。
    知見: 境界の符号 `-1` という値は効かず、周期境界 `η = 1` と整数運動量 `p(M) = 1` でも同じ 4 式が出る。
    レビューの指摘で、(C)(D) が `M = 0` でも成り立つので具体版 `lie_H2_checkZ`・`lie_H2_checkY` から `M ≠ 0` を外し、使われなくなった `M ≠ 0` を `H_2` 側の入れ子交換子・係数変換・Taylor 係数の抽出・`T_{V_2}` の作用の定理から連鎖的に外した。

  - ゴールラインの確認の二十三個目（済み、2026-11-01）: `ClaimEigenATildeDiag.lean` の `P̌_μ`（`checkPmat`）と `c`（`checkC`）を `((Real.sqrt M : ℝ) : ℂ)` から `DefinitionCheckFermi.lean` の `sqrtM M` で書き直し、
    `sqrtM_ne_zero` と同じ主張だった `sqrtM_cast_ne_zero` を消した（本文の `P̌` と `def_check_fermi` の `ψ̌` は同じ `√M_col` を使う）。`DefinitionCheckFermi` の import は `ClaimEigenATildeDiag` と同じ三つなので循環しない。
    `det_checkPmat`・`det_checkPmat_of_necSuf` の `(√M)^2 = M` は `sqrtM_sq` を引く。主張の値は定義を展開すれば変わらない。`check-no-sorry.sh` の targets と `lean/docs/ch015-formalization.md` の対応表を直し、
    `DefinitionCheckFermi.lean` 冒頭の「`P̌_μ` は並行して形式化中」の古い記述を直した。レビューの指摘（必須 3 件・任意 2 件）を直した。

  - ゴールラインの確認の二十四個目（済み、2026-11-01）: `lean/README.md` と `lean/docs/` が書く `.lean` のパスと `Ising2D.` の名前の実在を機械的に確かめる `lean/scripts/check-docs-references.sh` を置いた
    （パスは lean/・Ising2D/・mathlib 起点と実在ファイルの末尾で読み、名前は宣言・構造体の欄・コンストラクタ・名前空間・モジュールの完全な名前で照合する。削除・改名の経緯を書いた段落は除く）。
    実在しないパスは 0 件だった。実在しない名前は 1 件で、README の表の抽象テンソル冪の実装名 `Ising2D.NecSufTensorPow`（「抽象版」の改名で巻き込まれた誤り）を実在する `Ising2D.AbstractTensorPow` に直した。
    同じ表の人手ラベル `gamma_2_periodicity`（本文にもノートにも無い）を、`gamma2_add_int_mul_two_pi` は `periodicity_of_check_fermi` の (1) の `γ_2` 側、`gamma2_thetaMu_of_dvd` は整数運動量の経路だけが使う退避ノートの `gamma2_theta_M_periodicity` の一般形、の 2 行に分けて直した。
    README の「ビルド」節にスクリプトの使い方を足した。二回のレビューの指摘（必須 2 件・任意 7 件）を直した。

  - ゴールラインの確認の二十五個目（済み、2026-11-01）: `lean/README.md` と `lean/docs/` の表の行か見出しにファイル名で出ない `Ising2D/` の Lean のファイルが 86 個あった
    （前回の 21 個は「ファイル名も宣言した名前もどこにも出ない」で数えた数。今回は表の行か見出しにファイル名で出ることを基準にした）。
    67 個は、そのファイルで宣言した名前が既に載っている表の行の Lean の名前の列にファイル名を書き足した。
    19 個は行を足した（章末の主張 7 本、`FromNecSuf` と必要十分版 6 本、`RealMatrixBilinearFormAndNorm.lean`（ch011 の表の下の段落を表の行にした）、`IteratedCommutatorSmul.lean`、`ScalarCentral.lean`・`MatrixUnits.lean`、退避した `symmetrized_transfer_matrix_on_sector_exponential_form`）。
    `check-docs-references.sh` に検査 3「`Ising2D/` の全ファイルが、経緯の段落の外の表の行か見出しにファイル名で出る（そのファイル名で 1 つのファイルに決まるときだけ数え、コードブロックの中は数えない）」を足した。
    mathlib のパスの検査は `.lake/packages/mathlib/Mathlib` が在るときだけ行うようにした（取得途中の作業ツリーで偽の不合格になっていた）。レビューの指摘（必須 2 件・任意 6 件）を直した。

  - ゴールラインの確認の二十六個目（済み、2026-11-01）: 章末の主張 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimMaxEigenvectorInEvenSectorViaTraceOfEpsilonVPlus.lean`）に (1) を立て、仮定 `htr` を外した。
    (1) は人手 `def_V_plus` の `VPlusOfTransfer M K_1 K_2` について `trace_of_epsilon_V_plus` そのものとし、(2) は `vPlusDataOf_V` と `VPlusOfTransfer_eq_VPlus` でつないだ。
    (2) は人手どおり `im Q̌_{(1,…,1)}` の元（`Q̌ *ᵥ x`）について述べ、冪等性 `Qproj_mul_self` の一行、`η_{(1,…,1)} = +1`、`εQ̌ = Q̌`、`εy = y` の式変形を証明の中で一つずつ書いた（以前は `Q̌ y = y` を満たす `y` について述べ、冪等性の行が無かった）。
    `TheoremMaxEigenvectorInEvenSector.lean` 冒頭の「直接計算は形式化していない」の古い記述と ch018 の行を直した。レビューの指摘（必須 4 件・任意 4 件）を直した。

  - ゴールラインの確認の二十七個目（済み、2026-11-01）: `check-docs-references.sh` に検査 4「表の人手証明の列（見出しに「人手」「原文」「ラベル」を含み「記号」を含まない列）の名前が人手証明に実在する」を足した。
    実在とは、本文の `labels` か `id` にあるか、参照用ノートの退避の記録（「labels: …」「ブロック <id>」）にあってそのノートのファイル名が同じ行か表の前の文に出ることである。列はバッククォートの外の `|` だけで区切り、`<…>` で囲んだラベルは中身を読む。
    見出し行の無い表も不合格にした。不合格だった 93 か所は、改名ではなくすべて退避（整数運動量の経路・全スピン反転行列の固有値 −1 の側・どの章のゴールからも使われない主張・`W P^{(+)}` の指数表示）か、人手の列に書いた Lean の名前だった。
    退避は、該当する 16 の表の前に退避先のノートを名指す一文を置いて直した。Lean の名前 4 つには `Ising2D.` を付けた。README の記号の対応表の見出しを「人手の記号」にし、「現在形式化済みの命題」の表を途中で切っていた引用ブロックを表の後ろへ移した。
    二回のレビューの指摘（必須 3 件・任意 5 件）を直した。見出しの語で拾えない人手ラベルの列（ch010 の状態確認の表の「主張」、ch013 の「対象」、README の原文の問題の表の「箇所」）は検査の外のまま（中身は実在か退避済み）。

  - ゴールラインの確認の二十八個目（済み、2026-11-01）: 人手 `two_by_two_transfer_identity` の中間目標「`exp(tσ^x)` の閉じた形」の Lean を、`σ^x` の対角化（`Matrix.exp_units_conj`・`matrixExp_diagonal`）から、人手どおり指数級数を偶数項・奇数項に分ける証明へ書き換えた
    （`PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentity.lean` の `pauliX_sq`・`pauliX_pow_two_mul`・`pauliX_pow_two_mul_add_one`・`exp_smul_pauliX_hasSum`・`exp_smul_pauliX_eq_cosh_add_sinh`・`exp_smul_pauliX`）。対角化に使っていた `hadU` などは消した。
    既存の必要十分版 `NecSuf.exp_series_sum_of_sq_eq_one` の系を `ClaimTwoByTwoTransferIdentityFromNecSuf.lean` に置き、README の 2 本立ての表、`docs/ch010-formalization.md`・`docs/ch018-formalization.md`、`check-no-sorry.sh` の対象を直した。主張の型は変えていない。レビューの指摘のうち必須 1 件・任意 1 件を直した。任意のもう 1 件（`exp_smul_pauliX_hasSum` が `matExp_hasSum` と同じ中身）は、`matExp_hasSum` が `TensorPow M` 専用で `Mat(2,ℂ)` に使えないので残した。
  - ゴールラインの確認の二十九個目（済み、2026-11-01）: 人手 `eigenvector_of_A_theta_tilde` の Step 3（固有空間が 1 次元で、固有ベクトルは `v_{±,μ}` の `ℂ^×` 倍に限ること）と statement の「限る」の側を、
    参照用ノート `claims_unused_by_chapter_goals_not_adopted` へ退避した。後段（`diagonalization_check_P_D`・`det A = 1` の Step 6・`e^{±γ} = λ_±`・指数表示）が使うのは `λ_{±,μ}` の値と `A v_± = λ_± v_±` だけで、
    Step 3 は本文のどこからも使われず、「階数」「固有空間」「次元」を本文で定義しないまま使っていたため（README の「どこからも使われない主張は削る」の前例と同じ判断）。
    statement は「`c ∈ ℂ^×` について `v_{±,μ} := c(...)` は `λ_{±,μ}` に属する固有ベクトル」にし、レビューの指摘で Step 2 に欠けていた `cv ≠ 0` の段を足した（Lean の `isEigenvector_smul_eigen_pos/neg` の `smul_ne_zero` と同じ手順）。
    Lean の主張は変えていない（Step 3 はもとから形式化していなかった）。`ClaimEigenATildeDiag.lean` の冒頭と `docs/ch015-formalization.md` の「形式化できなかった主張」の節を直した。

  - ゴールラインの確認の三十個目（済み、2026-11-01）: 人手 `eigenvector_of_A_theta_tilde` Step 1 の同値の鎖が「移項」「単位行列の性質 `Iv = v`」「スカラー倍の括り出し」「行列とベクトルの積の分配則」を
    定義のブロック無しに根拠にしていたので、数学的道具立て（`000_calculation_formulae_45_46.ts`、棚卸しのまとまり「有限行列・Pauli行列・交換子」）に
    定義 `def_matrix_difference`・`def_zero_matrix` と主張 `matrix_difference_zero_iff_equal`・`matrix_difference_mul_vector`（どれも成分ごとの鎖）を足した。
    単位行列・スカラー倍は、同じ日に全証明の SageMath 検算の連続実行が `002_linear_space_general.ts` に足した `def_kronecker_delta`・`def_identity_matrix`・`def_matrix_scalar_multiple`・
    `identity_matrix_is_left_unit_of_mat_mult`・`scalar_multiple_factors_out_of_left_factor` を使う（rebase で同じラベルが衝突したので、こちらで書いた同じ内容の定義と主張は取り下げた）。
    Step 1 の 2〜5 段をこれらへのラベル参照にし、`I := I_{Mat(2,ℂ)}` を置いた。`det(A(θ) - λI)` の鎖の先頭の行（差・スカラー倍・単位行列の成分を同時に使っていた）を、
    差・スカラー倍・単位行列・クロネッカーのデルタの 4 行、`x·1 = x`・`x·0 = 0`・`y - 0 = y` の 3 行、`def_gamma1_gamma2_of_theta` の行に割った。`def_eigenvector` の零ベクトルとスカラー倍をラベル参照にした。
    Lean は具体版 `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean`（成分の式との接点 `kroneckerDelta`・`identity_matrix_apply`・`matrix_smul_apply`・`matrix_sub_apply`・`matrix_zero_apply` と、
    人手の鎖どおりの `matrix_sub_eq_zero_iff`・`vec_sub_eq_zero_iff`・`sub_mulVec_eq`、右の因子が数ベクトルの場合の `identity_matrix_mulVec`・`smul_mulVec_eq`）、
    必要十分版 `NecSuf/MatrixVectorIdentityScalarDifference.lean`（差が零 ⟺ 等しいは加法群、`Iv = v` は `1·x = x`・`0·x = 0`、`(λB)v = λ(Bv)` は左分配則と結合則で可換則は効かず結合則は外せない `mul_assoc_of_smul_mulVec`、`Av - Bv = (A - B)v` は右分配則）と導出 `...FromNecSuf.lean` を置いた。
    `eigenvalue_AMat_iff`・`charPoly_factor_thetaTilde` と必要十分版 `skew2_eigenvalue_iff`・`skew2_charPoly` の該当段を、mathlib の `Matrix.one_mulVec`・`smul_mulVec`・`sub_mulVec` と `simp` の一括処理から、これらの定理と定義ごとの行へ替えた。主張の型は変えていない。
    SageMath に `matrix_difference_zero_iff_equal`・`matrix_difference_mul_vector` の検算と、`det(A(θ) - λI)` の鎖の成分の行の検算 `eigenvector_of_A_theta_tilde_determinant_entries`（厳密計算のみ）を足した。
    三回のレビューの指摘（必須 7 件: 差と零行列の束ね、一ステップ一定理の 2 か所、必要十分版の型クラスの理由、段の数え方、行列式の行の検算の欠如、rebase 後に単位行列の成分とデルタの値を Lean の具体版・必要十分版で 1 段にしていたこと 2 件。任意 8 件）を直した。
    棚卸しの再生成 `npm run inventory:organization` は、SageMath 検算の連続実行が足した `transfer_matrix_claim_end_agrees_with_matrix_vector_product` が数学的道具立ての前提になる分類の検査で落ちる（この回の変更より前から）。

  - ゴールラインの確認の三十一個目（済み、2026-11-01）: 人手 `eigenvector_of_A_theta_tilde` Step 2 の第 2 成分を、`-b = ā` を代入して `ā` を括り出し最後に `b` へ戻す往復から、
    `b` のまま括り出す 6 行の鎖（`(-b)(∓r) + g_1 b` → `b(±r) + g_1 b`（四則）→ `(±r)b + g_1 b`（乗法の可換則）→ `(±r + g_1)b`（分配則）→ `(g_1 ± r)b`（加法の交換則）→ `λ_± (v_±)_2`）にした。
    第 2 成分は `b = -ā` を使わない（必要十分版 `skew2_mulVec_pos/neg` の知見）。Lean の具体版 `AMat_mulVec_eigen_pos/neg` と必要十分版 `skew2_mulVec_pos/neg` の第 2 成分を同じ 6 行の `calc` にし、
    `ClaimEigenATildeDiag.lean`・`NecSuf/TwoByTwoSkew.lean` の冒頭と `lean/docs/ch015-formalization.md` の古い記述を直した。SageMath `051_stepwise_identities_of_chapter_Cprime/check_02` の第 2 成分の段を 6 段に替えて再実行した（72 段、全段 PASS）。
    主張の型は変えていない。レビューの指摘（必須 3 件: 状態台帳・MEMORY.md・必要十分版のコメントの段数と経緯。任意 3 件: 符号と可換則の 1 行への束ね、下の符号の `g_1 + (-r) = g_1 - r`、文書の経緯の含み）を直した。
    `check-no-sorry.sh` が、前の回で足した `'` を含む 2 つの名前（`NecSuf.smul_mulVec_eq'`・`NecSuf.sub_mulVec_eq'`）を引用符なしで配列に置いていたため、bash の引用が崩れて終了コード 1 で落ちていた（OK の行は出る）。2 つを `"…"` で囲んで直し、1794 件すべてが `sorryAx` に依存しないことを確かめた。

  - ゴールラインの確認の三十二個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」を本文のファイルごとに割り、先頭の `002_linear_space_general.ts` の `scalar_identity_commutes` を直した。
    証明の「スカラー倍は行列の積の外へ出せる」「単位行列の性質 IA=A, AI=A」「同じ元の差は零行列」を、`scalar_multiple_factors_out_of_left_factor`・`..._right_factor`・`identity_matrix_is_left_unit_of_mat_mult`・`..._right_unit_...`・`matrix_difference_zero_iff_equal` への参照の 6 段の鎖にし（二つの主張を同時に使っていた二段を四段に割った）、主張の `0` を零行列 `O`、`I` を `I_{Mat(n,ℂ)}` にした。
    Lean の具体版 `scalar_identity_commutes` を、体 `K` 上の必要十分版の特殊化から、`ℂ`・`Fin n` の `matComm` について人手の 6 段と 1 対 1 の `calc` に書き直した（旧 `scalar_identity_commutes_fin`・`scalar_identity_commute` は消し、必要十分版からの導出と `TensorPow M` の系は `LemmaScalarIdentityCommutesFromNecSuf.lean`）。
    行列同士の積の 4 主張の具体版 `ClaimIdentityAndScalarMultipleInMatrixProduct.lean`、必要十分版 `NecSuf/MatrixProductIdentityAndScalar.lean`（右の因子のスカラー倍だけ可換則が効き、外せないことを `mul_comm_of_mul_smul_matrix` で確かめた）と導出を置いた。
    レビューの必須の指摘（必要十分版で右の単位元に可換則が効かないのに、人手は交換律の段を踏んでいた）を受け、人手に `complex_times_zero_is_zero`（`z·0_C = 0_C`）を足して `identity_matrix_is_right_unit_of_mat_mult` の 2 段を 1 段にした。SageMath は `139_scalar_identity_commutes/check_02_steps.sage`・`complex_times_zero_is_zero/` を足し、右の単位元の鎖の検算を直した。

  - ゴールラインの確認の三十三個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち `006_Z_Y_anticommutation.ts` の `pauli_matrix_products` を直した（台帳の順では次は `003_exp_linear_map.ts` だったが、同じ項目の 1 ファイルを先に済ませた）。
    本文に行列の符号反転を定める定義が無かったので、数学的道具立て（`000_calculation_formulae_45_46.ts`）に `def_matrix_negation`（`(-A)_{ik} := -A_{ik}`、右辺は `multiply_by_minus_one`）を足した。
    証明の「I の定義」「行列のスカラー倍の定義と ℂ の符号の計算」を `def_kronecker_delta`・`def_identity_matrix`・`def_matrix_negation` へのラベル参照にし、反可換性の 3 式を主張の左辺から始まる鎖にした（以前は `σ^xσ^z = -σ^zσ^x` のように主張と逆向きの式を示していた）。
    右辺の積 3 つは冒頭の準備へ移し、行列の積の段と成分の積の段（`(-1)·(-1) = 1` など）、`0 = -0` と `1 = -(-1)` の段を分けた。
    Lean は `PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` の 6 定理（`pauliX_mul_pauliX` など。型は不変）を `fin_cases`・`simp` の一括処理から人手の各段と 1 対 1 の `calc` にし、
    準備の `neg_I_mul_I`・`I_mul_neg_I`・`pauliX_mul_pauliZ_entries`・`pauliX_mul_pauliY_entries`・`pauliZ_mul_pauliY_entries` と共通の段 `twoByTwo_one_eq_kroneckerDelta`・`twoByTwo_kroneckerDelta_eq_identity` を置いた。
    `def_matrix_negation` の成分の接点 `matrix_neg_apply` は `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` に置いた。必要十分版は置かない（2×2 の成分計算だけで、抽象化して見えるものが無い）。
    SageMath `sagemath/check/160_pauli_matrix_products/check_02_stepwise_chains.sage`（`QQ[i]` の厳密計算、各鎖の全行）を足した。二回のレビューの指摘（必須 4 件: `def_matrix_negation` の参照先、`σ^a` の帰属、成分の積を行列の積の段へ束ねた 3 行、`ℝ` の符号の計算。任意 4 件）を直した。
    `check-no-sorry.sh` が、三十二個目で足した `'` を含む 4 つの名前（`NecSuf.smul_mul_matrix_apply'` など）を引用符なしで置いていたため、`lake env lean` が落ちて終了コード 1 になっていた。`"…"` で囲んで直した。

  - ゴールラインの確認の三十四個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち `003_exp_linear_map.ts` の「行列の差は成分ごと」5 か所を扱った。
    係数が `ℂ` に固定されているのは `complex_exp_of_real_argument` の 1 行 1 列の複素行列の差の鎖の 1 か所だけで、その 2 段目の根拠を `def_matrix_difference`（`m = p = 1`、`i = k = 1`）へのラベル参照に替えた（式と段は不変）。
    残る 4 か所は係数が `K`（`ℝ` または `ℂ`）か `ℝ` の行列である（`matrix_exp_series_converges` の後の成分の収束の Step 2 の 2 か所は `Mat(n,K)`、1 行 1 列の行列の差の鎖 2 か所は `[u]_K` と `[u]_ℝ`、`S_N([0]_K)` の鎖は `[1]_K - [1]_K = O`）。
    `def_matrix_difference` は `Mat(m,p,ℂ)` しか覆わないので替えなかった（`matrix_completeness` Step 3 と同じ扱い）。
    このブロックに Lean の具体版は無い（`complex_exp_of_real_argument`・`def_one_by_one_matrix` は形式化されていない）。
    SageMath `sagemath/check/complex_exp_of_real_argument/check_one_by_one_complex.sage` に、定義の成分の式と Sage の行列の差の一致の確認を足し、対応表の「本文に定義が無く」を定義を引く記述に直した。レビューの指摘は無かった。

  - ゴールラインの確認の三十五個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち `005_exp_conjugation_proof.ts` の `frobenius_inner_product_axioms` (2) の 4 本の鎖を直した。
    係数はどれも `ℂ`（`M(n;ℂ) = Mat(n,n,ℂ)`）なので、1 段目の根拠「(0) と行列の和の定義」「(0) とスカラー倍の定義」（2 つの根拠の束ね）を、(0) の段（`(B+C)_{ij}`・`(λB)_{ij}`・`(A+B)_{ij}`・`(λA)_{ij}` の形）と
    `def_matrix_sum`・`def_matrix_scalar_multiple` へのラベル参照の段の 2 段に割った。このブロックに Lean の具体版は無い。
    SageMath `sagemath/check/140_frobenius_inner_product_axioms/check_02_linearity_chains.sage`（`QQ[i]` の厳密計算、4 本の鎖の全行、左辺は `tr(A^*B)` で計算、252 段と否定コントロール 11 件、全段 PASS）を足した。
    レビューの必須の指摘は無く、任意の指摘（検算の (0) の段と定義の段が同じ式どうしの比較だったこと、否定コントロールが一度も実行されなくても通ること）を直した。
  - ゴールラインの確認の三十六個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち `004_transfer_matrix.ts` の 5 か所（`exp_of_diagonal_matrix` の部分和の成分の 2 本、`end_agrees_with_matrix_vector_product` の基底による展開の 2 本と主張の鎖の 1 行）を直した。
    係数はどれも `ℂ` である。本文に行列の有限和を定めるブロックが無かったので、定義 `def_finite_sum_of_matrices`（`Mat(m,n,ℂ)`、添字 `1..r`、左から足す）と主張 `finite_sum_of_matrices_entrywise`（有限和の成分は成分の有限和。帰納法の鎖）を `002_linear_space_general.ts` に足した。
    各箇所の「行列（数ベクトル）の和とスカラー倍は成分ごと」を、`finite_sum_of_matrices_entrywise` の段と `def_matrix_scalar_multiple` を各項へ同時に適用する段の 2 段に割った。数ベクトルの和とスカラー倍は、`end_agrees_with_matrix_vector_product` の証明の冒頭で `2^M` 行 1 列の行列としての定義のものと宣言した（`trace_of_idempotent` と同じ形）。
    この 2 ブロックに Lean の具体版の鎖は無い（`ClaimExpOfDiagonalMatrix.lean` は主張の形だけを持ち、部分和の段を持たない）。SageMath は `sagemath/check/finite_sum_of_matrices_entrywise/` を足し、`exp_of_diagonal_matrix`・`end_agrees_with_matrix_vector_product` の検算に新しい行を足した（全 PASS）。
    レビューの必須の指摘（有限和の未定義、数ベクトルの和の定義の宣言）を直し、再レビューで必須の指摘は無くなった。
  - ゴールラインの確認の三十七個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち、`008_TV1_hatZ_hatY_part1.ts` と `009_eigenvalues_of_V.ts` を調べ、台帳の 4 種（単位行列の性質・行列のスカラー倍の定義・行列の和の定義・行列の差は成分ごと）が 0 か所であることを確かめた
    （008 に残る名前だけの根拠は仮定の代入・`c c^{-1} = 1`・`linearity_of_T` の行列積の分配法則とスカラー倍との両立で、行列積の分配法則を定めるブロックは本文に無い。009 の `行列の等号は成分ごと` は下の別件）。
    続けて章のファイル `partition_function_projection_and_jordan_wigner.ts` の「行列のスカラー倍の定義」4 か所（`V1_in_Z_Y_epsilon` の Step 0 の 3 本の鎖と `V2_in_Z_Y` の Step 0 の鎖。係数はどれも `ℂ`）を直した。
    各鎖を `pauli_matrix_products` → `mat_mult` → ℂ の事実を 1 段に 1 つずつ（`complex_zero_times_is_zero`・加法の単位元・`complex_times_zero_is_zero`・積の単位元・可換律・結合律・`multiply_by_minus_one`・`(-1)·(-1) = 1`）→ `def_matrix_scalar_multiple` → `pauli_matrix_products` の鎖（12・11・11 段）に組み直し、「ℂ の四則」「2×2 行列の積の成分計算」「Pauli 行列の定義」の名前だけの根拠も消した。主張は変えていない。
    Lean の具体版 `pauliY_mul_pauliX_eq`・`pauliX_mul_pauliY_eq`（`ClaimV1InZYEpsilon.lean`）と `pauliZ_mul_pauliY`（`DefinitionTransferMatrixSymbols.lean`）を、`fin_cases`・`simp` の一括処理から人手の各段と 1 対 1 の `calc` にした（型は不変。行列の積の段は `simp only [Matrix.mul_apply, Fin.sum_univ_two]` と `rfl` に絞った）。必要十分版は置かない（2×2 の成分計算だけ）。
    SageMath `sagemath/check/V1_Jordan_Wigner_representation/check_step0_single_site_chains.sage`（34 段）・`V2_Jordan_Wigner_representation/check_step0_single_site_chain.sage`（11 段）を足した（`QQ[i]` の厳密計算、全段 PASS）。
    レビューの必須の指摘 3 件（新しく足した符号の段の束ね、「ℂ の四則」の段の束ね、「Pauli 行列の定義」が名前だけの根拠）を直し、再レビューで必須の指摘は無くなった。
    この VM の sage では、`_shared/` を `__file__` から読む既存の検算（`V1_Jordan_Wigner_representation` の 4 本など）が sage 本体の場所を基準にして落ちる。既存のログは変えていない。
  - ゴールラインの確認の三十八個目（済み、2026-11-01）: 「名前だけの根拠をラベル参照に替える」のうち、`eigenvalue_problem_reduction_to_A_theta.ts` の、本文の主張で引けるものを替えた（係数はどれも `ℂ`）。
    `anticommutator_of_Z_and_Y` の「II = I. 単位行列どうしの積」6 か所と「I は積の単位元」4 か所を、`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult` を 2×2 の各因子へ同時適用する参照にした（適用先の等式 `Iσ^x = σ^x` などを根拠に書いた）。
    `commutator_of_H_and_check_Z_Y` の Step 1 の「単位行列の性質」9 か所を同じ 2 つへ、「同じ行列の差は零行列」4 か所を `matrix_difference_zero_iff_equal` の ⟸ へのラベル参照にし、Step 1 の行列の零を `def_zero_matrix` の `O` に揃えた。式・主張は変えていないので SageMath は足していない。
    Lean の具体版 `jw_sq`・`jw_anticomm`（`ReductionToATheta/ClaimAnticommutatorZY.lean`）の 2×2 の単位行列の段を、mathlib の `one_mul`・`mul_one` から具体版 `identity_matrix_mul`・`mul_identity_matrix` にした。
    `ReductionToATheta/ClaimCommutatorHCheckZY.lean` の Step 1 の該当 10 段は、`TensorPow M` の添字が `Conf M` で `Fin m` の具体版が当てはまらないので、`scalar_identity_commutes_tensorPow` と同じく必要十分版を `Conf M` へ特殊化した系
    `identity_matrix_mul_tensorPow`・`mul_identity_matrix_tensorPow`（`ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`）・`matrix_sub_eq_zero_iff_tensorPow`（`ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`）を足して、mathlib の `one_mul`・`mul_one`・`sub_self` から替えた。
    レビューの必須の指摘は無かった。任意の指摘（仮の記号 `σ` の根拠、`Conf M` の段を mathlib のまま残していたこと）を直した。

  - ゴールラインの確認の三十九個目（済み、2026-11-02）: `eigenvalue_problem_reduction_to_A_theta.ts` の `commutator_of_H_and_check_Z_Y` Step 1 に残っていた「零行列の和は零行列」6 か所と「零行列を引いても変わらない」2 か所を扱った。
    本文 `002_linear_space_general.ts` に主張 `matrix_plus_zero_matrix`（`X + O = X`）・`zero_matrix_plus_matrix`（`O + X = X`）・`matrix_minus_zero_matrix`（`X − O = X`）・`finite_sum_of_zero_matrices`（`Σ_{j=1}^{r} O = O`、`r ≥ 1`）を 1 ブロック 1 主張で足した
    （置き場は前回の案の `000_calculation_formulae_45_46.ts` ではなく、引く `def_matrix_sum`・`def_finite_sum_of_matrices` と同じファイルにした。前方参照を作らないため）。
    「零行列の和は零行列」の行を「有限和を O にする行」と「O を足して消す行」の 2 行に分け、後者を `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix` に、「零行列を引いても変わらない」を `matrix_minus_zero_matrix` にした。
    有限和を O にする行は、添字が `1..M_col−1` の 2 か所（`[H_1^{(+)}, Z_1]`・`[H_1^{(+)}, Y_{M_col}]`）だけを `finite_sum_of_zero_matrices` にした。残る 4 か所は一つの添字を除いた集合の上の和で名前の根拠のまま残した（次の一歩の「有限和の添字の付け方」の件）。
    SageMath は 4 つの主張の検算 `sagemath/check/<ラベル>/` を足し（`QQ` の多項式環の厳密計算）、`051_stepwise_identities_of_chapter_Cprime` の check_01 に足した行を入れた（288 → 294 段、全段 PASS）。
    Lean は具体版 `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimAddAndSubtractZeroMatrix.lean`（人手の鎖と 1 段ずつの `calc`）、必要十分版 `NecSuf/MatrixAddSubZero.lean`（`AddZeroClass`・`SubNegZeroMonoid`・`AddCommMonoid`。乗法は効かない）、系 `ClaimAddAndSubtractZeroMatrixFromNecSuf.lean` を置いた。
    `ClaimCommutatorHCheckZY.lean` はこの段を `Finset.sum_eq_single` にまとめたまま（`TensorPow M` の添字 `Conf M` と和の添字の件のため）で、冒頭に新しい根拠との対応を書いた。
    レビューの必須の指摘 2 件（範囲外の和への `finite_sum_of_zero_matrices` の適用、1 行に 2 操作）を直し、再レビューで必須の指摘は無くなった。

  - ゴールラインの確認の四十一個目（済み、2026-11-02）: 「名前だけの根拠をラベル参照に替える」のうち `004_transfer_matrix.ts` の `exp_of_diagonal_matrix` の冪の帰納法の基底の 2 か所（「単位行列の非対角成分」「単位行列の対角成分」）を扱った（係数は `ℂ`）。
    各行を `def_identity_matrix`（`(I_{Mat(n,ℂ)})_{kl} = δ_{kl}`）と `def_kronecker_delta`（`δ` の値 `0_ℂ`・`1_ℂ`）の 2 段に割った。証明の冒頭に、`def_exp` を `K := ℂ` として用いるのでその `I` が `I_{Mat(n,ℂ)}` であることと、`d_k^0 := 1_ℂ` を書いた。主張は変えていない。
    このブロックに Lean の具体版の鎖は無い（`ClaimExpOfDiagonalMatrix.lean` は mathlib の `exp` で主張の形だけを持つ）。SageMath `sagemath/check/exp_of_diagonal_matrix/check_diagonal_power_and_partial_sum.sage` の基底の鎖に `δ` と定義どおりに作った単位行列の行を足した（全 PASS）。
    レビューの必須の指摘は無く、任意の指摘 2 件（冒頭の根拠を `K := ℂ` にする、`k = k` を添える）を直した。残した任意の指摘: 同じ証明で基底の末尾が `0_ℂ`、帰納の段・部分和が素の `0`（略記の規約 `set_and_algebra_notation` の上では同じ元）。`def_exp` の「`I`（単位行列）」が `def_identity_matrix` を引かず、`K = ℝ` の `I` を定めるブロックが無い（下の `K` の件）。`003_exp_linear_map.ts` の `scalar_exp_is_limit_of_partial_sums` の「単位行列の対角成分は 1」も `K` の件に入る。

  - ゴールラインの確認の四十二個目（済み、2026-11-02）: 「名前だけの根拠をラベル参照に替える」のうち `005_exp_conjugation_proof.ts` の係数が `ℂ` の箇所を扱った。
    `def_ad_X_matrix` の逆行列の一意性の鎖の「単位行列との右からの積」「単位行列との左からの積」「行列積の結合律」を `identity_matrix_is_right_unit_of_mat_mult`・`identity_matrix_is_left_unit_of_mat_mult`・`mat_mult_associative` へのラベル参照に替え、正則の定義の `I` が `I_{Mat(n,ℂ)}`（`def_identity_matrix`）であることを書いた。
    `matrix_exp_conjugation` の Step 1 の `ad_X(cZ)` の鎖で、「スカラー倍と行列の積の両立」で 2 項を同時に変えていた 1 行を `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor` の 2 行に割った。主張は変えていない。
    SageMath `sagemath/check/142_matrix_exp_conjugation/check_02_ad_linearity_chain.sage` で Step 1 の 2 本の鎖を一行ずつ厳密に確かめた（PASS）。
    Lean の対応は既存のまま 1 対 1 でない（今回の変更で新しく生じたものではない）: ad の線型性は必要十分版 `NecSuf/ExpConjugation.lean` の `adCLM` が mathlib の連続線型作用素の差として型から得ており、Step 1 の鎖は無い。逆行列の一意性は具体版が `matExpUnits` を mathlib の `Units` として扱い、証明が無い。具体版 `ClaimExpConjugation.lean` は `TensorPow M` 上で必要十分版を特殊化するだけで、必要十分版の論法（左右の乗法の可換性と `exp_add_of_commute`）は本文の `ad_binomial` と有限和の組み替えと別である（証明の書き方の「証明手順が具体版と同じ」に反する。下の次の一歩に件として足した）。
    レビューの必須の指摘 1 件（同じ鎖の「行列積の結合律」）と任意の指摘 3 件を直した。

  - ゴールラインの確認の四十四個目（済み、2026-11-02）: 「名前だけの根拠をラベル参照に替える」のうち `eigenvalue_problem_eigenvalues_of_V_plus.ts` の 6 か所を扱った（係数は `ℂ`）。
    `sign_flip_conjugation` Step 3 の「スカラー倍と行列積の両立」2 か所を `negation_factors_out_of_right_factor`（`Y_j(-Z_k) = -(Y_jZ_k)`）・`negation_factors_out_of_left_factor`（`(-Z_j)Y_j = -(Z_jY_j)`）にし、鎖の `(+Y_j)` を `Y_j` に、結果を括弧付きにした。
    `V_plus_is_invertible` Step 2・Step 3 は、レビューの必須の指摘（括弧が無く結合律・単位元の適用先が決まらない、`scalar_identity_commutes` が `a·X` の段に当てはまらない）を受け、`V^{(+)} = a((E_+A_+)E_+)` と読むことを書いて鎖の括弧を全て書き、
    スカラー倍の 5 段（`scalar_multiple_factors_out_of_left_factor`・`..._right_factor`・`scalar_multiple_is_associative`・`aa^{-1}=1_ℂ`・`scalar_multiple_by_one`）、結合律 1 回 1 行の `mat_mult_associative`、`identity_matrix_is_left_unit_of_mat_mult`（`A_∓` へ）・`..._right_unit_...`（`E_±` へ）にした。主張は変えていない。
    Lean は `Uflip_conj_H1`・`Uflip_conj_H2` の `Matrix.mul_neg`・`Matrix.neg_mul` を `TensorPow M` の系 `mul_neg_matrix_tensorPow`・`neg_mul_matrix_tensorPow`（`ClaimNegationFactorsOutOfMatrixProductFromNecSuf.lean`）に、
    `VPlus_mul_VPlusInv`・`VPlusInv_mul_VPlus` を人手の各行と 1 対 1 の `calc` にした（系 `smul_mul_matrix_tensorPow`・`mul_smul_matrix_tensorPow` を足した。`mat_mult_associative`・`scalar_multiple_is_associative`・`scalar_multiple_by_one` は Lean の具体版が無いので mathlib の `Matrix.mul_assoc`（引数を明示して 1 回ずつ）・`smul_smul`・`one_smul` のまま）。
    SageMath `050_claim_even_sector_eigenvalues/check_09_sign_flip_step3_chains.sage`（`QQ(i)`、114 段）・`check_10_V_plus_inverse_chains.sage`（`QQ`、252 段）を足した（全 PASS）。
    `check-no-sorry.sh` が四十三個目で足した `'` を含む 6 つの名前を引用符なしで置いていて `lake env lean` が落ちていた（終了コード 1）ので、`"…"` で囲んで直した。再レビューで必須の指摘は無くなった。
  - ゴールラインの確認の四十五個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` の Step 3 の「共役は積を保つ」2 か所と Step 4 の「`S` の定義かつ共役はスカラー倍を保つ」2 か所を扱った（係数は `ℂ`）。
    Step 3 は `conjugation_is_ring_homomorphism` を `n = 2^{M_col}`、`B = U`（Step 0 で可逆）として、`T_B` の定義・乗法性・`T_B` の定義の 3 行にし、`UXU^{-1}` を `(UX)U^{-1}` と読むことを Step 3 の冒頭に書いた。
    Step 4 は `S` の定義・`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor`・Step 3・`scalar_multiple_of_negated_matrix`・`S` の定義の 6 行にした。`a(−H) = −(aH)` を引ける主張が無かったので、主張 `scalar_multiple_of_negated_matrix`（`a(−A)=−(aA)`、成分の鎖）を `002_linear_space_general.ts` に足した（SageMath `sagemath/check/scalar_multiple_of_negated_matrix/`、Lean の具体版 `smul_neg_matrix`（`ClaimScalarMultipleOfNegatedMatrix.lean`）、必要十分版 `NecSuf/SmulNegMatrix.lean`（係数は `Monoid` と `HasDistribNeg`。鎖に和が無いので加法は効かない）、系 `smul_neg_matrix_tensorPow`）。主張は変えていない。
    Lean は `UflipUnit`（`U` を可逆元とする単元）を置き、`Uflip_conj_mul` を `noncomm_ring` から `Conjugation.T_mul` の特殊化に、`Uflip_conj_smul` を `mul_smul_matrix_tensorPow`・`smul_mul_matrix_tensorPow` に、`Uflip_conj_S1plus`・`Uflip_conj_S2` を人手の行と 1 対 1 の `calc` にした。
    SageMath `050_claim_even_sector_eigenvalues/check_11_sign_flip_step3_step4_conjugation_chains.sage`（`QQ(i)`、150 段）を足した（全 PASS）。レビューで必須の指摘は無かった（任意の指摘のうち 2 件は下の次の一歩に残した）。

  - ゴールラインの確認の四十六個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 0 の `σ_m^xσ_m^x = I`・`σ_m^zσ_m^z = I`（名前だけの根拠「パウリ行列の積」、`I` に添字なし）を扱った（係数は `ℂ`）。
    `a ∈ {x, z}` についての 5 行の鎖（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`pauli_matrix_products`・`identity_matrix_is_left_unit_of_mat_mult` を `m` 番目以外の因子へ同時適用・`kronecker_product_rule` (2)）にし、鎖の中に限り `I := I_{Mat(2,ℂ)}` と書くことを宣言した（結論は `I_{Mat(2^{M_col},ℂ)}`）。主張は変えていない。
    Lean は具体版 `siteOp_mul_self_of_mul_self_eq_one`（人手の 5 行と 1 対 1 の `calc`）と特殊化 `sigmaX_mul_sigmaX_site`・`sigmaZ_mul_sigmaZ_site` を `ClaimSignFlipConjugation.lean` に置いた（`check-no-sorry.sh` に足した）。
    SageMath `050_claim_even_sector_eigenvalues/check_12_sign_flip_step0_site_square_chains.sage`（`QQ(i)`、90 段）を足した（全 PASS）。
    レビューの必須の指摘 1 件（「以下 `I := I_{Mat(2,ℂ)}`」が同じ証明の後ろの `U^{-1}U = I` と食い違う）を宣言の範囲を鎖の中に限って直し、任意の指摘 2 件（同じ主張の既存の定理との関係の注記、否定コントロールを鎖の判定に通す）を直した。

  - ゴールラインの確認の四十七個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 1 の `F` による共役の鎖のうち、`Fσ_k^xF^{-1}`（2 か所）と `Fσ_k^zF^{-1}`（1 か所）の名前だけの根拠「パウリ行列の積」を扱った（係数は `ℂ`）。
    準備に `σ_k^zσ_k^x = -(σ_k^xσ_k^z)` の 10 行の鎖（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`identity_matrix_is_left_unit_of_mat_mult`・`pauli_matrix_products`・`negation_is_scalar_multiple_by_minus_one`・`kronecker_multilinear`・その逆向き）を置き、`(σ_k^zσ_k^x)σ_k^z` から `negation_factors_out_of_left_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_right_unit_of_mat_mult` の 5 行、`(σ_k^zσ_k^z)σ_k^z` から Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 2 行にした。主張は変えていない。
    主張 `negation_is_scalar_multiple_by_minus_one`（`-A = (-1_ℂ)A`、成分の 3 行の鎖）を `002_linear_space_general.ts` に足した（SageMath `sagemath/check/negation_is_scalar_multiple_by_minus_one/`、Lean の具体版 `neg_eq_neg_one_smul_matrix`、必要十分版 `NecSuf/NegEqNegOneSmulMatrix.lean`（`MulOneClass`・`HasDistribNeg`。加法・結合則・右単位元は効かない）、系 `neg_eq_neg_one_smul_tensorPow`）。
    Lean は `ClaimSignFlipConjugation.lean` に人手の行と 1 対 1 の `sigmaZ_mul_sigmaX_site`・`sigmaZ_sigmaX_sigmaZ_site`・`sigmaZ_sigmaZ_sigmaZ_site` を置いた（`kronecker_multilinear` の行は `MultilinearMap.map_update_smul`、`mat_mult_associative` の行は `Matrix.mul_assoc` を 1 回。どちらも Lean の具体版が無い）。
    SageMath `050_claim_even_sector_eigenvalues/check_13_sign_flip_step1_F_conjugation_chains.sage`（`QQ(i)`、171 段）を足した（全 PASS）。レビューの必須の指摘 1 件（Step 1 の段落から `(σ^z)^{-1} = σ^z` を消していた）と任意の指摘 4 件を直した。
    残した任意の指摘: 新しい 3 定理は `Uflip_conj_sigmaX`・`Uflip_conj_sigmaZ` の証明から使われない（Step 0 と同じく、Lean の `U` はサイトごとの因子 `flipFam` で持ち、`F`・`E` を置いていない）。

  - ゴールラインの確認の四十八個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 1 の `Fσ_k^yF^{-1}` の名前だけの根拠「パウリ行列の積」2 行を扱った（係数は `ℂ`）。
    前回の次の一歩の案（行列の二重の符号反転 `-(-A) = A` を足す）は採らなかった。`mat_mult_associative` で `(σ_k^zσ_k^y)σ_k^z` を `σ_k^z(σ_k^yσ_k^z)` に組み替えれば、`pauli_matrix_products` の `σ^yσ^z = -σ^zσ^y` をそのままの向きで使える（`-(-A) = A` の成分の鎖には本文に無い ℂ の `(-1)(-1) = 1` が要る）。
    四十七個目の `σ_k^zσ_k^x` の 10 行の鎖を、鎖の中に限った文字 `(p, q) ∈ {(z, x), (y, z)}` の `σ_k^pσ_k^q = -(σ_k^qσ_k^p)` に一般化し、`Fσ_k^yF^{-1}` を `mat_mult_associative`・その鎖の `(y, z)`・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行にした。主張は変えていない。
    Lean は `ClaimSignFlipConjugation.lean` に一般形 `siteOp_mul_of_anticomm`（人手の 10 行と 1 対 1 の `calc`）を置き、`sigmaZ_mul_sigmaX_site` をその特殊化にし、`sigmaY_mul_sigmaZ_site`・`sigmaZ_sigmaY_sigmaZ_site` を足した（`check-no-sorry.sh` に足した）。
    SageMath `050_claim_even_sector_eigenvalues/check_14_sign_flip_step1_F_conjugation_sigma_y_chain.sage`（`QQ(i)`、243 段）を足した（全 PASS）。
    レビューの必須の指摘 1 件（鎖の文字 `a, b` が Step 1 冒頭と `E` の段落の `a, b` と衝突する）を `p, q` に替えて範囲を鎖の中に閉じて直し、任意の指摘 3 件を直した。

  - ゴールラインの確認の四十九個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 1 の `E` による共役の鎖（`k` 奇数）の名前だけの根拠「パウリ行列の積」5 行を扱った（係数は `ℂ`）。
    1 行目の積を `(σ_k^xσ_k^a)σ_k^x` と括弧付きで書き、`a = x` は Step 0 の `σ_m^xσ_m^x = I`・`identity_matrix_is_left_unit_of_mat_mult` の 2 行、`a = y, z` は `mat_mult_associative`・`σ_k^pσ_k^q` の鎖（組 `(y, x)` を足した。`(z, x)` は既存）・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行にした。二重の符号反転は要らない。主張は変えていない。
    Lean は `ClaimSignFlipConjugation.lean` に `sigmaY_mul_sigmaX_site`（`siteOp_mul_of_anticomm` の特殊化）・`sigmaX_sigmaX_sigmaX_site`・`sigmaX_sigmaY_sigmaX_site`・`sigmaX_sigmaZ_sigmaX_site`（人手の 2 行目以降と 1 対 1 の `calc`）を足した（`check-no-sorry.sh` に足した）。
    SageMath `050_claim_even_sector_eigenvalues/check_15_sign_flip_step1_E_conjugation_chains.sage`（`QQ(i)`、135 段）を足した（全 PASS）。
    レビューの必須の指摘は無く、任意の指摘 3 件（`E` の段落に使う道具の文を足す、`E` の鎖の根拠の位置を `\quad` に揃える、check_15 のコメント）を直した。

  - ゴールラインの確認の五十個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` の Step 0 の「可逆行列の有限積も可逆」と、Step 1 の `F`・`E` の鎖の 1 行目「`k` 以外のサイトの因子は可換」「`k` が奇数なら第 `k` 因子だけが効く」「`k` が偶数なら `E` の全因子と可換」を扱った（係数は `ℂ`）。
    `E`・`F` をサイトの行列の積から、クロネッカー積 `E := E_1⊠⋯⊠E_{M_col}`（`E_m` は `m` 奇数で `σ^x`、偶数で `I`）・`F := σ^z⊠⋯⊠σ^z` に定義し直した（同じ行列。check_16 で旧定義との一致も確かめた）。積の定義のままでは、`F = σ_k^zG` への並べ替えと `M_col` 個の積の帰納法が要るため。
    Step 0 は `E_mE_m = I` の 2 行、`FF = I`・`EE = I` の 4 行、`def_invertible_elements_of_R` の一意性による `F^{-1} = F`・`E^{-1} = E`、(ii) による `U^{-1} = F^{-1}E^{-1} = FE^{-1} = FE` の鎖にした。
    Step 1 の先頭に、`W ∈ {E, F}` の `Wσ_k^aW^{-1} = I⊠⋯⊠((W_kσ^a)W_k)⊠⋯⊠I`（7 行）、`p ∈ {x, z}` の `I⊠⋯⊠((σ^pσ^a)σ^p)⊠⋯⊠I = (σ_k^pσ_k^a)σ_k^p`（5 行）、`k` 偶数の `σ_k^a` へ戻す鎖（4 行）を置き、`F`・`E` の各鎖の 1 行目をこれらを引く 2〜3 行に替えた。主張は変えていない。
    Lean は `ClaimSignFlipConjugation.lean` で `Uflip := Eflip * Fflip`、`UflipInv := Fflip * Eflip` とし（`flipFam` は `Uflip_eq_siteProd` で残す）、`eFlipFam_mul_self`・`Fflip_mul_self`・`Eflip_mul_self`・`Uflip_mul_inv`・`UflipInv_mul`（(ii) の証明の 6 行ずつ）、`siteProd_conj_siteOp`・`siteProd_update_conj_eq_siteOp`・`siteProd_update_eFlipFam_conj_of_odd`・`Fflip_conj_siteOp`・`Eflip_conj_siteOp_of_even`・`Eflip_conj_siteOp_of_odd`・`Fflip_conj_sigmaX/Y/Z`・`Eflip_conj_sigmaX/Y/Z_of_even` を置いた（`check-no-sorry.sh` に足した）。人手の `W^{-1} = W` の行は、Lean が `W^{-1}` を置かず `(Wσ_k^a)W` で述べるので立てない。
    SageMath `check_16_sign_flip_step0_E_F_U_invertibility_chains.sage`（120 段）・`check_17_sign_flip_step1_W_conjugation_chains.sage`（690 段）を足した（`QQ(i)`、全 PASS）。
    レビューの必須の指摘 2 件（定義の言い換えで Step 1 の 1 行目の説明が誤りになった、`E_mE_m = I` の 1 段目の根拠が無い）を、上の Step 1 の鎖と `E_mE_m` の表示した鎖で直した。任意の指摘のうち 5 件（`E, F` の所属集合、`(σ^z)^{-1}` の名残、`W = F` の `W_mW_m = I` の根拠、「まず」の重なり、Lean の 1 行目の分割と overview・対応表）を直した。
    残した任意の指摘: `Uflip_conj_sigmaX/Y/Z` は今もサイトごとの因子 `flipFam` の成分計算で示しており、今回の `F`・`E` の鎖の定理を使わない（五十一個目で直した）。

  - ゴールラインの確認の五十一個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 1 の合成の段（`UXU^{-1} = E(FXF^{-1})E^{-1}` を断りなく使い、`(∵ F による共役の計算)`・`(∵ E による共役の場合分け)` の名前だけの根拠で代入と符号の外出しを 1 行にまとめていた）を扱った（係数は `ℂ`）。
    合成の鎖（`U` の定義・Step 0 の `U^{-1} = FE`・`mat_mult_associative` 3 回・Step 0 の `F^{-1} = F`・`E^{-1} = E`・Step 1 冒頭の読み）と、`a = x, y, z` ごとに `F` の式・`negation_factors_out_of_right_factor`・`negation_factors_out_of_left_factor`・`E` の式（`k` の偶奇）を 1 行ずつ引く鎖にした。
    `k` 奇数の `Uσ_k^yU^{-1} = -(-σ_k^y)` を戻す段のために、主張 `matrix_double_negation`（`-(-A) = A`、成分の 6 行の鎖。`(-1_ℂ)(-1_ℂ) = 1_ℂ` は既存の書き方に合わせ `definition_of_cc` の積で引く）を `002_linear_space_general.ts` に足した。
    Step 2 の「Step 1 の第 1 式」「第 2・第 3 式」は Step 1 に `E` の鎖の第 1〜4 式もあって曖昧なので、`Uσ_k^xU^{-1} = -σ_k^x` などの式で指すようにした。主張は変えていない。
    Lean は `ClaimSignFlipConjugation.lean` に `Uflip_conj_eq_Eflip_conj_Fflip_conj`（合成の鎖。`F^{-1}`・`E^{-1}` の行は `Fflip_conj_siteOp` と同じく立てない）・`Uflip_conj_sigmaX_eq_neg`・`Uflip_conj_sigmaY_of_even/odd`・`Uflip_conj_sigmaZ_of_even/odd`・`Eflip_conj_sigmaX/Y/Z_of_odd` を置き、
    `Uflip_conj_sigmaX/Y/Z`（型は変えていない。Step 2 が使うスカラー倍の形）をこれらから導いた。サイトごとの因子の成分計算（`flipFam`・`flipFamInv`・`Uflip_eq_siteProd`・`UflipInv_eq_siteProd`・`Uflip_conj_siteProd`・`Uflip_conj_siteOp`・`conj_pauliX/Y/Z`）は削除した。
    `matrix_double_negation` の具体版 `neg_neg_matrix`、必要十分版 `NecSuf/NegNegMatrix.lean`（`Monoid`・`Neg` に `-x = (-1)x` と `(-1)(-1) = 1` を仮定で渡す。加法・積の可換律は効かない）、系 `neg_neg_tensorPow` を置いた（`check-no-sorry.sh`・README・`lean/docs/ch009-formalization.md` を更新）。
    SageMath `050_claim_even_sector_eigenvalues/check_18_sign_flip_step1_composition_chains.sage`（`QQ(i)` と不定元の `X`、336 段）と `sagemath/check/matrix_double_negation/` を足した（全 PASS）。
    レビューの必須の指摘 2 件（`matrix_double_negation` の overview の題名の写し間違い、この台帳の更新）と任意の指摘 1 件（check_18 の否定コントロールのコメントは `M = 2` でだけ反可換）を直した。

  - ゴールラインの確認の五十二個目（済み、2026-11-02）: `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 2（`Z_m`・`Y_m` への作用）の名前だけの根拠「Step 1 を `Z_m` の各因子に適用」「符号は因子ごとの符号の積」「`m` の偶奇ごとに符号を計算」を扱った（係数は `ℂ`）。
    `P_0 := I`・`P_{r+1} := P_rσ_{r+1}^x`（`r ∈ ℤ_{≥0}`）を置き、`UP_rU^{-1}` が `r` 偶数で `P_r`・奇数で `-P_r` となる帰納法（`conjugation_is_ring_homomorphism` の `T_B` の定義・単位性・乗法性、Step 1 の `Uσ_k^xU^{-1} = -σ_k^x`、符号の外出し 2 本、`matrix_double_negation`）と、`Z_m = P_{m-1}σ_m^z`・`Y_m = P_{m-1}σ_m^y` から `m` の偶奇で場合分けして符号を 1 行ずつ外へ出す鎖にした。`(-1)^{m-1}` のような `ℂ` の冪は使わない。`conjugation_is_ring_homomorphism` を `B = U` で使う宣言を Step 3 から Step 2 へ移した。主張は変えていない。
    Lean は `ClaimSignFlipConjugation.lean` のスカラー倍の形の `Uflip_conj_sigmaX/Y/Z` と `(-1)^k` の `Uflip_conj_xString` を削除し、`Uflip_conj_xString_zero`・`_succ`・`_parity`・`_of_even`・`_of_odd` と、人手の行どおりの `calc` の `Uflip_conj_Z`・`Uflip_conj_Y`（型は変えていない）を置いた（`check-no-sorry.sh`・`lean/docs/ch009-formalization.md` を更新）。
    SageMath `050_claim_even_sector_eigenvalues/check_19_sign_flip_step2_Z_Y_chains.sage`（`QQ(i)`、`M = 2〜5`、436 段）を足した（全 PASS）。
    レビューの必須の指摘は無く、任意の指摘 5 件（`r` の帰属、conversion の Lean の対応の抜け、`Uflip_conj_mul` と `xString`・`xString_succ` の docstring、check_19 の `T_B` の定義の行）を直した。
    残した任意の指摘: 行列の有限積 `σ_1^x⋯σ_r^x` を左から読むことを定めるブロックが本文に無く、`def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の `⋯` と `Z_m = P_{m-1}σ_m^z` の行がそれを前提にしている（下の「次の一歩」に足した）。

  - ゴールラインの確認の五十三個目（済み、2026-11-02）: `sign_flip_conjugation` Step 3 の「共役の ℂ 線型性」（`H_1^{(+)}`・`H_2` の有限和と差への適用）は引ける主張が本文に無く、一回には大きいので、補題の単位に割った（下の次の一歩）。今回はその先頭の「行列の積は因子の和に分配する」を行った（係数は `ℂ`）。
    `002_linear_space_general.ts` に主張 `finite_sum_of_complex_sums`（`Σ_{j=1}^{n}(a_j+b_j) = Σa_j + Σb_j`。`n` の帰納法で、帰納法の段は和の結合律・交換律を 1 行 1 回の 5 行）・`mat_mult_distributes_over_sum_in_right_factor`（`A(B+C) = AB+AC`）・`mat_mult_distributes_over_sum_in_left_factor`（`(A+B)C = AC+BC`。どちらも成分の 6 行の鎖）を足した。
    これらを使い、`008_TV1_hatZ_hatY_part1.ts` の `linearity_of_T` の証明の名前だけの根拠 4 種（左右の分配法則、左右の積とスカラー倍の両立）を、2 つの分配の主張と `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor` へのラベル参照にした（`g·h·g^{-1}` を `(gh)g^{-1}` と読むこと、4 つの主張を `m = n = p = 2^M` で使うことを書き、括弧を全て書いた。主張は変えていない）。
    Lean は具体版 `ClaimMatMultDistributesOverSum.lean`（`finite_sum_of_complex_sums_step`・`_succ`・`finite_sum_of_complex_sums`・`mul_add_matrix(_apply)`・`add_mul_matrix(_apply)`）、必要十分版 `NecSuf/MatMulDistribSum.lean`（係数は `AddCommMonoid`・`Mul`・左または右の分配則。乗法の結合則・単位元・可換則は効かない。有限型の上の和は `Fintype.equivFin` で番号を付けてから同じ帰納法）、導出と `TensorPow M` の系 `mul_add_matrix_tensorPow`・`add_mul_matrix_tensorPow`（`ClaimMatMultDistributesOverSumFromNecSuf.lean`）を置き、
    `linearity_of_T_on_check` を `mul_add`・`add_mul`・`mul_smul_comm`・`smul_mul_assoc` の `rw` から人手の 6 行と 1 対 1 の `calc` にした（`check-no-sorry.sh`・README・`lean/docs/ch014-formalization.md` を更新）。
    SageMath `sagemath/check/finite_sum_of_complex_sums/`・`mat_mult_distributes_over_sum_in_right_factor/`・`mat_mult_distributes_over_sum_in_left_factor/` を足し、`200_linearity_of_T/check_01_linearity.sage` を新しい鎖の括弧どおりに本文の定義の成分の式で組み直した（全 PASS）。
    レビューの必須の指摘 1 件（`n = 2^M` の `n` が証明に出ない）と任意の指摘 4 件（分配の主張の注記が Step 3 の現状と違う、`TensorPow M` の系が必要十分版の特殊化であることの記述、`finite_sum_add'` の番号付けの記述、200 番の overview の注記）を直した。
  - ゴールラインの確認の五十四個目（済み、2026-11-02）: `sign_flip_conjugation` Step 3 の「共役の ℂ 線型性」の補題の単位の (b)（共役は和と有限和を保つ）を行った。
    本文には既に `mat_conj`（`000_calculation_formulae_00_09.ts`。`T_B(A) := BAB^{-1}` は和とスカラー倍を保つ）があったので、新しい和の主張は立てず、その証明の名前だけの根拠 4 か所（左右の分配則、スカラー倍と積の交換 2 か所）を `mat_mult_distributes_over_sum_in_right_factor`・`..._left_factor`・`scalar_multiple_factors_out_of_right_factor`・`..._left_factor` へのラベル参照にした（`BAB^{-1}` を `(BA)B^{-1}` と読むこと、`n ∈ ℤ_{≥1}` を主張に書き、括弧を全て書いた。主張の中身は変えていない）。
    有限和を保つことは主張 `matrix_conjugation_preserves_finite_sum`（`T_B(Σ_{j=1}^{r}X_j) = Σ_{j=1}^{r}T_B(X_j)`。`r` の帰納法で、段は `def_finite_sum_of_matrices`・`mat_conj` の和・帰納法の仮定・`def_finite_sum_of_matrices`）として `mat_conj` の直後に足した。`T_B` は `mat_conj` の `T_B` で立て、`linearity_of_T` の `T_g` には触れていない。
    Lean は具体版 `ClaimMatrixConjugationPreservesSums.lean`（`conj_add_matrix`・`conj_smul_matrix`・`conj_finite_sum_of_matrices`。`T_B` は `Conjugation.T`、`B` は `Mat(n,ℂ)` の単元）、必要十分版 `NecSuf/MatrixConjugationSum.lean`（`B^{-1}` を任意の行列 `B'` に置き換えて述べる。`B` の可逆性と行列の積の結合則は効かない）、導出と `TensorPow M` の系 `conj_add_tensorPow`・`conj_smul_tensorPow`・`conj_finite_sum_tensorPow`（`ClaimMatrixConjugationPreservesSumsFromNecSuf.lean`）を置いた（`check-no-sorry.sh`・README を更新）。
    SageMath は `sagemath/check/122_mat_conj/check_02_chains.sage`（2 本の鎖を一行ずつ）と `sagemath/check/matrix_conjugation_preserves_finite_sum/` を足した（全 PASS）。同じフォルダの既存の `check_01_linearity.sage` は、Sage の起動のされ方で `__file__` が Sage の内部を指し、`_shared/operators.sage` を読めずに落ちる（今回の変更の前から。ログは書き換えていない）。
    レビューの必須の指摘 1 件（必要十分版の「効いている仮定」が、スカラー倍の段の係数の乗法の結合則・左分配則を落としていた）と任意の指摘（注記の「分けた」、122 番の overview の範囲と判定数、前方参照の記録）を直した。
  - ゴールラインの確認の五十五個目（済み、2026-11-02）: `sign_flip_conjugation` Step 3 の補題の単位の (c) を (c1)・(c2) に割り、(c1)（符号反転は和と有限和に分配する）を行った。
    `002_linear_space_general.ts` の `matrix_double_negation` の直後に主張 `negation_distributes_over_matrix_sum`（`-(A+B) = (-A)+(-B)`。成分の 7 行の鎖。根拠は `def_matrix_negation`・`def_matrix_sum`・`multiply_by_minus_one`・`ℂ` の分配律）と
    `finite_sum_of_negated_matrices`（`Σ_{j=1}^{r}(-X_j) = -Σ_{j=1}^{r}X_j`。`r` の帰納法で、段は `def_finite_sum_of_matrices`・帰納法の仮定・`negation_distributes_over_matrix_sum`・`def_finite_sum_of_matrices`）を足した。本文のほかのブロックはまだ引いていない（(d) で `H_2` の鎖が引く）。
    Lean は具体版 `ClaimNegationDistributesOverMatrixSum.lean`（`neg_add_matrix_apply`・`neg_add_matrix`・`neg_finite_sum_of_matrices`）、必要十分版 `NecSuf/NegMatrixSum.lean`（係数は `Add`・`Mul`・`Neg`・`One`・左分配則と、`-x = (-1)x` の仮定 `hneg`。加法の結合則・交換則・零、乗法の結合則・単位元・可換則は効かない）、
    導出と `TensorPow M` の系 `neg_add_tensorPow`・`neg_finite_sum_tensorPow`（`ClaimNegationDistributesOverMatrixSumFromNecSuf.lean`）を置いた（`check-no-sorry.sh`・README を更新）。
    SageMath は `sagemath/check/negation_distributes_over_matrix_sum/`・`finite_sum_of_negated_matrices/` を足した（全 PASS）。
    レビューの必須の指摘は無く、任意の指摘 2 件（必要十分版の `AddCommMonoid` が要る理由の書き方、有限和の検算で `r = 1` の主張を Sage の演算と比べていなかったこと）を直した。
  - ゴールラインの確認の五十六個目（済み、2026-11-02）: `sign_flip_conjugation` Step 3 の補題の単位の (c2)（差と符号反転、共役が差を保つこと）を行った。
    `002_linear_space_general.ts` の `finite_sum_of_negated_matrices` の直後に主張 `matrix_difference_is_sum_with_negation`（`A - B = A + (-B)`。成分の 4 行の鎖。根拠は `def_matrix_difference`・`def_complex_difference`・`def_matrix_negation`・`def_matrix_sum`）と
    `difference_of_negated_matrices`（`(-A)-(-B) = -(A-B)`。行列の等号の 3 行で、`-(-B)` は `B` へ戻さず `negation_distributes_over_matrix_sum` の右辺として読む）を足した。
    `000_calculation_formulae_00_09.ts` の `matrix_conjugation_preserves_finite_sum` の直後に主張 `matrix_conjugation_preserves_negation`（`T_B(-W) = -T_B(W)`。`negation_factors_out_of_right_factor`・`..._left_factor`）と
    `matrix_conjugation_preserves_difference`（`T_B(X-W) = T_B(X)-T_B(W)`。差を和と符号反転へ戻し、`mat_conj` の和を保つことと上の主張で閉じる）を足した。本文のほかのブロックはまだ引いていない（(d) で `H_1^{(+)}` の鎖が引く）。
    Lean は具体版 `ClaimMatrixDifferenceIsSumWithNegation.lean`（`matrix_sub_eq_add_neg_apply`・`matrix_sub_eq_add_neg`・`neg_sub_neg_matrix`）・`ClaimMatrixConjugationPreservesDifference.lean`（`conj_neg_matrix`・`conj_sub_matrix`）、
    必要十分版 `NecSuf/MatrixSubNeg.lean`（差は仮定 `hsub` だけ、`(-A)-(-B)` はそれと和の符号反転だけが効く。二重の符号反転・加法の逆元は効かない）・`NecSuf/MatrixConjugationNegSub.lean`（`B^{-1}` を任意の `B'` に置き換え、係数は `Semiring`・`HasDistribNeg` と `hsub`）、
    導出と `TensorPow M` の系 `sub_eq_add_neg_tensorPow`・`neg_sub_neg_tensorPow`・`conj_neg_tensorPow`・`conj_sub_tensorPow`（2 本の `*FromNecSuf.lean`）を置いた（`check-no-sorry.sh`・README を更新）。
    SageMath は同名の 4 ディレクトリを足した（全 PASS）。レビューの必須の指摘は無く、任意の指摘 3 件（2 行の根拠に代入と適用先を書く、必要十分版に `InvolutiveNeg` が効かないことを書く）を直した。

  - ゴールラインの確認の五十七個目（済み、2026-11-02）: (d) を三つに割った（下の「次の一歩」）。先頭の「`conjugation_is_ring_homomorphism` の `T_B` を `mat_conj` の `T_B` に揃える」を行った。
    `000_calculation_formulae_45_46.ts` の主張を、主張の中で `T_B(A) = BAB^{-1}` と定義し直す形から `mat_conj` の共役写像（`(BA)B^{-1}`）について述べる形にし、正則の意味（`BB^{-1} = I` かつ `B^{-1}B = I`）を主張に書き、合成則の正則な行列を `G, H` にして「`GH` は正則」を主張に入れた（証明の準備で示していたこと）。
    三つの鎖の括弧を外した行を括弧付きにし、「行列の積の結合法則」「単位元の性質」を `mat_mult_associative`・`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult` へのラベル参照にした（乗法性 9 行、単位性 3 行、右逆元・左逆元 各 5 行、合成則 8 行）。
    「逆元の一意性から `(AB)^{-1} = B^{-1}A^{-1}`」を、`(GH)^{-1}(GH) = I` と右逆元の鎖から出す 5 行の鎖にした。主張は弱めていない（「`GH` は正則」を足した分だけ強めた）。
    Lean は具体版 `ClaimConjugationIsRingHom.lean` の節 `ComplexMatrixChains`（`(Matrix (Fin n) (Fin n) ℂ)ˣ` の単元で、`conj_mul_matrix`・`conj_one_matrix`・`mul_mul_inv_rev_matrix`・`inv_rev_mul_mul_matrix`・`mulUnitOfChains`（2 本の鎖から組んだ単元）・`mulUnitOfChains_eq_mul`・`units_mul_inv_rev_matrix`・`conj_comp_matrix`（この 2 本は値が `GH` のどの単元 `U` についても述べる）・`conj_comp_matrix_of_chains`）を置き、
    必要十分版 `NecSuf/Conjugation.lean` の `sandwich_mul`・`sandwich_one`・`sandwich_comp` を同じ段の `calc` に書き直し、導出 `conj_*_matrix_of_necSuf` と `TensorPow M` の系 `conj_mul_tensorPow`・`conj_one_tensorPow` を `ClaimConjugationIsRingHomFromNecSuf.lean` に置いた。
    `sign_flip_conjugation` の `Uflip_conj_mul`・`Uflip_conj_xString_zero` は一般の環の `Conjugation.T_mul`・`T_one`（`simp` でまとめるので人手と 1 対 1 でない）からこの系へ付け替えた。一般の環の `T_mul` ほかは残し、README の表に 1 対 1 でないことを書いた。
    SageMath は `117_conjugation_is_ring_homomorphism/check_02_chains.sage`（五本の鎖を一行ずつ、`QQ` 上の厳密計算、PASS）。レビューの必須の指摘 5 件（一意性の段の 1 対 1、`GH` の正則性を Lean で鎖から組むこと、正則の意味の置き場、段数のコメント、`T_mul` の説明）と任意の指摘 8 件を直し、再レビューで必須の指摘が無くなった。

  - ゴールラインの確認の六十二個目（済み、2026-11-02）: 上の (g) を行った。`eigenvalue_problem_eigenvalues_of_V_plus.ts` の `check_number_operator_idempotent` (3) の鎖を 17 行（`mat_mult_associative` 4 回・`matrix_difference_is_sum_with_negation` 2 回・`mat_mult_distributes_over_sum_in_left_factor`・`identity_matrix_is_left_unit_of_mat_mult`・`negation_factors_out_of_left_factor`・`mat_mult_distributes_over_sum_in_right_factor`・`negation_factors_out_of_right_factor`）、
    `check_number_operators_commute` Step 2 の鎖を 10 行（`mat_mult_associative` 3 回・`negation_factors_out_of_left_factor`・`negation_factors_out_of_right_factor`・`matrix_double_negation`）、Step 3 の「結合法則」3 か所を `mat_mult_associative` の参照にした。主張は変えていない。証明中の変数 `A, B` は引く主張の変数との衝突を避けて `X, W` にした。
    Lean は `EigenvalueProblem/EigenvaluesOfVPlus/DefinitionCheckNumberOperator.lean` の `nOp_mul_self`・`mul_nOp_of_anticommute`・`commute_cre_nOp`・`commute_ann_nOp`・`nOp_mul_nOp_of_ne`・`commute_nOp_nOp`（型は変えていない）を人手の行どおりの calc にし、必要十分版の特殊化を `nOp_mul_self_of_necSuf` ほか `*_of_necSuf` に改名して残した。必要十分版 `NecSuf/NumberOperator.lean` の `num_mul_num`・`commute_mul_of_anticommute`・`commute_num_num` も `noncomm_ring` をやめて同じ段にした（`check-no-sorry.sh`・`lean/docs/ch017-formalization.md` を更新）。
    SageMath は `050_claim_even_sector_eigenvalues/check_23_check_number_operator_associativity_chains.sage`（Jordan–Wigner の模型で `QQ` の 693 段、不定元で 28 段、否定コントロール 6 行。PASS）。
    レビューの必須の指摘 2 件（overview の表の列、ch017 の「特殊化して導出」の文）と任意の指摘 5 件（変数の衝突、必要十分版のコメント 3 件、両版の対応の記述）を直した。
  - ゴールラインの確認の六十五個目（済み、2026-11-02）: 上の (j) を行った。`max_eigenvalue_of_V_plus_simple` (3) の固有方程式に左から `Q̌_{ε'}` を掛ける鎖の「行列の積の結合法則」を `mat_mult_associative`（`q → 1`）の参照にし、(1) の行と固有方程式の行に隠れていたスカラー倍の外出しを `scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`（`p → 1`）の行に分けた（5 行。主張は不変）。
    Lean は `DiagonalizationAndExponentialForm/TheoremMaxEigenvalueSimple.lean` に人手の 5 行と 1 対 1 の `checkBigLambda_smul_Qproj_mulVec_of_eigen` を足し、`eq_Qproj_univ_mulVec_of_eigen` を人手の順（鎖 → 差が 0 → 割る → 和の項を消す）の具体版に書き直し、必要十分版 `NecSuf.eq_proj_of_eigen` の特殊化を `eq_Qproj_univ_mulVec_of_eigen_of_necSuf` に残した。必要十分版の中の段も同じ 5 段の calc（`hchain`）にし、冒頭の人手の筋の記述を今の人手に合わせた。`check-no-sorry.sh` に 2 定理を足した。
    SageMath は `050_claim_even_sector_eigenvalues/check_26_max_eigenvalue_simple_left_projection_chain.sage`（Jordan–Wigner の模型で `M = 2, 3, 4`、`QQ` の厳密等号 143 段、否定コントロール 2 行。PASS）。
    レビューの必須の指摘 2 件（`check-no-sorry.sh` の対象、両版のステップの対応）を直した。
    再レビューの必須の指摘「検算ファイル名の番号」は、CLAUDE.md の例外 1（SageMath 検証と証明の対応キー。内容の分かる名前を含む）に当たるので残した。任意の指摘のうち、注記の存在しない名前空間 `Ising2D.Abstract.eq_proj_of_eigen` と「作用の 4 法則」（実際は 5 つ）は直した。残り（必要十分版のスカラーを ℂ に固定している件。証明は `sub_smul`・`smul_eq_zero`・`sub_eq_zero` しか使わない。同じ章の注記の `Ising2D.Abstract.two_pow_smul_tau_projOn`）は次の一歩の件に残す。
  - ゴールラインの確認の六十六個目（済み、2026-11-02）: 上の (k) を行った。`V_plus_is_invertible` Step 2 の `a := (2s_2)^{M_col/2}` を `ℝ` の元として宣言し（`s_2 ∈ ℝ_{>0}` は `V_plus_is_positive_definite`）、`def_matrix_scalar_multiple` の係数が `ℂ` であることから、Step 2・Step 3 の鎖の係数を `inclusion_rr_to_cc` の `a_ℂ`・`(a^{-1})_ℂ` で書いた。
    `aa^{-1} = 1_ℂ` の 1 行を `real_inclusion_preserves_product`（`a → a, b → a^{-1}`）・`ℝ` の `aa^{-1} = 1`・略記 `1_ℂ = (1)_ℂ` の 3 行に分けた（Step 3 も同じ）。主張の `R^{(+)}` と `V_plus_is_positive_definite` の主張・Step 1 の `V_2` の鎖・Step 3 の係数を `((2s_2)^{M_col/2})_ℂ` と書いた。主張の文の崩れ（「置く」の二重）も直した。主張は不変。
    Lean は `ClaimVPlusPositiveDefinite.lean` の `VPlus_mul_VPlusInv`・`VPlusInv_mul_VPlus` の `a` を `ℝ` にし、`Complex.ofReal_mul`・`mul_inv_cancel₀`・`Complex.ofReal_one` を人手の 3 行に 1 段ずつ当てた calc にした（定理の型は不変。`real_rpow_neg_half_M_eq_inv`・`real_rpow_two_s2_ne_zero` を足した。`real_inclusion_preserves_product` の Lean の具体版は無く、mathlib の `Complex.ofReal_mul`）。
    SageMath は `050_claim_even_sector_eigenvalues/check_27_V_plus_inverse_real_inclusion_chains.sage`（`ℝ` は `AA`、`ℂ` は `QQbar`。168 段、否定コントロール 12 行。PASS）。`check_10` の冒頭に係数の段は `check_27` が覆うと書いた。
    レビューの必須の指摘 4 件（`V_plus_is_positive_definite` の係数が包含なしで「〜の意味である」が同一視になっていた、`a^{-1}` の検算が自明だった、主張の文の崩れ、検算の再実行）と任意の指摘 4 件（`(1)_ℂ` の行、`s_2 > 0` の参照、`Complex.ofReal_mul` の注記、否定コントロールを鎖の中で）を直した。
    残した件: `V2_exponential_representation` が係数を `K_2^*, s_2 ∈ ℝ_{>0} ⊂ ℂ` と包含の同一視で書いている（論文全体の `K_1, K_2^*` の帰属の件と同じ扱い）。
  - ゴールラインの確認の六十七個目（済み、2026-11-02）: 「(k) の後に扱う」残りの先頭の `check_number_operator_idempotent` を行った（`check_number_operators_commute` Step 1 の「すなわち `XW = -(WX)`」は次の回）。
    `002_linear_space_general.ts` に定義 `def_matrix_anticommutator`（`[X, W]_+ := XW + WX`）と主張 `zero_matrix_is_left_zero_of_mat_mult`（`O_{m,n}B = O_{m,p}`、成分の 5 行）・`matrix_sum_with_itself_zero_implies_zero`（`X + X = O ⇒ X = O`。`2_ℂ = ι(2)` の準備の 2 本の鎖と成分の 11 行）・`matrix_summand_from_sum_equation`（`A + B = C ⇒ B = C - A`、成分の 8 行）を足した。
    `check_number_operator_idempotent` の (1)(2) の「反交換子の定義」「同じ項の和」「ℂ の四則」をこれらと `def_kronecker_delta`・`scalar_multiple_by_one` の参照にし、(1) の主張を 2 乗から積 `= O` の形にした。(3) の鎖の先頭に `def_exp` (1) の冪を積へ運ぶ 4 行を足し、末尾の `ň - 0·0`・「零元との積と減法」を (1) の第 1 式・第 2 式・`zero_matrix_is_left_zero_of_mat_mult`・`matrix_minus_zero_matrix` の 4 行にした。`anticommutator_of_check_psi` の主張に反交換子の定義と右辺 `0` が零行列であることを書いた。主張の中身は変えていない。
    Lean は具体版 `DefinitionMatrixAnticommutator.lean`・`ClaimZeroMatrixProductAndSumEquations.lean`、必要十分版 `NecSuf/MatrixZeroMulAndSumEquations.lean`、導出と `TensorPow M` の系 `ClaimZeroMatrixProductAndSumEquationsFromNecSuf.lean` を置き、`DefinitionCheckNumberOperator.lean` の `cre_sq`・`ann_sq`・`ann_mul_cre` を人手の鎖と 1 対 1 の具体版にし（必要十分版の特殊化は `*_of_necSuf`）、`nOp_sq`（冪の 4 段）を足し、`nOp_mul_self` の末尾を同じ 4 段にした。`NecSuf.ann_mul_cre` を mathlib の 1 行から同じ並びの calc にした。`tensorPow_two_torsion_free` は新しい系の別名にした。
    SageMath は `sagemath/check/` の同名 3 ディレクトリと、`050` の `check_23` の更新・`check_28`（全 PASS）。
    レビューの必須の指摘 2 件（`2_ℂ` を `inclusion_rr_to_cc` の略記と二重に定義していた、`050` の overview の段数）と任意の指摘 4 件を直した。
    残した任意の指摘: `cre_ann_add_ann_cre_eq_one` は `CheckFermiSetup` が反交換関係の右辺を `if` で受け取るため、人手の `δ = 1_ℂ`・`1_ℂI = I` の 2 行が `if_pos` の 1 段になる。具体版が引く `TensorPow M` の系は必要十分版の特殊化である（既存の `identity_matrix_mul_tensorPow` などと同じ。上の `TensorPow M` の件）。`anticommutator_of_check_psi` の表示式の右辺は `0` のままで、散文で零行列 `O` と断っている。

  - ゴールラインの確認の六十八個目（済み、2026-11-02）: 「(k) の後に扱う」残りの `check_number_operators_commute` Step 1 の「すなわち `XW = -(WX)`」を行った。
    Step 1 の 4 式の右辺を `anticommutator_of_check_psi` の意味どおり零行列 `O` と書き、「すなわち」を `XW + WX = [X, W]_+ = O`（`def_matrix_anticommutator` を右辺から左辺へ・4 式）の 2 行の鎖と既存の `matrix_equals_negation_if_sum_is_zero`（主張の `X → XW`、`Y → WX`）の参照にした。
    レビューの指摘で、第 2 式・第 3 式の `δI = O` を `δI = 0_ℂI = O` に、第 3 式の「反交換子が引数の順序に依らない」を和の交換・定義へ戻す・第 2 式・`δ` の対称性の行に開き（第 3 式は 7 行）、`δ_{μ,ν} = 0` に `def_kronecker_delta` の参照を付けた。このため `002_linear_space_general.ts` に主張 `zero_scalar_multiple_is_zero_matrix`（`0_ℂA = O`）・`matrix_sum_is_commutative`（`A + B = B + A`）を足した。主張の中身は変えていない。
    Lean は `matrix_equals_negation_if_sum_is_zero` の具体版 `ClaimMatrixEqualsNegationIfSumIsZero.lean`（それまで Lean の対応が無かった）・必要十分版 `NecSuf/MatrixEqNegOfAddEqZero.lean`（係数は `AddGroup`。乗法は効かない）・系 `…FromNecSuf.lean`、新しい 2 主張の具体版 `ClaimZeroScalarMultipleAndMatrixSumCommutative.lean`・必要十分版 `NecSuf/ZeroSmulAndAddCommMatrix.lean`・系、`DefinitionCheckNumberOperator.lean` の Step 1 の 4 式 `anticomm_*_eq_zero`（人手の行と 1 対 1 の calc）と `mul_eq_neg_of_anticomm_eq_zero`、場の `if c then I else O` を `δI` へ読み替える `ite_one_zero_eq_delta_smul` を置き、`commute_cre_nOp`・`commute_ann_nOp` から `eq_neg_of_add_eq_zero_left/right` を外した。
    SageMath は新しい 2 ディレクトリと `050` の `check_29`（20 組、厳密等号 520 個、否定コントロール 6 行。全 PASS）。
    レビューの必須の指摘 4 件と任意の指摘 5 件を直した。残した任意の指摘: `mul_eq_neg_of_anticomm_eq_zero` が引くのは具体版ではなく `TensorPow M` の系（上の `TensorPow M` の件と同じ）。`ite_one_zero_eq_delta_smul` の `1_ℂI = I` は `scalar_multiple_by_one` の `TensorPow M` の系が無いので mathlib の `one_smul`（下の「`scalar_multiple_by_one` に Lean の具体版が無い」件）。

  - ゴールラインの確認の七十個目（済み、2026-11-02）: `check_joint_eigenspace_decomposition` の (l2) を行った。Step 3 の「`ε_ν=1` と単位元の積」を `scalar_multiple_by_one` を右辺から左辺へ引く行と場合の仮定の行に、
  - ゴールラインの確認の七十一個目（済み、2026-11-02）: `check_joint_eigenspace_decomposition` の (l3) を三つに割り、(l3a) を行った。行列の有限積の定義 `def_finite_product_of_matrices` と主張 `zero_matrix_is_right_zero_of_mat_mult`・`finite_product_of_identity_matrices` を足し、Step 1・Step 2 の最後の行をその参照にした（主張の中身は不変）。Lean は具体版・必要十分版・`TensorPow M` の系、SageMath は新しい 2 ディレクトリと `050` の `check_32`。
    「`ε_ν=0` と零元の積」を `zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ引く行と場合の仮定の行に、「`Q̌_ε` の定義とスカラーの分配」を Step 3 の最初の鎖・直前の二つの場合・`scalar_multiple_factors_out_of_right_factor`・異なる添字の因子の可換性・`Q̌_ε` の定義の 5 行に割った。
    Step 3 の最初の鎖の右辺と最後の鎖の 1 行目を `(∏_{μ≠ν}R_μ)(ň_νR_ν)` とかっこ付きで書いた（主張の中身は不変）。
    Lean は `scalar_multiple_by_one` の具体版 `ClaimScalarMultipleByOne.lean`（それまで Lean の対応が無かった）・必要十分版 `NecSuf/OneSmulMatrix.lean`（スカラーの `1 • x = x` だけが効く）・系 `…FromNecSuf.lean`（`one_smul_tensorPow`）と、
    Step 3 の二つの場合の鎖と 1 対 1 の `nOp_mul_projFactor_of_mem`・`nOp_mul_projFactor_of_not_mem`（`ClaimCheckJointEigenspace.lean`）。SageMath は `050` の `check_31`（568 段、否定コントロール 2 行。PASS）。
    レビューの必須の指摘は無く、任意の指摘 5 件を直した。Step 3 の最後の鎖の Lean の具体版は (l5) で置く（`nOp_mul_Qproj` はまだ必要十分版の特殊化）。`ε_ν ∈ {0,1}` を ℂ の係数として使う帰属は論文全体の帰属の件に残る。

## 次の一歩

runbook のゴールラインの確認を続ける。先頭の一つだけを行う。

- 本文のほかの証明（`003_exp_linear_map.ts`・`004_transfer_matrix.ts`・`005_exp_conjugation_proof.ts`・`008_TV1_hatZ_hatY_part1.ts`・`009_eigenvalues_of_V.ts` と章のファイル）が、
  「単位行列の性質」「行列のスカラー倍の定義」「行列の和の定義」「行列の差は成分ごと」を、名前だけで根拠にしている（約 30 か所）。`def_identity_matrix`・`def_matrix_scalar_multiple`・`def_matrix_difference`・`def_zero_matrix` へのラベル参照に替える。
  行列の和を定義するブロックは `def_matrix_sum`（`002_linear_space_general.ts`、2026-11-01 に SageMath の検算の連続実行が足した）。各ブロックの Lean の対応も確かめる。
  1 回に 1 ファイルずつ進める（`002_linear_space_general.ts` の `scalar_identity_commutes` は三十二個目、`006_Z_Y_anticommutation.ts` の `pauli_matrix_products` は三十三個目で済んだ。行列の符号反転は `def_matrix_negation` を引く）。`003_exp_linear_map.ts` は三十四個目で、係数が `ℂ` の 1 か所だけ替えた。`005_exp_conjugation_proof.ts` は三十五個目で 4 か所とも替えた。`004_transfer_matrix.ts` は三十六個目で 5 か所とも替えた（行列の有限和は `finite_sum_of_matrices_entrywise` を引く）。`008_TV1_hatZ_hatY_part1.ts`・`009_eigenvalues_of_V.ts` は三十七個目で 4 種が 0 か所と確かめ、同じ回に `partition_function_projection_and_jordan_wigner.ts` の 4 か所を替えた。`eigenvalue_problem_reduction_to_A_theta.ts` は三十八個目で、本文の主張で引ける 23 か所を替えた。同じファイルの「零行列の和は零行列」「零行列を引いても変わらない」は三十九個目で扱った（一つの添字を除いた集合の上の和の 4 か所は下の「有限和の添字の付け方」の件に残る）。`003_exp_linear_map.ts` の残りの係数が `ℂ` の箇所は四十個目で扱った（`theorem_exp_zero` の「零行列のスカラー倍は零行列」を新しく足した `scalar_multiple_of_zero_matrix`、「零行列は加法の単位元」を `matrix_plus_zero_matrix` に替えた）。このファイルに残る名前だけの根拠（`theorem_exp_product` の `AI = A = IA`、`scalar_exp_is_limit_of_partial_sums`・`scalar_exp_product`・`scalar_exp_zero` の「単位行列の対角成分」「行列の和とスカラー倍は成分ごと」「零行列のスカラー倍」「行列の差は成分ごと」など）はどれも係数が `K = ℝ` または `ℂ` なので、下の `K` の件で扱う。`theorem_exp_zero` の Lean の具体版は無い（Lean の `exp` は mathlib の `NormedSpace.exp` で、`exp(O) = I` は使う側が `Complex.exp_zero` などで閉じている）。`004_transfer_matrix.ts` の「単位行列の非対角成分」「単位行列の対角成分」2 か所は四十一個目で替えた。`005_exp_conjugation_proof.ts` の係数が `ℂ` で既存のラベルで引ける 3 か所（`def_ad_X_matrix` の単位行列の 2 か所、`matrix_exp_conjugation` Step 1 の両立の 1 行）は四十二個目で替えた。`matrix_exp_conjugation` の残り 3 か所は四十三個目で、主張 `scalar_multiple_distributes_over_matrix_difference`（`c(A−B)=cA−cB`）・`negation_factors_out_of_left_factor`（`(−A)B=−(AB)`）・`negation_factors_out_of_right_factor`（`A(−B)=−(AB)`）を `002_linear_space_general.ts` に足して替えた（SageMath の検算、Lean の具体版 `matrix_smul_sub`・`neg_mul_matrix`・`mul_neg_matrix`、必要十分版 `NecSuf/SmulMatrixSub.lean`・`NecSuf/NegMatrixProduct.lean` を置いた。必要十分版は係数の乗法の可換則も加法の逆元も要らない）。`ad_binomial` の「単位行列との積とスカラー `1` 倍」（1 行に 3 つの事実を使っている）は係数が `K = ℝ` または `ℂ` なので下の `K` の件で扱う。同じファイルに残る `matrix_exp_conjugation` Step 6 の「行列の和の結合則と `(-Q_N)+Q_N=O`」と Step 7 の「行列の加法についての逆元 `X+(-X)=O`」は 4 種とは別の根拠で、引ける主張が本文に無い（行列の加法の結合則・逆元を主張として足すかは、この 4 種が済んでから扱う）。`eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 3 の 2 か所と `V_plus_is_invertible` の 4 か所は四十四個目で替えた。次は同じファイルの残り（下の件）を済ませてから `eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`・`thermodynamic_limit_*.ts` ほかの章のファイル。
  `002_linear_space_general.ts` の `matrix_completeness` Step 3 の「行列の差は成分ごとである」は `K = ℝ` または `ℂ` の行列で、`def_matrix_difference` は `ℂ` しか覆わないので、そのままは参照に替えられない（`mat_mult` を `K` について述べる件と同じ扱い。SageMath の連続実行の台帳にも記録がある）。
  `003_exp_linear_map.ts` の残り 4 か所（係数が `K` か `ℝ` の行列の差）も同じである。`def_matrix_difference`（と `def_zero_matrix`）を `K = ℝ` または `ℂ` について述べ直せば、この 5 か所を参照に替えられる。
- `matrix_exp_conjugation` の Lean は人手証明と 1 対 1 でない（四十二個目のレビュー）。具体版 `ClaimExpConjugation.lean` は `TensorPow M` 上で必要十分版 `NecSuf/ExpConjugation.lean` を特殊化するだけで、本文の Step 1〜7（ad の線型性、`ad_binomial`、有限和の組み替え、ノルム評価、逆元）に対応する補題が無い。必要十分版の論法（左右の乗法の可換性と `exp_add_of_commute`）も本文と別である。本文の手順に沿った具体版を置くかを判断する（通しの証明の判定スクリプトの主張には影響しない）。
- 有限和の添字の付け方が本文で定まっていない。複素数の有限和 `def_finite_sum_of_complex_numbers`（添字 `1..m`）と行列の有限和 `def_finite_sum_of_matrices`（添字 `1..r`）は、添字が `1` から始まる場合しか定めない。
  本文は `Σ_{p=0}^{N}`（`exp_of_diagonal_matrix` など）と、多重添字の集合 `𝓘`・`𝓘×𝓘` の上の和（`end_agrees_with_matrix_vector_product` の基底による展開と主張の鎖、ほか `ℂ` の和を `𝓘` で取る既存の箇所）を使っており、`𝓘` の上で「左から足す」順序（`ν` で並べる等）を定めていない。複素数と行列の両方の有限和について、有限集合の添字の付け方を定める 1 件として扱う。
  `commutator_of_H_and_check_Z_Y` Step 1 の「零行列の和は零行列（一つの添字を除いた集合の上の和。空の和を含む）」4 か所（`[H_2, Z_j]`・`[H_2, Y_j]`・`[H_1^{(+)}, Z_j]`（`2 ≤ j`）・`[H_1^{(+)}, Y_j]`（`j ≤ M_col−1`））も、この件で添字の集合の上の和と空の和（`M_col = 2` の後の 2 か所）を定めてから `finite_sum_of_zero_matrices` を広げて参照に替える。同じ鎖の前の行「`a = j`（`m = j−1`、`m = j`）の項を有限和から分ける」も同じ件である。
- 本文に「行列の等号は成分ごと」を定める定義のブロックが無い（`matrix_difference_zero_iff_equal`・`mat_columnwise`、三十九個目・四十個目で足した `matrix_plus_zero_matrix`・`scalar_multiple_of_zero_matrix` などの証明の末尾が名前だけで根拠にしている）。
  また数ベクトルを `m` 行 1 列の行列として扱うことを `mat_mult` が「みなす」と書いており、三十個目の定義もそれに乗っている（証明の書き方の「同一視をしない」）。
  行列の等号の定義と、数ベクトルと 1 列の行列を行き来する写像に名前を付けるかを判断する（Lean の数ベクトルは `Fin m → ℂ` で、1 列の行列とは別の型である）。
- 単位行列の記号が本文で `I`・`I_{\mathrm{Mat}(k,\mathbb{C})}`（`def_identity_matrix`）・`I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`（9 か所）・`I_{(\mathbb{C}^2)^{\otimes M}}`（2 か所）と分かれている。`def_identity_matrix` は `I_{\mathrm{Mat}(k,\mathbb{C})}` しか覆わない。記号を揃えるか定義に挙げるかを判断する。
- `theorem_exp_zero` の SageMath の検算 `sagemath/check/138_theorem_exp_zero/` は、scipy の `expm` と級数の和を行列全体で比べるだけで、証明の鎖を一行ずつは確かめていない（四十個目のレビューの任意の指摘）。全証明の SageMath 検算の連続実行の扱いに合わせて、鎖の各行の検算を足すかを決める。
- `def_eigenvector`（`000_calculation_formulae_45_46.ts`）が引く `def_matrix_scalar_multiple` は `002_linear_space_general.ts` にあり、生成物のファイルの並びでは後に来る（検査は落とさない）。`mat_conj`・`matrix_conjugation_preserves_finite_sum`（`000_calculation_formulae_00_09.ts`）が引く分配の 2 主張・スカラー倍を積の外へ出す 2 主張・`def_finite_sum_of_matrices` も同じである（五十四個目）。出版物で定義より前に参照が出るかを確かめ、出るなら置き場を直す。
- 2026-11-01、SageMath の検算の連続実行が人手 `trace_basic_properties` を直した（(3) の右辺を `Σ_{k=1}^{n} 1_C` に、(4) を「`P'P = I` なら `tr(P(AP')) = tr(A)`」に、各鎖を一ステップ一定理に）。`DefinitionTrace.lean` の `trace_one_eq_card`（`(card n : ℂ)`）と `trace_conj`（`(P * A * Q).trace` は `(PA)Q`、手順も人手の 5 行と対応しない）を人手と一対一に直す。
- 本文に `(-1)·(-1) = 1`（ℂ）を主張として置くブロックが無い。`V1_in_Z_Y_epsilon` の Step 0 の σ^yσ^x の鎖が `definition_of_cc` の積の名前で引いており、Lean は `neg_one_mul`・`neg_neg` の 2 補題で閉じている（三十七個目のレビューの任意の指摘）。主張として足して引くかを判断する。
- Lean の `TensorPow M` は行列の添字を `Conf M`（`Fin M → Fin 2`）に取り、人手の `Mat(2^{M_col},ℂ)` の添字 `1, …, 2^{M_col}` と型が違う。このため単位行列・差の段では、添字が `Fin m` の具体版ではなく、必要十分版を `Conf M` へ特殊化した系（`identity_matrix_mul_tensorPow` ほか、`scalar_identity_commutes_tensorPow`）を使っている（三十八個目のレビューの任意の指摘）。上の「有限和の添字の付け方」の件と合わせて、人手が多重添字の集合 `𝓘` で行列を添字づけるのか、Lean が `Conf M` と `Fin (2^M)` の間の写像に名前を付けるのかを判断する。

- `eigenvalue_problem_eigenvalues_of_V_plus.ts` に残る名前だけの根拠（四十四個目のレビュー）。`sign_flip_conjugation` Step 0 の `σσ = I` は四十六個目で済んだ。Step 1 の `F` による共役の 3 本の「パウリ行列の積」は四十七個目・四十八個目で済んだ。`E` による共役の鎖の「パウリ行列の積」5 か所は四十九個目で済んだ。Step 0 の「可逆行列の有限積も可逆」と `F`・`E` の鎖の 1 行目は五十個目で済んだ（`E`・`F` をクロネッカー積で定義し直した）。Step 1 の合成の段と、その中の代入と符号の外出しの行は五十一個目で済んだ（Lean の `Uflip_conj_sigmaX/Y/Z` も人手の合成の行どおりに組み直した）。Step 2 の `Z_m`・`Y_m` への作用は五十二個目で済んだ（`P_r` の帰納法と `m` の偶奇の場合分けの鎖。Lean の `Uflip_conj_xString_*`・`Uflip_conj_Z`・`Uflip_conj_Y`）。次は Step 3 の「共役の ℂ 線型性」（`H_1^{(+)} = Σ_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1`・`H_2 = Σ_{m=1}^{M_col}Z_mY_m` への適用）で、五十三個目で次の補題の単位に割った（上から順に 1 回に 1 つ）。(a) 行列の積は因子の和に分配する（五十三個目で済んだ）。(b) 共役は和と有限和を保つ（五十四個目で済んだ。和は既存の `mat_conj`、有限和は `matrix_conjugation_preserves_finite_sum`。どちらも `mat_conj` の `T_B` について述べ、`T_g` には触れていない）。(c) 符号反転と和・差。五十五個目でさらに二つに割った。(c1) 符号反転は和と有限和に分配する: `-(A+B) = (-A)+(-B)`（`negation_distributes_over_matrix_sum`）、`Σ_{j=1}^{r}(-X_j) = -Σ_{j=1}^{r}X_j`（`finite_sum_of_negated_matrices`、帰納法）（五十五個目で済んだ）。(c2) 差: `matrix_difference_is_sum_with_negation`・`difference_of_negated_matrices`・`matrix_conjugation_preserves_negation`・`matrix_conjugation_preserves_difference`（五十六個目で済んだ）。次は (d)。(d) は五十七個目で次の三つに割った（上から順に 1 回に 1 つ）。(d0) `conjugation_is_ring_homomorphism` の `T_B` を `mat_conj` の `T_B` に揃える（五十七個目で済んだ。下の「(d) の前に」の件と、括弧の読み・証明の 1 段目の件はこれで済んだ）。(d1) `H_2` の鎖（`UH_2U^{-1} = T_U(Σ Z_mY_m) = Σ T_U(Z_mY_m) = Σ(-(Z_mY_m)) = -Σ Z_mY_m = -H_2`）と Lean の `Uflip_conj_H2` の書き直し。（五十八個目で済んだ。人手の鎖は `def_H2`・`T_B` の定義・`matrix_conjugation_preserves_finite_sum`・`T_B` の定義を各項に・項の鎖・`finite_sum_of_negated_matrices`・`def_H2` の 7 行。Lean は項の鎖を `Uflip_conj_ZY`（5 段）、`Uflip_conj_H2` を `M = r + 1` の `calc` 7 段（`M = 0` は空の和の場合）にした。SageMath は `check_20_sign_flip_step3_H2_chain.sage`。Step 3 冒頭の `H_2` の出典も `def_H2` にした）。(d2) は五十九個目で済んだ（人手の鎖は `def_H1_plus`・`T_B` の定義・`matrix_conjugation_preserves_difference`・`matrix_conjugation_preserves_finite_sum`（`r = M_col−1 ≥ 1`）・`T_B` の定義を各項と引く項に・項の鎖・`finite_sum_of_negated_matrices`・`difference_of_negated_matrices`・`def_H1_plus` の 9 行。Lean は `lastSign` 付きの和を人手の差の形へ読み替える `H1plus_eq_sub`、項の鎖 `Uflip_conj_YZ`（5 段）、`Uflip_conj_H1plus` を `M = r + 2` の `calc` 9 段（`M = 0, 1` は人手の範囲外で一般形 `Uflip_conj_H1 (-1)`）にした。SageMath は `check_21_sign_flip_step3_H1plus_chain.sage`）。(e) は六十個目で済んだ（項の鎖の根拠を「Step 2 の `UY_mU^{-1} = Y_m` を `m = j` で」に直し、`j, k ∈ {1, …, M_col}` を宣言した。Step 3 の鎖が引く主張の変数の置き方を、行末の `(n → 2^{M_col}, B → U)`・`(m → …, A → …, B → …)` の形に揃え、有限和の項は `(X_1, …, X_r) → (…)` の列、和の値を置く変数の添字は `ℓ` で書いた。Step 2 の前の段落「以下、共役が ℂ 線型で積を保つこと（…）を繰り返し使う」は削った。Lean の Step 3 のコメントも同じ形にした）。これで `sign_flip_conjugation` の Step 3 の件は済んだ。同じファイルのほかのブロックに残る名前だけの根拠は、六十一個目でブロックの単位に割った（上から順に 1 回に 1 つ）。(f) `iH_is_real_symmetric` Step 1・Step 2 のスカラー倍の鎖（六十一個目で済んだ。主張 `scalar_multiple_distributes_over_matrix_sum`・`finite_sum_of_scalar_multiples` を `002_linear_space_general.ts` に足し、`H_2`・`S_2`・`S_1^{(+)}` の鎖を `finite_sum_of_scalar_multiples`・`scalar_multiple_distributes_over_matrix_difference`・`scalar_multiple_is_associative`・ℂ の積の結合律・交換律・単位元の 1 行 1 主張にした。Lean は具体版 `ClaimScalarMultipleDistributesOverMatrixSum.lean`、必要十分版 `NecSuf/SmulMatrixSum.lean`、`TensorPow M` の系 `smul_add_tensorPow`・`finite_sum_smul_tensorPow`・`smul_sub_tensorPow`、鎖と 1 対 1 の `EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`（`H2_eq_neg_I_smul_sum_sigmaX`・`S2_eq_K2star_smul_sum_sigmaX`・`S1plus_eq_K1_smul_sub`）。SageMath は 2 主張の検算と `050` の `check_22_iH_real_symmetric_scalar_chains.sage`）。(g) `check_number_operator_idempotent`・`check_number_operators_commute` の「結合法則」6 か所（六十二個目で済んだ。`trace_of_check_number_operator_product` には「結合法則」は無かった。(3) の鎖の「行列の積の分配法則」の行と、commute Step 2 の「(-1)^2 = 1」の行も既存の主張の参照に割った。Lean は `DefinitionCheckNumberOperator.lean` の `nOp_mul_self`（17 段）・`mul_nOp_of_anticommute`（10 段）・`nOp_mul_nOp_of_ne`（7 段）を人手と 1 対 1 の calc にし、必要十分版の特殊化を `*_of_necSuf` に残した。SageMath は `050` の `check_23_check_number_operator_associativity_chains.sage`）。同じ 2 ブロックに残る名前だけの根拠（(g) の後に扱う）: `check_number_operator_idempotent` (1) の「反交換子の定義」「同じ項の和」「ℂ の四則」と 2 乗の記法 `X^2`（本文に行列の 2 乗の定義ブロックが無い）、(3) の末尾の「`ň_μ - 0·0`」と「零元との積と減法」（零行列との積 `OA = O` の主張が本文に無い）、(2) の「ℂ の四則」、commute Step 1 の「すなわち `XW = -(WX)`」（反交換子が `0` から出す段）。(1)(2) の Lean は必要十分版の特殊化だけで、人手の鎖と 1 対 1 の具体版が無い。(h) `check_joint_eigenspace_decomposition` の「分配法則と、単位行列との積」4 か所（六十三個目で済んだ。Step 0 の `R^{(1)}R^{(0)}`・`R^{(0)}R^{(1)}` と Step 3 の `ε_ν = 0` の場合を、`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_*_factor`・`identity_matrix_is_*_unit_of_mat_mult`・`negation_factors_out_of_*_factor`・差へ戻す行の 5 行にした。`R^{(0)}R^{(0)}` は本文に行列の加法の結合則が無いので、`R^{(1)}R^{(0)} = 0` を先に示し、`matrix_minus_zero_matrix` で閉じる 8 行の鎖にした（Lean の calc は最後の定義の行を除いた 7 段）（Step 0 の中で異なる上付き添字の積を冪等性より前に置いた）。Lean は `ClaimCheckJointEigenspace.lean` の `nOp_mul_one_sub_nOp`・`one_sub_nOp_mul_nOp`・`one_sub_nOp_mul_self` を人手と 1 対 1 の calc にし、`matrix_sub_zero_matrix_tensorPow` を足した。SageMath は `050` の `check_24_joint_eigenspace_distributivity_chains.sage`）。同じブロックに残る名前だけの根拠（(k) の後に扱う）: Step 0 の `n - n = 0` の「行列の加法逆元」3 か所と Step 0 の和の「行列の加法（加法逆元と単位元）」（`A - A = O`・行列の加法の結合則を主張として本文に持たない）、Step 1〜Step 3 の「因子の可換性により寄せる」「零行列は行列積の零元」「可換な有限個の因子の積の分配法則による展開」「単位行列の有限積」「単元の積」「スカラーの分配」、Step 5 の「行列の作用の分配法則」ほか。(1)〜(4) の Lean は必要十分版の特殊化だけで、Step 1〜Step 5 の鎖と 1 対 1 の具体版が無い。(i) `eigenvalues_of_check_Vprime` の「行列の冪の定義と積の結合法則」「スカラー倍と行列の積の交換」「スカラー倍の結合法則」と「行列積の結合法則」7 か所（六十四個目で済んだ。`def_exp` (1) の冪は `A^{m+1} := A^m A` なので Step 2 は `X̌^{k+1} = X̌^kX̌` から始めて Step 1 を先に引く順に組み直し、`k = 0` の「自明」「単位行列の右単位元」も `def_exp` (1)・単位行列の主張・`scalar_multiple_by_one` の鎖にし、数の冪 `ǧ(ε)^k` を証明の中で定めた。Step 4 の `Q̌_ε^2` は `def_exp` (1) の冪から `Q̌_εQ̌_ε` へ運び、冪等性の行を `check_joint_eigenspace_decomposition` (1) のラベル参照にした。Lean は人手と 1 対 1 の `Xop_pow_mul_Qproj`・`Qproj_mul_Xop_pow`・`Qproj_mulVec_Qproj_mulVec`、SageMath は `050` の `check_25`）。同じブロックに残るもの（(k) の後に扱う。六十四個目のレビューの任意の指摘）: Lean の Step 3・Step 3' の極限の段（`Vprime_mul_Qproj`・`Qproj_mul_Vprime`）は必要十分版の特殊化だけで、足した Step 2・Step 3' の帰納法の具体版を使っていない。Step 4 の後半の鎖 `V̌'y = V̌'(Q̌_εy) = e^{ǧ}Q̌_εy = e^{ǧ}y` の Lean `Vprime_mulVec_of_mem_range` は `mulVec_mulVec` から閉じる別の道で、`Qproj_mulVec_Qproj_mulVec` を使っていない（人手の後半の鎖の 2 行目も `(V̌'Q̌_ε)y = V̌'(Q̌_εy)` とスカラー倍の作用を名前を出さずに使っている）。Lean の `Qproj_mul_self` は `Q̌Q̌ = Q̌` の形で、人手 (1) の `Q̌_ε^2 = Q̌_ε` と形が違う（`Qproj_mulVec_Qproj_mulVec` の最後の行が `sq` と 2 操作になる）。Step 1 の「行列の積の分配法則」「有限和のくくり出し」、Step 3 の「有限和と行列積の分配法則」「有限和からの共通因子のくくり出し」も名前だけの根拠である。Step 3' の末尾の「全ての `k ∈ ℕ`」は Step 2 の `k ∈ ℤ_{≥0}` と記号が違う。(j) `max_eigenvalue_of_V_plus_simple` 付近の「行列の積の結合法則」1 か所（六十五個目で済んだ。(3) の左から `Q̌_{ε'}` を掛ける鎖を、`scalar_multiple_factors_out_of_left_factor`・`eigenvalues_of_V_plus` (1)・`mat_mult_associative`（`q → 1`）・固有方程式・`scalar_multiple_factors_out_of_right_factor` の 5 行にした。Lean は人手と 1 対 1 の `checkBigLambda_smul_Qproj_mulVec_of_eigen`、`eq_Qproj_univ_mulVec_of_eigen` を人手の順の具体版にし、必要十分版の特殊化を `eq_Qproj_univ_mulVec_of_eigen_of_necSuf` に残した。必要十分版 `NecSuf.eq_proj_of_eigen` も同じ 5 段の calc にした。SageMath は `050` の `check_26`）。同じブロックに残る名前だけの根拠（(k) の後に扱う。六十五個目のレビューの任意の指摘）: (3) の「すなわち `(Λ̌_{ε'}−Λ̌_max)Q̌_{ε'}x = 0`」（差へのスカラー倍の分配）、「割ることができて」、`x = Σ_ε Q̌_ε x` を `check_joint_eigenspace_decomposition` (2) の `Σ_ε Q̌_ε = I` だけで引いている行（`x = Ix = (ΣQ̌_ε)x = ΣQ̌_εx` の 3 主張を束ねている。Lean の `sum_Qproj_mulVec` も 3 補題）。鎖の `a → Λ̌_{ε'}`・`a → Λ̌_max` は ℝ の元を ℂ の係数として使っている（論文全体の帰属の件）。必要十分版 `NecSuf.eq_proj_of_eigen` はスカラーを ℂ に固定しているが、証明は `sub_smul`・`smul_eq_zero`・`sub_eq_zero` しか使わないので零因子の無い環で述べ直せる（README 4 節の要件 2）。本文の注記 `Ising2D.Abstract.two_pow_smul_tau_projOn`（`eigenvalue_problem_eigenvalues_of_V_plus.ts`）の名前空間は実在しない。(k) `V_plus_is_invertible` Step 2 の `a` の帰属（六十六個目で済んだ。`a ∈ ℝ_{>0}` を宣言し、係数を包含 `a_ℂ`・`(a^{-1})_ℂ` で掛け、`aa^{-1} = 1_ℂ` を `real_inclusion_preserves_product`・`ℝ` の `aa^{-1} = 1`・略記 `1_ℂ = (1)_ℂ` の 3 行にした。`V_plus_is_positive_definite` の主張・Step 1・Step 3 の係数も `((2s_2)^{M_col/2})_ℂ` にした。Lean は `VPlus_mul_VPlusInv`・`VPlusInv_mul_VPlus` の `a` を `ℝ` にして同じ行の calc、SageMath は `050` の `check_27`）。(k) の次は、下の「(k) の後に扱う」と書いた残りを、この段落に出てくる順（`check_number_operator_idempotent`（六十七個目で済んだ）・`check_number_operators_commute`（Step 1 の「すなわち `XW = -(WX)`」。六十八個目で済んだ） → `check_joint_eigenspace_decomposition`（六十九個目で次の単位に割った。上から順に 1 回に 1 つ。(l1) Step 0・Step 3 の「行列の加法逆元」3 か所・和の「行列の加法（加法逆元と単位元）」・冪等性の行 5 か所（六十九個目で済んだ。`matrix_difference_zero_iff_equal` の `⟸`、新しい主張 `matrix_plus_difference_cancels`（`A + (B − A) = B`）、Step 0 冒頭に (3) の `ň_μ^2 = ň_μ` を `def_exp` (1) で積 `ň_μň_μ = ň_μ` へ運ぶ 5 行を置いてその参照にした。Lean は `nOp_mul_nOp_of_sq`・`nOp_add_one_sub_nOp` と既存 calc の段の付け替え、必要十分版 `NecSuf/MatrixAddSubCancel.lean`。SageMath は `matrix_plus_difference_cancels/` と `050` の `check_30`）。(l2) Step 3 の行末「`ε_ν=1` と単位元の積」と「`ε_ν=0` と零元の積」と「`Q̌_ε` の定義とスカラーの分配」（七十個目で済んだ。`scalar_multiple_by_one`・`zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ引く行と場合の仮定の行、`scalar_multiple_factors_out_of_right_factor` の行。Lean は `nOp_mul_projFactor_of_mem`・`nOp_mul_projFactor_of_not_mem` と `scalar_multiple_by_one` の具体版・必要十分版。SageMath は `050` の `check_31`）。(l3) Step 1〜Step 3 の「因子の可換性により寄せる」「異なる添字の因子の可換性」「零行列は行列積の零元」「可換な有限個の因子の積の分配法則による展開」「単位行列の有限積」。七十一個目で次の三つに割った（上から順に 1 回に 1 つ）。(l3a) 行列の有限積の定義と、Step 1・Step 2 の最後の行（七十一個目で済んだ。`def_finite_product_of_matrices`（`r ∈ ℤ_{≥1}`、左から掛け、空の積を持たない。複素数の有限積と同じ形）・`zero_matrix_is_right_zero_of_mat_mult`・`finite_product_of_identity_matrices` を `002_linear_space_general.ts` に足し、`Q̌_ε` の積をその参照に、Step 1 の「零行列は行列積の零元」・Step 2 の「単位行列の有限積」を新しい主張の参照にした。Lean は具体版 `finiteMatrixProduct`・`matrix_mul_zero_matrix`・`finite_product_of_identity_matrices`、必要十分版 `NecSuf/FiniteProductLeft.lean`（`finProdLeft`。`Mul` だけで定まり、`∏1 = 1` は `1·1 = 1` だけが効く）・`NecSuf/MatrixMulZero.lean`、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_32`）。(l3b) Step 2 の「可換な有限個の因子の積の分配法則による展開」（七十二個目で済んだ。`{0,1}^r` の上の行列の和を、一般の有限集合の添字の付け方を決めずに、最後の成分で `1` を `0` より先に足す帰納法の定義 `def_sum_over_binary_words`（`(ε', e)` の記法も定める）で定め、主張 `sum_over_binary_words_distributes_in_left_factor`（`(Σ X_ε)C = Σ X_εC`）・`expansion_of_finite_product_of_two_term_sums`（`∏(A_j^{(1)}+A_j^{(0)}) = Σ_ε ∏A_j^{(ε_j)}`。因子の可換性は使わない）を `002_linear_space_general.ts` に足した。Step 2 の 2 行目をその参照（右辺から左辺へ）にし、展開の項の数え方を説明していた段落を消し、主張 (2) の和を `def_sum_over_binary_words` と `def_check_index_set` の参照にした。Lean は具体版 `binaryWordMatrixSum`・`binaryWordMatrixSum_mul`・`expansion_of_finite_product_of_two_term_sums`、必要十分版 `NecSuf/BinaryWordSum.lean`（和は `Add` だけ、分配は和を保つ写像、展開は `Distrib` だけ）、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_33`。複素数の和 `Σ_{ε∈{0,1}^𝓜̌}`（`trace_of_check_Vprime` ほか）と `𝓘` の上の和は、下の「有限和の添字の付け方」の件に残る。Lean の `sum_Qproj` は `Finset (CheckIdx M)` の上の `Finset.sum` で、`binaryWordMatrixSum` と別の和である。(l5) で Step 2 を人手と 1 対 1 にするとき、二つをつなぐ等式が要る。七十二個目のレビューの任意の指摘: 語の `(1)`・`(0)` と上付き添字の `A^{(1)}` が同じ括弧の形で衝突している。Step 5 の `(Σ_ε Q̌_ε)x = Σ_ε Q̌_εx` は `sum_over_binary_words_distributes_in_left_factor`（`p → 1`）で引けるが、`Q̌_{ε'}(Σ y_ε)` の左から掛ける形の主張はまだ無い（(l4) で扱う）。`check_33` は `ε_μň_μ + (1−ε_μ)(I−ň_μ) = R_μ^{(ε_μ)}`（`Q̌_ε` の定義の因子）を確かめていない）。(l3c) Step 1・Step 3 の因子の並べ替え（「因子の可換性により寄せる」「異なる添字の因子の可換性」）。七十三個目で二つに割った（上から順に 1 回に 1 つ）。(l3c1) 部分集合の上の積を使わない行（七十三個目で済んだ。主張 `matrix_commuting_with_each_factor_commutes_with_finite_product`（各因子と可換な `X` は `∏A_j` とも可換）・`product_of_two_finite_products_of_matrices`（`j < i` で `A_iB_j = B_jA_i` なら `(∏A_j)(∏B_j) = ∏(A_jB_j)`）を `002_linear_space_general.ts` に足した。Step 0 の末尾の散文「`R_μ^{(e)}` と `R_ν^{(e')}` も可換」を、単位行列との積の 2 行と 4 通りの上付き添字の組の鎖（`check_number_operators_commute` (2)・`commuting_with_difference`）にし、以下「Step 0 の可換性」として引く形にした（Step 0 の冒頭の `scalar_identity_commutes` は使わなくなったので外した）。Step 1 の `ε = ε'` の鎖を `def_exp` (1) の冪の 4 行から始め、「異なる添字の因子の可換性」を `product_of_two_finite_products_of_matrices` の参照にした。Step 3 の「左右どちらから掛けても同じ」を、因子ごとの可換性の 3 つの場合の鎖と `matrix_commuting_with_each_factor_commutes_with_finite_product` を右辺から左辺へ引く鎖にした。Lean は具体版 `ClaimFiniteProductsOfCommutingMatrices.lean`、必要十分版 `NecSuf/FiniteProductCommute.lean`（`Semigroup` だけが効く）、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_34`）。(l3c2) `∏_{μ≠ν}` を使う 3 行（七十四個目で済んだ。定義 `def_finite_product_of_matrices_omitting_one_index`（`r ∈ ℤ_{≥2}`、`s_{r,ν}` で `ν` 以外の添字を小さい順に並べ、`def_finite_product_of_matrices` の `r − 1` 個の積とする）と主張 `moving_one_factor_of_finite_product_to_the_end`（`ν < j` で `A_νA_j = A_jA_ν` なら `∏A_j = (∏_{j≠ν}A_j)A_ν`）を `002_linear_space_general.ts` に足した。Step 1 の `ε ≠ ε'` の鎖は、`R_ν^{(ε_ν)}` と `Q̌_{ε'}` の因子の可換性を先に示し、`Q̌_ε`・`Q̌_{ε'}` の両方で `ν` の因子を末尾へ寄せて `R_ν^{(ε'_ν)}R_ν^{(ε_ν)} = 0` を作る 10 行にした。Step 3 は因子ごとの可換性の 3 つの場合を先に置き、`ň_νQ̌_ε` の鎖を 9 行にした。主張の文の「積の順序は問わない」は外した（主張の中身は不変）。Lean は具体版 `DefinitionFiniteProductOfMatricesOmittingOneIndex.lean`（`s_{r,ν}` は `Fin.succAbove`）、必要十分版 `NecSuf/FiniteProductOmittingOneIndex.lean`（`Semigroup` と `ν < j` の可換性だけが効く）、`TensorPow M` の系。SageMath は `moving_one_factor_of_finite_product_to_the_end/` と `050` の `check_35`（置き換わった鎖を `check_31`・`check_32` から外した）。Lean の `Qproj` は `NecSuf.projOn`（`Finset.noncommProd`）で、人手の左から掛ける積 `finProdLeft`・`finProdLeftOmitting` と別の定義である。(l5) で Step 1・Step 3 を人手と 1 対 1 にするとき、`Qproj` と `finProdLeft` をつなぐ等式が要る（七十一個目のレビューの任意の指摘））。(l4) Step 4・Step 5 の「冪の零乗」「単位行列の作用」「行列の作用の分配法則」「零ベクトルへの行列の作用」（七十五個目で済んだ。定義 `def_power_of_complex_number`（`z^0 := 1_ℂ`、`z^{m+1} := z^m z`）を `000_calculation_formulae_20_29.ts` に、主張 `sum_over_binary_words_distributes_in_right_factor`（`C(Σ X_ε) = Σ CX_ε`）を `002_linear_space_general.ts` に足し、Step 4 の `2^0 = 1` をその定義に、Step 5 を `identity_matrix_is_left_unit_of_mat_mult`（`n → 1`）・`sum_over_binary_words_distributes_in_left_factor`／`_right_factor`（`p → 1`）・`zero_matrix_is_right_zero_of_mat_mult`（`p → 1`）の参照にした。Step 5 の冒頭に、数ベクトルを `2^{M_col}` 行 1 列の行列として扱うこと・数ベクトルの和は `def_sum_over_binary_words`（`n → 1`）・零ベクトルは `O_{2^{M_col},1}` であることを書いた。Lean は具体版 `mul_binaryWordMatrixSum`、必要十分版からの導出 `mul_binaryWordMatrixSum_of_necSuf`（`NecSuf.binWordSum_map` の `f := (C * ·)`。新しい必要十分版の定理は要らない）、`TensorPow M` の系 `mul_binWordSum_tensorPow`。SageMath は `sum_over_binary_words_distributes_in_right_factor/` と `050` の `check_36`。七十五個目のレビューの任意の指摘: Step 4 の `z → 2` の `2` と行の値 `1` を `2_ℂ`・`1_ℂ` と書くか（`trace_of_check_number_operator_product` の `2^{M_col−k}` の帰属と合わせて決める）、Step 5 冒頭の「行列として扱う」は `mat_mult` の「みなす」に乗っている（上の「行列の等号は成分ごと」の件の数ベクトルと 1 列の行列の写像と同じ件）、右の因子の主張の置き換え `(A → C, B → X_{(1)}, C → X_{(0)})` で `C` が二通りに読める、Step 5 の Lean（`sum_Qproj_mulVec`・`eq_zero_of_sum_eq_zero`）と Step 4 の Lean（`trace_Qproj` は `2^M` で約分）は人手と 1 対 1 でない（(l5) で扱う））。(l4b) Step 5 の残りの名前だけの根拠（七十六個目で済んだ。主張 `sum_over_binary_words_with_one_nonzero_term`（`ε ≠ ε'` で `B_ε = O` なら `Σ_ε B_ε = B_{ε'}`。帰納法で、族 `C_{δ'} := B_{(δ',1)} + B_{(δ',0)}` に名前を付けた）を `002_linear_space_general.ts` に足し、直和の鎖の 1 行目をその参照（右辺から左辺へ）と、前提の `ε ≠ ε'` の `Q̌_{ε'}y_ε` の 4 行の鎖（`x_ε` の取り方・`mat_mult_associative`（`q → 1`）・Step 1 の (1)・`zero_matrix_is_left_zero_of_mat_mult`（`p → 1`））、`Q̌_{ε'}y_{ε'} = y_{ε'}` の 4 行の鎖にした。散文「各項は像に属するから和は全体を張る」は `trace_of_idempotent` の `im` の定義で述べ直した。Lean は具体版 `binaryWordMatrixSum_eq_of_eq_zero`、必要十分版 `NecSuf.binWordSum_eq_of_eq_zero`（`AddZeroClass` だけが効く）、導出 `binaryWordMatrixSum_eq_of_eq_zero_of_necSuf`、`TensorPow M` の系 `binWordSum_eq_of_eq_zero_tensorPow`。SageMath は `sum_over_binary_words_with_one_nonzero_term/` と `050` の `check_joint_eigenspace_step5_direct_sum_first_line.sage`（新しいファイルなので番号を付けなかった）。七十六個目のレビューの任意の指摘: `im`（と `ker`）は主張 `trace_of_idempotent` の statement の中で定めており、独立した定義のブロックに切り出す余地がある。具体版の `(δ, e) = ε'` は mathlib の `Fin.snoc_init_self` 1 本で、人手は成分ごとに示している。`C` の定義の行は Lean では `rfl` で `calc` の行を立てていない）。(l5) (1)〜(4) の Step 1〜Step 5 の鎖と 1 対 1 の Lean の具体版。七十七個目で次の単位に割った（上から順に 1 回に 1 つ）。(l5a) Step 0 の異なる添字の因子の可換性の鎖（七十七個目で済んだ。`YI = IY` と 4 通りの上付き添字の組を `mul_identity_eq_identity_mul_step0`・`nOp_mul_nOp_comm_step0`・`nOp_mul_one_sub_nOp_comm_step0`・`one_sub_nOp_mul_nOp_comm_step0`・`one_sub_nOp_mul_one_sub_nOp_comm_step0`、まとめを `projFactor_mul_comm_step0` に置いた。引く `commuting_with_difference` に Lean の対応が無かったので、具体版 `ClaimCommutingWithDifference.lean`（8 行の鎖と 1 対 1）・必要十分版 `NecSuf/CommuteWithMatrixDifference.lean`（`Semiring`・`HasDistribNeg`・`x - y = x + (-y)`。加法の逆元と乗法の可換則は効かない）・導出と `TensorPow M` の系 `…FromNecSuf.lean` を置いた。人手証明と SageMath は変えていない。レビューの必須の指摘は無く、任意の指摘 1 件（対応表の根拠の書き方）を直した。残した任意の指摘: 人手の `commuting_with_difference` の 6〜8 行目は補題を右辺から左辺へ使うが、そう書いていない（同じ論文の Step 0 の鎖の書き方とそろえるなら人手と SageMath の回で直す））。(l5b) `Q̌_ε`（Lean の `Qproj` は `Finset.noncommProd`）と人手の左からの有限積 `finProdLeft` をつなぐ等式（七十八個目で済んだ。`ClaimCheckJointEigenspace.lean` に人手の添字 `μ = j + 1` を与える `checkIdxOfFin`（単射・全射）と、`M_col = r + 1` の形の `Qproj_eq_finProdLeft`（`Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}` の左から掛ける積。因子は `NecSuf.projFactor F.nOp T (checkIdxOfFin j)`）を置いた。必要十分版 `NecSuf/FiniteProductLeftAsNoncommProd.lean` の `finProdLeft_eq_noncommProd_image`（モノイド・因子の可換性・単射な添字の写像が効く。可換性は末尾に 1 因子を足す段でも効く）の特殊化である。人手証明と SageMath は変えていない。レビューの必須の指摘 2 件（「何が効いているか」の記述）と任意の指摘 2 件を直した。残した任意の指摘: 等式は `M = r + 1` の形でだけ述べてあるので、(l5c) 以降で `F : CheckFermiSetup M` の主張へ戻すときに `M = r + 1` に分ける段が要る（人手の `M_col ≥ 2` から従う）。人手の証明の冒頭の「`Q̌_ε = ∏ R_μ^{(ε_μ)}` である」は、定義の因子 `ε_μň_μ + (1-ε_μ)(I-ň_μ)` が `R_μ^{(ε_μ)}` に等しいことの鎖を書いておらず、Lean も同じ（人手と SageMath の回で扱う））。(l5c) Step 1 の `ε ≠ ε'` の鎖（七十九個目で済んだ。`ClaimCheckJointEigenspace.lean` に、`ε_ν ≠ ε'_ν` なら `R_ν^{(ε_ν)}R_ν^{(ε'_ν)} = 0` の場合分け `projFactor_mul_projFactor_eq_zero_step1`、`R_ν^{(ε_ν)}` と `Q̌_{ε'}` の各因子の可換性 `projFactor_comm_factor_step1`（`μ ≠ ν` は Step 0 の可換性、`μ = ν` は 2 行の鎖）、10 行の鎖と 1 対 1 の `Qproj_mul_Qproj_of_ne_step1`（`M_col = r + 2`、人手の `ν` は `checkIdxOfFin ν`。`mat_mult_associative` の 2 行は具体版が無いので `Matrix.mul_assoc`）を置いた。(1) 前半 `Qproj_mul_Qproj_of_ne` は型を変えずに `M = r + 2` でこの鎖を使い、人手の範囲外の `M = 0, 1` は必要十分版の特殊化 `Qproj_mul_Qproj_of_ne_of_necSuf` で閉じる。人手証明と SageMath は変えていない。レビューの必須の指摘は無く、任意の指摘 2 件（冒頭コメントの「すべて特殊化」の記述、可換性の 2 行目のコメントの場合分けの向き）を直した）。(l5d) Step 1 の `ε = ε'` の鎖（八十個目で済んだ。`ClaimCheckJointEigenspace.lean` に、人手の 8 行の鎖を `Q̌_ε^2 = Q̌_εQ̌_ε` の 4 行 `Qproj_sq_eq_mul_self_step1` と `Q̌_εQ̌_ε = Q̌_ε` の 4 行 `Qproj_mul_self_step1`（`M_col = r + 1`。`product_of_two_finite_products_of_matrices` は `TensorPow M` の系 `finProdLeft_mul_finProdLeft_tensorPow`、前提は Step 0 の可換性）に分けて人手と 1 対 1 の calc で置き、`Qproj_sq_step1` でつないだ。7 行目の各因子の冪等性は `projFactor_mul_self_step0`（場合分けで Step 0 冒頭の `ň_μň_μ = ň_μ` と `R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`）。(1) 後半 `Qproj_mul_self` は型を変えずに `M ≥ 1` で `Qproj_mul_self_step1` を使い、`M = 0` は必要十分版の特殊化 `Qproj_mul_self_of_necSuf` で閉じる。人手証明と SageMath は変えていない。レビューの必須の指摘は無く、任意の指摘 3 件（対応表の `M = 1` の書き方、`projFactor_mul_self_step0` を calc と書いていたこと、冪の形と積の形の往復の注記）を直した。残した任意の指摘: 5 行目・8 行目の「`Q̌_ε` の定義（冒頭）」は Lean では定理 `Qproj_eq_finProdLeft` である（(l5c) と同じ扱い））。(l5e) Step 2（八十一個目で済んだ。`ClaimCheckJointEigenspace.lean` に、人手の `R_μ^{(e)}` を `rFactor`、語 `ε ∈ {0,1}^𝓜̌` から `ε_μ = 1` の `μ` の集合への全単射を `finsetOfBinWord` として置き、4 行の鎖 `Σ_ε Q̌_ε = Σ_ε ∏R_μ^{(ε_μ)} = ∏(R_μ^{(1)} + R_μ^{(0)}) = ∏I = I` と 1 対 1 の `sum_Qproj_step2`（`M_col = r + 1`。和は `NecSuf.binWordSum`、展開は `expansion_of_finite_product_of_two_term_sums_tensorPow`、Step 0 の和は定義の行まで含めた `rFactor_one_add_rFactor_zero`、最後は `finite_product_of_identity_matrices_tensorPow`）を置いた。Lean の `Finset.sum` と人手の和をつなぐ `sum_Qproj_eq_binWordSum` は、必要十分版 `NecSuf/BinaryWordSumAsFinsetSum.lean` の `binWordSum_eq_sum`（加法についての可換モノイド。人手の証明の行ではない）の特殊化である。(2) の `sum_Qproj` は型を変えずに `M ≥ 1` でこの鎖から示し、`M = 0` は必要十分版の特殊化 `sum_Qproj_of_necSuf` で閉じる。人手証明と SageMath は変えていない。レビューの必須の指摘 1 件（`rFactor_one_add_rFactor_zero` の 2 段目の根拠を `matrix_plus_difference_cancels` に）と任意の指摘 3 件を直した。残した任意の指摘: `checkIdxOfFin_mem_finsetOfBinWord` は対応表と `check-no-sorry.sh` に載せていない（`checkIdxOfFin_injective` と同じ扱い）。(2) の必要十分版 `NecSuf.sum_projOn` は `Finset.induction_on` で添字を 1 つずつ足す別の論法で、人手の手順に当たる必要十分版の部品は `finProdLeft_add_eq_binWordSum`・`finProdLeft_const_one'` である（`M = 0` の特殊化にだけ使う。Step 1 の前例と同じ扱い））。(l5f) Step 3 の `ň_νQ̌_ε`・`Q̌_εň_ν` の鎖（八十二個目で済んだ。`ClaimCheckJointEigenspace.lean` に、最初の三つの場合 `ň_ν R_μ^{(ε_μ)} = R_μ^{(ε_μ)} ň_ν` を `nOp_mul_projFactor_comm_step3`（`μ ≠ ν` の人手の `R_ν^{(1)}` は、Step 0 の可換性 `projFactor_mul_comm_step0` の `e'` を `T' → 𝓜̌` 全体で表す）、直前の二つの場合を `nOp_mul_projFactor_step3`、主張の左辺から始める 9 行の鎖を `nOp_mul_Qproj_step3`、右から掛けた側の 4 行の鎖を `Qproj_mul_nOp_step3`（`M_col = r + 2`。`mat_mult_associative` の行は Step 1 と同じく mathlib の `Matrix.mul_assoc`）に人手と 1 対 1 の calc で置いた。(3) の `nOp_mul_Qproj`・`commute_nOp_Qproj` は型を変えずに `M = r + 2` でこの鎖から示し、`M = 0, 1` は必要十分版の特殊化 `nOp_mul_Qproj_of_necSuf`・`commute_nOp_Qproj_of_necSuf` で閉じる。人手証明と SageMath は変えていない。レビューの必須の指摘は無く、任意の指摘 3 件（場合の仮定の行のコメント 2 件、対応表の「(4)(5)」）を直した）。(l5g) Step 4 の `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1` の 3 行（八十三個目で済んだ。`ClaimTraceCheckNumberOperatorProduct.lean` に、因子の混在を許す人手の主張そのものの具体版 `trace_projFactorProd`（右辺は `ℂ` の冪 `(2 : ℂ) ^ (M − |S|)`。必要十分版 `NecSuf.two_pow_smul_tau_projOn` の特殊化）を足し、`ClaimCheckJointEigenspace.lean` の `trace_Qproj_step4` に人手の 3 行（`trace_projFactorProd` の `S → 𝓜̌`・`Nat.sub_self`・`def_power_of_complex_number` の `z^0 := 1_ℂ` を `pow_zero` で）と 1 対 1 の calc を置いて、(4) 前半の `trace_Qproj` をこの鎖から示すようにした。人手証明と SageMath は変えていない。レビューの必須の指摘は無く、任意の指摘 3 件（`ClaimTraceCheckNumberOperatorProduct.lean` の冒頭、`pow_zero` の言い方、冒頭の除く側の列挙）を直した。`trace_of_check_number_operator_product` の人手の帰納法（`tr(R_μP) = tr(P)/2`）と 1 対 1 の具体版はまだ無い（`ň` だけの `trace_nOpProd` も必要十分版の特殊化）。このブロックを扱う回に置く）。(l5h) Step 5（八十四個目で済んだ。人手が数ベクトルを `2^{M_col}` 行 1 列の行列として扱うので、`ClaimCheckJointEigenspace.lean` に 1 列の行列 `Matrix (Conf M) (Fin 1) ℂ` で、前半の 3 行 `colVec_eq_sum_Qproj_mul_step5`、`ε ≠ ε'` の 4 行 `Qproj_mul_colVec_of_ne_step5`、`Q̌_{ε'}y_{ε'}` の 4 行 `Qproj_mul_colVec_self_step5`、直和の 5 行 `eq_zero_of_binWordSum_eq_zero_step5`（`M_col = r + 1`）を人手と 1 対 1 の calc で置いた。引く主張の 1 列の行列での系 `identity_matrix_mul_colVec`・`zero_matrix_mul_colVec`・`matrix_mul_zero_colVec`・`binWordSum_mul_colVec`・`mul_binWordSum_colVec`・`binWordSum_eq_of_eq_zero_colVec` を各 `*FromNecSuf.lean` に必要十分版の特殊化として足した。(5) の `sum_Qproj_mulVec`・`eq_zero_of_sum_eq_zero` は型を変えずに、`M = r + 1` で数ベクトルを mathlib の単射 `Matrix.replicateCol (Fin 1)` で 1 列の行列へ送り、和を `finsetOfBinWord`・`NecSuf.binWordSum_eq_sum` で人手の和へ付け替えてこの鎖から示す（運ぶ段は人手の行ではない。`M = 0` は従来の mathlib の証明）。`mat_mult_associative` の 2 行は Step 1 と同じく `Matrix.mul_assoc`。人手証明と SageMath は変えていない。レビューの必須の指摘 1 件（`lean/docs/ch017-formalization.md` の「Step 4・Step 5 の具体版はまだ無い」の記述）と任意の指摘 3 件（置き換えの注記の省略、`r` の読み、添字の移し替えを運ぶ段と書くこと）を直した。これで `check_joint_eigenspace_decomposition` の (l5) は済んだ）。 → `eigenvalues_of_check_Vprime`（八十五個目で次の単位に割った。上から順に 1 回に 1 つ。(m1) Step 1 の左から掛ける形 `X̌Q̌_ε = ǧ(ε)Q̌_ε` の鎖（八十五個目で済んだ。主張 `finite_sum_of_matrices_distributes_in_left_factor`（`(ΣX_j)C = Σ(X_jC)`。帰納法）・`difference_of_scalar_multiples_of_one_matrix`（`aA − bA = (a − b)A`。成分の鎖）を `002_linear_space_general.ts` に足し、名前だけの根拠「行列の積の分配法則」「同時固有空間分解 (3)」「有限和のくくり出し」の 4 行を、`def_check_number_operator` (2)・新しい 2 主張・`scalar_multiple_factors_out_of_left_factor`・`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_left_factor`・`negation_factors_out_of_left_factor`・`identity_matrix_is_left_unit_of_mat_mult`・(3)・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・`ǧ` の定義の 14 行の鎖にした（和の各項へ同時に適用する行は「各項へ」と書く）。Lean は具体版 `ClaimFiniteSumOfMatricesDistributesInLeftFactor.lean`・`ClaimScalarMultiplesOfOneMatrix.lean`（`finite_sum_of_scalar_multiples_of_one_matrix` の具体版もここに置いた。それまで Lean の対応が無かった）、必要十分版 `NecSuf/FiniteSumMulMatrix.lean`（右分配則と有限和の定義だけが効く）・`NecSuf/SmulOneMatrix.lean`（差のくくり出しは `x − y = x + (−y)`・`−y = (−1)y`・結合則・右分配則だけ、有限和のくくり出しは成分の有限和と `Finset.sum_mul` だけが効く）、`TensorPow M` の系、`ClaimEigenvaluesCheckVprime.lean` の 14 段の calc `Xop_mul_Qproj_step1`（`M_col = r + 1`。和の添字の付け替えは `Xop_eq_sum_fin`・`gval_eq_sum_fin` で、人手の行ではない）。`Xop_mul_Qproj` は型を変えずに `M = r + 1` でこの鎖から示し、人手の範囲外の `M = 0` は従来の mathlib の証明 `Xop_mul_Qproj_of_finset_sum`。SageMath は新しい 2 ディレクトリと `050` の `check_eigenvalues_of_check_Vprime_step1_left_chain.sage`。残した件: 人手は `γ(θ̃_μ)`・`ǧ(ε) ∈ ℝ` と `ε_μ ∈ {0,1}` をそのまま ℂ の係数として使っており、最後の行「`ǧ` の定義」の ℝ から ℂ への包含を書いていない（論文全体の帰属の件。Lean は `push_cast`）。`finite_sum_of_scalar_multiples_of_one_matrix` 自身の証明の「ℂ の有限和の分配則」は名前だけの根拠のまま（Lean は `Finset.sum_mul`）。`finite_sum_of_matrices_entrywise` に Lean の具体版が無い（`Matrix.sum_apply`）。レビューの必須の指摘 1 件（`NecSuf/SmulOneMatrix.lean` の差のくくり出しが `Semiring` を仮定していた。`Add`・`Monoid`・`HasDistribNeg`・`RightDistribClass` にした）を直した。残した任意の指摘: 同じ形の前例 `NecSuf/SmulMatrixSub.lean` も `Semiring` を仮定している。`NecSuf.finite_sum_smul_one_matrix'` は `Finset.sum_mul` のために `NonUnitalNonAssocSemiring` を取っており、人手の「ℂ の有限和の分配則」を主張として立てる回に加法の可換モノイドと右分配則だけへ減らせる）。(m2) Step 1 の右から掛ける形（八十六個目で済んだ。主張 `finite_sum_of_matrices_distributes_in_right_factor`（`C(ΣX_j) = Σ(CX_j)`。帰納法）を `002_linear_space_general.ts` に足し、「同じ計算を (3) の右から掛ける形に対して行えば」の段落を、`Q̌_εX̌` から始める 14 行の鎖（`def_check_number_operator` (2)・新しい主張・`scalar_multiple_factors_out_of_right_factor`・`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_right_factor`・`negation_factors_out_of_right_factor`・`identity_matrix_is_right_unit_of_mat_mult`・(3) の `Q̌_εň_ν = ε_νQ̌_ε`・`difference_of_scalar_multiples_of_one_matrix`・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・`ǧ` の定義）にした。Lean は具体版 `ClaimFiniteSumOfMatricesDistributesInRightFactor.lean`（`mul_finite_sum_of_matrices`）、必要十分版 `NecSuf/MatrixMulFiniteSum.lean`（`mul_finite_sum_matrix'`。左分配則と有限和の定義だけが効く）、`TensorPow M` の系 `mul_finite_sum_tensorPow`、一般の `M` の `Qproj_mul_nOp`（`M = r + 2` は `Qproj_mul_nOp_step3`、`M = 0, 1` は必要十分版の特殊化）、`ClaimEigenvaluesCheckVprime.lean` の 14 段の calc `Qproj_mul_Xop_step1`。`Qproj_mul_Xop` は型を変えずに `M = r + 1` でこの鎖から示し、人手の範囲外の `M = 0` は可換性による `Qproj_mul_Xop_of_commute`。SageMath は新しいディレクトリと `050` の `check_eigenvalues_of_check_Vprime_step1_right_chain.sage`。レビューの必須の指摘は記録の更新だけで、任意の指摘 2 件（帰納の段の代入に「同時に置き換える」を添えた、overview の段数の書き方）を直した。残した任意の指摘: 左右の鎖の `scalar_multiple_is_associative` の行は mathlib の `smul_smul` で閉じている（下の `mat_mult_associative`・`scalar_multiple_is_associative` の具体版の件と同じ）。(m3) Step 3・Step 3' の部分和の鎖（八十七個目で済んだ。定義 `def_finite_sum_of_complex_numbers_from_index_zero`（`000_calculation_formulae_00_09.ts`）・`def_finite_sum_of_matrices_from_index_zero`（`002_linear_space_general.ts`）を足し（`Σ_{k=0}^{K} z_k := Σ_{j=1}^{K+1} z_{j-1}`。添字 `0` から始まる整数の範囲の和だけを定め、下の「有限和の添字の付け方」の件の多重添字の集合 `𝓘` の上の和は扱っていない）、名前だけの根拠「有限和と行列積の分配法則」「有限和からの共通因子のくくり出し」を、`E_K` の定義・新しい行列の定義・`finite_sum_of_matrices_distributes_in_left_factor`（右は `_right_factor`）・`scalar_multiple_factors_out_of_left_factor`（右は `_right_factor`）・Step 2（右は Step 3' の帰納法）・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・新しい複素数の定義の 8 行の鎖にした。係数の和は `Σ(1/k!)ǧ(ε)^k` の形に揃え、極限の鎖の 3 行目も同じ形にした。Lean は `ClaimEigenvaluesCheckVprime.lean` の `partialExpSum`（`Finset.range (K + 1)` の上の和）と、8 段の calc `partialExpSum_mul_Qproj`・`Qproj_mul_partialExpSum`（定義の 2 行は mathlib の `Finset.sum_range`）。SageMath は `050` の `check_eigenvalues_of_check_Vprime_step3_partial_sum_chains.sage`（974 段）。残した件: 極限の鎖の最後の行「実指数級数の収束と極限の一意性」が引く `real_exp_series_converges` は `a ∈ ℝ_{≥0}` についての主張で、`a^m/m!` の形で書かれている。`ǧ(ε)` は負になりうる（`ε = 0` で `ǧ = −½Σγ < 0`）ので、この行はそのままでは引けない（(m4) で扱う）。係数 `1/k!` を ℂ の元として掛けることも、`ǧ(ε) ∈ ℝ` と同じく包含を書いていない（論文全体の帰属の件）。レビューの任意の指摘 2 件（検算の説明で、添字をずらす定義の行が構成上一致することを明記、Step 3' の帰納法の範囲を `k ∈ ℤ_{≥0}` に）を直した。残した任意の指摘: 添字 0 からの和を使う `def_exp`・`real_exp_series_converges`（`003_exp_linear_map.ts`）は新しい定義を引いていない（係数が `K` か `ℝ` の和でもあり、下の `def_matrix_difference` の `K` の件と同じ扱い）。）。(m4a) Step 3・Step 3' の人手の極限の鎖（八十八個目で済んだ。最後の行が引いていた `real_exp_series_converges` は `a ∈ ℝ_{≥0}` だけを述べ、`ǧ(ε) < 0` を覆わなかった。主張 `matrix_multiplication_continuity_in_right_factor`（`‖A_N − A‖ → 0 ⟹ ‖BA_N − BA‖ → 0`。係数 `ℂ`）・`scalar_sequence_times_matrix_converges`（`|c_N − c| → 0 ⟹ ‖c_NA − cA‖ → 0`）を `002_linear_space_general.ts` に足し、鎖を `matrix_exp_series_converges` (1)・`matrix_multiplication_continuity`（Step 3' は新しい右の因子の主張）・部分和の鎖・`ǧ(ε)_ℂ` への書き換え・`(1/k!)z = z/k!`・`scalar_exp_is_limit_of_partial_sums`（`K = ℂ`）と新しい主張と `matrix_norm_triangle_inequality` (4)・`complex_exp_of_real_argument` の行にした。主張文に、右辺が `(exp(ǧ(ε)))_ℂ` を掛けた行列であることを書いた（主張の強さは不変）。Lean は新しい 2 主張の具体版（`MathematicalTools/VectorAndMatrixNormsAndConvergence/` の `matrix_mul_left_tendsto`・`smul_matrix_tendsto`。Frobenius ノルム）、必要十分版 `NecSuf/ContinuityOfProductsAndScalarMultiples.lean`（`Norm`・`Sub`・`Mul`/`SMul` と分配・劣乗法性・非負性・`‖ax‖ = ‖a‖‖x‖` の仮定だけ）、導出と `TensorPow M` の系 `mul_left_tendsto_tensorPow`・`smul_tendsto_tensorPow`。SageMath は新しい 2 ディレクトリと `050` の `check_eigenvalues_of_check_Vprime_step3_limit_chains.sage`。新しいフォルダ `VectorAndMatrixNormsAndConvergence` は部「数学的道具立て」の「数ベクトル・行列の長さと収束」に当たる。新しい 2 主張は棚卸しにまだ無いので、所属の割り当ては構成再編の連続実行の棚卸しを待つ。残した件: Step 1・Step 2・部分和の鎖は `ǧ(ε)` を `_ℂ` を付けずに ℂ の係数として使っている（論文全体の帰属の件）。新しい 2 主張と `matrix_multiplication_continuity` の 1 行目の分配則と「実数列の極限」は名前だけの根拠。極限の鎖の `exp(ǧ(ε)_ℂ)Q̌_ε` の行は 3 つの主張（数の exp の極限・スカラー倍の列の収束・極限の一意性）を 1 行で引いている（レビューの任意の指摘。2 行に割れる）。）。(m4b) Step 3・Step 3' の極限の段の Lean（八十九個目で済んだ。`Vprime_mul_Qproj`・`Qproj_mul_Vprime` を人手の極限の鎖の 7 行と 1 対 1 の calc にした。`lim` は `limUnder atTop`、行列の列の収束と `‖A_K − A‖ → 0` は Frobenius ノルムを入れた `tendsto_iff_norm_sub_tendsto_zero` で行き来する（人手の行ではない）。1 行目は新しい `partialExpSum_tendsto`（`matExp_hasSum` の添字を `K ↦ K + 1` で送る）、2 行目は新しい主張 `matrix_multiplication_continuity` の具体版 `matrix_mul_right_tendsto`（`MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimMatrixMultiplicationContinuity.lean`。係数 `ℂ`）・必要十分版 `NecSuf.mul_right_tendsto'`（右分配則・劣乗法性・ノルムの非負性だけ）・導出と `TensorPow M` の系 `mul_right_tendsto_tensorPow`（Step 3' は `mul_left_tendsto_tensorPow`）、3 行目は部分和の鎖を各 `K` へ、4 行目は `rfl`（Lean の係数は初めから `ℂ` へ送ってある）、5 行目は `mul_comm`・`mul_one_div`、6 行目は `complex_exp_partial_sum_tendsto` と `smul_tendsto_tensorPow` と `Filter.Tendsto.limUnder_eq`、7 行目は `Complex.ofReal_exp`。それまでの必要十分版の特殊化は `ClaimEigenvaluesCheckVprimeFromNecSuf.lean` の `Vprime_mul_Qproj_of_necSuf`・`Qproj_mul_Vprime_of_necSuf` へ移した。人手証明と SageMath は変えていない。レビューの必須の指摘 3 件（冪の補題の古いコメント、README の対応表の欠け、MEMORY.md）と任意の指摘 3 件（具体版ファイルの冒頭、必要十分版の効いていない構造の書き方、具体版の無い段の明記）を直した。残した件: `scalar_exp_is_limit_of_partial_sums`・`complex_exp_of_real_argument`・`matrix_norm_triangle_inequality` (4)・`matrix_exp_series_converges` (1) は Lean の具体版が無く mathlib で閉じている。calc の 2 行目と 6 行目は `TensorPow M` の系（必要十分版の特殊化）を通り、添字が `Fin n` の具体版は使っていない（具体版の添字を `[Fintype n]` へ広げれば具体版だけで閉じる。レビューの任意の指摘）。`NecSuf.SimpleEigenvalue` の import は具体版ファイルに残っている）。 (m5) Step 4 の後半の鎖（次はこれ。Lean の `Vprime_mulVec_of_mem_range` は `mulVec_mulVec` から閉じ、`Qproj_mulVec_Qproj_mulVec` を使っていない。人手の 2 行目は `(V̌'Q̌_ε)y = V̌'(Q̌_εy)` とスカラー倍の作用を名前を出さずに使っている）と、Step 3' の末尾の「全ての `k ∈ ℕ`」（Step 2 は `k ∈ ℤ_{≥0}`）、Lean の `Qproj_mulVec_Qproj_mulVec` の最後の行が `sq` と `Qproj_mul_self` の 2 操作になっている件（(l5d) の `Qproj_sq_step1` を使えば 1 操作になる）） → `max_eigenvalue_of_V_plus_simple` → `iH_is_real_symmetric`）に 1 回に 1 ブロックずつ扱う。`iH_is_real_symmetric` に残る名前だけの根拠（Step 0 の「行列積の成分計算」、Step 1・Step 2 の Z_mY_m・Y_mZ_{m+1}・Y_{M_col}Z_1 の鎖の「相異なる因子どうしは可換」「σσ = I」「Step 0」、Step 3 の散文の実対称性の論証。Step 0〜Step 2 の鎖の終わりは `-i\,σ^x_m`・`-i\,G` と書き、六十一個目で書き換えた `H_2`・`S_1^{(+)}` の鎖が引く `(-i)σ^x_m`・`(-i)G` と字面が違う（六十一個目のレビューの任意の指摘））と、`S_1^{(+)} := iK_1H_1^{(+)}` の `K_1, K_2^* ∈ ℝ` を ℂ の係数として使う帰属（論文全体の件）、Step 3 の Lean（`ClaimPositiveDefinite.lean` の `S1plus_isHermitian` ほか）が人手と別の論法である件は、(k) の後に扱う。なお Step 2 は `conjugation_is_ring_homomorphism` の `T_B` の定義と乗法性を「（`B=U`）」の形で引いたままである（Step 3 は `(n → 2^{M_col}, B → U)`）。同じ形に揃えるかは、同じファイルの残りを扱うときに合わせて決める。以下は割る前の (d) の記述である。(d) Step 3 の鎖（`UH_2U^{-1} = T_U(Σ Z_mY_m) = Σ T_U(Z_mY_m) = Σ(-(Z_mY_m)) = -Σ Z_mY_m = -H_2` と、差の項を含む `H_1^{(+)}` の鎖。`M_col - 1 ≥ 1` で有限和の定義が使える）と、Lean の `Uflip_conj_H1plus`・`Uflip_conj_H2`（いまは `Uflip_conj_sum`（`Finset.mul_sum`・`Finset.sum_mul`）と `Finset.sum_neg_distrib` で閉じ、`H1plus` は `lastSign` 付きの `Fin M` の上の和で人手の差の形と違う）の人手どおりの書き直し。Step 2・Step 3 の単項の `+` もこのとき扱う。 (d) の鎖は `conjugation_is_ring_homomorphism` の `T_B`（Step 2 で `B = U` と宣言済み）と `mat_conj`・`matrix_conjugation_preserves_finite_sum` の `T_B` を同じ鎖でつなぐ。`conjugation_is_ring_homomorphism` は主張の中で `T_B(A) = BAB^{-1}` を定義し直し、括弧の読みを宣言していないので、(d) の前に、その主張の `T_B` を「`mat_conj` の `T_B`」と書き換えるか、二つが同じ写像であることを本文に書く（五十四個目のレビューの任意の指摘）。Step 3 の直前の段落「以下、共役が ℂ 線型で積を保つこと（…）を繰り返し使う」は、積を保つことが四十五個目でラベル参照になったので、線型性を扱うときに整理する（四十五個目のレビューの任意の指摘）。`conjugation_is_ring_homomorphism` 自身が `T_B(A) = BAB^{-1}` の括弧の読みを宣言しておらず、証明の 1 段目も括弧を外している（Lean の `Conjugation.T` は `(BA)B^{-1}`。同じレビューの任意の指摘）。
  ほかのブロックの「結合法則」（`Λ̌` の固有値の章の 1016・1027・1148・1179〜1187・2012・2083・2151・3329 行付近）、「単位行列との積」（1547・1563・1576・1666・1724・1833 行付近）、「スカラー倍」（287・299・357・2016〜2020・2087〜2091 行付近）。
  `V_plus_is_invertible` Step 2 の `a := (2s_2)^{M_col/2}` は実数で、引く主張は係数を `ℂ` に取るが、`a` を `ℂ` の元として使うことを本文に書いていない（記号の帰属）。
- 本文に行列の有限積 `A_1⋯A_r` の読み方（左から掛ける、`r = 0` は単位行列）を定めるブロックが無い。`def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の `σ_1^x⋯σ_{m-1}^x` と、`sign_flip_conjugation` Step 2 の `Z_m = P_{m-1}σ_m^z`・`global_spin_flip_jordan_wigner_representation` の `P_{r+1} = P_rσ_{r+1}^x` がそれを前提にしている（五十二個目のレビューの任意の指摘）。定義を足して引くかを判断する。
- 人手 `mat_mult_associative`・`scalar_multiple_is_associative` に Lean の具体版が無い（`scalar_multiple_by_one` は七十個目で具体版 `matrix_one_smul` と `TensorPow M` の系 `one_smul_tensorPow` を置いたが、既存の使う側は mathlib の `one_smul` のまま）。`VPlus_mul_VPlusInv` ほかが mathlib の `Matrix.mul_assoc`・`smul_smul`・`one_smul` で閉じている。具体版（と `TensorPow M` の系）を置くかを決める。
- 2026-11-02、SageMath の検算の連続実行が人手 `sigma_z_diagonal_action` を 4 つの主張に分けた（`sigma_z_diagonal_action`: `σ_m^z f_{ι(μ)} = μ(m)_C f_{ι(μ)}`、`sigma_z_product_action`、`site_sigma_z_is_diagonal`、`site_sigma_z_product_is_diagonal`。足した定義 `def_diagonal_matrix`・`def_finite_product_of_complex_numbers` と主張 `finite_product_with_zero_factor_is_zero` も）。
  `ClaimSigmaZDiagonalAction.lean` の `sigmaZ_eq_diagonal`・`sigmaZ_mulVec_basisVec`・`sigmaZ_mul_sigmaZ_eq_diagonal` は人手と 1 対 1 でない（Lean は対角性を先に示して作用をその系とし、積の対角性を `Matrix.diagonal_mul_diagonal` で閉じる。人手は場合分け → 固有ベクトルの等式、対角性はクロネッカー積の成分の 0 の因子と積の成分の和から別に示す）。`sigmaZ_mul_sigmaZ_mulVec_basisVec` は `sigma_z_product_action` の 6 行と同じ順である。冒頭のコメントに定理ごとの対応を書いた。3 つに人手の鎖と対応する具体版を置き直す。
  同じ回に人手 `first_transfer_matrix_pauli_form` の前半を、`D` の非対角成分・対角成分の成分の鎖（新しい主張 `config_basis_vector_own_component`・`site_sigma_z_product_diagonal_entry`・`finite_sum_with_single_nonzero_term`・`finite_product_of_complex_ones` を引く）に書き直し、成分の一致の鎖に `exp((K_1)_C d(μ)_C) = exp((K_1 d(μ))_C) = (exp(K_1 d(μ)))_C` の 2 行を足した。Lean の具体版（`V1PauliForm_apply_configBasisIso` ほか）との対応を確かめる。
  次の Lean のコメントは、2026-11-02 の人手の書き換えより前の内容のままである（Lean の証明は変えていないので、コメントだけを今の人手に合わせる）。
  `PartitionFunction/TransferMatrixRepresentation/ClaimFirstTransferMatrixPauliForm.lean` の 20〜27 行と 72 行（人手の中間目標を `D f_{ι(μ)} = (∑ μμ) f_{ι(μ)}` と、周期端を和から分ける段として書いている。今の人手は `D` の非対角成分・対角成分の鎖と `m^+` による付け替え）。
  `ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean` の 30・85 行、`PartitionFunction/ProjectionAndJordanWigner/DefinitionSymmetrizedTransferMatrix.lean` の 21・28・133 行、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean` の 14・47 行（対角性の根拠として `sigma_z_diagonal_action` を引く。今は `site_sigma_z_is_diagonal`・`site_sigma_z_product_is_diagonal`、対角成分は `site_sigma_z_product_diagonal_entry`）。
- 本文に、一般の `n` の正則な行列 `(Mat(n,ℂ))^×` と逆行列 `B^{-1}` を定める定義のブロックが無い（五十七個目のレビュー）。`def_invertible_elements_of_R` は `Mat(2^M,ℂ)` だけを対象にし、後の章（`008_TV1_hatZ_hatY_part1.ts`）にある。
  `mat_conj`・`conjugation_is_ring_homomorphism` ほか一般の `n` の主張は「正則」を名前だけで使い、`conjugation_is_ring_homomorphism` は正則の意味（`BB^{-1} = I` かつ `B^{-1}B = I`）を主張の中に書いて補っている。一般の `n` の定義ブロックを置いて各主張から引くかを判断する（逆元が一つに定まることも、そのブロックで示すことになる）。
  同じレビューの任意の指摘: `mat_mult_associative` の Lean の具体版が無い（各所で mathlib の `Matrix.mul_assoc` を使っている）。`conjugation_is_ring_homomorphism` は乗法性・単位性・合成則（と `GH` の正則性）を 1 ブロックに束ねている（1 ブロック 1 主張）。
