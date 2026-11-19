import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 必要なのは平方根、正錐延長の存在、延長に対する極大性だけである。 -/
theorem maximalOrderedSubfield_positive_isSquare
    {K T : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (R : T) (C : Set K)
    (hsqrt : ∀ a ∈ C, ∃ b : K, b ≠ 0 ∧ b * b = a)
    (hext : ∀ a ∈ C, ∀ b : K, b * b = a → b ∉ carrier R →
      ∃ (E : T) (D : Set K), b ∈ carrier E ∧
        ExtendsPositiveConeOn (carrier R) (carrier E) C D)
    (hmax : ∀ (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier R) (carrier E) C D → E = R)
    (a : K) (ha : a ∈ C) :
    ∃ b : K, b ∈ carrier R ∧ b ≠ 0 ∧ b * b = a := by
  obtain ⟨b, hb0, hb⟩ := hsqrt a ha
  by_cases hbR : b ∈ carrier R
  · exact ⟨b, hbR, hb0, hb⟩
  obtain ⟨E, D, hbE, hED⟩ := hext a ha b hb hbR
  have hER := hmax E D hED
  exact False.elim (hbR (hER ▸ hbE))

end Ising2DLambda.NecSuf.FisherZero
