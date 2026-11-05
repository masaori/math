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
| Step 1・Step 2: `S_2` は実対称（`iH_is_real_symmetric` Step 1）で、`real_symmetric_matrix_is_hermitian`（`A → S_2`）でエルミート | `expS2C_posDef` の中の `S2_isHermitian`（`M ≥ 1` では人手の鎖の `S2_isHermitian_of_real_symmetric`、`M = 0` は人手の範囲外の補助で反可換性から） |
| Step 2: `exp_hermitian_is_positive_definite` で `B := exp(½K_1D)` と `A := exp(S_2)` は正定値 | `physicalV1halfC_posDef`、`expS2C_posDef` |
| Step 2: `exp_of_negative_is_left_inverse` で `B' := exp(-½K_1D)` は `B'B = I` | `physicalV1halfInvC`、`physicalV1halfInvC_mul_physicalV1halfC` |
| Step 3: `B` がエルミートなので `B^* = B` | `physicalV1halfC_conjTranspose` |
| Step 3 の 4 行の鎖 `W = BV_2B = B((2s_2)^{M_col/2}A)B = (2s_2)^{M_col/2}BAB = (2s_2)^{M_col/2}B^*AB` | `physicalSymTransferC_eq_smul_congruence` の `calc` の 4 段（係数 `(2s_2)^{M_col/2}` は `twoS2Pow`） |
| Step 3: `congruence_preserves_positive_definite`（Lean は `TensorPow M` の系 `congruence_preserves_positive_definite_tensorPow`。必要十分版の特殊化で、添字 `Fin n` の 1 対 1 の具体版は通らない）で `B^*(AB)` は正定値、`mat_mult_associative`、`K_2 > 0` で `(2s_2)^{M_col/2} > 0`、`positive_real_multiple_preserves_positive_definite` で `W` は正定値 | `physicalSymTransferC_posDef`（`twoS2Pow_pos`） |
| 正定値性を実ベクトルで読む（`partition_function_sandwich` が使う形） | `realQuadForm_pos_of_map_posDef`、`physicalSymTransferR_posDef` |
| `½K_1D` は転置不変（人手に対応する行の無い補助。Step 2・Step 3 が使う `B^⊤ = B` の前提で、`½K_1D = ½(K_1D)`・`transpose_of_matrix_scalar_multiple`・`(K_1D)^⊤ = K_1D` から）、Step 2: `B = exp(½K_1D)` は転置不変、Step 2–3: `V_2^⊤ = V_2` | `halfK1D_transpose`、`physicalV1halfC_transpose`・`physicalV1halfR_isSymm`、`V2_transpose`・`physicalV2R_isSymm` |
| Step 3 の結論「`W = BV_2B` は実対称」（具体的な `B = V_1^{1/2}`, `V_2` について） | `physicalSymTransferR_isSymm` |
| `partition_function_sandwich`（`Z = tr(W^{N_row})` → `trace_power_sandwich` の両側の評価を `n = N_row` に適用） | `partition_function_sandwich_physical` |

- Step 3 の「スカラー倍と行列積の結合則」と `mat_mult_associative` は具体版が無く、mathlib の `Matrix.mul_smul`・`Matrix.smul_mul`・
  `Matrix.mul_assoc` を引く。`exp_hermitian_is_positive_definite` の Lean（`posDef_exp_of_isHermitian`）は人手の段と一対一でない
  （`ClaimPositiveDefinite.lean` の注意）。`positive_real_multiple_preserves_positive_definite` は、添字が `Conf M` の行列なので
  `positive_real_multiple_preserves_positive_definite_tensorPow`（必要十分版の特殊化。具体版は添字 `Fin n` で、人手の 13 行の鎖と
  1 対 1。`ClaimPositiveRealMultiplePreservesPositiveDefinite.lean`）を引く。
- Step 1 の `transpose_of_matrix_product`・`transpose_of_matrix_scalar_multiple`・`transpose_of_finite_sum_of_matrices` は、添字が `Conf M` の行列なので、
  `TensorPow M` の系 `transpose_mul_tensorPow`・`transpose_smul_tensorPow`・`finite_sum_transpose_tensorPow`（必要十分版を添字 `Conf M` へ特殊化したもの。
  具体版（添字 `Fin m`）と手順は同じ。`ClaimIHPauliForm.lean` の Step 3 の節と同じ扱い）を引く。
- 人手の Step 1 は `M_col ≥ 1` で述べる。Lean の鎖は `M = n + 1` で述べ（`K1D_transpose_succ`・`K1D_hasRealEntries_succ`）、
  人手の範囲外の `M = 0` は、添字が空で `D` が零行列であることによる補助の場合分けで一般の `M` の形（`K1D_transpose`・`K1D_hasRealEntries`）へ広げる。
- 実対称性の段のうち Step 2・Step 3（`physicalV1halfC_transpose`・`V2_transpose` と、実行列の `symTransfer_isSymm`）は、
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
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealMultipleOfHermitianIsHermitian
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverseFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries

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

/-- 人手に対応する行の無い補助（Step 2・Step 3 が使う `B^⊤ = B` の前提）: `½K_1D` は転置不変（`½K_1D = ½(K_1D)`（`halfK1D_eq_half_smul_K1D`）、`transpose_of_matrix_scalar_multiple`、`(K_1D)^⊤ = K_1D`）。 -/
theorem halfK1D_transpose (K1 : ℝ) :
    ((((K1 / 2 : ℝ) : ℂ)) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))ᵀ
      = (((K1 / 2 : ℝ) : ℂ)) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m) := by
  rw [halfK1D_eq_half_smul_K1D, transpose_smul_tensorPow, K1D_transpose]

/-- 人手 Step 2: `B = exp(½K_1D)` は転置不変（転置不変な行列の指数関数は転置不変）。 -/
theorem physicalV1halfC_transpose (K1 : ℝ) : (physicalV1halfC M K1)ᵀ = physicalV1halfC M K1 := by
  rw [physicalV1halfC, V1PauliForm, matExp, ← Matrix.exp_transpose, halfK1D_transpose]

/-- 人手 Step 2: `V_1^{1/2}` は実対称（実行列で）。 -/
theorem physicalV1halfR_isSymm (K1 : ℝ) : (physicalV1halfR M K1).IsSymm := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  show (physicalV1halfR M K1)ᵀ.map Complex.ofRealHom = (physicalV1halfR M K1).map Complex.ofRealHom
  rw [Matrix.transpose_map, ← physicalV1halfC_eq_map, physicalV1halfC_transpose]

/-! ## Step 1・Step 2: `B = exp(½K_1D)` と `A = exp(S_2)` は正定値、`B' = exp(-½K_1D)` は `B'B = I` -/

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

/-! ## 具体的な `W` は実対称 -/

/-- **人手 `W_is_real_symmetric_positive_definite` Step 3 の「`W` は実対称」を具体的な `W` について**:
`B = V_1^{1/2}`（Step 2、`physicalV1halfR_isSymm`）と `V_2`（`physicalV2R_isSymm`）が実対称なので
`W = BV_2B` も実対称（`symTransfer_isSymm`）。 -/
theorem physicalSymTransferR_isSymm (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).IsSymm :=
  symTransfer_isSymm (physicalV1halfR_isSymm K1) (physicalV2R_isSymm hK2)

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
  exact positive_real_multiple_preserves_positive_definite_tensorPow hcong (twoS2Pow_pos hK2) -- `positive_real_multiple_preserves_positive_definite`

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
