/-
# 具体的な分配関数 `Z(K_1,K_2)` と具体的な `W` についての挟み撃ち

正本: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`

* `maxeig_001_definition_transfer_matrix_square_root`（ラベル **`def_transfer_matrix_square_root`**）
  の「`V_1^{1/2}V_1^{1/2} = V_1`」

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`

* `maxeig_003_claim_W_is_positive_definite`（ラベル **`W_is_real_symmetric_positive_definite`**）
  の正定値性（Step 1・Step 2・Step 3 の鎖）と実対称性（Step 3 の転置の鎖と成分の実性）と可逆性（`BB' = I` の鎖と `def_invertible_elements_of_R` (ii) の 2 回の適用）
* `maxeig_definition_W_real`（ラベル **`def_W_real`**）の `W_ℝ := ϱ(W)`
* `maxeig_claim_W_real_is_symmetric`（ラベル **`W_real_is_symmetric`**）
* `maxeig_claim_W_real_is_positive_definite`（ラベル **`W_real_is_positive_definite`**）
* `maxeig_claim_trace_of_W_power_via_W_real`（ラベル **`trace_of_W_power_via_W_real`**）
* `maxeig_009_claim_partition_function_sandwich`（ラベル **`partition_function_sandwich`**）

本ファイルは、章 001 の具体的な分配関数 `Ising2D.partitionFunction` と、`PhysicalSymTransferBridge.lean` の
具体的な `W = V_1^{1/2}V_2V_1^{1/2}`（係数 `ℂ` の `physicalSymTransferC`、実行列の `physicalSymTransferR`）について、
人手 `partition_function_sandwich` の主張そのもの
`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}` を、
`c(M_col) := rayleighSup physicalSymTransferR` について立てる。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `def_transfer_matrix_square_root`: `V_1^{1/2}V_1^{1/2} = exp(K_1D) = V_1`（`theorem_exp_product`、`½K_1D` は自分自身と可換） | `physicalV1halfC_mul_self` |
| 同じ等式の実行列での表示 | `physicalV1halfR_mul_self_map` |
| `Z_equals_trace_of_W` の「とくに」: 具体的な `(Z(K_1,K_2))_ℂ = tr(W^{N_row})`（`W = (V_1^{1/2}V_2)V_1^{1/2}`、係数は `ℂ`） | `partition_function_eq_trace_physicalSymTransferC` |
| `trace_of_W_power_via_W_real`: `W^q` の成分の実性と `(W^q)_ℝ = (W_ℝ)^q`（`real_matrix_of_real_entry_matrix_preserves_power`、`n → d`, `A → W`）、4 行の鎖 `tr(W^q) = Σ_k (W^q)_kk = Σ_k (((W^q)_ℝ)_kk)_ℂ = Σ_k (((W_ℝ)^q)_kk)_ℂ = (Σ_k ((W_ℝ)^q)_kk)_ℂ` | `trace_of_W_power_via_W_real` の `calc` の 4 段 |
| `partition_function_sandwich` の準備 `Z(K_1,K_2) = T`（`Z_equals_trace_of_W` の「とくに」、`trace_of_W_power_via_W_real` の `q → N_row`、`inclusion_rr_to_cc_is_injective`） | `partition_function_eq_sum_diag_W_real_pow` |
| Step 1 の準備: `m^+`、`σ^z_{m+1} = σ^z_{m^+}`（Lean の `D` は `nextSite` で書いてあるので定義どおり） | `nextSite`（`rfl`） |
| Step 1 の準備: `σ^z_{m^+}σ^z_m = σ^z_mσ^z_{m^+}`（`distinct_site_pauli_matrices_commute`。`M_col = 1` は同じ行列） | `sigmaZ_nextSite_mul_comm`（`siteOp_mul_comm`） |
| Step 1: `(σ^z_k)^⊤ = σ^z_k` の 5 行 | `sigmaZ_transpose` の `calc` の 5 段 |
| Step 1: `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` の 5 行（`transpose_of_matrix_product`） | `sigmaZ_mul_sigmaZ_nextSite_transpose` の `calc` の 5 段（`transpose_mul_tensorPow`） |
| Step 1: `(K_1D)^⊤ = K_1D` の 5 行（`transpose_of_matrix_scalar_multiple`・`transpose_of_finite_sum_of_matrices`） | `K1D_transpose_succ` の `calc` の 5 段（`transpose_smul_tensorPow`・`finite_sum_transpose_tensorPow`）、一般の `M` の `K1D_transpose` |
| Step 1: `σ^z_k` の成分は実（`kronecker_of_real_entry_matrices_has_real_entries`） | `sigmaZ_hasRealEntries` |
| Step 1: `σ^z_mσ^z_{m+1}`・`D`・`K_1D` の成分は実（`product_of_real_entry_matrices_has_real_entries`・`finite_sum_of_real_entry_matrices_has_real_entries`・`real_scalar_multiple_of_real_entry_matrix_has_real_entries`） | `K1D_hasRealEntries_succ`（`matrix_mul_hasRealEntries`・`finite_sum_hasRealEntries`・`real_smul_hasRealEntries`）、一般の `M` の `K1D_hasRealEntries` |
| Step 1 の結論「`K_1D` は実対称」 | `K1D_isRealSymmetric` |
| Step 2: `real_symmetric_matrix_is_hermitian`（`A → K_1D`）で `K_1D` はエルミート | `K1D_isHermitian` |
| Step 2: `real_multiple_of_hermitian_is_hermitian`（`α → ½`, `A → K_1D`）で `½K_1D` はエルミート | `halfK1D_isHermitian`（`physicalV1halfC` の指数 `(K_1/2)_ℂD` を `½(K_1D)` へ書き直すのは `halfK1D_eq_half_smul_K1D`・`physicalV1halfC_eq_matExp_half`） |
| Step 1: `S_2` は実対称（`iH_is_real_symmetric` の結論。実対称性を示すのはその Step 3） | `S2C_isRealSymmetric`（`iH_is_real_symmetric` の結論の Lean `S2_isRealSymmetric`。`M ≥ 1` は `S2_hasRealEntries`・`S2_transpose_by_pauli_form`、`M = 0` は人手の範囲外の補助） |
| Step 2: `real_symmetric_matrix_is_hermitian`（`A → S_2`）で `S_2` はエルミート | `expS2C_posDef` の中の `real_symmetric_isHermitian _ (S2C_isRealSymmetric K2)` |
| Step 2: `exp_hermitian_is_positive_definite` で `B := exp(½K_1D)` と `A := exp(S_2)` は正定値 | `physicalV1halfC_posDef`、`expS2C_posDef` |
| Step 2: `exp_of_negative_is_left_inverse` で `B' := exp(-½K_1D)` は `B'B = I` | `physicalV1halfInvC`、`physicalV1halfInvC_mul_physicalV1halfC` |
| Step 3: `B` がエルミートなので `B^* = B` | `physicalV1halfC_conjTranspose` |
| Step 3 の 5 行の鎖 `W = (BV_2)B = (B(cA))B = (c(BA))B = c((BA)B) = c((B^*A)B)`（`c = (2s_2)^{M_col/2}`。3 行目は `scalar_multiple_factors_out_of_right_factor`、4 行目は `scalar_multiple_factors_out_of_left_factor`） | `physicalSymTransferC_eq_smul_congruence` の `calc` の 5 段（係数 `c` は `twoS2Pow`。3・4 段は `TensorPow M` の系 `mul_smul_matrix_tensorPow`・`smul_mul_matrix_tensorPow`） |
| Step 3: `congruence_preserves_positive_definite`（Lean は `TensorPow M` の系 `congruence_preserves_positive_definite_tensorPow`。必要十分版の特殊化で、添字 `Fin n` の 1 対 1 の具体版は通らない）で `B^*(AB)` は正定値、`mat_mult_associative` で `(B^*A)B = B^*(AB)`、`K_2 > 0` で `(2s_2)^{M_col/2} > 0`、`positive_real_multiple_preserves_positive_definite` で `W` は正定値 | `physicalSymTransferC_posDef`（`twoS2Pow_pos`） |
| `def_W_real`: `W_ℝ := ϱ(W)`（`def_real_matrix_of_real_entry_matrix`、`B → W`） | `realMatrixOfRealEntries (physicalSymTransferC …) (physicalSymTransferC_hasRealEntries …)`。実成分で組んだ `physicalSymTransferR` に等しい（`physicalSymTransferR_eq_realMatrixOfRealEntries`） |
| `W_real_is_positive_definite`: `ξ_k := (x_k)_ℂ` と `ξ ≠ 0`（`inclusion_rr_to_cc_is_injective`、`a → x_k`, `b → 0`） | `W_real_is_positive_definite` の `hξ` |
| 同じ主張の「`ξ^*Wξ = ρ_ℂ` を満たす `ρ ∈ ℝ_{>0}`」（`W_is_real_symmetric_positive_definite`、`def_hermitian_positive_definite`） | 同じ定理の `posDef_conjugateBilinearValue_pos (physicalSymTransferC_posDef …)` |
| 同じ主張の 10 行の鎖 `ρ_ℂ = ξ^*Wξ = … = (x^⊤W_ℝx)_ℂ` | `conjugate_bilinear_value_of_real_vector_W` の `calc` の 9 段と、10 行目（`def_real_bilinear_value`）の `W_real_is_positive_definite` の `rw [dotProduct_mulVec_eq_real_bilinear_value]` |
| 同じ主張の結び（`inclusion_rr_to_cc_is_injective`、`a → ρ`, `b → x^⊤W_ℝx`） | `W_real_is_positive_definite` |
| 同じ主張を実成分で組んだ `W` で読む（`partition_function_sandwich_and_limit_in_N_row`・`onsager_limit_in_N_row_physical` の `c(M_col) > 0` と、章「M→∞ の極限と閉形式」の偶セクターの橋渡しが使う形） | `physicalSymTransferR_posDef` |
| Step 2: `½K_1D` の成分は実（Step 1 の `K_1D` の成分の実性と `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（主張の行数・列数 `m, n → 2^{M_col}`, `c → ½`, `B → K_1D`）） | `halfK1D_hasRealEntries` |
| Step 2: `(½K_1D)^⊤ = ½K_1D` の 3 行（`transpose_of_matrix_scalar_multiple`、Step 1 の `(K_1D)^⊤ = K_1D`、`½K_1D` の略記） | `halfK1D_transpose` の `calc` の 3 段（`transpose_smul_tensorPow`・`K1D_transpose`・`rfl`） |
| Step 2: `½K_1D` は実対称（上の 2 つ） | `halfK1D_isRealSymmetric` |
| Step 2: `exp_of_real_symmetric_is_real_symmetric`（`n → 2^{M_col}`, `A → ½K_1D` と `A → S_2`）で `B = exp(½K_1D)` と `A = exp(S_2)` は実対称 | `physicalV1halfC_isRealSymmetric`、`expS2C_isRealSymmetric` |
| Step 3 が使う `B^⊤ = B`（Step 2 の `B` の実対称性の第 2 成分、`def_real_symmetric_complex_matrix`） | `physicalV1halfC_transpose` |
| Step 3: `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`） | `V2_eq_twoS2Pow_smul_expS2C` |
| Step 3: `V_2^⊤ = V_2` の 4 行（`V_2 = (2s_2)^{M_col/2}A`、`transpose_of_matrix_scalar_multiple`、Step 2 の `A^⊤ = A`、`V_2 = (2s_2)^{M_col/2}A`） | `V2_transpose` の `calc` の 4 段 |
| Step 3: `W^⊤ = W` の 7 行（`def_symmetrized_transfer_matrix`、`transpose_of_matrix_product` を 2 回、Step 2 の `B^⊤ = B` を 2 箇所へ、`V_2^⊤ = V_2`、`mat_mult_associative`、`def_symmetrized_transfer_matrix`） | `physicalSymTransferC_transpose` の `calc` の 7 段 |
| Step 3: `V_2` の成分は実（`real_scalar_multiple_of_real_entry_matrix_has_real_entries`、`c → (2s_2)^{M_col/2}`, `B → A`） | `V2_hasRealEntries` |
| Step 3: `BV_2` と `W = (BV_2)B` の成分は実（`product_of_real_entry_matrices_has_real_entries` を 2 回） | `physicalSymTransferC_hasRealEntries` |
| Step 3 の結論「`W` は実対称」（`def_real_symmetric_complex_matrix`） | `physicalSymTransferC_isRealSymmetric` |
| `W_real_is_symmetric`: 4 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = (W^⊤)_kl = W_lk = ((W_ℝ)_lk)_ℂ` と `inclusion_rr_to_cc_is_injective`（`a → (W_ℝ)_kl`, `b → (W_ℝ)_lk`） | `W_real_entry_symm` の `calc` の 4 段 |
| 同じ主張の結び（`def_real_symmetric_matrix` の意味で対称。Lean の `Matrix.IsSymm`） | `W_real_is_symmetric` |
| 同じ主張を実成分で組んだ `W` で読む（章「M→∞ の極限と閉形式」の偶セクターの橋渡しが使う形） | `physicalSymTransferR_isSymm` |
| 可逆性: `BB' = I` の 3 行の鎖（`B`・`B'` の置き方、`matrix_double_negation`（`A → ½K_1D`）、`exp_of_negative_is_left_inverse`（`A → -½K_1D`）） | `physicalV1halfC_mul_physicalV1halfInvC` の `calc` の 3 段 |
| 可逆性: `B ∈ R^×`（`def_invertible_elements_of_R` の `g → B`, `h → B'`。`B'B = I` は Step 2） | `physicalV1halfC_isUnit` |
| 可逆性: `BV_2 ∈ R^×`（`B ∈ R^×`、`V2_invertible`、`def_invertible_elements_of_R` (ii)（`g_1 → B`, `g_2 → V_2`）） | `physicalV1halfC_mul_V2_isUnit`（`V2_invertible` は `isUnit_V2`） |
| 可逆性: `W = (BV_2)B ∈ R^×` の 2 行（`def_symmetrized_transfer_matrix`、`def_invertible_elements_of_R` (ii)（`g_1 → BV_2`, `g_2 → B`）） | `physicalSymTransferC_isUnit` |
| `trace_power_upper_bound` を本文の `W`（`def_symmetrized_transfer_matrix`）と `W_ℝ`（`def_W_real`）に当てたもの（`W` の実対称性は `W_is_real_symmetric_positive_definite`、`rayleigh_bounds_operator_norm` が要る `W_ℝ` の対称性・正定値性は `W_real_is_symmetric`・`W_real_is_positive_definite`） | `trace_power_upper_bound_physical`（一般の `W` の具体版は `ClaimTracePowerUpperBound.lean` の `trace_power_upper_bound`） |
| `moment_log_convexity` を本文の `W`（`def_symmetrized_transfer_matrix`）と `W_ℝ`（`def_W_real`）に当てたもの（`W` の実対称性は `W_is_real_symmetric_positive_definite`、`W_ℝ` の対称性・正定値性は `W_real_is_symmetric`・`W_real_is_positive_definite`） | `moment_log_convexity_physical`（一般の `W` の具体版は `ClaimMomentLogConvexity.lean` の `moment_log_convexity`） |
| `trace_power_sandwich` を本文の `W`（`def_symmetrized_transfer_matrix`）と `W_ℝ`（`def_W_real`）に当てたもの（仮定の渡し方は上の 2 行と同じ） | `trace_power_sandwich_physical`（一般の `W` の具体版は `ClaimTracePowerSandwich.lean` の `trace_power_sandwich`） |
| `partition_function_sandwich`（準備の `Z(K_1,K_2) = T`（`T := Σ_k ((W_ℝ)^{N_row})_kk`）→ `trace_power_sandwich` の両側の評価を `n = N_row` に適用） | `partition_function_sandwich_physical` |

