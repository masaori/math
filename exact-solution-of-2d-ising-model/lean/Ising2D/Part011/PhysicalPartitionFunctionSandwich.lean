/-
# 具体的な分配関数 `Z(K_1,K_2)` と具体的な `W` についての挟み撃ち

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_001_definition_transfer_matrix_square_root`（ラベル **`def_transfer_matrix_square_root`**）
  の「`V_1^{1/2}V_1^{1/2} = V_1`」
* `maxeig_003_claim_W_is_positive_definite`（ラベル **`W_is_real_symmetric_positive_definite`**）
  のうち `B := V_1^{1/2}` と `V_2` についての部分（Step 1・Step 2 と、Step 3 の `V_2 = (2s_2)^{M_col/2}A`）
* `maxeig_009_claim_partition_function_sandwich`（ラベル **`partition_function_sandwich`**）

`Ising2D.partition_function_sandwich`（`Claim009_PartitionFunctionSandwich.lean`）は一般の実行列
`B, V_1, V_2` と、`Z = tr((V_1V_2)^{N_row})` を仮定として受け取る。本ファイルはその仮定を、
章 001 の具体的な分配関数 `Ising2D.partitionFunction` と、`PhysicalSymTransferBridge.lean` の
具体的な実行列 `physicalV1halfR`（`V_1^{1/2}`）・`physicalV2R`（`V_2`）についてすべて証明し、
人手 `partition_function_sandwich` の主張そのもの
`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}` を、
`c(M_col) := rayleighSup physicalSymTransferR` について立てる。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `def_transfer_matrix_square_root`: `V_1^{1/2}V_1^{1/2} = exp(K_1D) = V_1`（`theorem_exp_product`、`½K_1D` は自分自身と可換） | `physicalV1halfC_mul_self` |
| 同じ等式の実行列での表示 | `physicalV1halfR_mul_self_map` |
| `partition_function_via_transfer_matrix` を実行列 `V_1 = V_1^{1/2}V_1^{1/2}`, `V_2` で読む | `partitionFunction_eq_trace_real` |
| Step 1: `σ^z_mσ^z_{m+1}` は転置不変（人手はクロネッカー積の形から、Lean は `sigma_z_diagonal_action` の対角表示から示す） | `sigmaZ_mul_sigmaZ_transpose` |
| Step 1: 実係数の有限和 `½K_1D` も転置不変 | `halfK1D_transpose` |
| Step 2: `B = exp(½K_1D)` は転置不変（実対称行列の指数関数は実対称） | `physicalV1halfC_transpose`、実行列で `physicalV1halfR_isSymm` |
| Step 3 が使う (2) の仮定「`B` は可逆」（`exp(X)exp(-X) = I`。人手 Step 2 の「`B` はエルミートかつ正定値」は Lean では使わないので形式化しない） | `physicalV1halfC_isUnit`、実行列で `physicalV1halfR_isUnit` |
| Step 2: `A := exp(S_2)` は正定値（`exp_hermitian_is_positive_definite` (1)） | `V2_posDef` の中 |
| Step 3: `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）と `(2s_2)^{M_col/2} > 0` | `V2_posDef`（下の注意） |
| Step 2–3: `A` は転置不変なので `V_2^⊤ = V_2` | `V2_transpose`、実行列で `physicalV2R_isSymm` |
| `V_2` の正定値性を実ベクトルで読む | `physicalV2R_posDef` |
| `partition_function_sandwich` | `partition_function_sandwich_physical` |

**`V_2` の正定値性の適用順についての注意。** 人手 Step 3 は `W = (2s_2)^{M_col/2}B^*AB` と変形し、
`exp_hermitian_is_positive_definite` の (2)・(3) をこの順に `B^*AB`・`W` へ適用する。Lean では一般の定理
`partition_function_sandwich` が `V_2` の正定値性を仮定に取るので、(1)・(3) を先に `A`・`V_2 = (2s_2)^{M_col/2}A`
へ使い（`V2_posDef`）、(2) は `symTransfer_posDef`（合同変換）の中で使う。使う定理の組は同じで、適用の順序だけが違う。

## 仮定について

人手は `N_row ∈ ℤ_{≥1}` を仮定するので `1 ≤ Nrow` を仮定する。`K_2 > 0` は `V2_exponential_representation`
の仮定と、(3) に渡す `(2s_2)^{M_col/2} > 0` が使う。`K_1` の正値性は使わないので仮定に置かない。

同じ具体的な行列についての主張を具体化しただけなので、必要十分版は置かない
（抽象的な内容は `partition_function_sandwich` と `Ising2D/NecSuf/RayleighMoments.lean` に尽きている）。
-/
import Ising2D.Part001.ClaimPartitionFunctionViaTransferMatrix
import Ising2D.Part004.ClaimV2InZY
import Ising2D.Part009.Claim013_PositiveDefinite
import Ising2D.Part011.PhysicalSymTransferBridge
import Ising2D.Part011.Claim009_PartitionFunctionSandwich

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

/-- `B = exp(½K_1D)` は可逆（`exp(X)exp(-X) = exp(-X)exp(X) = I`。`matExpUnits` がその逆元を持つ）。 -/
theorem physicalV1halfC_isUnit (K1 : ℝ) : IsUnit (physicalV1halfC M K1) :=
  ⟨matExpUnits _, rfl⟩

/-- 人手 Step 2: `V_1^{1/2}` は実対称（実行列で）。 -/
theorem physicalV1halfR_isSymm (K1 : ℝ) : (physicalV1halfR M K1).IsSymm := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  show (physicalV1halfR M K1)ᵀ.map Complex.ofRealHom = (physicalV1halfR M K1).map Complex.ofRealHom
  rw [Matrix.transpose_map, ← physicalV1halfC_eq_map, physicalV1halfC_transpose]

