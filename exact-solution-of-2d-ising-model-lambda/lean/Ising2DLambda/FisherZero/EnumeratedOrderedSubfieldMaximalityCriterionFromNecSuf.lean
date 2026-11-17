import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldMaximalityCriterion
import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldMaximalityCriterion
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 台の表示写像を Qbar の部分体の台集合に特殊化する。 -/
theorem enumeratedOrderedSubfield_maximalityCriterion_from_necSuf
    (ξ : ℕ → Qbar) (hξ : Function.Surjective ξ)
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1)))
    (hrestrict : ∀ (n : ℕ) (z : Qbar),
      (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ F n) ↔ z ∈ C n)
    (hcapture : ∀ n (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone (F n) E (C n) D → ξ n ∈ E → ξ n ∈ F (n + 1))
    (E : Subfield Qbar) (D : Set Qbar)
    (hED : ExtendsPositiveCone
      (increasingSubfieldUnion F
        (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)))
      E {x | ∃ n, x ∈ C n} D) :
    E = increasingSubfieldUnion F
      (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)) := by
  have h := Ising2DLambda.NecSuf.FisherZero.enumeratedOrderedSubfield_maximalityCriterion
    (carrier := fun A : Subfield Qbar => (A : Set Qbar)) ξ hξ F C
    (fun n => (isSubfieldPositiveCone_iff_from_necSuf (F n) (C n)).1 (hstep n).cone_F)
    hrestrict
    (by
      intro n A B hExt hmem
      exact hcapture n A B
        ((extendsPositiveCone_iff_from_necSuf (F n) A (C n) B).2 hExt) hmem)
    E D
    ((extendsPositiveCone_iff_from_necSuf _ E _ D).1 hED)
  apply Subfield.ext
  intro z
  exact Set.ext_iff.mp h z

end Ising2DLambda.FisherZero
