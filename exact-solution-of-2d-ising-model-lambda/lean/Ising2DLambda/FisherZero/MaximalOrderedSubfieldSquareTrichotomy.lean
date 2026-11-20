import Ising2DLambda.FisherZero.MaximalOrderedSubfieldPositiveIsSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正錐の三分法と正の元の平方根から、部分体の平方の三分法を得る。 -/
theorem maximalOrderedSubfield_squareTrichotomy
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (z : Qbar) (hz : z ∈ R) :
    ExactlyOneOfThree (z = 0)
      (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ z = w * w)
      (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ -z = w * w) := by
  have hsquareCone (w : Qbar) (hw : w ≠ 0) (hwR : w ∈ R) : w * w ∈ C := by
    rcases (hC.trichotomy w hwR).1 with hzero | hpositive | hnegative
    · exact False.elim (hw hzero)
    · exact hC.mul_mem w w hpositive hpositive
    · have hmul := hC.mul_mem (-w) (-w) hnegative hnegative
      simpa only [neg_mul_neg] using hmul
  have htri := hC.trichotomy z hz
  rcases htri with ⟨hcases, hzeroPositive, hzeroNegative, hpositiveNegative⟩
  constructor
  · rcases hcases with hzero | hpositive | hnegative
    · exact Or.inl hzero
    · obtain ⟨w, hwR, hw0, hsq⟩ :=
        maximalOrderedSubfield_positive_isSquare R C hC hmax z hpositive
      exact Or.inr (Or.inl ⟨w, hwR, hw0, hsq.symm⟩)
    · obtain ⟨w, hwR, hw0, hsq⟩ :=
        maximalOrderedSubfield_positive_isSquare R C hC hmax (-z) hnegative
      exact Or.inr (Or.inr ⟨w, hwR, hw0, hsq.symm⟩)
  constructor
  · rintro ⟨hzero, w, hwR, hw0, hsq⟩
    exact hzeroPositive ⟨hzero, hsq ▸ hsquareCone w hw0 hwR⟩
  constructor
  · rintro ⟨hzero, w, hwR, hw0, hsq⟩
    exact hzeroNegative ⟨hzero, hsq ▸ hsquareCone w hw0 hwR⟩
  · rintro ⟨⟨w, hwR, hw0, hsq⟩, ⟨v, hvR, hv0, hsq'⟩⟩
    exact hpositiveNegative ⟨hsq ▸ hsquareCone w hw0 hwR,
      hsq' ▸ hsquareCone v hv0 hvR⟩

end Ising2DLambda.FisherZero
