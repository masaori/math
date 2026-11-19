import Ising2DLambda.FisherZero.PositiveWeightedSquareSums

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 基礎体の正錐を係数とする平方和は負の単位元にならない。 -/
theorem subfieldWeightedSquareSum_ne_neg_one (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) :
    (-1 : Qbar) ∉ positiveWeightedSquareSums F CF := by
  classical
  have hzero : (0 : Qbar) ∉ CF := by
    intro h
    exact (hCF.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩
  have hone : (1 : Qbar) ∈ CF := one_mem_of_isSubfieldPositiveCone F CF hCF
  have hminus : (-1 : Qbar) ∉ CF := by
    intro h
    have hsum := hCF.add_mem 1 (-1) hone h
    have : (1 : Qbar) + -1 = 0 := by ring
    exact hzero (this ▸ hsum)
  have hsquare (y : Qbar) (hy : y ∈ F) : y * y = 0 ∨ y * y ∈ CF := by
    rcases (hCF.trichotomy y hy).1 with hz | hp | hn
    · left
      rw [hz, zero_mul]
    · exact Or.inr (hCF.mul_mem _ _ hp hp)
    · right
      have h := hCF.mul_mem (-y) (-y) hn hn
      simpa only [neg_mul_neg] using h
  rintro ⟨ι, _, c, y, hc, hy, hsum⟩
  have hterm (i : ι) : c i * (y i * y i) = 0 ∨ c i * (y i * y i) ∈ CF := by
    rcases hsquare (y i) (hy i) with hz | hp
    · left
      rw [hz, mul_zero]
    · exact Or.inr (hCF.mul_mem _ _ (hc i) hp)
  have hfinite : ∀ s : Finset ι,
      (∑ i ∈ s, c i * (y i * y i)) = 0 ∨
      (∑ i ∈ s, c i * (y i * y i)) ∈ CF := by
    intro s
    induction s using Finset.induction_on with
    | empty => exact Or.inl (by simp)
    | insert i s his ih =>
      rw [Finset.sum_insert his]
      rcases hterm i with hz | hp
      · simpa [hz] using ih
      · rcases ih with hs | hs
        · simpa [hs] using (Or.inr hp : c i * (y i * y i) = 0 ∨ c i * (y i * y i) ∈ CF)
        · exact Or.inr (hCF.add_mem _ _ hp hs)
  have hfinal := hfinite Finset.univ
  rw [← hsum] at hfinal
  rcases hfinal with h0 | hp
  · exact (by norm_num : (-1 : Qbar) ≠ 0) h0
  · exact hminus hp

end Ising2DLambda.FisherZero
