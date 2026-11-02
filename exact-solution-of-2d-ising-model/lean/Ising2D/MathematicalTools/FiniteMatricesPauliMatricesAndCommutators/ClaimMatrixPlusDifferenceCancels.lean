/-
# 行列 A と差 B − A の和は B（**具体版**）

対応する人手証明のラベル: `matrix_plus_difference_cancels`（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_matrix_plus_difference_cancels`）。

**必要十分版**: `Ising2D/NecSuf/MatrixAddSubCancel.lean`。具体版をその系として導くのは
`ClaimMatrixPlusDifferenceCancelsFromNecSuf.lean`。

## 人手証明との対応

* 成分の鎖の 7 行は `matrix_add_sub_cancel_apply` の `calc` の 7 段と 1 対 1 である。
  `def_matrix_sum`・`def_matrix_difference` は `matrix_sum_apply`・`matrix_sub_apply`、`def_complex_difference` は `sub_eq_add_neg`、
  `ℂ` の加法の交換律・結合律・逆元・単位元（`complex_numbers_form_a_field`）は `add_comm`・`add_assoc`・`add_neg_cancel`・`zero_add`。
* 最後の「全ての成分が一致する」は `Matrix.ext`。人手の `m, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix

namespace Ising2D

open Matrix

/-- **`matrix_plus_difference_cancels`** の成分の鎖: `(A + (B - A))_{ik} = B_{ik}`。 -/
theorem matrix_add_sub_cancel_apply {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ)
    (i : Fin m) (k : Fin p) : (A + (B - A)) i k = B i k :=
  calc (A + (B - A)) i k
      = A i k + (B - A) i k := matrix_sum_apply _ _ _ _                  -- `def_matrix_sum`
    _ = A i k + (B i k - A i k) := by rw [matrix_sub_apply]              -- `def_matrix_difference`
    _ = A i k + (B i k + -A i k) := by rw [sub_eq_add_neg]               -- `def_complex_difference`
    _ = A i k + (-A i k + B i k) := by rw [add_comm (B i k)]             -- 加法の交換律
    _ = (A i k + -A i k) + B i k := (add_assoc _ _ _).symm               -- 加法の結合律
    _ = 0 + B i k := by rw [add_neg_cancel]                              -- 加法の逆元
    _ = B i k := zero_add _                                              -- 加法の単位元

/-- **`matrix_plus_difference_cancels`**: `A + (B - A) = B`。 -/
theorem matrix_add_sub_cancel {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) : A + (B - A) = B :=
  Matrix.ext (matrix_add_sub_cancel_apply A B)   -- 全ての成分が一致する

end Ising2D
