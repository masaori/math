/-
# 可換な二つの行列の差とも可換（**具体版**）

対応する人手証明のラベル: `commuting_with_difference`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_commuting_with_difference`）。

**必要十分版**: `Ising2D/NecSuf/CommuteWithMatrixDifference.lean`。具体版をその系として導くのは
`ClaimCommutingWithDifferenceFromNecSuf.lean`。

## 人手証明との対応

* 人手の鎖 `G(X - W) = G(X + (-W)) = GX + G(-W) = XG + G(-W) = XG + (-(GW)) = XG + (-(WG)) = XG + (-W)G = (X + (-W))G = (X - W)G`
  の 8 行は、`matrix_mul_sub_eq_sub_mul_of_commute` の `calc` の 8 段と 1 対 1 である
  （`matrix_difference_is_sum_with_negation` は `matrix_sub_eq_add_neg`、`mat_mult_distributes_over_sum_in_right_factor` は `mul_add_matrix`、
  `negation_factors_out_of_right_factor` は `mul_neg_matrix`、`negation_factors_out_of_left_factor` は `neg_mul_matrix`、
  `mat_mult_distributes_over_sum_in_left_factor` は `add_mul_matrix`）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProduct

namespace Ising2D

open Matrix

/-- **`commuting_with_difference`**: `GX = XG` かつ `GW = WG` なら `G(X - W) = (X - W)G`。 -/
theorem matrix_mul_sub_eq_sub_mul_of_commute {n : ℕ} (G X W : Matrix (Fin n) (Fin n) ℂ)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  calc G * (X - W)
      = G * (X + (-W)) := by rw [matrix_sub_eq_add_neg]  -- `matrix_difference_is_sum_with_negation`
    _ = G * X + G * (-W) := mul_add_matrix G X (-W)      -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = X * G + G * (-W) := by rw [hX]                   -- 仮定 `GX = XG`
    _ = X * G + (-(G * W)) := by rw [mul_neg_matrix]     -- `negation_factors_out_of_right_factor`
    _ = X * G + (-(W * G)) := by rw [hW]                 -- 仮定 `GW = WG`
    _ = X * G + (-W) * G := by rw [neg_mul_matrix]       -- `negation_factors_out_of_left_factor`
    _ = (X + (-W)) * G := (add_mul_matrix X (-W) G).symm -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (X - W) * G := by rw [matrix_sub_eq_add_neg]     -- `matrix_difference_is_sum_with_negation`

end Ising2D
