import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldStepChoice
import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldStepChoice

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体とその正錐へ戻す。 -/
theorem enumeratedOrderedSubfield_stepChoice_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (x : Qbar) :
    ∃ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone F E C D ∧
      ((∃ (E' : Subfield Qbar) (D' : Set Qbar),
          ExtendsPositiveCone F E' C D' ∧ x ∈ E') → x ∈ E) := by
  have h := Ising2DLambda.NecSuf.FisherZero.enumeratedOrderedSubfield_stepChoice
    (fun E : Subfield Qbar => (E : Set Qbar)) F C
    ((isSubfieldPositiveCone_iff_from_necSuf F C).1 hC) x
  obtain ⟨E, D, hExt, hCapture⟩ := h
  refine ⟨E, D, (extendsPositiveCone_iff_from_necSuf F E C D).2 hExt, ?_⟩
  intro hPossible
  apply hCapture
  obtain ⟨E', D', hExt', hx⟩ := hPossible
  exact ⟨E', D', (extendsPositiveCone_iff_from_necSuf F E' C D').1 hExt', hx⟩

end Ising2DLambda.FisherZero
