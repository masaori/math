import Mathlib.Algebra.Ring.Defs
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

theorem sumOfSquares_isSquare_of_positiveRoots
    {K : Type*} [Semiring K] (C : Set K)
    (hsq : ∀ x : K, x ≠ 0 → x * x ∈ C)
    (hadd : ∀ x y : K, x ∈ C → y ∈ C → x + y ∈ C)
    (hroot : ∀ x : K, x ∈ C → ∃ y : K, y * y = x)
    (a b : K) : ∃ c : K, c * c = a * a + b * b := by
  by_cases ha : a = 0
  · exact ⟨b, by simp [ha]⟩
  by_cases hb : b = 0
  · exact ⟨a, by simp [hb]⟩
  exact hroot _ (hadd _ _ (hsq a ha) (hsq b hb))

end Ising2DLambda.NecSuf.FisherZero
