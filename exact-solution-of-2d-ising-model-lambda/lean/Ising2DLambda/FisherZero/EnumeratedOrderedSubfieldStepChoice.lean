import Ising2DLambda.FisherZero.IncreasingPositiveConeUnionRestriction

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 列挙した元を一段で選ぶ具体版。延長可能なら証人を選び、
不可能なら現在の部分体と正錐を保つ。 -/
theorem enumeratedOrderedSubfield_stepChoice
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (x : Qbar) :
    ∃ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone F E C D ∧
      ((∃ (E' : Subfield Qbar) (D' : Set Qbar),
          ExtendsPositiveCone F E' C D' ∧ x ∈ E') → x ∈ E) := by
  classical
  by_cases h : ∃ (E' : Subfield Qbar) (D' : Set Qbar),
      ExtendsPositiveCone F E' C D' ∧ x ∈ E'
  · obtain ⟨E, D, hExt, hx⟩ := h
    exact ⟨E, D, hExt, fun _ => hx⟩
  · refine ⟨F, C, ?_, ?_⟩
    · exact ⟨(fun _ hz => hz), hC, hC,
        (fun z => ⟨(fun hz => hz.1), (fun hz => ⟨hz, hC.subset z hz⟩)⟩)⟩
    · intro hPossible
      exact False.elim (h hPossible)

end Ising2DLambda.FisherZero
