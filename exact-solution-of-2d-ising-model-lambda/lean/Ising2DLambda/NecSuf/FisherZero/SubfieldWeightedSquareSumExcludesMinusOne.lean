import Ising2DLambda.NecSuf.FisherZero.PositiveWeightedSquareSums

namespace Ising2DLambda.NecSuf.FisherZero

/-- 平方の三分法と錐の閉性だけで、重み付き平方和は負の単位元を避ける。 -/
theorem weightedSquareSums_ne_neg_one {K : Type} [Field K] (E C : Set K)
    (hminus : (-1 : K) ∉ C)
    (hadd : ∀ x y : K, x ∈ C → y ∈ C → x + y ∈ C)
    (hmul : ∀ x y : K, x ∈ C → y ∈ C → x * y ∈ C)
    (htrich : ∀ y : K, y ∈ E → y = 0 ∨ y ∈ C ∨ -y ∈ C) :
    (-1 : K) ∉ weightedSquareSums E C := by
  classical
  have hsquare (y : K) (hy : y ∈ E) : y * y = 0 ∨ y * y ∈ C := by
    rcases htrich y hy with hz | hp | hn
    · left
      rw [hz, zero_mul]
    · exact Or.inr (hmul _ _ hp hp)
    · right
      have h := hmul (-y) (-y) hn hn
      simpa only [neg_mul_neg] using h
  rintro ⟨ι, _, c, y, hc, hy, hsum⟩
  have hterm (i : ι) : c i * (y i * y i) = 0 ∨ c i * (y i * y i) ∈ C := by
    rcases hsquare (y i) (hy i) with hz | hp
    · left
      rw [hz, mul_zero]
    · exact Or.inr (hmul _ _ (hc i) hp)
  have hfinite : ∀ s : Finset ι,
      (∑ i ∈ s, c i * (y i * y i)) = 0 ∨
      (∑ i ∈ s, c i * (y i * y i)) ∈ C := by
    intro s
    induction s using Finset.induction_on with
    | empty => exact Or.inl (by simp)
    | insert i s his ih =>
      rw [Finset.sum_insert his]
      rcases hterm i with hz | hp
      · simpa [hz] using ih
      · rcases ih with hs | hs
        · simpa [hs] using (Or.inr hp : c i * (y i * y i) = 0 ∨ c i * (y i * y i) ∈ C)
        · exact Or.inr (hadd _ _ hp hs)
  have hfinal := hfinite Finset.univ
  rw [← hsum] at hfinal
  rcases hfinal with h0 | hp
  · exact neg_ne_zero.mpr one_ne_zero h0
  · exact hminus hp

end Ising2DLambda.NecSuf.FisherZero
