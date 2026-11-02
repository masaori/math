/-
# 零行列を左から掛けると零行列・自分自身との和が零行列なら零行列・和の等式から右の項を差で表す（**具体版**）

対応する人手証明のラベル: `zero_matrix_is_left_zero_of_mat_mult`, `matrix_sum_with_itself_zero_implies_zero`,
`matrix_summand_from_sum_equation`（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_zero_matrix_is_left_zero_of_mat_mult`, `linear_space_general_claim_matrix_sum_with_itself_zero_implies_zero`,
`linear_space_general_claim_matrix_summand_from_sum_equation`）。

**必要十分版**: `Ising2D/NecSuf/MatrixZeroMulAndSumEquations.lean`。具体版をその系として導くのは
`ClaimZeroMatrixProductAndSumEquationsFromNecSuf.lean`。

## 人手証明との対応

* `zero_matrix_is_left_zero_of_mat_mult` の成分の鎖の 5 行は、`zero_matrix_mul_apply` の `calc` の 5 段と 1 対 1 である。
  `0_ℂ z = 0_ℂ`（`complex_zero_times_is_zero`）は `zero_mul`、`Σ_{j=1}^{n} 0_ℂ = 0_ℂ`（`finite_sum_of_complex_zeros`）は
  `Finset.sum_const_zero` で出す（どちらも人手の主張に Lean の具体版が無い。`identity_matrix_mul_apply` と同じ扱い）。
* `matrix_sum_with_itself_zero_implies_zero` の準備の `2_ℂ := ι(2)` は `complexTwo`、`1_ℂ + 1_ℂ = 2_ℂ` の 4 行の鎖は `one_add_one_eq_complexTwo` の 4 段、
  `2_ℂ ≠ 0_ℂ` の鎖は `complexTwo_ne_zero`、逆元 `2_ℂ^{-1}` の取り方（`complex_numbers_form_a_field` の逆元の存在）は `inv_mul_cancel₀` である。
  成分の鎖の 11 行は `matrix_eq_zero_of_add_self_eq_zero_apply` の 11 段と 1 対 1 である。
* `matrix_summand_from_sum_equation` の成分の鎖の 8 行は `matrix_eq_sub_of_add_eq_apply` の 8 段と 1 対 1 である。
  `ℂ` の加法の単位元・逆元・結合律・交換律（`complex_numbers_form_a_field`）は `zero_add`・`neg_add_cancel`・`add_assoc`・`add_comm`、
  `def_complex_difference` は `sub_eq_add_neg`。
* 最後の「全ての成分が一致する」は `Matrix.ext`。人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix

namespace Ising2D

open Matrix

/-- **`zero_matrix_is_left_zero_of_mat_mult`** の成分の鎖: `(O_{m,n} B)_{ik} = (O_{m,p})_{ik}`。 -/
theorem zero_matrix_mul_apply {m n p : ℕ} (B : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    ((0 : Matrix (Fin m) (Fin n) ℂ) * B) i k = (0 : Matrix (Fin m) (Fin p) ℂ) i k :=
  calc ((0 : Matrix (Fin m) (Fin n) ℂ) * B) i k
      = ∑ j, (0 : Matrix (Fin m) (Fin n) ℂ) i j * B j k := matrix_mul_apply_sum _ _ _ _  -- `mat_mult`
    _ = ∑ j, (0 : ℂ) * B j k := by simp only [matrix_zero_apply]                      -- `def_zero_matrix` を各項へ
    _ = ∑ _j : Fin n, (0 : ℂ) := by simp only [zero_mul]                               -- `complex_zero_times_is_zero` を各項へ
    _ = 0 := Finset.sum_const_zero                                                      -- `finite_sum_of_complex_zeros`
    _ = (0 : Matrix (Fin m) (Fin p) ℂ) i k := (matrix_zero_apply _ _).symm             -- `def_zero_matrix`

/-- **`zero_matrix_is_left_zero_of_mat_mult`**: `O_{m,n} B = O_{m,p}`。 -/
theorem zero_matrix_mul {m n p : ℕ} (B : Matrix (Fin n) (Fin p) ℂ) :
    (0 : Matrix (Fin m) (Fin n) ℂ) * B = 0 :=
  Matrix.ext (zero_matrix_mul_apply B)   -- 全ての成分が一致する

/-- 人手 `matrix_sum_with_itself_zero_implies_zero` の証明の `2_ℂ := ι_{ℝ→ℂ}(2) = (2, 0)`（`inclusion_rr_to_cc` の略記）。 -/
def complexTwo : ℂ := ⟨2, 0⟩

/-- `matrix_sum_with_itself_zero_implies_zero` の準備の第 1 の鎖: `1_ℂ + 1_ℂ = 2_ℂ`。 -/
theorem one_add_one_eq_complexTwo : (1 : ℂ) + 1 = complexTwo :=
  calc (1 : ℂ) + 1
      = (⟨1, 0⟩ : ℂ) + ⟨1, 0⟩ := rfl                                  -- `inclusion_rr_to_cc`
    _ = ⟨1 + 1, 0 + 0⟩ := rfl                                         -- `definition_of_cc` の和
    _ = ⟨2, 0⟩ := by norm_num                                         -- `ℝ` の四則
    _ = complexTwo := rfl                                             -- `inclusion_rr_to_cc`

/-- `matrix_sum_with_itself_zero_implies_zero` の準備の第 2 の鎖: `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ`（第 1 成分が `ℝ` で `2 ≠ 0`）。 -/
theorem complexTwo_ne_zero : complexTwo ≠ 0 := by
  intro h
  have h2 : (2 : ℝ) = 0 := congrArg Complex.re h
  norm_num at h2

/-- **`matrix_sum_with_itself_zero_implies_zero`** の成分の鎖: `X + X = O` なら `X_{ik} = O_{ik}`。 -/
theorem matrix_eq_zero_of_add_self_eq_zero_apply {m p : ℕ} (X : Matrix (Fin m) (Fin p) ℂ)
    (h : X + X = 0) (i : Fin m) (k : Fin p) : X i k = (0 : Matrix (Fin m) (Fin p) ℂ) i k :=
  calc X i k
      = 1 * X i k := (one_mul _).symm                                              -- `1_ℂ` は積の単位元
    _ = (complexTwo⁻¹ * complexTwo) * X i k := by
          rw [inv_mul_cancel₀ complexTwo_ne_zero]                                  -- `2_ℂ^{-1}` の取り方
    _ = complexTwo⁻¹ * (complexTwo * X i k) := mul_assoc _ _ _                     -- 積の結合律
    _ = complexTwo⁻¹ * ((1 + 1) * X i k) := by rw [one_add_one_eq_complexTwo]     -- 準備の鎖 `1_ℂ + 1_ℂ = 2_ℂ` を右辺から左辺へ
    _ = complexTwo⁻¹ * (1 * X i k + 1 * X i k) := by rw [add_mul]                 -- 分配律
    _ = complexTwo⁻¹ * (X i k + X i k) := by rw [one_mul]                          -- `1_ℂ` は積の単位元（2 か所）
    _ = complexTwo⁻¹ * (X + X) i k := by rw [matrix_sum_apply]                     -- `def_matrix_sum`
    _ = complexTwo⁻¹ * (0 : Matrix (Fin m) (Fin p) ℂ) i k := by rw [h]            -- 仮定 `X + X = O`
    _ = complexTwo⁻¹ * 0 := by rw [matrix_zero_apply]                              -- `def_zero_matrix`
    _ = 0 := mul_zero _                                                            -- `complex_times_zero_is_zero`
    _ = (0 : Matrix (Fin m) (Fin p) ℂ) i k := (matrix_zero_apply _ _).symm        -- `def_zero_matrix`

/-- **`matrix_sum_with_itself_zero_implies_zero`**: `X + X = O` なら `X = O`。 -/
theorem matrix_eq_zero_of_add_self_eq_zero {m p : ℕ} (X : Matrix (Fin m) (Fin p) ℂ) (h : X + X = 0) :
    X = 0 :=
  Matrix.ext (matrix_eq_zero_of_add_self_eq_zero_apply X h)   -- 全ての成分が一致する

/-- **`matrix_summand_from_sum_equation`** の成分の鎖: `A + B = C` なら `B_{ik} = (C - A)_{ik}`。 -/
theorem matrix_eq_sub_of_add_eq_apply {m p : ℕ} (A B C : Matrix (Fin m) (Fin p) ℂ)
    (h : A + B = C) (i : Fin m) (k : Fin p) : B i k = (C - A) i k :=
  calc B i k
      = 0 + B i k := (zero_add _).symm                                   -- 加法の単位元
    _ = (-A i k + A i k) + B i k := by rw [neg_add_cancel]               -- 加法の逆元
    _ = -A i k + (A i k + B i k) := add_assoc _ _ _                      -- 加法の結合律
    _ = -A i k + (A + B) i k := by rw [matrix_sum_apply]                 -- `def_matrix_sum`
    _ = -A i k + C i k := by rw [h]                                      -- 仮定 `A + B = C`
    _ = C i k + -A i k := add_comm _ _                                   -- 加法の交換律
    _ = C i k - A i k := (sub_eq_add_neg _ _).symm                       -- `def_complex_difference` を右辺から左辺へ
    _ = (C - A) i k := (matrix_sub_apply _ _ _ _).symm                   -- `def_matrix_difference`

/-- **`matrix_summand_from_sum_equation`**: `A + B = C` なら `B = C - A`。 -/
theorem matrix_eq_sub_of_add_eq {m p : ℕ} (A B C : Matrix (Fin m) (Fin p) ℂ) (h : A + B = C) :
    B = C - A :=
  Matrix.ext (matrix_eq_sub_of_add_eq_apply A B C h)   -- 全ての成分が一致する

end Ising2D
