/-
# 可換な二つの `Mat(2^M, ℂ)` の行列の差とも可換（**具体版**）

対応する人手証明のラベル: `commuting_with_difference`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。

**必要十分版**: `Ising2D/NecSuf/CommuteWithMatrixDifference.lean`。具体版をその系として導くのは
`ClaimCommutingWithDifferenceFromNecSuf.lean`。

## 人手証明との対応

人手の鎖 `G(X - W) = G(X + (-W)) = GX + G(-W) = XG + G(-W) = XG + (-(GW)) = XG + (-(WG)) = XG + (-W)G = (X + (-W))G = (X - W)G`
の 8 行は、`mul_sub_eq_sub_mul_of_commute_tensorPow` の `calc` の 8 段と 1 対 1 である。各段が引く人手の主張の `Mat(2^M, ℂ)` の具体版は
`matrix_difference_is_sum_with_negation` が `sub_eq_add_neg_tensorPow`、`mat_mult_distributes_over_sum_in_right_factor` が `mul_add_matrix_tensorPow`、
`negation_factors_out_of_right_factor` が `mul_neg_matrix_tensorPow`、`negation_factors_out_of_left_factor` が `neg_mul_matrix_tensorPow`、
`mat_mult_distributes_over_sum_in_left_factor` が `add_mul_matrix_tensorPow` である。添字 `Fin n` の行列の具体版
`matrix_mul_sub_eq_sub_mul_of_commute`（`ClaimCommutingWithDifference.lean`）と同じ鎖である。

符号反転 `-(GW)`・`-(WG)` は、`TensorPow M` の上の演算として明示して書く（`ClaimNegationFactorsOutOfTensorPowProduct.lean` の冒頭の注記の最後の段落と同じ理由）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowMatMultDistributesOverSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfTensorPowProduct

namespace Ising2D

/-- **`commuting_with_difference`**（`Mat(2^M, ℂ)`）: `GX = XG` かつ `GW = WG` なら `G(X - W) = (X - W)G`（`G, X, W ∈ TensorPow M`）。 -/
theorem mul_sub_eq_sub_mul_of_commute_tensorPow {M : ℕ} (G X W : TensorPow M)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  calc G * (X - W)
      = G * (X + (-W)) := by rw [sub_eq_add_neg_tensorPow]                       -- `matrix_difference_is_sum_with_negation`
    _ = G * X + G * (-W) := mul_add_matrix_tensorPow G X (-W)                     -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = X * G + G * (-W) := by rw [hX]                                            -- 仮定 `GX = XG`
    _ = X * G + @Neg.neg (TensorPow M) _ (G * W) := by
        rw [mul_neg_matrix_tensorPow]                                             -- `negation_factors_out_of_right_factor`
    _ = X * G + @Neg.neg (TensorPow M) _ (W * G) := by rw [hW]                    -- 仮定 `GW = WG`
    _ = X * G + (-W) * G := by rw [neg_mul_matrix_tensorPow]                      -- `negation_factors_out_of_left_factor`
    _ = (X + (-W)) * G := (add_mul_matrix_tensorPow X (-W) G).symm                -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (X - W) * G := by rw [sub_eq_add_neg_tensorPow]                           -- `matrix_difference_is_sum_with_negation`

end Ising2D
