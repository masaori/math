/-
# 具体版を必要十分版から導く: `Σ_kΣ_l (u_kP_kl)v_l = Σ_k u_k(Pv)_k` と、対称な `Q` で `Σ_k (Qu)_k v_k = Σ_k u_k(Qv)_k`

具体版 `Ising2D.real_bilinear_value_is_sum_with_real_matrix_vector_product`・
`Ising2D.real_symmetric_matrix_moves_between_factors_of_sum_of_products`
（`ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`）と同じ主張を、必要十分版
`Ising2D.NecSuf.bilinear_value_is_sum_with_matrix_vector_product'`・`symmetric_matrix_moves_between_factors_of_sum_of_products'`
（`NecSuf/BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`）を係数 `R → ℝ` で特殊化して得る。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors
import Ising2D.NecSuf.BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

theorem real_bilinear_value_is_sum_with_real_matrix_vector_product_of_necSuf (P : Matrix n n ℝ) (u v : n → ℝ) :
    ∑ k, ∑ l, u k * P k l * v l = ∑ k, u k * (P *ᵥ v) k :=
  NecSuf.bilinear_value_is_sum_with_matrix_vector_product' (R := ℝ) P u v

theorem real_symmetric_matrix_moves_between_factors_of_sum_of_products_of_necSuf (Q : Matrix n n ℝ)
    (hQ : Q.IsSymm) (u v : n → ℝ) :
    ∑ k, (Q *ᵥ u) k * v k = ∑ k, u k * (Q *ᵥ v) k :=
  NecSuf.symmetric_matrix_moves_between_factors_of_sum_of_products' (R := ℝ) Q hQ u v

end Ising2D
