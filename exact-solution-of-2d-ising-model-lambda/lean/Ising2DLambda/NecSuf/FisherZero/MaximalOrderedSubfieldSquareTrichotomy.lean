import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- この論法には三分法、非零平方の正性、正の元の平方根だけが要る。 -/
theorem maximalOrderedSubfield_squareTrichotomy
    {K : Type} [Zero K] [Neg K] [Mul K]
    (F C : Set K)
    (htri : ∀ z ∈ F,
      (z = 0 ∨ z ∈ C ∨ -z ∈ C) ∧
        ¬(z = 0 ∧ z ∈ C) ∧ ¬(z = 0 ∧ -z ∈ C) ∧ ¬(z ∈ C ∧ -z ∈ C))
    (hsquareCone : ∀ w ∈ F, w ≠ 0 → w * w ∈ C)
    (hpositiveSquare : ∀ a ∈ C, ∃ w, w ∈ F ∧ w ≠ 0 ∧ w * w = a)
    (z : K) (hz : z ∈ F) :
    (z = 0 ∨ (∃ w, w ∈ F ∧ w ≠ 0 ∧ z = w * w) ∨
      (∃ w, w ∈ F ∧ w ≠ 0 ∧ -z = w * w)) ∧
    ¬(z = 0 ∧ (∃ w, w ∈ F ∧ w ≠ 0 ∧ z = w * w)) ∧
    ¬(z = 0 ∧ (∃ w, w ∈ F ∧ w ≠ 0 ∧ -z = w * w)) ∧
    ¬((∃ w, w ∈ F ∧ w ≠ 0 ∧ z = w * w) ∧
      (∃ w, w ∈ F ∧ w ≠ 0 ∧ -z = w * w)) := by
  rcases htri z hz with ⟨hcases, hzeroPositive, hzeroNegative, hpositiveNegative⟩
  constructor
  · rcases hcases with hzero | hpositive | hnegative
    · exact Or.inl hzero
    · obtain ⟨w, hwF, hw0, hsq⟩ := hpositiveSquare z hpositive
      exact Or.inr (Or.inl ⟨w, hwF, hw0, hsq.symm⟩)
    · obtain ⟨w, hwF, hw0, hsq⟩ := hpositiveSquare (-z) hnegative
      exact Or.inr (Or.inr ⟨w, hwF, hw0, hsq.symm⟩)
  constructor
  · rintro ⟨hzero, w, hwF, hw0, hsq⟩
    exact hzeroPositive ⟨hzero, hsq ▸ hsquareCone w hwF hw0⟩
  constructor
  · rintro ⟨hzero, w, hwF, hw0, hsq⟩
    exact hzeroNegative ⟨hzero, hsq ▸ hsquareCone w hwF hw0⟩
  · rintro ⟨⟨w, hwF, hw0, hsq⟩, ⟨v, hvF, hv0, hsq'⟩⟩
    exact hpositiveNegative ⟨hsq ▸ hsquareCone w hwF hw0,
      hsq' ▸ hsquareCone v hvF hv0⟩

end Ising2DLambda.NecSuf.FisherZero
