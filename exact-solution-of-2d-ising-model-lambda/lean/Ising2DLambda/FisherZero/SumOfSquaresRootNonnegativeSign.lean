import Ising2DLambda.FisherZero.ImaginaryUnitSquareRootFormula

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 二つの平方の和の根は、零か正錐の元になるように符号を選べる。 -/
theorem maximalOrderedSubfield_sumOfSquares_rootNonnegative
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a b : Qbar) (ha : a ∈ R) (hb : b ∈ R) :
    ∃ c : Qbar, c ∈ R ∧ c * c = a * a + b * b ∧ (c = 0 ∨ c ∈ C) := by
  obtain ⟨c, hc, hc2⟩ :=
    maximalOrderedSubfield_sumOfSquares_isSquare R C hC hmax a b ha hb
  obtain ⟨hcases, _⟩ := hC.trichotomy c hc
  rcases hcases with hzero | hpos | hneg
  · exact ⟨c, hc, hc2, Or.inl hzero⟩
  · exact ⟨c, hc, hc2, Or.inr hpos⟩
  · refine ⟨-c, R.neg_mem hc, ?_, Or.inr hneg⟩
    simpa only [neg_mul_neg] using hc2

end Ising2DLambda.FisherZero
