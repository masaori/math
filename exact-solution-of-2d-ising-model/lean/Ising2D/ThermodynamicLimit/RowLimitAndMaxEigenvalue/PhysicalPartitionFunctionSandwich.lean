/-
# 具体的な分配関数 `Z(K_1,K_2)` と具体的な `W` についての挟み撃ち

正本: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`

* `maxeig_001_definition_transfer_matrix_square_root`（ラベル **`def_transfer_matrix_square_root`**）
  の「`V_1^{1/2}V_1^{1/2} = V_1`」

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`

* `maxeig_003_claim_W_is_positive_definite`（ラベル **`W_is_real_symmetric_positive_definite`**）
  の正定値性（Step 1・Step 2・Step 3 の鎖）と実対称性（可逆性はまだ置いていない）
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
| `Z_equals_trace_of_W` の「とくに」: 具体的な `Z(K_1,K_2) = tr(W^{N_row})`（`W = (V_1^{1/2}V_2)V_1^{1/2}`、係数は `ℂ`） | `partition_function_eq_trace_physicalSymTransferC` |
| 同じ等式を実行列 `W` で読む | `partitionFunction_eq_trace_physicalSymTransferR_pow` |
| Step 1: `K_1D` の成分は実（Lean は `D` の対角表示 `sum_sigmaZ_sigmaZ_eq_diagonal` から示す） | `K1D_hasRealEntries` |
| Step 1: `K_1D` は転置不変（`σ^z_mσ^z_{m+1}` が転置不変で、実係数の有限和） | `sigmaZ_mul_sigmaZ_transpose`、`K1D_transpose` |
| Step 1 の結論「`K_1D` は実対称」 | `K1D_isRealSymmetric` |
| Step 2: `real_symmetric_matrix_is_hermitian`（`A → K_1D`）で `K_1D` はエルミート | `K1D_isHermitian` |
| Step 2: `real_multiple_of_hermitian_is_hermitian`（`α → ½`, `A → K_1D`）で `½K_1D` はエルミート | `halfK1D_isHermitian`（`physicalV1halfC` の指数 `(K_1/2)_ℂD` を `½(K_1D)` へ書き直すのは `halfK1D_eq_half_smul_K1D`・`physicalV1halfC_eq_matExp_half`） |
| Step 1・Step 2: `S_2` は実対称（`iH_is_real_symmetric` Step 1）で、`real_symmetric_matrix_is_hermitian`（`A → S_2`）でエルミート | `expS2C_posDef` の中の `S2_isHermitian`（`M ≥ 1` では人手の鎖の `S2_isHermitian_of_real_symmetric`、`M = 0` は人手の範囲外の補助で反可換性から） |
| Step 2: `exp_hermitian_is_positive_definite` で `B := exp(½K_1D)` と `A := exp(S_2)` は正定値 | `physicalV1halfC_posDef`、`expS2C_posDef` |
| Step 2: `exp_of_negative_is_left_inverse` で `B' := exp(-½K_1D)` は `B'B = I` | `physicalV1halfInvC`、`physicalV1halfInvC_mul_physicalV1halfC` |
| Step 3: `B` がエルミートなので `B^* = B` | `physicalV1halfC_conjTranspose` |
| Step 3 の 4 行の鎖 `W = BV_2B = B((2s_2)^{M_col/2}A)B = (2s_2)^{M_col/2}BAB = (2s_2)^{M_col/2}B^*AB` | `physicalSymTransferC_eq_smul_congruence` の `calc` の 4 段（係数 `(2s_2)^{M_col/2}` は `twoS2Pow`） |
| Step 3: `congruence_preserves_positive_definite`（Lean は `TensorPow M` の系 `congruence_preserves_positive_definite_tensorPow`。必要十分版の特殊化で、添字 `Fin n` の 1 対 1 の具体版は通らない）で `B^*(AB)` は正定値、`mat_mult_associative`、`K_2 > 0` で `(2s_2)^{M_col/2} > 0`、`positive_real_multiple_preserves_positive_definite` で `W` は正定値 | `physicalSymTransferC_posDef`（`twoS2Pow_pos`） |
| 正定値性を実ベクトルで読む（`partition_function_sandwich` が使う形） | `realQuadForm_pos_of_map_posDef`、`physicalSymTransferR_posDef` |
| Step 1: `½K_1D` は転置不変、Step 2: `B = exp(½K_1D)` は転置不変、Step 2–3: `V_2^⊤ = V_2` | `halfK1D_transpose`、`physicalV1halfC_transpose`・`physicalV1halfR_isSymm`、`V2_transpose`・`physicalV2R_isSymm` |
| Step 3 の結論「`W = BV_2B` は実対称」（具体的な `B = V_1^{1/2}`, `V_2` について） | `physicalSymTransferR_isSymm` |
| `partition_function_sandwich`（`Z = tr(W^{N_row})` → `trace_power_sandwich` の両側の評価を `n = N_row` に適用） | `partition_function_sandwich_physical` |