- Step 3 の `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor` は、添字が `Conf M` の行列なので
  `TensorPow M` の系 `mul_smul_matrix_tensorPow`・`smul_mul_matrix_tensorPow`（必要十分版の特殊化。具体版は添字 `Fin n` の
  `mul_smul_matrix`・`smul_mul_matrix`）を引く。`mat_mult_associative` は具体版が無く、mathlib の `Matrix.mul_assoc` を引く。`exp_hermitian_is_positive_definite` の Lean（`posDef_exp_of_isHermitian`）は人手の段と一対一でない
  （`ClaimPositiveDefinite.lean` の注意）。`positive_real_multiple_preserves_positive_definite` は、添字が `Conf M` の行列なので
  `positive_real_multiple_preserves_positive_definite_tensorPow`（必要十分版の特殊化。具体版は添字 `Fin n` で、人手の 13 行の鎖と
  1 対 1。`ClaimPositiveRealMultiplePreservesPositiveDefinite.lean`）を引く。
- Step 1 の `transpose_of_matrix_product`・`transpose_of_matrix_scalar_multiple`・`transpose_of_finite_sum_of_matrices`、Step 2 の `(½K_1D)^⊤` の鎖の `transpose_of_matrix_scalar_multiple` は、添字が `Conf M` の行列なので、
  `TensorPow M` の系 `transpose_mul_tensorPow`・`transpose_smul_tensorPow`・`finite_sum_transpose_tensorPow`（必要十分版を添字 `Conf M` へ特殊化したもの。
  具体版（添字 `Fin m`）と手順は同じ。`ClaimIHPauliForm.lean` の Step 3 の節と同じ扱い）を引く。
- 人手の Step 1 は `M_col ≥ 1` で述べる。Lean の鎖は `M = n + 1` で述べ（`K1D_transpose_succ`・`K1D_hasRealEntries_succ`）、
  人手の範囲外の `M = 0` は、添字が空で `D` が零行列であることによる補助の場合分けで一般の `M` の形（`K1D_transpose`・`K1D_hasRealEntries`）へ広げる。
- Step 2 の `exp_of_real_symmetric_is_real_symmetric` と Step 3 の `V_2^⊤ = V_2` の鎖の `transpose_of_matrix_scalar_multiple` は、添字が `Conf M` の行列なので、
  `TensorPow M` で述べた具体版 `exp_of_real_symmetric_is_real_symmetric` と系 `transpose_smul_tensorPow` を引く。
- `W_real_is_positive_definite` の鎖と `trace_of_W_power_via_W_real` の鎖の 4 段目の `real_inclusion_preserves_finite_sum` には Lean の具体版が無く、既存の慣行どおり mathlib の
  `Complex.ofReal_sum` を引く（`ClaimTraceOfPositiveDefiniteIsPositive.lean` と同じ扱い）。各項へ当てる行は `Finset.sum_congr` で項ごとに 1 回ずつ当てる。
- Step 3 の `W^⊤ = W` の鎖の `transpose_of_matrix_product` は、添字が `Conf M` の行列なので `TensorPow M` の系 `transpose_mul_tensorPow` を引き、
  `mat_mult_associative` は具体版が無いので mathlib の `Matrix.mul_assoc` を引く。
