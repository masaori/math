/-
# 行列の差は符号反転した行列との和に等しい・符号反転した行列の差は差の符号反転に等しい（**具体版**）

対応する人手証明のラベル: `matrix_difference_is_sum_with_negation`, `difference_of_negated_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_matrix_difference_is_sum_with_negation`,
`linear_space_general_claim_difference_of_negated_matrices`）。

**必要十分版**: `Ising2D/NecSuf/MatrixSubNeg.lean`。具体版をその系として導くのは
`ClaimMatrixDifferenceIsSumWithNegationFromNecSuf.lean`。

## 人手証明との対応

* `matrix_difference_is_sum_with_negation` の `(i, j)` 成分の鎖の 4 行は、`matrix_sub_eq_add_neg_apply` の `calc` の 4 段と 1 対 1 である。
  成分の式との接点は `matrix_sub_apply`（`def_matrix_difference`）・`matrix_neg_apply`（`def_matrix_negation`）・
  `matrix_sum_apply`（`def_matrix_sum`）である。人手の `z - w := z + (-w)`（`def_complex_difference`）は `sub_eq_add_neg`。
  最後の「全ての成分が一致する」は `Matrix.ext`。
* `difference_of_negated_matrices` の行列の等号の 3 行は、`neg_sub_neg_matrix` の `calc` の 3 段と 1 対 1 である
  （`matrix_sub_eq_add_neg` → `neg_add_matrix`（`negation_distributes_over_matrix_sum`）を右辺から左辺へ → `matrix_sub_eq_add_neg`）。
  二重の符号反転 `-(-B)` は `B` へ戻さない（人手も戻さない）。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationDistributesOverMatrixSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`matrix_difference_is_sum_with_negation`** の成分の鎖: `(A - B)_{ij} = (A + (-B))_{ij}`。 -/
theorem matrix_sub_eq_add_neg_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (A - B) i j = (A + (-B)) i j :=
  calc (A - B) i j
      = A i j - B i j := matrix_sub_apply _ _ _ _                             -- `def_matrix_difference`
    _ = A i j + (-B i j) := sub_eq_add_neg _ _                                -- `def_complex_difference`
    _ = A i j + (-B) i j := by rw [matrix_neg_apply]                          -- `def_matrix_negation`
    _ = (A + (-B)) i j := (matrix_sum_apply _ _ _ _).symm                     -- `def_matrix_sum`

/-- **`matrix_difference_is_sum_with_negation`**: `A - B = A + (-B)`。 -/
theorem matrix_sub_eq_add_neg {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : A - B = A + (-B) :=
  Matrix.ext (matrix_sub_eq_add_neg_apply A B)   -- 全ての成分が一致する

/-- **`difference_of_negated_matrices`**: `(-A) - (-B) = -(A - B)`。 -/
theorem neg_sub_neg_matrix {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : (-A) - (-B) = -(A - B) :=
  calc (-A) - (-B)
      = (-A) + (-(-B)) := matrix_sub_eq_add_neg _ _                          -- `matrix_difference_is_sum_with_negation`（`A → -A`, `B → -B`）
    _ = -(A + (-B)) := (neg_add_matrix A (-B)).symm                           -- `negation_distributes_over_matrix_sum`（`B → -B`）
    _ = -(A - B) := by rw [matrix_sub_eq_add_neg A B]                         -- `matrix_difference_is_sum_with_negation`

end Ising2D
