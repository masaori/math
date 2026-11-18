import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 台の零でない元が平方根を持つことと、正錐が零を含まないことだけを使う。 -/
theorem positiveConeElement_hasQbarSquareRoot {K : Type}
    [Zero K] [Mul K]
    (carrier C : Set K)
    (hC0 : (0 : K) ∉ C)
    (hzero : (0 : K) * 0 = 0)
    (hsqrt : ∀ a ∈ carrier, a ≠ 0 → ∃ b : K, b * b = a)
    (a : K) (ha : a ∈ C) (hCa : C ⊆ carrier) :
    ∃ b : K, b ≠ 0 ∧ b * b = a := by
  have ha0 : a ≠ 0 := by
    intro haz
    exact hC0 (haz ▸ ha)
  obtain ⟨b, hb⟩ := hsqrt a (hCa ha) ha0
  refine ⟨b, ?_, hb⟩
  intro hb0
  apply ha0
  simpa [hb0, hzero] using hb.symm

end Ising2DLambda.NecSuf.FisherZero
