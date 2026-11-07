/-
# `real_bilinear_value_of_symmetric_matrix_is_symmetric` を必要十分版から導く

具体版 `Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric`（`ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean`）と同じ主張を、
必要十分版 `Ising2D.NecSuf.bilinear_value_of_symmetric_matrix_is_symmetric'`（`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean`）を
係数 `R → ℝ` で特殊化して得る。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric
import Ising2D.NecSuf.BilinearValueOfSymmetricMatrixIsSymmetric

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

theorem real_bilinear_value_of_symmetric_matrix_is_symmetric_of_necSuf (P : Matrix n n ℝ) (hP : P.IsSymm)
    (u v : n → ℝ) :
    u ⬝ᵥ P *ᵥ v = v ⬝ᵥ P *ᵥ u :=
  NecSuf.bilinear_value_of_symmetric_matrix_is_symmetric' (R := ℝ) P hP u v

end Ising2D
