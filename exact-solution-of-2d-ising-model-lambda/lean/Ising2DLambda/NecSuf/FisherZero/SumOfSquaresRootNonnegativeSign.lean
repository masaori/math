import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 必要なのは環の符号反転と、与えられた根の所属・三分法だけである。 -/
theorem sumOfSquares_rootNonnegative
    {K : Type*} [Ring K] (F C : Set K)
    (hneg : ∀ z, z ∈ F → -z ∈ F)
    (htri : ∀ z, z ∈ F → z = 0 ∨ z ∈ C ∨ -z ∈ C)
    (a b : K) (hroot : ∃ z : K, z ∈ F ∧ z * z = a * a + b * b) :
    ∃ c : K, c ∈ F ∧ c * c = a * a + b * b ∧ (c = 0 ∨ c ∈ C) := by
  obtain ⟨c, hc, hc2⟩ := hroot
  rcases htri c hc with hzero | hpos | hnegative
  · exact ⟨c, hc, hc2, Or.inl hzero⟩
  · exact ⟨c, hc, hc2, Or.inr hpos⟩
  · refine ⟨-c, hneg c hc, ?_, Or.inr hnegative⟩
    simpa only [neg_mul_neg] using hc2

end Ising2DLambda.NecSuf.FisherZero
