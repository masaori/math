/-
# スカラー倍は行列の差に分配する（**具体版**）

対応する人手証明のラベル: `scalar_multiple_distributes_over_matrix_difference`
（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_scalar_multiple_distributes_over_matrix_difference`）。

**必要十分版**: `Ising2D/NecSuf/SmulMatrixSub.lean`。具体版をその系として導くのは
`ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf.lean`。

## 人手証明との対応

* `(i, k)` 成分の鎖の 12 行は `matrix_smul_sub_apply` の `calc` の 12 段と 1 対 1 である。最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_smul_apply`（`def_matrix_scalar_multiple`）・
  `matrix_sub_apply`（`def_matrix_difference`）である。
* 人手の `z - w := z + (-w)`（`def_complex_difference`）は `sub_eq_add_neg`、`-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は
  `neg_one_mul` で出す（Lean の `ℂ` の差・符号反転はこれらの式で定義されていない）。
  `ℂ` の分配律・積の結合律・交換律は `mul_add`・`mul_assoc`・`mul_comm`（`complex_numbers_form_a_field`）。
* 人手の `m, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`scalar_multiple_distributes_over_matrix_difference`** の成分の鎖: `(c(A - B))_{ik} = (cA - cB)_{ik}`。 -/
theorem matrix_smul_sub_apply {m p : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (c • (A - B)) i k = (c • A - c • B) i k :=
  calc (c • (A - B)) i k
      = c * (A - B) i k := matrix_smul_apply _ _ _ _                         -- `def_matrix_scalar_multiple`
    _ = c * (A i k - B i k) := by rw [matrix_sub_apply]                      -- `def_matrix_difference`
    _ = c * (A i k + -B i k) := by rw [sub_eq_add_neg]                        -- `def_complex_difference`
    _ = c * A i k + c * (-B i k) := mul_add _ _ _                             -- 分配律
    _ = c * A i k + c * ((-1) * B i k) := by rw [neg_one_mul]                 -- `multiply_by_minus_one`
    _ = c * A i k + (c * (-1)) * B i k := by rw [mul_assoc]                   -- 積の結合律
    _ = c * A i k + ((-1) * c) * B i k := by rw [mul_comm c (-1)]             -- 積の交換律
    _ = c * A i k + (-1) * (c * B i k) := by rw [mul_assoc]                   -- 積の結合律
    _ = c * A i k + -(c * B i k) := by rw [neg_one_mul]                       -- `multiply_by_minus_one`
    _ = c * A i k - c * B i k := (sub_eq_add_neg _ _).symm                    -- `def_complex_difference`
    _ = (c • A) i k - (c • B) i k := by rw [matrix_smul_apply, matrix_smul_apply]  -- `def_matrix_scalar_multiple` を 2 箇所
    _ = (c • A - c • B) i k := (matrix_sub_apply _ _ _ _).symm                -- `def_matrix_difference`

/-- **`scalar_multiple_distributes_over_matrix_difference`**: `c(A - B) = cA - cB`。 -/
theorem matrix_smul_sub {m p : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin p) ℂ) :
    c • (A - B) = c • A - c • B :=
  Matrix.ext (matrix_smul_sub_apply c A B)   -- 全ての成分が一致する

end Ising2D
