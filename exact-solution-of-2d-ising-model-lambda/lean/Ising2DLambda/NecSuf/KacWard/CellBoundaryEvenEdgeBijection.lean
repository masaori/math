import Ising2DLambda.NecSuf.KacWard.PlaneCellBoundaryInjective

namespace Ising2DLambda.NecSuf.KacWard

open scoped symmDiff

/-- A finite boundary with trivial kernel and a preimage for every admissible
edge set identifies the subsets of an ambient set with its admissible edges. -/
theorem boundary_bijective_of_even_edge_preimages
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (boundary : Finset α → Finset β) (ambient : Finset α)
    (admissible : Finset β → Prop)
    (hsymm : ∀ A B, boundary (A ∆ B) = boundary A ∆ boundary B)
    (hkernel : ∀ A, boundary A = ∅ → A = ∅)
    (hclosed : ∀ A, A ⊆ ambient → admissible (boundary A))
    (hpreimage : ∀ E, admissible E →
      ∃ A, A ⊆ ambient ∧ boundary A = E) :
    Function.Bijective
      (fun A : {T : Finset α // T ⊆ ambient} =>
        (⟨boundary A.1, hclosed A.1 A.2⟩ :
          {E : Finset β // admissible E})) := by
  have hinj := boundary_injective_of_symmetric_difference boundary hsymm hkernel
  constructor
  · intro A B hAB
    exact Subtype.ext (hinj (congrArg Subtype.val hAB))
  · intro E
    obtain ⟨A, hA, hboundary⟩ := hpreimage E.1 E.2
    exact ⟨⟨A, hA⟩, Subtype.ext hboundary⟩

end Ising2DLambda.NecSuf.KacWard
