/-
# `real_bilinear_value_at_most_value_at_absolute_vector` を必要十分版から導く

具体版 `Ising2D.real_bilinear_value_at_most_value_at_absolute_vector`（`ClaimRealBilinearValueAtMostValueAtAbsoluteVector.lean`）と同じ主張を、
必要十分版 `Ising2D.NecSuf.bilinear_value_at_most_value_at_absolute_vector'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`）を
係数 `R → ℝ` で特殊化して得る。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimRealBilinearValueAtMostValueAtAbsoluteVector
import Ising2D.NecSuf.BilinearValueAtMostValueAtAbsoluteVector

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

theorem real_bilinear_value_at_most_value_at_absolute_vector_of_necSuf (P : Matrix n n ℝ)
    (hP : ∀ k l, 0 ≤ P k l) (x : n → ℝ) :
    x ⬝ᵥ P *ᵥ x ≤ (fun k => |x k|) ⬝ᵥ P *ᵥ (fun k => |x k|) :=
  NecSuf.bilinear_value_at_most_value_at_absolute_vector' (R := ℝ) P hP x

end Ising2D
