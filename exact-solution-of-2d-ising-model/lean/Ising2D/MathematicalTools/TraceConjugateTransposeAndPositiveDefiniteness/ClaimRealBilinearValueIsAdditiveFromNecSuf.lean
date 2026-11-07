/-
# `real_bilinear_value_is_additive_in_right_vector`・`real_bilinear_value_is_additive_in_left_vector` を必要十分版から導く

具体版 `Ising2D.real_bilinear_value_is_additive_in_right_vector`・`Ising2D.real_bilinear_value_is_additive_in_left_vector`
（`ClaimRealBilinearValueIsAdditive.lean`）と同じ主張を、必要十分版
`Ising2D.NecSuf.bilinear_value_is_additive_in_right_vector'`・`bilinear_value_is_additive_in_left_vector'`
（`NecSuf/BilinearValueIsAdditive.lean`）を係数 `R → ℝ` で特殊化して得る。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueIsAdditive
import Ising2D.NecSuf.BilinearValueIsAdditive

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

theorem real_bilinear_value_is_additive_in_right_vector_of_necSuf (P : Matrix n n ℝ) (x y z w : n → ℝ)
    (hw : ∀ l, w l = y l + z l) :
    x ⬝ᵥ P *ᵥ w = x ⬝ᵥ P *ᵥ y + x ⬝ᵥ P *ᵥ z :=
  NecSuf.bilinear_value_is_additive_in_right_vector' (R := ℝ) P x y z w hw

theorem real_bilinear_value_is_additive_in_left_vector_of_necSuf (P : Matrix n n ℝ) (x y z w : n → ℝ)
    (hw : ∀ k, w k = y k + z k) :
    w ⬝ᵥ P *ᵥ x = y ⬝ᵥ P *ᵥ x + z ⬝ᵥ P *ᵥ x :=
  NecSuf.bilinear_value_is_additive_in_left_vector' (R := ℝ) P x y z w hw

end Ising2D
