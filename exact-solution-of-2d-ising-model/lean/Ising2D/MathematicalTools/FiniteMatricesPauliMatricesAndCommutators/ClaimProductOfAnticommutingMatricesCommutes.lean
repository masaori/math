/-
# 反可換な二つの行列の積は可換（**具体版**）

対応する人手証明のラベル: `product_of_anticommuting_matrices_commutes`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_product_of_anticommuting_matrices_commutes`）。

**必要十分版**: `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_mul_of_anticomm'`。
具体版をその系として導くのと `TensorPow M` での系は `ClaimProductOfAnticommutingMatricesCommutesFromNecSuf.lean`。

## 人手証明との対応

* 人手の鎖 `G(XY) = (GX)Y = (−(XG))Y = −((XG)Y) = −(X(GY)) = −(X(−(YG))) = −(−(X(YG))) = X(YG) = (XY)G` の 8 行は、
  `matrix_mul_comm_of_anticomm_pair` の `calc` の 8 段と 1 対 1 である
  （`negation_factors_out_of_left_factor` は `neg_mul_matrix`、`negation_factors_out_of_right_factor` は `mul_neg_matrix`、
  `matrix_double_negation` は `neg_neg_matrix`）。
* `mat_mult_associative` には Lean の具体版が無いので、その 3 段は mathlib の `Matrix.mul_assoc` で閉じる
  （状態台帳の「人手 `mat_mult_associative`・`scalar_multiple_is_associative` に Lean の具体版が無い」の件）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegation

namespace Ising2D

open Matrix

/-- **`product_of_anticommuting_matrices_commutes`**: `GX = −(XG)` かつ `GY = −(YG)` なら `G(XY) = (XY)G`。 -/
theorem matrix_mul_comm_of_anticomm_pair {n : ℕ} (G X Y : Matrix (Fin n) (Fin n) ℂ)
    (hX : G * X = -(X * G)) (hY : G * Y = -(Y * G)) : G * (X * Y) = (X * Y) * G :=
  calc G * (X * Y)
      = (G * X) * Y := (Matrix.mul_assoc G X Y).symm    -- `mat_mult_associative`
    _ = (-(X * G)) * Y := by rw [hX]                    -- 仮定 `GX = −(XG)`
    _ = -((X * G) * Y) := neg_mul_matrix _ _            -- `negation_factors_out_of_left_factor`
    _ = -(X * (G * Y)) := by rw [Matrix.mul_assoc]      -- `mat_mult_associative`
    _ = -(X * (-(Y * G))) := by rw [hY]                 -- 仮定 `GY = −(YG)`
    _ = -(-(X * (Y * G))) := by rw [mul_neg_matrix]     -- `negation_factors_out_of_right_factor`
    _ = X * (Y * G) := neg_neg_matrix _                 -- `matrix_double_negation`
    _ = (X * Y) * G := (Matrix.mul_assoc X Y G).symm    -- `mat_mult_associative`

end Ising2D
