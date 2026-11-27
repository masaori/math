/-
# 可換な `Mat(2^M, ℂ)` の行列のスカラー倍とも可換（**具体版**）

対応する人手証明のラベル: `commuting_with_scalar_multiple`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。

**必要十分版**: `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_smul_of_commute'`。
具体版をその系として導くのは `ClaimCommutingWithScalarMultipleFromNecSuf.lean`。

## 人手証明との対応

人手の鎖 `G(cX) = c(GX) = c(XG) = (cX)G` の 3 行は、`mul_smul_comm_of_commute_tensorPow` の `calc` の 3 段と 1 対 1 である。
各段が引く人手の主張の `Mat(2^M, ℂ)` の具体版は、`scalar_multiple_factors_out_of_right_factor` が `mul_smul_matrix_tensorPow`、
`scalar_multiple_factors_out_of_left_factor` が `smul_mul_matrix_tensorPow`（`ClaimIdentityAndScalarMultipleInTensorPowProduct.lean`）である。
添字 `Fin n` の行列の具体版 `matrix_mul_smul_comm_of_commute`（`ClaimCommutingWithScalarMultiple.lean`）と同じ鎖である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct

namespace Ising2D

/-- **`commuting_with_scalar_multiple`**（`Mat(2^M, ℂ)`）: `GX = XG` なら `G(cX) = (cX)G`（`c ∈ ℂ`、`G, X ∈ TensorPow M`）。 -/
theorem mul_smul_comm_of_commute_tensorPow {M : ℕ} (c : ℂ) (G X : TensorPow M)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  calc G * (c • X)
      = c • (G * X) := mul_smul_matrix_tensorPow c G X          -- `scalar_multiple_factors_out_of_right_factor`
    _ = c • (X * G) := by rw [h]                                -- 仮定 `GX = XG`
    _ = (c • X) * G := (smul_mul_matrix_tensorPow c X G).symm   -- `scalar_multiple_factors_out_of_left_factor`

end Ising2D
