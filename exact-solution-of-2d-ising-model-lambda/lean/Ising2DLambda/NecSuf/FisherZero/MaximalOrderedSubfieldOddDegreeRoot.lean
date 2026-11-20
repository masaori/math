import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone
import Mathlib.Algebra.Ring.Parity

namespace Ising2DLambda.NecSuf.FisherZero

/-- 根の次数に応じた延長と極大性だけで根が元の集合に戻る。 -/
theorem maximalOrderedSubfield_oddDegreeRoot
    {K T P : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (R : T) (C : Set K) (f : P)
    (hasRoot : P → K → Prop) (degree : K → ℕ)
    (hoddRoot : ∃ β : K, hasRoot f β ∧ Odd (degree β))
    (extension : K → T)
    (hmember : ∀ β : K, β ∈ carrier (extension β))
    (hext : ∀ β : K, Odd (degree β) →
      ∃ D : Set K, ExtendsPositiveConeOn (carrier R) (carrier (extension β)) C D)
    (hmax : ∀ E : T, ∀ D : Set K,
      ExtendsPositiveConeOn (carrier R) (carrier E) C D → E = R) :
    ∃ β : K, β ∈ carrier R ∧ hasRoot f β := by
  obtain ⟨β, hroot, hodd⟩ := hoddRoot
  obtain ⟨D, hD⟩ := hext β hodd
  have hER := hmax (extension β) D hD
  exact ⟨β, hER ▸ hmember β, hroot⟩

end Ising2DLambda.NecSuf.FisherZero
