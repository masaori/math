import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 選択の一段に要るのは台の集合、正錐の制限、証人の有無だけである。 -/
theorem enumeratedOrderedSubfield_stepChoice {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (F : T) (C : Set K)
    (hC : IsPositiveConeOn (carrier F) C) (x : K) :
    ∃ (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier F) (carrier E) C D ∧
      ((∃ (E' : T) (D' : Set K),
          ExtendsPositiveConeOn (carrier F) (carrier E') C D' ∧ x ∈ carrier E') →
        x ∈ carrier E) := by
  classical
  by_cases h : ∃ (E' : T) (D' : Set K),
      ExtendsPositiveConeOn (carrier F) (carrier E') C D' ∧ x ∈ carrier E'
  · obtain ⟨E, D, hExt, hx⟩ := h
    exact ⟨E, D, hExt, fun _ => hx⟩
  · refine ⟨F, C, ?_, ?_⟩
    · exact ⟨(fun _ hz => hz), hC, hC,
        (fun z => ⟨(fun hz => hz.1), (fun hz => ⟨hz, hC.subset z hz⟩)⟩)⟩
    · intro hPossible
      exact False.elim (h hPossible)

end Ising2DLambda.NecSuf.FisherZero
