/-
# 対称化転送行列 `W := V₁^{1/2} V₂ V₁^{1/2}` と `Z = tr(W^{N_row})`

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_001_definition_transfer_matrix_square_root`（ラベル **`def_transfer_matrix_square_root`**）
* `maxeig_001a_definition_symmetrized_transfer_matrix`（ラベル **`def_symmetrized_transfer_matrix`**）
* `maxeig_002_claim_Z_equals_trace_of_W`（ラベル **`Z_equals_trace_of_W`**）
* `maxeig_003_claim_W_is_positive_definite`（ラベル **`W_is_real_symmetric_positive_definite`**）
* `maxeig_004_claim_W_has_positive_entries`（ラベル **`W_has_positive_entries`**）

## 他章に仮定として置いた事実（重要）

本ファイルは章 010（`partition_function_in_pauli_form`）・章 009
（`def_config_basis_iso`, `sigma_z_diagonal_action`, `V2_component_equals_pauli`,
`iH_is_real_symmetric`, `exp_hermitian_is_positive_definite`）に依存するが、
それらの Lean 形式化は本タスクの担当外なので **import せず仮定として受け取る**。
具体的には次を仮定の形にしている。

1. `Z(J,J') = tr((V₁V₂)^{N_row})`（章 010）— `Claim009_PartitionFunctionSandwich.lean` の仮定。
2. `V₁^{1/2}` が**正の対角行列**であること（章 009 の `sigma_z_diagonal_action` +
   `exp_of_diagonal_matrix`）— ここでは `Ising2D.diagExp d`（`d : n → ℝ`）として与える。
   人手証明の `d μ = (1/2)K₁ ∑_m μ(m)μ(m+1)` に対応する。
3. `V₂` の成分がすべて正であること（章 010 の `V2_component_equals_pauli`）— 仮定。
4. `V₂` が実対称正定値であること（章 009 の `iH_is_real_symmetric` +
   `exp_hermitian_is_positive_definite`）— 仮定。なお 4 を導く一般補題
   `Ising2D.matExp_isSymm` / `Ising2D.matExp_posDef`（実対称行列の指数関数は
   実対称正定値）は本ファイルで証明済みなので、章 009 が形式化されればそのまま接続できる。
-/
import Ising2D.Part011.Claim008_TracePowerSandwich
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix
open scoped NormedSpace

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## `W := B V₂ B` -/

/-- 人手証明の `W := V₁^{1/2} V₂ V₁^{1/2}`（`B = V₁^{1/2}`）。 -/
def symTransfer (B V2 : Matrix n n ℝ) : Matrix n n ℝ := B * V2 * B

/-- `(B V₂ B)^{k+1} = B (V₂ (B B))^k V₂ B`（人手証明の結合法則による括り直し）。 -/
theorem symTransfer_pow_succ (B V2 : Matrix n n ℝ) (k : ℕ) :
    symTransfer B V2 ^ (k + 1) = B * (V2 * (B * B)) ^ k * V2 * B := by
  induction k with
  | zero => simp [symTransfer]
  | succ k ih =>
      rw [pow_succ, ih]
      simp only [symTransfer, pow_succ]
      noncomm_ring

/-- `V₁ (V₂ V₁)^k V₂ = (V₁ V₂)^{k+1}`（人手証明の最後の等号）。 -/
theorem mul_pow_mul_eq (V1 V2 : Matrix n n ℝ) (k : ℕ) :
    V1 * (V2 * V1) ^ k * V2 = (V1 * V2) ^ (k + 1) := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [pow_succ, pow_succ, ← ih]
      noncomm_ring

/-- **`tr((V₁V₂)^n) = tr(W^n)`**（人手証明 `Z_equals_trace_of_W`）。

`B * B = V₁` だけを仮定する。 -/
theorem trace_symTransfer_pow {B V1 V2 : Matrix n n ℝ} (hBB : B * B = V1) (k : ℕ) :
    (symTransfer B V2 ^ (k + 1)).trace = ((V1 * V2) ^ (k + 1)).trace := by
  rw [symTransfer_pow_succ, hBB]
  rw [Matrix.trace_mul_comm (B * (V2 * V1) ^ k * V2) B]
  rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, hBB]
  rw [mul_pow_mul_eq]

