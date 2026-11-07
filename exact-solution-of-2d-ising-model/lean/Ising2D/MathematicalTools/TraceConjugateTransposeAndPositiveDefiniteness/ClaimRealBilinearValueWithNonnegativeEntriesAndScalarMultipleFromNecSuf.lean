/-
# `real_bilinear_value_with_nonnegative_entries_is_nonnegative`・`real_bilinear_value_of_scalar_multiple_vector` を必要十分版から導く

具体版 `Ising2D.real_bilinear_value_with_nonnegative_entries_is_nonnegative`・`Ising2D.real_bilinear_value_of_scalar_multiple_vector`
（`ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple.lean`）と同じ主張を、必要十分版
`Ising2D.NecSuf.bilinear_value_with_nonnegative_entries_is_nonnegative'`・`bilinear_value_of_scalar_multiple_vector'`
（`NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean`）を係数 `R → ℝ` で特殊化して得る。
積の非負性の仮定は `mul_nonneg`、`c` の可換性の仮定は ℝ の乗法の可換則 `mul_comm` で埋める。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple
import Ising2D.NecSuf.BilinearValueNonnegativeAndScalarMultiple

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

theorem real_bilinear_value_with_nonnegative_entries_is_nonnegative_of_necSuf [Nonempty n] (P : Matrix n n ℝ)
    (hP : ∀ k l, 0 ≤ P k l) (x y : n → ℝ) (hx : ∀ k, 0 ≤ x k) (hy : ∀ l, 0 ≤ y l) :
    x ⬝ᵥ P *ᵥ y ≥ 0 :=
  NecSuf.bilinear_value_with_nonnegative_entries_is_nonnegative' (R := ℝ)
    (fun _ _ hs ht => mul_nonneg hs ht) P hP x y hx hy

theorem real_bilinear_value_of_scalar_multiple_vector_of_necSuf (P : Matrix n n ℝ) (c : ℝ) (u w : n → ℝ)
    (hw : ∀ k, w k = c * u k) :
    w ⬝ᵥ P *ᵥ w = c * c * (u ⬝ᵥ P *ᵥ u) :=
  NecSuf.bilinear_value_of_scalar_multiple_vector' (R := ℝ) P c u (fun k l => mul_comm (u k * P k l) c) w hw

end Ising2D