- Step 3 の「スカラー倍と行列積の結合則」と `mat_mult_associative` は具体版が無く、mathlib の `Matrix.mul_smul`・`Matrix.smul_mul`・
  `Matrix.mul_assoc` を引く。`exp_hermitian_is_positive_definite` の Lean（`posDef_exp_of_isHermitian`）は人手の段と一対一でない
  （`ClaimPositiveDefinite.lean` の注意）。`positive_real_multiple_preserves_positive_definite` の Lean（`posDef_smul_of_pos`）も、
  人手のエルミート性の段（`real_multiple_of_hermitian_is_hermitian`）と正値性の 13 行の成分の鎖と 1 対 1 でなく、
  mathlib の `Matrix.conjTranspose_smul`・`Matrix.smul_mulVec`・`dotProduct_smul`・`mul_pos` で閉じている。
- Step 1 の「`K_1D` の成分は実」は、人手（`σ^z` 2 個と単位行列のクロネッカー積なので成分が実、実係数の有限和なので実）と論法が違い、
  `D` の対角表示から示している。
- 実対称性の段（`halfK1D_transpose`・`physicalV1halfC_transpose`・`V2_transpose` と、実行列の `symTransfer_isSymm`）は、
  人手の転置の 4 行の鎖と 1 対 1 でなく、mathlib の `Matrix.exp_transpose` に委ねている。可逆性（人手の `BB' = I` の鎖と
  `def_invertible_elements_of_R` (ii) の 2 回の適用）はまだ置いていない。どちらも状態台帳の次の単位で扱う。

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
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimPartitionFunctionSandwich
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealMultipleOfHermitianIsHermitian
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverseFromNecSuf

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

