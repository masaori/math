/-
# 符号反転した行列のスカラー倍はスカラー倍の符号反転に等しい（**具体版**）

対応する人手証明のラベル: `scalar_multiple_of_negated_matrix`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_multiple_of_negated_matrix`）。

**必要十分版**: `Ising2D/NecSuf/SmulNegMatrix.lean`。具体版をその系として導くのは
`ClaimScalarMultipleOfNegatedMatrixFromNecSuf.lean`。

## 人手証明との対応

* `(i, j)` 成分の鎖を人手の行の順に 1 行ずつ辿り、最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_smul_apply`（`def_matrix_scalar_multiple`）と
  `matrix_neg_apply`（`def_matrix_negation`）である。
* 人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  `ℂ` の積の結合律・交換律は `mul_assoc`・`mul_comm` で出す（`complex_numbers_form_a_field`）。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`scalar_multiple_of_negated_matrix`** の成分の鎖: `(a(-A))_{ij} = (-(aA))_{ij}`。 -/
theorem smul_neg_matrix_apply {m n : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (a • (-A)) i j = (-(a • A)) i j :=
  calc (a • (-A)) i j
      = a * (-A) i j := matrix_smul_apply _ _ _ _                            -- `def_matrix_scalar_multiple`
    _ = a * (-A i j) := by rw [matrix_neg_apply]                             -- `def_matrix_negation`
    _ = a * ((-1) * A i j) := by rw [neg_one_mul]                            -- `multiply_by_minus_one`
    _ = (a * (-1)) * A i j := (mul_assoc _ _ _).symm                         -- 積の結合律
    _ = ((-1) * a) * A i j := by rw [mul_comm a (-1)]                        -- 積の交換律
    _ = (-1) * (a * A i j) := mul_assoc _ _ _                                -- 積の結合律
    _ = -(a * A i j) := neg_one_mul _                                        -- `multiply_by_minus_one`
    _ = -((a • A) i j) := by rw [matrix_smul_apply]                          -- `def_matrix_scalar_multiple`
    _ = (-(a • A)) i j := (matrix_neg_apply _ _ _).symm                      -- `def_matrix_negation`

/-- **`scalar_multiple_of_negated_matrix`**: `a(-A) = -(aA)`。 -/
theorem smul_neg_matrix {m n : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    a • (-A) = -(a • A) :=
  Matrix.ext (smul_neg_matrix_apply a A)   -- 全ての成分が一致する

end Ising2D
