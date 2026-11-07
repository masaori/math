/-
# 具体版を必要十分版から導出する: 実数の行列とベクトルの積は、ベクトルの実数倍と交換する

人手証明のラベル: **`real_matrix_vector_product_commutes_with_real_scalar_multiple`**
（正本 `structured-latex/content/002_linear_space_general.ts`）。

必要十分版 `Ising2D.NecSuf.matrix_vector_product_commutes_with_scalar_multiple'`
（`Ising2D/NecSuf/MatrixVectorProductCommutesWithScalarMultiple.lean`）を `R → ℝ` に特殊化する。
仮定 `hc`（`c` が `P_ij` と可換）は `ℝ` の乗法の交換則 `mul_comm` で埋める。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixVectorProductCommutesWithRealScalarMultiple
import Ising2D.NecSuf.MatrixVectorProductCommutesWithScalarMultiple

namespace Ising2D

open Matrix

/-- **人手 `real_matrix_vector_product_commutes_with_real_scalar_multiple`**（必要十分版の特殊化）。 -/
theorem real_matrix_vector_product_commutes_with_real_scalar_multiple_of_necSuf {α β : Type*} [Fintype β]
    (P : Matrix α β ℝ) (c : ℝ) (u w : β → ℝ) (hw : ∀ k, w k = c * u k) :
    ∀ i, (P *ᵥ w) i = c * (P *ᵥ u) i := fun i =>
  NecSuf.matrix_vector_product_commutes_with_scalar_multiple' P c u w hw i fun j => mul_comm (P i j) c

end Ising2D