- 可逆性の段の `matrix_double_negation`・`exp_of_negative_is_left_inverse`・`def_invertible_elements_of_R` (ii) は、添字が `Conf M` の行列なので
  `TensorPow M` の系 `neg_neg_tensorPow`・`matExp_neg_mul_matExp_tensorPow`・`invertible_product_isUnit_tensorPow`（必要十分版の特殊化。
  (ii) の具体版（添字 `Fin n`、人手の 2 本の 6 行の鎖と 1 対 1）は `DefinitionInvertibleElementsProduct.lean`）を引く。

## 仮定について

人手は `N_row ∈ ℤ_{≥1}` を仮定するので `1 ≤ Nrow` を仮定する。`K_2 > 0` は `V2_exponential_representation`
の仮定と、`positive_real_multiple_preserves_positive_definite` に渡す `(2s_2)^{M_col/2} > 0` が使う。
`K_1` の正値性は使わないので仮定に置かない。

同じ具体的な行列についての主張を具体化しただけなので、必要十分版は置かない
（抽象的な内容は、引いた主張それぞれの必要十分版（`NecSuf/CongruencePreservesPositiveDefinite.lean`・
`NecSuf/StarFixedScalarMultipleOfHermitian.lean`・`NecSuf/HermitianOfStarFixedSymmetricEntries.lean`・
`NecSuf/ExpNegMulExp.lean`・`NecSuf/RayleighMoments.lean`）に尽きている）。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimPartitionFunctionViaTransferMatrix
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV2InZY
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveDefinite
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimIHPauliForm
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionSymmetrizedTransferMatrix
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerSandwich
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealMultipleOfHermitianIsHermitian
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverseFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfRealSymmetricIsRealSymmetric
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionInvertibleElementsProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionRealMatrixOfRealEntryMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfPositiveDefiniteIsPositive
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimOperatorBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerUpperBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimMomentLogConvexity

namespace Ising2D

open Matrix
open scoped ComplexOrder

variable {M : ℕ}

/-! ## `V_1^{1/2}` -/

/-- **人手 `def_transfer_matrix_square_root`: `V_1^{1/2}V_1^{1/2} = exp(K_1D) = V_1`**
（`theorem_exp_product` を自分自身と可換な `½K_1D` に適用し、`first_transfer_matrix_pauli_form` で `V_1` に戻す）。 -/
theorem physicalV1halfC_mul_self (K1 : ℝ) :
    physicalV1halfC M K1 * physicalV1halfC M K1 = V1 M K1 := by
  rw [first_transfer_matrix_pauli_form, physicalV1halfC, V1PauliForm, V1PauliForm, matExp, matExp,
    ← Matrix.exp_add_of_commute _ _ (Commute.refl _), ← add_smul]
  congr 2
  push_cast
  ring

/-- `V_1^{1/2}V_1^{1/2} = V_1` を実行列 `physicalV1halfR` で書いたもの（成分を `ℂ` へ埋め込むと `V_1`）。 -/
theorem physicalV1halfR_mul_self_map (K1 : ℝ) :
    (physicalV1halfR M K1 * physicalV1halfR M K1).map Complex.ofRealHom = V1 M K1 := by
  rw [Matrix.map_mul, ← physicalV1halfC_eq_map, physicalV1halfC_mul_self]

/-! ## `Z(K_1,K_2)` を `W` のトレースとして -/

/-- **人手 `Z_equals_trace_of_W` の「とくに」**（具体的な `Z(K_1,K_2)` と `W` について。2 行）:
`N_row ∈ ℤ_{≥1}` について `(Z(K_1,K_2))_ℂ = tr((V_1V_2)^{N_row}) = tr(W^{N_row})`。
`(·)_ℂ` は人手の `inclusion_rr_to_cc` の略記 `r_ℂ` で、Lean の `((· : ℝ) : ℂ)` に当たる。
本体は具体版 `trace_mul_pow_eq_trace_symmetrized_pow` を `B := V_1^{1/2}`（準備 1 の `BB = V_1` は `physicalV1halfC_mul_self`、`W = (BV_2)B` は `physicalSymTransferC` の定義）で引く。 -/
theorem partition_function_eq_trace_physicalSymTransferC (K1 K2 : ℝ) {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ) = (physicalSymTransferC M K1 K2 ^ Nrow).trace :=
  calc ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ)
      = ((V1 M K1 * V2 M K2) ^ Nrow).trace :=
        partition_function_via_transfer_matrix K1 K2 hN          -- `partition_function_via_transfer_matrix`
    _ = (physicalSymTransferC M K1 K2 ^ Nrow).trace :=
        trace_mul_pow_eq_trace_symmetrized_pow (physicalV1halfC_mul_self K1) rfl Nrow hN
                                                                -- 本体を `n := N_row` に適用

/-! ## Step 1: `K_1D` は実対称

人手 Step 1 の準備・`(σ^z_k)^⊤` の 5 行・`(σ^z_mσ^z_{m+1})^⊤` の 5 行・`(K_1D)^⊤` の 5 行・成分の実性の 2 段落と 1 対 1 に対応する。
人手の `m^+`（`m ≤ M_col−1` なら `m+1`、`m = M_col` なら `1`）は Lean の `nextSite m` である。Lean の `D` ははじめから
`∑ σ^z_m σ^z_{nextSite m}` と書いてあるので、準備の `σ^z_{m+1} = σ^z_{m^+}` の段は定義どおりの等式（`rfl`）になる。
人手の `M_col ≥ 1` は Lean では `M = n + 1` と書く。`M = 0`（人手の範囲外）は、添字が空で `D` が零行列なので、補助の場合分けで埋める。 -/

/-- **人手 Step 1 の `(σ^z_k)^⊤ = σ^z_k` の 5 行の鎖**（`k ∈ {1, …, M_col}`。`sigmaX_transpose` と同じ形）。 -/
theorem sigmaZ_transpose {M : ℕ} (k : Fin M) : (sigmaZ k)ᵀ = sigmaZ k := by
  have hform : ∀ A : Matrix (Fin 2) (Fin 2) ℂ,
      Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A = fun j => if j = k then A else 1 := by
    intro A
    funext j
    by_cases h : j = k
    · rw [h, Function.update_self, if_pos rfl]
    · rw [Function.update_of_ne h, if_neg h]; rfl
  calc
    (sigmaZ k)ᵀ
        = (siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k pauliZ))ᵀ := rfl
                                                        -- `def_site_pauli_matrices`（`k → k`, `a → z`）
    _ = siteProd M (fun j => if j = k then pauliZᵀ else (1 : Matrix (Fin 2) (Fin 2) ℂ)ᵀ) := by
      rw [siteProd_transpose, hform]                    -- `kronecker_transpose`（`M → M_col`, `A_k → σ^z`, `A_j → I`（`j ≠ k`））
      congr 1
      funext j
      dsimp only
      by_cases h : j = k
      · rw [if_pos h, if_pos h]
      · rw [if_neg h, if_neg h]
    _ = siteProd M (fun j => if j = k then pauliZᵀ else 1) := by
      rw [identity_matrix_two_transpose]                -- `transpose_of_identity_matrix_of_order_two`（第 `k` 因子以外の因子へ同時に適用）
    _ = siteProd M (fun j => if j = k then pauliZ else 1) := by
      rw [pauliZ_transpose]                             -- `transpose_of_pauli_z`（第 `k` 因子へ）
    _ = sigmaZ k := by
      rw [← hform]; rfl                                 -- `def_site_pauli_matrices`（`k → k`, `a → z`）

/-- **人手 Step 1 の準備の `σ^z_{m^+}σ^z_m = σ^z_mσ^z_{m^+}`**: `m^+ ≠ m` なら `distinct_site_pauli_matrices_commute`
（`j → m^+`, `k → m`, `a, b → z`。Lean は `siteOp_mul_comm`）、`m^+ = m`（`M_col = 1` のときに限る）なら両辺は同じ行列。
Lean の場合分けは「`M_col = 1` のときに限る」を使わない（どちらの枝も閉じる）。 -/
theorem sigmaZ_nextSite_mul_comm {M : ℕ} (m : Fin M) :
    sigmaZ (nextSite m) * sigmaZ m = sigmaZ m * sigmaZ (nextSite m) := by
  by_cases h : nextSite m = m
  · rw [h]                                              -- `m^+ = m`: 両辺は同じ行列 `σ^z_mσ^z_m`
  · exact siteOp_mul_comm h pauliZ pauliZ               -- `distinct_site_pauli_matrices_commute`（`j → m^+`, `k → m`, `a, b → z`）