/-- 人手 Step 1: `σ^z_mσ^z_{m'}` は転置不変（`sigma_z_diagonal_action` による対角表示から）。 -/
theorem sigmaZ_mul_sigmaZ_transpose (m m' : Fin M) :
    (sigmaZ m * sigmaZ m')ᵀ = sigmaZ m * sigmaZ m' := by
  rw [sigmaZ_mul_sigmaZ_eq_diagonal, Matrix.diagonal_transpose]

/-- 人手 Step 1: 実係数の有限和 `½K_1D` は転置不変。 -/
theorem halfK1D_transpose (K1 : ℝ) :
    ((((K1 / 2 : ℝ) : ℂ)) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (((K1 / 2 : ℝ) : ℂ)) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m) := by
  rw [Matrix.transpose_smul, Matrix.transpose_sum]
  simp only [sigmaZ_mul_sigmaZ_transpose]

/-- 人手 Step 2: `B = exp(½K_1D)` は転置不変（転置不変な行列の指数関数は転置不変）。 -/
theorem physicalV1halfC_transpose (K1 : ℝ) : (physicalV1halfC M K1)ᵀ = physicalV1halfC M K1 := by
  rw [physicalV1halfC, V1PauliForm, matExp, ← Matrix.exp_transpose, halfK1D_transpose]

/-- 人手 Step 2: `V_1^{1/2}` は実対称（実行列で）。 -/
theorem physicalV1halfR_isSymm (K1 : ℝ) : (physicalV1halfR M K1).IsSymm := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  show (physicalV1halfR M K1)ᵀ.map Complex.ofRealHom = (physicalV1halfR M K1).map Complex.ofRealHom
  rw [Matrix.transpose_map, ← physicalV1halfC_eq_map, physicalV1halfC_transpose]

/-! ## `Z(K_1,K_2)` を `W` のトレースとして -/

/-- **人手 `Z_equals_trace_of_W` の「とくに」**（具体的な `Z(K_1,K_2)` と `W` について。2 行）:
`N_row ∈ ℤ_{≥1}` について `Z(K_1,K_2) = tr((V_1V_2)^{N_row}) = tr(W^{N_row})`。
`Z(K_1,K_2) ∈ ℝ` は包含 `ℝ → ℂ`（`inclusion_rr_to_cc`）で `ℂ` の元として読む。
本体は具体版 `trace_mul_pow_eq_trace_symmetrized_pow` を `B := V_1^{1/2}`（準備 1 の `BB = V_1` は `physicalV1halfC_mul_self`、`W = (BV_2)B` は `physicalSymTransferC` の定義）で引く。 -/
theorem partition_function_eq_trace_physicalSymTransferC (K1 K2 : ℝ) {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ) = (physicalSymTransferC M K1 K2 ^ Nrow).trace :=
  calc ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ)
      = ((V1 M K1 * V2 M K2) ^ Nrow).trace :=
        partition_function_via_transfer_matrix K1 K2 hN          -- `partition_function_via_transfer_matrix`
    _ = (physicalSymTransferC M K1 K2 ^ Nrow).trace :=
        trace_mul_pow_eq_trace_symmetrized_pow (physicalV1halfC_mul_self K1) rfl Nrow hN
                                                                -- 本体を `n := N_row` に適用

/-! ## `V_2` -/

/-- **人手 Step 2–3**: `A = exp(S_2)` は転置不変（`S_2` が転置不変）なので `V_2 = (2s_2)^{M_col/2}A` も転置不変。 -/
theorem V2_transpose {K2 : ℝ} (hK2 : 0 < K2) : (V2 M K2)ᵀ = V2 M K2 := by
  rw [V2_exponential_representation hK2, V2H2Form, matExp, Matrix.transpose_smul,
    ← Matrix.exp_transpose, S2_transpose]

/-- `V_2` は実対称（実行列で）。 -/
theorem physicalV2R_isSymm {K2 : ℝ} (hK2 : 0 < K2) : (physicalV2R M K2).IsSymm := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  show (physicalV2R M K2)ᵀ.map Complex.ofRealHom = (physicalV2R M K2).map Complex.ofRealHom
  rw [Matrix.transpose_map, ← physicalV2C_eq_map, V2_transpose hK2]

/-! ## 具体的な `W` は実対称 -/

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の「`W` は実対称」を具体的な `W` について**:
`B = V_1^{1/2}`（Step 2、`physicalV1halfR_isSymm`）と `V_2`（`physicalV2R_isSymm`）が実対称なので
`W = BV_2B` も実対称（`symTransfer_isSymm`）。 -/
theorem physicalSymTransferR_isSymm (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).IsSymm :=
  symTransfer_isSymm (physicalV1halfR_isSymm K1) (physicalV2R_isSymm hK2)

/-! ## Step 1・Step 2: `B = exp(½K_1D)` と `A = exp(S_2)` は正定値、`B' = exp(-½K_1D)` は `B'B = I` -/

/-- 人手 Step 1: `K_1D` の成分は実（`D` は対角行列で、対角成分は `∑_m μ(m)μ(m+1)`。`sum_sigmaZ_sigmaZ_eq_diagonal`）。 -/
theorem K1D_hasRealEntries (K1 : ℝ) :
    MatrixHasRealEntries ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := by
  intro I J
  rw [sum_sigmaZ_sigmaZ_eq_diagonal, Matrix.smul_apply, smul_eq_mul]
  by_cases h : I = J
  · subst h
    refine ⟨K1 * ∑ m : Fin M, sgn (I m) * sgn (I (nextSite m)), ?_⟩
    rw [Matrix.diagonal_apply_eq]
    simp only [sgnC, Complex.ofReal_mul, Complex.ofReal_sum]
  · exact ⟨0, by rw [Matrix.diagonal_apply_ne _ h, mul_zero, Complex.ofReal_zero]⟩

/-- 人手 Step 1: `K_1D` は転置不変（`σ^z_mσ^z_{m+1}` が転置不変で、実係数 `K_1` の有限和）。 -/
theorem K1D_transpose (K1 : ℝ) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m) := by
  rw [Matrix.transpose_smul, Matrix.transpose_sum]
  simp only [sigmaZ_mul_sigmaZ_transpose]

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

