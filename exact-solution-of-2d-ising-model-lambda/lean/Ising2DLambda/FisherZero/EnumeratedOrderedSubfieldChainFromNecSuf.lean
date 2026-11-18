import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldChain
import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldChain
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の反復を代数的数の部分体とその正錐へ特殊化する。 -/
theorem enumeratedOrderedSubfield_chain_from_necSuf
    (F₀ : Subfield Qbar) (C₀ : Set Qbar)
    (hC₀ : IsSubfieldPositiveCone F₀ C₀) (ξ : ℕ → Qbar) :
    ∃ (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar),
      F 0 = F₀ ∧ C 0 = C₀ ∧
      (∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1))) ∧
      (∀ n (E : Subfield Qbar) (D : Set Qbar),
        ExtendsPositiveCone (F n) E (C n) D → ξ n ∈ E → ξ n ∈ F (n + 1)) := by
  obtain ⟨F, C, hF₀, hC₀', hstep, hcapture⟩ :=
    Ising2DLambda.NecSuf.FisherZero.enumeratedOrderedSubfield_chain
      (fun E : Subfield Qbar => (E : Set Qbar)) F₀ C₀
      ((isSubfieldPositiveCone_iff_from_necSuf F₀ C₀).mp hC₀) ξ
  refine ⟨F, C, hF₀, hC₀', ?_, ?_⟩
  · intro n
    exact (extendsPositiveCone_iff_from_necSuf
      (F n) (F (n + 1)) (C n) (C (n + 1))).mpr (hstep n)
  · intro n E D hExt hx
    exact hcapture n E D
      ((extendsPositiveCone_iff_from_necSuf (F n) E (C n) D).mp hExt) hx

end Ising2DLambda.FisherZero