/-- **人手 Step 1 の `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` の 5 行の鎖**（`m ∈ {1, …, M_col}`。周期端 `m = M_col` を含む）。 -/
theorem sigmaZ_mul_sigmaZ_nextSite_transpose {M : ℕ} (m : Fin M) :
    (sigmaZ m * sigmaZ (nextSite m))ᵀ = sigmaZ m * sigmaZ (nextSite m) :=
  calc (sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (sigmaZ m * sigmaZ (nextSite m))ᵀ := rfl                            -- 準備の `σ^z_{m+1} = σ^z_{m^+}`（Lean の `D` は `nextSite` で書いてある）
    _ = (sigmaZ (nextSite m))ᵀ * (sigmaZ m)ᵀ :=
        transpose_mul_tensorPow _ _                                         -- `transpose_of_matrix_product`（必要十分版の `Conf M` への特殊化。`m, n, p → 2^{M_col}`, `A → σ^z_m`, `B → σ^z_{m^+}`）
    _ = sigmaZ (nextSite m) * sigmaZ m := by
        rw [sigmaZ_transpose, sigmaZ_transpose]                             -- 上で得た `(σ^z_k)^⊤ = σ^z_k` を `k → m^+` と `k → m` へ同時に適用
    _ = sigmaZ m * sigmaZ (nextSite m) :=
        sigmaZ_nextSite_mul_comm m                                          -- 準備の `σ^z_{m^+}σ^z_m = σ^z_mσ^z_{m^+}`
    _ = sigmaZ m * sigmaZ (nextSite m) := rfl                               -- 準備の `σ^z_{m+1} = σ^z_{m^+}`

/-- **人手 Step 1 の `(K_1D)^⊤ = K_1D` の 5 行の鎖**（`M = n + 1`）。 -/
theorem K1D_transpose_succ (K1 : ℝ) (n : ℕ) :
    ((K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m) :=
  calc ((K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m))ᵀ
      = ((K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m))ᵀ := rfl
                                                                            -- `def_transfer_matrix_square_root` の `D` の定義
    _ = (K1 : ℂ) • (∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m))ᵀ :=
        transpose_smul_tensorPow _ _                                        -- `transpose_of_matrix_scalar_multiple`（必要十分版の `Conf M` への特殊化。`m, n → 2^{M_col}`, `c → (K_1)_ℂ`, `A → Σσ^z_ℓσ^z_{ℓ+1}`）
    _ = (K1 : ℂ) • ∑ m : Fin (n + 1), (sigmaZ m * sigmaZ (nextSite m))ᵀ := by
        rw [finite_sum_transpose_tensorPow n]                               -- `transpose_of_finite_sum_of_matrices`（必要十分版の `Conf M` への特殊化。主張の行数・列数 `m, n → 2^{M_col}`, `r → M_col`, `X_ℓ → σ^z_ℓσ^z_{ℓ+1}`（`1 ≤ ℓ ≤ M_col`））
    _ = (K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m) := by
        rw [Finset.sum_congr rfl fun m _ => sigmaZ_mul_sigmaZ_nextSite_transpose m]
                                                                            -- 上で得た `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` を各項へ
    _ = (K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m) := rfl
                                                                            -- `def_transfer_matrix_square_root` の `D` の定義

/-- `K_1D` は転置不変（使う側が引く、一般の `M` の形）。`M = n + 1` は人手の鎖 `K1D_transpose_succ`、
`M = 0`（人手の範囲外）は添字が空で `D` が零行列なので転置しても零行列（補助）。 -/
theorem K1D_transpose (K1 : ℝ) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m) := by
  cases M with
  | zero => rw [Finset.univ_eq_empty, Finset.sum_empty, smul_zero, Matrix.transpose_zero]
  | succ n => exact K1D_transpose_succ K1 n

/-- **人手 Step 1 の `σ^z_k` の成分の実性**（`k ∈ {1, …, M_col}`、`M = n + 1`。`sigmaX_hasRealEntries` と同じ形）:
`σ^z_k = I⊠⋯⊠σ^z⊠⋯⊠I`（`def_site_pauli_matrices`）の因子 `I`・`σ^z` の成分はすべて実数なので、
`kronecker_of_real_entry_matrices_has_real_entries` より `σ^z_k` の成分はすべて実数。 -/
theorem sigmaZ_hasRealEntries {n : ℕ} (k : Fin (n + 1)) : MatrixHasRealEntries (sigmaZ k) := by
  have hform : sigmaZ k
      = siteProd (n + 1) (Function.update (1 : Fin (n + 1) → Matrix (Fin 2) (Fin 2) ℂ) k pauliZ) := rfl
                                                        -- `def_site_pauli_matrices`（`k → k`, `a → z`）
  rw [hform]
  refine siteProd_hasRealEntries _ fun j => ?_          -- `kronecker_of_real_entry_matrices_has_real_entries`（`M → M_col`, `A_k → σ^z`, `A_j → I`（`j ≠ k`））
  by_cases h : j = k
  · rw [h, Function.update_self]
    exact pauliZ_hasRealEntries                         -- `pauli_z_has_real_entries`
  · rw [Function.update_of_ne h]
    exact identity_matrix_two_hasRealEntries            -- `identity_matrix_of_order_two_has_real_entries`

/-- **人手 Step 1 の `K_1D` の成分の実性の 2 段落**（`M = n + 1`）:
`σ^z_m`・`σ^z_{m^+}` の成分は実数なので `product_of_real_entry_matrices_has_real_entries` より `σ^z_mσ^z_{m^+}`（準備により `σ^z_mσ^z_{m+1}`）の成分は実数、
`finite_sum_of_real_entry_matrices_has_real_entries` より `D` の成分は実数、
`real_scalar_multiple_of_real_entry_matrix_has_real_entries` より `K_1D = (K_1)_ℂD` の成分は実数。 -/
theorem K1D_hasRealEntries_succ (K1 : ℝ) (n : ℕ) :
    MatrixHasRealEntries ((K1 : ℂ) • ∑ m : Fin (n + 1), sigmaZ m * sigmaZ (nextSite m)) := by
  have hterm : ∀ m : Fin (n + 1), MatrixHasRealEntries (sigmaZ m * sigmaZ (nextSite m)) := fun m =>
    matrix_mul_hasRealEntries _ _ (sigmaZ_hasRealEntries m) (sigmaZ_hasRealEntries (nextSite m))
                                                        -- `product_of_real_entry_matrices_has_real_entries`（`m, n, p → 2^{M_col}`, `A → σ^z_m`, `B → σ^z_{m^+}`）。準備の `σ^z_{m+1} = σ^z_{m^+}` は定義どおり
  have hD := finite_sum_hasRealEntries n (fun m : Fin (n + 1) => sigmaZ m * sigmaZ (nextSite m)) hterm
                                                        -- `finite_sum_of_real_entry_matrices_has_real_entries`（`m, n → 2^{M_col}`, `r → M_col`, `X_ℓ → σ^z_ℓσ^z_{ℓ+1}`）
  exact real_smul_hasRealEntries K1 _ hD                -- `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（主張の行数・列数 `m, n → 2^{M_col}`, `c → K_1`, `B → D`）

/-- `K_1D` の成分は実（使う側が引く、一般の `M` の形）。`M = n + 1` は人手の 2 段落 `K1D_hasRealEntries_succ`、
`M = 0`（人手の範囲外）は `D` が零行列なので成分は `0 = (0)_ℂ`（補助）。 -/
theorem K1D_hasRealEntries (K1 : ℝ) :
    MatrixHasRealEntries ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := by
  cases M with
  | zero =>
    intro I J
    exact ⟨0, by rw [Finset.univ_eq_empty, Finset.sum_empty, smul_zero, Matrix.zero_apply,
      Complex.ofReal_zero]⟩
  | succ n => exact K1D_hasRealEntries_succ K1 n

/-- 人手 Step 1 の結論: `K_1D` は実対称（`def_real_symmetric_complex_matrix`）。 -/
theorem K1D_isRealSymmetric (K1 : ℝ) :
    MatrixIsRealSymmetric ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) :=
  ⟨K1D_hasRealEntries K1, K1D_transpose K1⟩

/-- 人手 Step 2: `K_1D` はエルミート（`real_symmetric_matrix_is_hermitian`、`n → 2^{M_col}`, `A → K_1D`）。 -/
theorem K1D_isHermitian (K1 : ℝ) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)).IsHermitian :=
  real_symmetric_isHermitian _ (K1D_isRealSymmetric K1)

/-- 人手 Step 2: `½K_1D` はエルミート（`real_multiple_of_hermitian_is_hermitian`、`α → ½`, `A → K_1D`）。 -/
theorem halfK1D_isHermitian (K1 : ℝ) :
    (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))).IsHermitian :=
  real_multiple_isHermitian (1 / 2) (K1D_isHermitian K1)

/-- `physicalV1halfC` の指数 `(K_1/2)_ℂ D` は人手の `½K_1D`（`½` 倍した `K_1D`）である（スカラー倍の結合）。 -/
theorem halfK1D_eq_half_smul_K1D (K1 : ℝ) :
    ((K1 / 2 : ℝ) : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)
      = ((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := by
  rw [smul_smul]
  congr 1
  push_cast
  ring

/-- 人手 `def_transfer_matrix_square_root` の `B = V_1^{1/2} = exp(½K_1D)` を、`½K_1D` の形で書いたもの。 -/
theorem physicalV1halfC_eq_matExp_half (K1 : ℝ) :
    physicalV1halfC M K1
      = matExp (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))) := by
  rw [physicalV1halfC, V1PauliForm, halfK1D_eq_half_smul_K1D]

/-- 人手 Step 2: `½K_1D` の成分はすべて実数（Step 1 の `K_1D` の成分の実性と
`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（主張の行数・列数 `m, n → 2^{M_col}`, `c → ½`, `B → K_1D`））。 -/
theorem halfK1D_hasRealEntries (K1 : ℝ) :
    MatrixHasRealEntries (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))) :=
  real_smul_hasRealEntries (1 / 2) _ (K1D_hasRealEntries K1)