/-- 人手 Step 2 の `A := exp(S_2)`（`S_2 = iK_2^*H_2`）。 -/
noncomputable def expS2C (M : ℕ) (K2 : ℝ) : TensorPow M :=
  matExp ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M)

/-- 人手 Step 2: `A = exp(S_2)` は正定値（`S_2` はエルミート（`iH_is_real_symmetric`）なので `exp_hermitian_is_positive_definite`）。 -/
theorem expS2C_posDef (K2 : ℝ) : (expS2C M K2).PosDef :=
  posDef_exp_of_isHermitian (S2_isHermitian (Complex.conj_ofReal _))

/-- 人手 Step 3 の係数 `(2s_2)^{M_col/2}`（`s_2 = sinh 2K_2`）。 -/
noncomputable def twoS2Pow (M : ℕ) (K2 : ℝ) : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2)

/-- 人手 Step 3: `K_2 > 0` なら `(2s_2)^{M_col/2} > 0`。 -/
theorem twoS2Pow_pos {K2 : ℝ} (hK2 : 0 < K2) : 0 < twoS2Pow M K2 :=
  Real.rpow_pos_of_pos (by linarith [sinh_two_mul_pos hK2]) _

/-! ## Step 3: 具体的な `W` は正定値 -/

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の 4 行の鎖**:
`W = BV_2B = B((2s_2)^{M_col/2}A)B = (2s_2)^{M_col/2}BAB = (2s_2)^{M_col/2}B^*AB`。 -/
theorem physicalSymTransferC_eq_smul_congruence (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    physicalSymTransferC M K1 K2
      = ((twoS2Pow M K2 : ℝ) : ℂ)
          • ((physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1) :=
  calc physicalSymTransferC M K1 K2
      = physicalV1halfC M K1 * V2 M K2 * physicalV1halfC M K1 := rfl            -- `def_symmetrized_transfer_matrix`
    _ = physicalV1halfC M K1 * (((twoS2Pow M K2 : ℝ) : ℂ) • expS2C M K2) * physicalV1halfC M K1 := by
        rw [V2_exponential_representation hK2]; rfl                              -- `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）
    _ = ((twoS2Pow M K2 : ℝ) : ℂ) • (physicalV1halfC M K1 * expS2C M K2 * physicalV1halfC M K1) := by
        rw [Matrix.mul_smul, Matrix.smul_mul]                                    -- スカラー倍と行列積の結合則
    _ = ((twoS2Pow M K2 : ℝ) : ℂ)
          • ((physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1) := by
        rw [physicalV1halfC_conjTranspose]                                       -- `B^* = B`

/-- **人手 `W_is_real_symmetric_positive_definite` の「`W` は正定値」を具体的な `W` について**:
`congruence_preserves_positive_definite`（`A → exp(S_2)`, `B → V_1^{1/2}`, `B' → exp(-½K_1D)`）で `B^*(AB)` は正定値、
`mat_mult_associative` で `B^*AB = B^*(AB)`、`positive_real_multiple_preserves_positive_definite`（`r → (2s_2)^{M_col/2}`）で `W` は正定値。 -/
theorem physicalSymTransferC_posDef (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferC M K1 K2).PosDef := by
  have hcong : ((physicalV1halfC M K1)ᴴ * (expS2C M K2 * physicalV1halfC M K1)).PosDef :=
    congruence_preserves_positive_definite_tensorPow (expS2C_posDef K2)
      (physicalV1halfInvC_mul_physicalV1halfC K1)                               -- `congruence_preserves_positive_definite`
  have hassoc : (physicalV1halfC M K1)ᴴ * expS2C M K2 * physicalV1halfC M K1
      = (physicalV1halfC M K1)ᴴ * (expS2C M K2 * physicalV1halfC M K1) :=
    Matrix.mul_assoc _ _ _                                                       -- `mat_mult_associative`
  rw [physicalSymTransferC_eq_smul_congruence K1 hK2, hassoc]
  exact posDef_smul_of_pos hcong (twoS2Pow_pos hK2)                              -- `positive_real_multiple_preserves_positive_definite`

/-- 実行列 `A` を成分ごとに `ℂ` へ埋め込んだ行列が正定値なら、`x ≠ 0` の実ベクトルで `x^⊤Ax > 0`
（`x` を成分ごとに `ℂ` へ埋め込むと `x^*Ax = x^⊤Ax`）。 -/
theorem realQuadForm_pos_of_map_posDef {A : Matrix (Conf M) (Conf M) ℝ}
    (hA : (A.map Complex.ofRealHom).PosDef) (x : Conf M → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ A *ᵥ x := by
  set xc : Conf M → ℂ := fun i => (x i : ℂ) with hxc
  have hxc0 : xc ≠ 0 := by
    intro h
    apply hx
    funext i
    exact Complex.ofReal_injective (congrFun h i)
  have hpos := hA.dotProduct_mulVec_pos hxc0
  have hval : star xc ⬝ᵥ A.map Complex.ofRealHom *ᵥ xc = ((x ⬝ᵥ A *ᵥ x : ℝ) : ℂ) := by
    have hstar : star xc = Complex.ofRealHom ∘ x := by
      funext i
      simp [hxc, Complex.conj_ofReal]
    have hxc' : xc = Complex.ofRealHom ∘ x := rfl
    rw [hstar, hxc']
    simp only [dotProduct, mulVec, Function.comp_apply, Matrix.map_apply,
      Complex.ofRealHom_eq_coe, Complex.ofReal_sum, Complex.ofReal_mul]
  rw [hval] at hpos
  exact Complex.zero_lt_real.mp hpos

/-- **人手 `W_is_real_symmetric_positive_definite` の「`W` は正定値」を実ベクトルで読む**（`partition_function_sandwich` が使う形）:
`x ≠ 0` なら `x^⊤Wx > 0`（`physicalSymTransferC_posDef` を `physicalSymTransferC_eq_map` で実行列へ）。 -/
theorem physicalSymTransferR_posDef (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ physicalSymTransferR M K1 K2 *ᵥ x :=
  realQuadForm_pos_of_map_posDef
    (by rw [← physicalSymTransferC_eq_map]; exact physicalSymTransferC_posDef K1 hK2) x hx

/-! ## 挟み撃ち -/

/-- 人手 `Z_equals_trace_of_W` の「とくに」を実行列 `W` で読む: `Z(K_1,K_2) = tr(W^{N_row})`
（`partition_function_eq_trace_physicalSymTransferC` を `physicalSymTransferC_eq_map` と埋め込みの単射性で `ℝ` へ戻す）。 -/
theorem partitionFunction_eq_trace_physicalSymTransferR_pow (K1 K2 : ℝ) {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    partitionFunction Nrow M K1 K2 = (physicalSymTransferR M K1 K2 ^ Nrow).trace := by
  apply Complex.ofReal_injective
  rw [partition_function_eq_trace_physicalSymTransferC K1 K2 hN, physicalSymTransferC_eq_map,
    ← Matrix.map_pow]
  simp only [Matrix.trace, Matrix.diag, Matrix.map_apply, Complex.ofRealHom_eq_coe,
    Complex.ofReal_sum]

/-- **人手 `partition_function_sandwich`（具体的な `Z(K_1,K_2)` と具体的な `W` について）**:
`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}`、`c(M_col) := sup{x^⊤Wx | ‖x‖ = 1}`。
人手どおり `Z = tr(W^{N_row})`（`Z_equals_trace_of_W`）へ書き換え、`trace_power_sandwich` の両側の評価を `n = N_row` に適用する
（`W` の実対称性は `physicalSymTransferR_isSymm`、正定値性は `physicalSymTransferR_posDef`）。 -/
theorem partition_function_sandwich_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow ≤ partitionFunction Nrow M K1 K2
      ∧ partitionFunction Nrow M K1 K2
        ≤ 2 ^ M * rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow := by
  rw [partitionFunction_eq_trace_physicalSymTransferR_pow K1 K2 hN]                -- `Z_equals_trace_of_W`
  have h := trace_power_sandwich (physicalSymTransferR_isSymm (M := M) K1 hK2)
    (physicalSymTransferR_posDef K1 hK2) hN                                        -- `trace_power_sandwich`（`n = N_row`）
  rw [card_conf] at h
  exact h

end Ising2D