/-- `V_1^{1/2}` は可逆（実行列で。行列式を `ℂ` へ埋め込むと複素行列の行列式）。 -/
theorem physicalV1halfR_isUnit (K1 : ℝ) : IsUnit (physicalV1halfR M K1) := by
  have h := physicalV1halfC_isUnit (M := M) K1
  rw [physicalV1halfC_eq_map, Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero] at h
  rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
  intro h0
  apply h
  rw [← RingHom.mapMatrix_apply, ← RingHom.map_det, h0, map_zero]

/-! ## `Z(K_1,K_2)` を実行列のトレースとして -/

/-- **人手 `partition_function_via_transfer_matrix` を実行列で読む**:
`Z(K_1,K_2) = tr((V_1^{1/2}V_1^{1/2} V_2)^{N_row})`（`V_1 = V_1^{1/2}V_1^{1/2}`）。 -/
theorem partitionFunction_eq_trace_real (K1 K2 : ℝ) {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    partitionFunction Nrow M K1 K2
      = ((physicalV1halfR M K1 * physicalV1halfR M K1 * physicalV2R M K2) ^ Nrow).trace := by
  apply Complex.ofReal_injective
  rw [partition_function_via_transfer_matrix K1 K2 hN, ← physicalV1halfR_mul_self_map,
    physicalV2C_eq_map, ← Matrix.map_mul, ← Matrix.map_pow]
  simp only [Matrix.trace, Matrix.diag, Matrix.map_apply, Complex.ofRealHom_eq_coe,
    Complex.ofReal_sum]

/-! ## `V_2` -/

/-- **人手 Step 2–3 の `V_2` の部分**: `A := exp(iK_2^*H_2)` は正定値（`exp_hermitian_is_positive_definite` (1)）で、
`V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）、`(2s_2)^{M_col/2} > 0` なので
同 (3) より `V_2` は正定値（適用順についてはファイル冒頭の注意）。 -/
theorem V2_posDef {K2 : ℝ} (hK2 : 0 < K2) : (V2 M K2).PosDef := by
  rw [V2_exponential_representation hK2, V2H2Form, matExp]
  refine posDef_smul_of_pos (posDef_exp_of_isHermitian (S2_isHermitian ?_)) ?_
  · exact Complex.conj_ofReal _
  · exact Real.rpow_pos_of_pos (by linarith [sinh_two_mul_pos hK2]) _

/-- **人手 Step 2–3**: `A = exp(S_2)` は転置不変（`S_2` が転置不変）なので `V_2 = (2s_2)^{M_col/2}A` も転置不変。 -/
theorem V2_transpose {K2 : ℝ} (hK2 : 0 < K2) : (V2 M K2)ᵀ = V2 M K2 := by
  rw [V2_exponential_representation hK2, V2H2Form, matExp, Matrix.transpose_smul,
    ← Matrix.exp_transpose, S2_transpose]

/-- `V_2` は実対称（実行列で）。 -/
theorem physicalV2R_isSymm {K2 : ℝ} (hK2 : 0 < K2) : (physicalV2R M K2).IsSymm := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  show (physicalV2R M K2)ᵀ.map Complex.ofRealHom = (physicalV2R M K2).map Complex.ofRealHom
  rw [Matrix.transpose_map, ← physicalV2C_eq_map, V2_transpose hK2]

/-- `V_2` の正定値性を実ベクトルで読む: `x ≠ 0` なら `x^⊤V_2x > 0`
（`x` を成分ごとに `ℂ` へ埋め込むと `x^*V_2x = x^⊤V_2x`）。 -/
theorem physicalV2R_posDef {K2 : ℝ} (hK2 : 0 < K2) (x : Conf M → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ physicalV2R M K2 *ᵥ x := by
  set xc : Conf M → ℂ := fun i => (x i : ℂ) with hxc
  have hxc0 : xc ≠ 0 := by
    intro h
    apply hx
    funext i
    exact Complex.ofReal_injective (congrFun h i)
  have hpos := (V2_posDef (M := M) hK2).dotProduct_mulVec_pos hxc0
  have hval : star xc ⬝ᵥ V2 M K2 *ᵥ xc = ((x ⬝ᵥ physicalV2R M K2 *ᵥ x : ℝ) : ℂ) := by
    have hstar : star xc = Complex.ofRealHom ∘ x := by
      funext i
      simp [hxc, Complex.conj_ofReal]
    have hxc' : xc = Complex.ofRealHom ∘ x := rfl
    rw [physicalV2C_eq_map, hstar, hxc']
    simp only [dotProduct, mulVec, Function.comp_apply, Matrix.map_apply,
      Complex.ofRealHom_eq_coe, Complex.ofReal_sum, Complex.ofReal_mul]
  rw [hval] at hpos
  exact Complex.zero_lt_real.mp hpos

/-! ## 挟み撃ち -/

/-- **人手 `partition_function_sandwich`（具体的な `Z(K_1,K_2)` と具体的な `W` について）**:
`c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}`、`c(M_col) := sup{x^⊤Wx | ‖x‖ = 1}`。 -/
theorem partition_function_sandwich_physical (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow ≤ partitionFunction Nrow M K1 K2
      ∧ partitionFunction Nrow M K1 K2
        ≤ 2 ^ M * rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow := by
  have h := partition_function_sandwich (rfl : physicalV1halfR M K1 * physicalV1halfR M K1 = _)
    (physicalV1halfR_isSymm K1) (physicalV1halfR_isUnit K1) (physicalV2R_isSymm hK2)
    (physicalV2R_posDef hK2) hN (partitionFunction_eq_trace_real K1 K2 hN)
  rw [card_conf] at h
  exact h

end Ising2D