/-! ## `W` の対称性・正定値性・成分の正値性 -/

/-- `B`, `V₂` が実対称なら `W = B V₂ B` も実対称
（人手証明 `W_is_real_symmetric_positive_definite` の Step 3 の後半）。 -/
theorem symTransfer_isSymm {B V2 : Matrix n n ℝ} (hB : B.IsSymm) (hV2 : V2.IsSymm) :
    (symTransfer B V2).IsSymm := by
  show (B * V2 * B)ᵀ = B * V2 * B
  rw [Matrix.transpose_mul, Matrix.transpose_mul, hB.eq, hV2.eq, Matrix.mul_assoc]

/-- 可逆な行列の `mulVec` は単射。 -/
theorem mulVec_eq_zero_iff_of_isUnit {B : Matrix n n ℝ} (hB : IsUnit B) {x : n → ℝ}
    (hx : B *ᵥ x = 0) : x = 0 := by
  obtain ⟨u, hu⟩ := hB
  have : (↑u⁻¹ : Matrix n n ℝ) *ᵥ (B *ᵥ x) = x := by
    rw [Matrix.mulVec_mulVec, ← hu, ← Units.val_mul]
    simp
  rw [hx, Matrix.mulVec_zero] at this
  exact this.symm

/-- **`W = B V₂ B` は正定値**（人手証明 Step 3 の合同変換）。

`B` は実対称かつ可逆、`V₂` は正定値とする。 -/
theorem symTransfer_posDef {B V2 : Matrix n n ℝ} (hB : B.IsSymm) (hBunit : IsUnit B)
    (hV2 : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ V2 *ᵥ x) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ symTransfer B V2 *ᵥ x := by
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hexp : x ⬝ᵥ symTransfer B V2 *ᵥ x = (B *ᵥ x) ⬝ᵥ V2 *ᵥ (B *ᵥ x) := by
    show x ⬝ᵥ (B * V2 * B) *ᵥ x = (B *ᵥ x) ⬝ᵥ V2 *ᵥ (B *ᵥ x)
    rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
      mulVec_dotProduct_selfadjoint hB x (V2 *ᵥ (B *ᵥ x))]
  rw [hexp]
  exact hV2 _ hBx

/-- **`W` の成分はすべて正**（人手証明 `W_has_positive_entries`）。

`B` が正の成分をもつ対角行列（人手証明の `V₁^{1/2}`）で `V₂` の成分がすべて正なら、
`W = B V₂ B` の成分もすべて正。 -/
theorem symTransfer_entry_pos {d : n → ℝ} {V2 : Matrix n n ℝ} (hd : ∀ i, 0 < d i)
    (hV2 : ∀ i j, 0 < V2 i j) (i j : n) :
    0 < symTransfer (diagonal d) V2 i j := by
  have hval : symTransfer (diagonal d) V2 i j = d i * V2 i j * d j := by
    show ((diagonal d) * V2 * (diagonal d)) i j = d i * V2 i j * d j
    rw [Matrix.mul_assoc, Matrix.diagonal_mul, Matrix.mul_diagonal, mul_assoc]
  rw [hval]
  exact mul_pos (mul_pos (hd i) (hV2 i j)) (hd j)

/-! ## 正の対角行列としての `V₁^{1/2}` -/

/-- 対角行列の指数関数 `exp(diagonal d) = diagonal (exp ∘ d)`。

人手証明の `V₁^{1/2} = exp((1/2)K₁D)` は、`D` が対角（章 009 の `sigma_z_diagonal_action`）
なのでこの形になる。 -/
noncomputable def diagExp (d : n → ℝ) : Matrix n n ℝ := diagonal (fun i => Real.exp (d i))

