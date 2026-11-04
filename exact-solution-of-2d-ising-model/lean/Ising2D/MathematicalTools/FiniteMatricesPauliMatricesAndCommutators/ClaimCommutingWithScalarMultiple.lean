/-
# 可換な行列のスカラー倍とも可換（**具体版**）

対応する人手証明のラベル: `commuting_with_scalar_multiple`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_commuting_with_scalar_multiple`）。

**必要十分版**: `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_smul_of_commute'`。
具体版をその系として導くのと `TensorPow M` での系は `ClaimCommutingWithScalarMultipleFromNecSuf.lean`。

## 人手証明との対応

* 人手の鎖 `G(cX) = c(GX) = c(XG) = (cX)G` の 3 行は、`matrix_mul_smul_comm_of_commute` の `calc` の 3 段と 1 対 1 である
  （`scalar_multiple_factors_out_of_right_factor` は `mul_smul_matrix`、`scalar_multiple_factors_out_of_left_factor` は `smul_mul_matrix`）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct

namespace Ising2D

open Matrix

/-- **`commuting_with_scalar_multiple`**: `GX = XG` なら `G(cX) = (cX)G`。 -/
theorem matrix_mul_smul_comm_of_commute {n : ℕ} (c : ℂ) (G X : Matrix (Fin n) (Fin n) ℂ)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  calc G * (c • X)
      = c • (G * X) := mul_smul_matrix c G X            -- `scalar_multiple_factors_out_of_right_factor`
    _ = c • (X * G) := by rw [h]                        -- 仮定 `GX = XG`
    _ = (c • X) * G := (smul_mul_matrix c X G).symm     -- `scalar_multiple_factors_out_of_left_factor`

end Ising2D