/-- **人手 Step 2 の `(½K_1D)^⊤ = ½K_1D` の 3 行の鎖**。 -/
theorem halfK1D_transpose (K1 : ℝ) :
    (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))ᵀ
      = ((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) :=
  calc (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))ᵀ
      = ((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))ᵀ :=
        transpose_smul_tensorPow _ _                    -- `transpose_of_matrix_scalar_multiple`（必要十分版の `Conf M` への特殊化。主張の行数・列数 `m, n → 2^{M_col}`, `c → (½)_ℂ`, `A → K_1D`）
    _ = ((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := by
        rw [K1D_transpose]                              -- Step 1 の `(K_1D)^⊤ = K_1D`
    _ = ((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := rfl   -- `½K_1D` の略記

/-- 人手 Step 2: `½K_1D` は実対称（成分の実性と転置の 3 行の鎖、`def_real_symmetric_complex_matrix`）。 -/
theorem halfK1D_isRealSymmetric (K1 : ℝ) :
    MatrixIsRealSymmetric (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))) :=
  ⟨halfK1D_hasRealEntries K1, halfK1D_transpose K1⟩

/-- 人手 Step 2: `B = exp(½K_1D)` は実対称（`exp_of_real_symmetric_is_real_symmetric`、`n → 2^{M_col}`, `A → ½K_1D`）。 -/
theorem physicalV1halfC_isRealSymmetric (K1 : ℝ) : MatrixIsRealSymmetric (physicalV1halfC M K1) := by
  rw [physicalV1halfC_eq_matExp_half]
  exact exp_of_real_symmetric_is_real_symmetric _ (halfK1D_isRealSymmetric K1)

/-- 人手 Step 3 が使う `B^⊤ = B`（Step 2 の `B` の実対称性の第 2 成分、`def_real_symmetric_complex_matrix`）。 -/
theorem physicalV1halfC_transpose (K1 : ℝ) : (physicalV1halfC M K1)ᵀ = physicalV1halfC M K1 :=
  (physicalV1halfC_isRealSymmetric K1).2

/-! ## Step 1・Step 2: `B = exp(½K_1D)` と `A = exp(S_2)` は正定値、`B' = exp(-½K_1D)` は `B'B = I` -/

/-- 人手 Step 2: `B = exp(½K_1D)` は正定値（`exp_hermitian_is_positive_definite`、`S → ½K_1D`）。 -/
theorem physicalV1halfC_posDef (K1 : ℝ) : (physicalV1halfC M K1).PosDef := by
  rw [physicalV1halfC_eq_matExp_half]
  exact posDef_exp_of_isHermitian (halfK1D_isHermitian K1)

/-- 人手 Step 3 の `B^* = B`（Step 2 の「`B` は正定値（とくにエルミート）」から）。 -/
theorem physicalV1halfC_conjTranspose (K1 : ℝ) : (physicalV1halfC M K1)ᴴ = physicalV1halfC M K1 :=
  (physicalV1halfC_posDef K1).isHermitian.eq

/-- 人手 Step 2 の `B' := exp(-½K_1D)`。 -/
noncomputable def physicalV1halfInvC (M : ℕ) (K1 : ℝ) : TensorPow M :=
  matExp (-(((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))))

/-- 人手 Step 2: `B'B = I`（`exp_of_negative_is_left_inverse`、`n → 2^{M_col}`, `A → ½K_1D`）。 -/
theorem physicalV1halfInvC_mul_physicalV1halfC (K1 : ℝ) :
    physicalV1halfInvC M K1 * physicalV1halfC M K1 = 1 := by
  rw [physicalV1halfInvC, physicalV1halfC_eq_matExp_half]
  exact matExp_neg_mul_matExp_tensorPow _

/-- 人手 Step 1 の「`S_2` も実対称」（`iH_is_real_symmetric` の結論を引く。実対称性を示すのはその Step 3 である）。
`iH_is_real_symmetric` の結論の Lean `S2_isRealSymmetric`（`ClaimIHPauliForm.lean`。`M = r + 1` は Step 3 の成分の実性と転置の鎖、
`M = 0` は人手の範囲外の補助）を `K_2^* = Kstar K_2` で引く。 -/
theorem S2C_isRealSymmetric (K2 : ℝ) :
    MatrixIsRealSymmetric ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M) :=
  S2_isRealSymmetric (Kstar K2)                                                   -- `iH_is_real_symmetric` の結論（`K_2^* → K_2^*`）

/-- 人手 Step 2 の `A := exp(S_2)`（`S_2 = iK_2^*H_2`）。 -/
noncomputable def expS2C (M : ℕ) (K2 : ℝ) : TensorPow M :=
  matExp ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M)

/-- 人手 Step 2: `A = exp(S_2)` は正定値（Step 1 の `S_2` の実対称性と `real_symmetric_matrix_is_hermitian`（`n → 2^{M_col}`, `A → S_2`）で
`S_2` はエルミート、`exp_hermitian_is_positive_definite`（`S → S_2`））。 -/
theorem expS2C_posDef (K2 : ℝ) : (expS2C M K2).PosDef :=
  posDef_exp_of_isHermitian (real_symmetric_isHermitian _ (S2C_isRealSymmetric K2))

/-- 人手 Step 3 の係数 `(2s_2)^{M_col/2}`（`s_2 = sinh 2K_2`）。 -/
noncomputable def twoS2Pow (M : ℕ) (K2 : ℝ) : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2)

/-- 人手 Step 3: `K_2 > 0` なら `(2s_2)^{M_col/2} > 0`。 -/
theorem twoS2Pow_pos {K2 : ℝ} (hK2 : 0 < K2) : 0 < twoS2Pow M K2 :=
  Real.rpow_pos_of_pos (by linarith [sinh_two_mul_pos hK2]) _

/-! ## Step 2: `A = exp(S_2)` は実対称、Step 3 が使う `V_2^⊤ = V_2` -/

/-- 人手 Step 2: `A = exp(S_2)` は実対称（`exp_of_real_symmetric_is_real_symmetric`、`n → 2^{M_col}`, `A → S_2`）。 -/
theorem expS2C_isRealSymmetric (K2 : ℝ) : MatrixIsRealSymmetric (expS2C M K2) :=
  exp_of_real_symmetric_is_real_symmetric _ (S2C_isRealSymmetric K2)

/-- 人手 Step 3 の `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`。`A = exp(S_2)`、係数は `((2s_2)^{M_col/2})_ℂ`）。 -/
theorem V2_eq_twoS2Pow_smul_expS2C {K2 : ℝ} (hK2 : 0 < K2) :
    V2 M K2 = ((twoS2Pow M K2 : ℝ) : ℂ) • expS2C M K2 := by
  rw [V2_exponential_representation hK2]; rfl