theorem diagExp_isSymm (d : n → ℝ) : (diagExp d).IsSymm := Matrix.isSymm_diagonal _

theorem diagExp_entry_pos (d : n → ℝ) (i : n) : 0 < Real.exp (d i) := Real.exp_pos _

/-- **`V₁^{1/2} V₁^{1/2} = V₁`**（人手証明 `def_transfer_matrix_square_root` の平方根の意味）。 -/
theorem diagExp_mul_self (d : n → ℝ) :
    diagExp d * diagExp d = diagExp (fun i => 2 * d i) := by
  simp only [diagExp, Matrix.diagonal_mul_diagonal]
  congr 1
  funext i
  rw [← Real.exp_add]
  ring_nf

theorem diagExp_isUnit (d : n → ℝ) : IsUnit (diagExp d) := by
  rw [Matrix.isUnit_iff_isUnit_det]
  simp only [diagExp, Matrix.det_diagonal]
  exact isUnit_iff_ne_zero.mpr (Finset.prod_pos fun i _ => Real.exp_pos (d i)).ne'

theorem diagExp_posDef (d : n → ℝ) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ diagExp d *ᵥ x := by
  set B := diagExp (fun i => d i / 2) with hBdef
  have hhalf : (fun i => 2 * (d i / 2)) = d := by
    funext i
    ring
  have hfac : diagExp d = B * B := by
    rw [hBdef, diagExp_mul_self, hhalf]
  have hBsymm : B.IsSymm := diagExp_isSymm _
  have hBunit : IsUnit B := diagExp_isUnit _
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hval : x ⬝ᵥ diagExp d *ᵥ x = vecNormSq (B *ᵥ x) := by
    rw [hfac, ← Matrix.mulVec_mulVec, mulVec_dotProduct_selfadjoint hBsymm x (B *ᵥ x)]
    rfl
  rw [hval]
  exact vecNormSq_pos hBx

/-! ## 実対称行列の指数関数は実対称正定値（章 009 の `exp_hermitian_is_positive_definite` の実版） -/

/-- 実対称行列の指数関数は実対称。 -/
theorem matExp_isSymm {S : Matrix n n ℝ} (hS : S.IsSymm) :
    (NormedSpace.exp S).IsSymm := Matrix.IsSymm.exp hS

/-- 実対称行列の指数関数は正定値。

人手証明 `W_is_real_symmetric_positive_definite` の Step 2 が引用している
`exp_hermitian_is_positive_definite` (1) の実行列版。
`exp(S) = exp(S/2)exp(S/2)` と `exp(S/2)` の対称性・可逆性だけから従う。 -/
theorem matExp_posDef {S : Matrix n n ℝ} (hS : S.IsSymm) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ NormedSpace.exp S *ᵥ x := by
  set B := NormedSpace.exp ((1 / 2 : ℝ) • S) with hBdef
  have hhalf : NormedSpace.exp S = B * B := by
    have hcomm : Commute ((1 / 2 : ℝ) • S) ((1 / 2 : ℝ) • S) := Commute.refl _
    rw [hBdef, ← Matrix.exp_add_of_commute _ _ hcomm]
    congr 1
    rw [← add_smul]
    norm_num
  have hBsymm : B.IsSymm := by
    refine Matrix.IsSymm.exp ?_
    show ((1 / 2 : ℝ) • S)ᵀ = (1 / 2 : ℝ) • S
    rw [Matrix.transpose_smul, hS.eq]
  have hBunit : IsUnit B := Matrix.isUnit_exp _
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hval : x ⬝ᵥ NormedSpace.exp S *ᵥ x = vecNormSq (B *ᵥ x) := by
    rw [hhalf, ← Matrix.mulVec_mulVec, mulVec_dotProduct_selfadjoint hBsymm x (B *ᵥ x)]
    rfl
  rw [hval]
  exact vecNormSq_pos hBx

end Ising2D
