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
  - 部「数学的道具立て」のまとまり「角度・極座標・複素数の積と商」「絶対値・偏角・複素平方根」: 形式化したファイルは無い（`Part008/Definition030_Fermi.lean` は `def_sqrt_cc` に説明で触れるだけで、形式化しているのは整数運動量の経路の `ψ_μ` である）。
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
  - 本文から参照用ノート `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts` へ退避された主張だけを形式化しているファイル:
    `Part004/ClaimEpsilonActionEigenvalues.lean`（`epsilon_action_eigenvalues_are_signs`）とその必要十分版の導出、`Part013/Claim007_H1H2ViaCheck.lean`（`H1_H2_via_check_Z_Y`）。
    runbook の置き場の規則に退避した主張の置き場が無いので動かしていない。旧番号のフォルダを無くす前に、置き場を runbook に足してから移す。

## 次の一歩

項目 7 の部「数学的道具立て」の続きを、棚卸しの `mathematicalToolGroups` の並びで一つずつ `Ising2D/MathematicalTools/<まとまりの英語名>/` へ移す。
次は「数ベクトル・行列の長さと収束」「行列指数関数と交換子計算」に形式化したファイルがあるかを調べることである（冒頭の `<ラベル>` では旧フォルダに見つからない。
`Part004/ClaimExpOfDiagonalMatrix` など冒頭が旧 Typst のパスだけのファイルは、旧ラベルと同じラベルの項目へ読み替えて数える）。無ければ「可逆行列・線型写像との対応・共役変換」の
`Part000/Claim045_ConjugationIsRingHom`（と `FromNecSuf`。`conjugation_is_ring_homomorphism`）へ進む。
残りの候補は `Part004/ClaimExpOfDiagonalMatrix`、`Part008/Definition016_TV`・`Definition030_Fermi`、`Part009/Definition001_Trace`・`Claim013_PositiveDefinite`、
`Part011/Claim005_PsdCauchySchwarz`（と補助の `Part011/Basic`）、`Part012/Theorem004_RiemannSumToIntegral`、`Part020/` に残る 3 本である。各ファイルの置き場は runbook の多数決の規則で決める（章の項目と混在するファイルもある）。
1 回に 1 まとまりずつ移し、`Ising2D.lean` の import、`check-no-sorry.sh`、コメントのパス（本文・ノートの中のパスを含む）、`lean/README.md`（数学的道具立てのまとまりの表）・`lean/docs/` の対応表を同じ回で直す。
数学的道具立てを移し終えたら、`RoutesNotAdopted/IntegerMomentum/`・`RoutesNotAdopted/MinusSector/`、参照用ノートへ退避した主張だけのファイル（置き場を runbook に足してから）の順に進める。