/-- **人手 Step 3 の `V_2^⊤ = V_2` の 4 行の鎖**（`V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）、
`transpose_of_matrix_scalar_multiple`、Step 2 の `A^⊤ = A`、`V_2 = (2s_2)^{M_col/2}A`）。 -/
theorem V2_transpose {K2 : ℝ} (hK2 : 0 < K2) : (V2 M K2)ᵀ = V2 M K2 :=
  calc (V2 M K2)ᵀ
      = (((twoS2Pow M K2 : ℝ) : ℂ) • expS2C M K2)ᵀ := by
        rw [V2_eq_twoS2Pow_smul_expS2C hK2]                                     -- `V_2 = (2s_2)^{M_col/2}A`
    _ = ((twoS2Pow M K2 : ℝ) : ℂ) • (expS2C M K2)ᵀ :=
        transpose_smul_tensorPow _ _                                            -- `transpose_of_matrix_scalar_multiple`（必要十分版の `Conf M` への特殊化。`c → ((2s_2)^{M_col/2})_ℂ`, `A → A`）
    _ = ((twoS2Pow M K2 : ℝ) : ℂ) • expS2C M K2 := by
        rw [(expS2C_isRealSymmetric K2).2]                                      -- Step 2 の `A^⊤ = A`（`def_real_symmetric_complex_matrix` の第 2 成分）
    _ = V2 M K2 := (V2_eq_twoS2Pow_smul_expS2C hK2).symm                        -- `V_2 = (2s_2)^{M_col/2}A`

/-! ## Step 3: 具体的な `W` は実対称 -/

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の `W^⊤ = W` の 7 行の鎖**:
`W^⊤ = ((BV_2)B)^⊤ = B^⊤(BV_2)^⊤ = B^⊤(V_2^⊤B^⊤) = B(V_2^⊤B) = B(V_2B) = (BV_2)B = W`。 -/
theorem physicalSymTransferC_transpose (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferC M K1 K2)ᵀ = physicalSymTransferC M K1 K2 :=
  calc (physicalSymTransferC M K1 K2)ᵀ
      = ((physicalV1halfC M K1 * V2 M K2) * physicalV1halfC M K1)ᵀ := rfl        -- `def_symmetrized_transfer_matrix`、`B = V_1^{1/2}`
    _ = (physicalV1halfC M K1)ᵀ * (physicalV1halfC M K1 * V2 M K2)ᵀ :=
        transpose_mul_tensorPow _ _                                             -- `transpose_of_matrix_product`（`A → BV_2`, `B → B`）
    _ = (physicalV1halfC M K1)ᵀ * ((V2 M K2)ᵀ * (physicalV1halfC M K1)ᵀ) := by
        rw [transpose_mul_tensorPow]                                            -- `transpose_of_matrix_product`（`A → B`, `B → V_2`）
    _ = physicalV1halfC M K1 * ((V2 M K2)ᵀ * physicalV1halfC M K1) := by
        rw [physicalV1halfC_transpose]                                          -- Step 2 の `B^⊤ = B` を 2 箇所へ同時に
    _ = physicalV1halfC M K1 * (V2 M K2 * physicalV1halfC M K1) := by
        rw [V2_transpose hK2]                                                   -- 上で得た `V_2^⊤ = V_2`
    _ = (physicalV1halfC M K1 * V2 M K2) * physicalV1halfC M K1 :=
        (Matrix.mul_assoc _ _ _).symm                                           -- `mat_mult_associative`（`A → B`, `B → V_2`, `C → B`）
    _ = physicalSymTransferC M K1 K2 := rfl                                     -- `def_symmetrized_transfer_matrix`

/-- 人手 Step 3: `V_2 = (2s_2)^{M_col/2}A` の成分は実（Step 2 の `A` の成分の実性と
`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → (2s_2)^{M_col/2}`, `B → A`））。 -/
theorem V2_hasRealEntries {K2 : ℝ} (hK2 : 0 < K2) : MatrixHasRealEntries (V2 M K2) := by
  rw [V2_eq_twoS2Pow_smul_expS2C hK2]
  exact real_smul_hasRealEntries _ _ (expS2C_isRealSymmetric K2).1

/-- 人手 Step 3: `W = (BV_2)B` の成分は実（`product_of_real_entry_matrices_has_real_entries` を `A → B, B → V_2` と
`A → BV_2, B → B` で 2 回）。 -/
theorem physicalSymTransferC_hasRealEntries (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    MatrixHasRealEntries (physicalSymTransferC M K1 K2) :=
  matrix_mul_hasRealEntries _ _
    (matrix_mul_hasRealEntries _ _ (physicalV1halfC_isRealSymmetric K1).1 (V2_hasRealEntries hK2))
    (physicalV1halfC_isRealSymmetric K1).1

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の結論「`W` は実対称」**（`def_real_symmetric_complex_matrix`）。 -/
theorem physicalSymTransferC_isRealSymmetric (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    MatrixIsRealSymmetric (physicalSymTransferC M K1 K2) :=
  ⟨physicalSymTransferC_hasRealEntries K1 hK2, physicalSymTransferC_transpose K1 hK2⟩

/-- **人手 `def_rayleigh_sup` の冒頭 `W_ℝ := ϱ(W)`（`def_real_matrix_of_real_entry_matrix`、`B → W`）を具体的な `W` について**:
成分がすべて実数の `W = physicalSymTransferC`（`physicalSymTransferC_hasRealEntries`）を `ϱ` で実数の行列へ移すと、
実成分で組んだ `physicalSymTransferR` になる（各成分で `W_pq = (physicalSymTransferR_pq)_ℂ`（`physicalSymTransferC_eq_map`）に
`realMatrixOfRealEntries_apply_eq` を当てる）。Lean の `c(M_col) = rayleighSup (physicalSymTransferR …)` は、この等式で人手の
`sup{x^⊤W_ℝx | ‖x‖ = 1}` と同じ値である（`rayleighSup_physicalSymTransferR_eq`）。 -/
theorem physicalSymTransferR_eq_realMatrixOfRealEntries (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    physicalSymTransferR M K1 K2
      = realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2) := by
  ext p q
  symm
  apply realMatrixOfRealEntries_apply_eq
  rw [physicalSymTransferC_eq_map, Matrix.map_apply, Complex.ofRealHom_eq_coe]

/-- **人手 `def_rayleigh_sup` の `c(M_col) := sup 𝓡`、`𝓡 = {x^⊤W_ℝx | ‖x‖ = 1}`、`W_ℝ = ϱ(W)` を具体的な `W` について**:
Lean の `rayleighSup (physicalSymTransferR …)` は `rayleighSup (ϱ(W))` に等しい。 -/
theorem rayleighSup_physicalSymTransferR_eq (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    rayleighSup (physicalSymTransferR M K1 K2)
      = rayleighSup (realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) := by
  rw [← physicalSymTransferR_eq_realMatrixOfRealEntries K1 hK2]

/-- **人手 `W_real_is_symmetric` の 4 行の鎖と単射性**:
`((W_ℝ)_kl)_ℂ = W_kl = (W^⊤)_kl = W_lk = ((W_ℝ)_lk)_ℂ` に `inclusion_rr_to_cc_is_injective`（`a → (W_ℝ)_kl`, `b → (W_ℝ)_lk`）を当てる。 -/
theorem W_real_entry_symm (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (k l : Conf M) :
    realMatrixOfRealEntries (physicalSymTransferC M K1 K2) (physicalSymTransferC_hasRealEntries K1 hK2) k l
      = realMatrixOfRealEntries (physicalSymTransferC M K1 K2) (physicalSymTransferC_hasRealEntries K1 hK2) l k :=
  inclusion_rr_to_cc_is_injective <|
    calc ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
            (physicalSymTransferC_hasRealEntries K1 hK2) k l : ℝ) : ℂ)
        = physicalSymTransferC M K1 K2 k l :=
          ofReal_realMatrixOfRealEntries_apply _ _ k l                           -- `def_W_real`
      _ = (physicalSymTransferC M K1 K2)ᵀ k l := by
          rw [physicalSymTransferC_transpose K1 hK2]                             -- `W^⊤ = W`（`W_is_real_symmetric_positive_definite`）
      _ = physicalSymTransferC M K1 K2 l k := Matrix.transpose_apply _ _ _       -- `def_matrix_transpose`
      _ = ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
            (physicalSymTransferC_hasRealEntries K1 hK2) l k : ℝ) : ℂ) :=
          (ofReal_realMatrixOfRealEntries_apply _ _ l k).symm                    -- `def_W_real`

/-- **人手 `W_real_is_symmetric`**: `W_ℝ` は対称（`def_real_symmetric_matrix`。Lean の `Matrix.IsSymm` は `W_ℝ^⊤ = W_ℝ`、
成分では `(W_ℝ)_lk = (W_ℝ)_kl`）。`k, l` は任意なので、上の鎖を各 `k, l` に当てる。 -/
theorem W_real_is_symmetric (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2)).IsSymm :=
  Matrix.IsSymm.ext fun k l => W_real_entry_symm K1 hK2 l k

/-- 人手 `W_real_is_symmetric` を、実成分で組んだ `physicalSymTransferR` で読む（`physicalSymTransferR_eq_realMatrixOfRealEntries`）。 -/
theorem physicalSymTransferR_isSymm (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).IsSymm := by
  rw [physicalSymTransferR_eq_realMatrixOfRealEntries K1 hK2]
  exact W_real_is_symmetric K1 hK2

/-! ## Step 3: 具体的な `W` は正定値 -/

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の 5 行の鎖**（`c := (2s_2)^{M_col/2}` を `ℂ` の元として）:
`W = (BV_2)B = (B(cA))B = (c(BA))B = c((BA)B) = c((B^*A)B)`。 -/
theorem physicalSymTransferC_eq_smul_congruence (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    physicalSymTransferC M K1 K2
      = ((twoS2Pow M K2 : ℝ) : ℂ)
          • ((physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1) :=
  calc physicalSymTransferC M K1 K2
      = (physicalV1halfC M K1 * V2 M K2) * physicalV1halfC M K1 := rfl          -- `def_symmetrized_transfer_matrix`、`B = V_1^{1/2}`
    _ = (physicalV1halfC M K1 * (((twoS2Pow M K2 : ℝ) : ℂ) • expS2C M K2)) * physicalV1halfC M K1 := by
        rw [V2_eq_twoS2Pow_smul_expS2C hK2]                                     -- Step 3 の冒頭の `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）
    _ = (((twoS2Pow M K2 : ℝ) : ℂ) • (physicalV1halfC M K1 * expS2C M K2)) * physicalV1halfC M K1 := by
        rw [mul_smul_matrix_tensorPow]                                           -- `scalar_multiple_factors_out_of_right_factor`（`a → c`, `A → B`, `B → A`）
    _ = ((twoS2Pow M K2 : ℝ) : ℂ) • ((physicalV1halfC M K1 * expS2C M K2) * physicalV1halfC M K1) :=
        smul_mul_matrix_tensorPow _ _ _                                          -- `scalar_multiple_factors_out_of_left_factor`（`a → c`, `A → BA`, `B → B`）
    _ = ((twoS2Pow M K2 : ℝ) : ℂ)
          • ((physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1) := by
        rw [physicalV1halfC_conjTranspose]                                       -- `B^* = B`

/-- **人手 `W_is_real_symmetric_positive_definite` の「`W` は正定値」を具体的な `W` について**:
`congruence_preserves_positive_definite`（`A → exp(S_2)`, `B → V_1^{1/2}`, `B' → exp(-½K_1D)`）で `B^*(AB)` は正定値、
`mat_mult_associative` で `(B^*A)B = B^*(AB)`、`positive_real_multiple_preserves_positive_definite`（`α → (2s_2)^{M_col/2}`）で `W` は正定値。 -/
theorem physicalSymTransferC_posDef (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferC M K1 K2).PosDef := by
  have hcong : ((physicalV1halfC M K1)ᴴ * (expS2C M K2 * physicalV1halfC M K1)).PosDef :=
    congruence_preserves_positive_definite_tensorPow (expS2C_posDef K2)
      (physicalV1halfInvC_mul_physicalV1halfC K1)                               -- `congruence_preserves_positive_definite`
  have hassoc : (physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1
      = (physicalV1halfC M K1)ᴴ * (expS2C M K2 * physicalV1halfC M K1) :=
    Matrix.mul_assoc _ _ _                                                       -- `mat_mult_associative`
  rw [physicalSymTransferC_eq_smul_congruence K1 hK2, hassoc]
  exact positive_real_multiple_preserves_positive_definite_tensorPow hcong (twoS2Pow_pos hK2) -- `positive_real_multiple_preserves_positive_definite`

/-- **人手 `W_real_is_positive_definite` の 10 行の鎖のうち 9 行**（`ξ_k := (x_k)_ℂ`）:
`ρ_ℂ = ξ^*Wξ = ΣΣ \overline{ξ_k}W_klξ_l = ΣΣ \overline{(x_k)_ℂ}W_kl(x_l)_ℂ = ΣΣ (x_k)_ℂW_kl(x_l)_ℂ = ΣΣ (x_k)_ℂ((W_ℝ)_kl)_ℂ(x_l)_ℂ
= ΣΣ (x_k(W_ℝ)_kl)_ℂ(x_l)_ℂ = ΣΣ (x_k(W_ℝ)_klx_l)_ℂ = Σ_k(Σ_l x_k(W_ℝ)_klx_l)_ℂ = (ΣΣ x_k(W_ℝ)_klx_l)_ℂ`。
人手の 10 行目 `= (x^⊤W_ℝx)_ℂ`（`def_real_bilinear_value`）は `W_real_is_positive_definite` の `rw [dotProduct_mulVec_eq_real_bilinear_value]` が受け持つ。 -/
theorem conjugate_bilinear_value_of_real_vector_W (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ)
    {ρ : ℝ} (hρ : conjugateBilinearValue (fun k => (x k : ℂ)) (physicalSymTransferC M K1 K2)
      (fun k => (x k : ℂ)) = (ρ : ℂ)) :
    (ρ : ℂ) = ((∑ k, ∑ l, x k * realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2) k l * x l : ℝ) : ℂ) := by
  set WR := realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
    (physicalSymTransferC_hasRealEntries K1 hK2) with hWR
  set ξ : Conf M → ℂ := fun k => (x k : ℂ) with hξ
  calc (ρ : ℂ)
      = conjugateBilinearValue ξ (physicalSymTransferC M K1 K2) ξ := hρ.symm     -- `ρ` の取り方
    _ = ∑ k, ∑ l, (star (ξ k) * physicalSymTransferC M K1 K2 k l) * ξ l := rfl   -- `def_conjugate_bilinear_value`
    _ = ∑ k, ∑ l, (star (x k : ℂ) * physicalSymTransferC M K1 K2 k l) * (x l : ℂ) := rfl -- `ξ` の置き方
    _ = ∑ k, ∑ l, ((x k : ℂ) * physicalSymTransferC M K1 K2 k l) * (x l : ℂ) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [complex_conjugate_of_real_inclusion (x k)]                          -- `complex_conjugate_of_real_inclusion`（`r → x_k`）を各項へ
    _ = ∑ k, ∑ l, ((x k : ℂ) * ((WR k l : ℝ) : ℂ)) * (x l : ℂ) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [ofReal_realMatrixOfRealEntries_apply]                               -- `def_W_real` の `((W_ℝ)_kl)_ℂ = W_kl` を各項へ
    _ = ∑ k, ∑ l, ((x k * WR k l : ℝ) : ℂ) * (x l : ℂ) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [real_inclusion_mul (x k) (WR k l)]                                  -- `real_inclusion_preserves_product`（`a → x_k`, `b → (W_ℝ)_kl`）を各項へ
    _ = ∑ k, ∑ l, ((x k * WR k l * x l : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          real_inclusion_mul (x k * WR k l) (x l)                                 -- `real_inclusion_preserves_product`（`a → x_k(W_ℝ)_kl`, `b → x_l`）を各項へ
    _ = ∑ k, ((∑ l, x k * WR k l * x l : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun k _ => (Complex.ofReal_sum _ _).symm             -- `real_inclusion_preserves_finite_sum`（`r_l → x_k(W_ℝ)_klx_l`）を各 `k` へ
    _ = ((∑ k, ∑ l, x k * WR k l * x l : ℝ) : ℂ) := (Complex.ofReal_sum _ _).symm -- `real_inclusion_preserves_finite_sum`（`r_k → Σ_l x_k(W_ℝ)_klx_l`）

/-- **人手 `W_real_is_positive_definite`**: `x ∈ ℝ^{2^{M_col}}` が `x ≠ 0` なら `x^⊤W_ℝx > 0`。
`ξ_k := (x_k)_ℂ` は `ξ ≠ 0`（`x_k ≠ 0` の `k` で `ξ_k = 0_ℂ = (0)_ℂ` なら単射性で `x_k = 0`）、`W` は正定値なので
`ξ^*Wξ = ρ_ℂ` を満たす `ρ ∈ ℝ_{>0}` があり、10 行の鎖と単射性（`a → ρ`, `b → x^⊤W_ℝx`）で `x^⊤W_ℝx = ρ > 0`。 -/
theorem W_real_is_positive_definite (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2) *ᵥ x := by
  have hξ : (fun k => (x k : ℂ)) ≠ 0 := by
    obtain ⟨k, hk⟩ := Function.ne_iff.mp hx                                     -- `x_k ≠ 0` となる `k`
    intro h
    apply hk
    exact inclusion_rr_to_cc_is_injective
      ((congrFun h k).trans Complex.ofReal_zero.symm)                             -- `ξ_k = 0_ℂ = (0)_ℂ` なら `x_k = 0`（`a → x_k`, `b → 0`）
  obtain ⟨ρ, hρ, hρW⟩ :=
    posDef_conjugateBilinearValue_pos (physicalSymTransferC_posDef K1 hK2) hξ     -- `W` は正定値（`W_is_real_symmetric_positive_definite`）
  have hxWx := inclusion_rr_to_cc_is_injective
    (conjugate_bilinear_value_of_real_vector_W K1 hK2 x hρW)                      -- 単射性（`a → ρ`, `b → x^⊤W_ℝx`）
  rw [dotProduct_mulVec_eq_real_bilinear_value, ← hxWx]                           -- `def_real_bilinear_value`（人手の鎖の 10 行目）
  exact hρ

/-- 人手 `W_real_is_positive_definite` を、実成分で組んだ `physicalSymTransferR` で読む
（`physicalSymTransferR_eq_realMatrixOfRealEntries`。`ClaimPartitionFunctionSandwichAndLimitInNRow.lean`・`TheoremOnsagerUnconditional.lean`・`PhysicalEvenSectorBridge.lean` が使う形）。 -/
theorem physicalSymTransferR_posDef (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ physicalSymTransferR M K1 K2 *ᵥ x := by
  rw [physicalSymTransferR_eq_realMatrixOfRealEntries K1 hK2]
  exact W_real_is_positive_definite K1 hK2 x hx

/-- **人手 `W_real_is_positive_semidefinite`**: すべての `u` で `u^⊤W_ℝu ≥ 0`（`W_ℝ := ϱ(W)`）。
人手の `u ≠ 0` の側（`W_real_is_positive_definite`）と `u = 0` の 5 行の鎖は `psd_of_pd`（`ClaimOperatorBound.lean`）の 2 つの場合である。 -/
theorem W_real_is_positive_semidefinite (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (u : Conf M → ℝ) :
    0 ≤ u ⬝ᵥ realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2) *ᵥ u :=
  psd_of_pd (W_real_is_positive_definite K1 hK2) u

/-! ## 可逆性: `B ∈ R^×`、`BV_2 ∈ R^×`、`W ∈ R^×`

人手の可逆性の段と 1 対 1 に対応する。`R = Mat(2^{M_col},ℂ)`（`def_invertible_elements_of_R`、`M → M_col`）は Lean の `TensorPow M`、
「`g ∈ R^×`」は単元 `⟨g, h, gh = I, hg = I⟩` を値 `g` に持つこと（`IsUnit g`）である。 -/

/-- **人手の可逆性の段の `BB' = I` の 3 行の鎖**:
`BB' = exp(½K_1D)exp(-½K_1D) = exp(-(-½K_1D))exp(-½K_1D) = I`。 -/
theorem physicalV1halfC_mul_physicalV1halfInvC (K1 : ℝ) :
    physicalV1halfC M K1 * physicalV1halfInvC M K1 = 1 :=
  calc physicalV1halfC M K1 * physicalV1halfInvC M K1
      = matExp (((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))
          * matExp (-(((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))) := by
        rw [physicalV1halfC_eq_matExp_half, physicalV1halfInvC]                  -- `B`, `B'` の置き方
    _ = matExp (-(-(((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))))
          * matExp (-(((1 / 2 : ℝ) : ℂ) • ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)))) := by
        rw [neg_neg_tensorPow]                                                   -- `matrix_double_negation`（`m, n → 2^{M_col}`, `A → ½K_1D`）
    _ = 1 := matExp_neg_mul_matExp_tensorPow _                                   -- `exp_of_negative_is_left_inverse`（`n → 2^{M_col}`, `A → -½K_1D`）

/-- **人手の可逆性の段の `B ∈ R^×`**（`def_invertible_elements_of_R` の `g → B`, `h → B'`。
`BB' = I` は上の 3 行の鎖、`B'B = I` は Step 2）。 -/
theorem physicalV1halfC_isUnit (K1 : ℝ) : IsUnit (physicalV1halfC M K1) :=
  ⟨⟨physicalV1halfC M K1, physicalV1halfInvC M K1,
    physicalV1halfC_mul_physicalV1halfInvC K1, physicalV1halfInvC_mul_physicalV1halfC K1⟩, rfl⟩

/-- **人手の可逆性の段の `BV_2 ∈ R^×`**（`B ∈ R^×`、`V2_invertible`（Lean の `isUnit_V2`）、
`def_invertible_elements_of_R` (ii)（`g_1 → B`, `g_2 → V_2`））。 -/
theorem physicalV1halfC_mul_V2_isUnit (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    IsUnit (physicalV1halfC M K1 * V2 M K2) :=
  invertible_product_isUnit_tensorPow (physicalV1halfC_isUnit K1) (isUnit_V2 hK2)

/-- **人手の可逆性の段の `W ∈ R^×` の 2 行**:
`W = (BV_2)B`（`def_symmetrized_transfer_matrix`、`B = V_1^{1/2}`）`∈ R^×`
（前の式の `BV_2 ∈ R^×`、`B ∈ R^×`、`def_invertible_elements_of_R` (ii)（`g_1 → BV_2`, `g_2 → B`））。 -/
theorem physicalSymTransferC_isUnit (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    IsUnit (physicalSymTransferC M K1 K2) := by
  have hW : physicalSymTransferC M K1 K2 = (physicalV1halfC M K1 * V2 M K2) * physicalV1halfC M K1 := rfl
                                                                                 -- `def_symmetrized_transfer_matrix`、`B = V_1^{1/2}`
  rw [hW]
  exact invertible_product_isUnit_tensorPow (physicalV1halfC_mul_V2_isUnit K1 hK2)
    (physicalV1halfC_isUnit K1)                                                  -- `def_invertible_elements_of_R` (ii)（`g_1 → BV_2`, `g_2 → B`）

/-! ## 挟み撃ち -/

/-- **人手 `trace_of_W_power_via_W_real`**: `tr(W^q) = (Σ_k ((W_ℝ)^q)_kk)_ℂ`（`W_ℝ := ϱ(W)`、`def_W_real`）。
`W` の成分の実性は `physicalSymTransferC_hasRealEntries`（`W_is_real_symmetric_positive_definite`）、`W^q` の成分の実性と
`(W^q)_ℝ = (W_ℝ)^q` は `real_matrix_of_real_entry_matrix_preserves_power`（`n → d`, `A → W`）。 -/
theorem trace_of_W_power_via_W_real (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (q : ℕ) :
    (physicalSymTransferC M K1 K2 ^ q).trace
      = ((∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ q) k k : ℝ) : ℂ) := by
  set hW := physicalSymTransferC_hasRealEntries (M := M) K1 hK2
  calc (physicalSymTransferC M K1 K2 ^ q).trace
      = ∑ k, (physicalSymTransferC M K1 K2 ^ q) k k := rfl                    -- `def_trace`（`n → d`, `A → W^q`）
    _ = ∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2 ^ q)
          (matrix_pow_hasRealEntries _ hW q) k k : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun k _ =>
          (ofReal_realMatrixOfRealEntries_apply _ _ k k).symm                 -- `def_real_matrix_of_real_entry_matrix`（`B → W^q`）を `d` 個の項へ
    _ = ∑ k, (((realMatrixOfRealEntries (physicalSymTransferC M K1 K2) hW) ^ q) k k : ℂ) := by
        rw [real_matrix_of_real_entry_matrix_preserves_power _ hW q]          -- `real_matrix_of_real_entry_matrix_preserves_power`（`n → d`, `A → W`）
    _ = ((∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2) hW) ^ q) k k : ℝ) : ℂ) :=
        (Complex.ofReal_sum _ _).symm                                         -- `real_inclusion_preserves_finite_sum`（`m → d`）

/-- **人手 `partition_function_sandwich` の準備**: `Z(K_1,K_2) = T`、`T := Σ_k ((W_ℝ)^{N_row})_kk`（`W_ℝ := ϱ(W)`、`def_W_real`）。
人手の 2 行の鎖 `(Z(K_1,K_2))_ℂ = tr(W^{N_row})`（`Z_equals_trace_of_W` の「とくに」、`partition_function_eq_trace_physicalSymTransferC`）
`= T_ℂ`（`trace_of_W_power_via_W_real`（`q → N_row`））と、`inclusion_rr_to_cc_is_injective`（`a → Z(K_1,K_2)`, `b → T`）に 1 対 1 で対応する。 -/
theorem partition_function_eq_sum_diag_W_real_pow (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    partitionFunction Nrow M K1 K2
      = ∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ Nrow) k k := by
  apply inclusion_rr_to_cc_is_injective                                       -- `inclusion_rr_to_cc_is_injective`（`a → Z(K_1,K_2)`, `b → T`）
  calc ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ)
      = (physicalSymTransferC M K1 K2 ^ Nrow).trace :=
        partition_function_eq_trace_physicalSymTransferC K1 K2 hN             -- `Z_equals_trace_of_W` の「とくに」
    _ = ((∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ Nrow) k k : ℝ) : ℂ) :=
        trace_of_W_power_via_W_real K1 hK2 Nrow                               -- `trace_of_W_power_via_W_real`（`q → N_row`）

/-- **人手 `trace_power_sandwich`（本文の具体的な `W` について）**: `n ≥ 1` について
`c(M_col)^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`（`W_ℝ := ϱ(W)`、`def_W_real`）。一般の `W` の具体版 `trace_power_sandwich`
（`ClaimTracePowerSandwich.lean`）に、`W_is_real_symmetric_positive_definite`（実対称性、`physicalSymTransferC_isRealSymmetric`）と
`W_real_is_symmetric`・`W_real_is_positive_definite` を渡す。 -/
theorem trace_power_sandwich_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) {n : ℕ} (hn : 1 ≤ n) :
    rayleighSup (realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n
        ≤ ∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n) k k
      ∧ ∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n) k k
        ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n :=
  trace_power_sandwich (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2)
    (W_real_is_symmetric K1 hK2) (W_real_is_positive_definite K1 hK2) hn

/-- **人手 `partition_function_sandwich`（具体的な `Z(K_1,K_2)` と具体的な `W` について）**:
`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}`（`ℝ` の順序）、`c(M_col) := sup{x^⊤W_ℝx | ‖x‖ = 1}`。
人手の 2 行の鎖 2 本（`Z(K_1,K_2) = T ≥ c^{N_row}`、`Z(K_1,K_2) = T ≤ 2^{M_col}c^{N_row}`）と 1 対 1 の `calc`。準備の `Z(K_1,K_2) = T` は
`partition_function_eq_sum_diag_W_real_pow`、不等式は `trace_power_sandwich_physical`（`n → N_row`）。主張の `c(M_col)` を実成分で組んだ
`physicalSymTransferR` の上限で述べるので、冒頭の 1 行で `W_ℝ = ϱ(W)` へ書き換える（`physicalSymTransferR_eq_realMatrixOfRealEntries`。人手の `W_ℝ` は `def_W_real` の `ϱ(W)` 一つなので、この行に人手の行は無い）。 -/
theorem partition_function_sandwich_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow ≤ partitionFunction Nrow M K1 K2
      ∧ partitionFunction Nrow M K1 K2
        ≤ 2 ^ M * rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow := by
  rw [physicalSymTransferR_eq_realMatrixOfRealEntries K1 hK2]                      -- `W_ℝ = physicalSymTransferR`（人手の行なし。主張の読み替え）
  set WR := realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
    (physicalSymTransferC_hasRealEntries K1 hK2) with hWR
  have hZT : partitionFunction Nrow M K1 K2 = ∑ k, (WR ^ Nrow) k k :=             -- 準備の `Z(K_1,K_2) = T`
    partition_function_eq_sum_diag_W_real_pow K1 hK2 hN
  have h := trace_power_sandwich_physical (M := M) K1 hK2 hN
  refine ⟨?_, ?_⟩
  · exact calc partitionFunction Nrow M K1 K2
        = ∑ k, (WR ^ Nrow) k k := hZT                                              -- 準備
      _ ≥ rayleighSup WR ^ Nrow := h.1                                             -- `trace_power_sandwich`（`n → N_row`）の左の不等式
  · calc partitionFunction Nrow M K1 K2
        = ∑ k, (WR ^ Nrow) k k := hZT                                              -- 準備
      _ ≤ 2 ^ M * rayleighSup WR ^ Nrow := h.2                                     -- `trace_power_sandwich`（`n → N_row`）の右の不等式

/-- **人手 `trace_power_upper_bound`（本文の具体的な `W` について）**: `n ≥ 1` について
`Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`（`W_ℝ := ϱ(W)`、`def_W_real`）。一般の `W` の具体版 `trace_power_upper_bound` に、
`W_is_real_symmetric_positive_definite`（実対称性、`physicalSymTransferC_isRealSymmetric`）と、`rayleigh_bounds_operator_norm` が要る
`W_real_is_symmetric`・`W_real_is_positive_definite` を渡す。 -/
theorem trace_power_upper_bound_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k, ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n) k k
      ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)) ^ n :=
  trace_power_upper_bound (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2)
    (W_real_is_symmetric K1 hK2) (W_real_is_positive_definite K1 hK2) hn

/-- **人手 `moment_log_convexity`** を本文の `W`（`def_symmetrized_transfer_matrix`）と `W_ℝ`（`def_W_real`）に当てたもの:
単位ベクトル `x` について、すべての `k ≥ 0` で `m_k > 0`、すべての `k ≥ 1` で `m_k^2 ≤ m_{k-1}m_{k+1}`（`m_k := x^⊤(W_ℝ)^kx`）。 -/
theorem moment_log_convexity_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) {x : Conf M → ℝ}
    (hx : vecNorm x = 1) :
    (∀ k : ℕ, 0 < momentWReal (physicalSymTransferC M K1 K2)
        (physicalSymTransferC_isRealSymmetric K1 hK2) x k)
      ∧ ∀ k : ℕ, 1 ≤ k →
          momentWReal (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2) x k ^ 2
            ≤ momentWReal (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2) x (k - 1)
              * momentWReal (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2) x (k + 1) :=
  moment_log_convexity (physicalSymTransferC M K1 K2) (physicalSymTransferC_isRealSymmetric K1 hK2)
    (W_real_is_symmetric K1 hK2) (W_real_is_positive_definite K1 hK2) hx

end Ising2D
