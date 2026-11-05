import Ising2DLambda.NecSuf.KacWard.ThreeTermPmFourDifferenceZero
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 三つの値が二値に収まり、隣接差が同じなら、その差は零。 -/
theorem threePeriod_difference_zero_necSuf {G : Type*} [AddCommGroup G]
    (T : ℕ → G) (b upper lower : G)
    (hdouble : (-lower + upper) + (-lower + upper) ≠ 0)
    (h12 : T 2 - T 1 = b) (h23 : T 3 - T 2 = b)
    (hfirst : T 1 = upper ∨ T 1 = lower)
    (hsecond : T 2 = upper ∨ T 2 = lower)
    (hthird : T 3 = upper ∨ T 3 = lower) : b = 0 := by
  have hT2 : T 2 = T 1 + b := by rw [← h12]; abel
  have hT3 : T 3 = T 2 + b := by rw [← h23]; abel
  have h₁ : (T 1 - b) + b = T 1 := by abel
  have h₂ : (T 1 - b) + (b + b) = T 2 := by
    rw [hT2]
    abel
  have h₃ : (T 1 - b) + ((b + b) + b) = T 3 := by
    rw [hT3, hT2]
    abel
  exact (threeTermTwoValue_difference_zero_necSuf (T 1 - b) b upper lower hdouble
    (by rw [h₁]; exact hfirst) (by rw [h₂]; exact hsecond)
    (by rw [h₃]; exact hthird)).1

end Ising2DLambda.NecSuf.KacWard
