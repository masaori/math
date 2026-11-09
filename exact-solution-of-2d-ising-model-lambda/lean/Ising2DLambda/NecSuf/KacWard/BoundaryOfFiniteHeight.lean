import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite height-one witness whose boundary is prescribed and whose points
lie in the ambient set gives a boundary preimage inside that set. -/
theorem boundary_of_finite_height
    {α β : Type*} [DecidableEq α]
    (boundary : Finset α → Finset β)
    (ambient : Finset α) (edges : Finset β) (height : α → Prop)
    (hwitness : ∃ selected : Finset α,
      (∀ p, p ∈ selected ↔ height p) ∧ boundary selected = edges)
    (hinside : ∀ p, height p → p ∈ ambient) :
    ∃ selected : Finset α, selected ⊆ ambient ∧ boundary selected = edges := by
  obtain ⟨selected, hselected, hboundary⟩ := hwitness
  refine ⟨selected, ?_, hboundary⟩
  intro p hp
  exact hinside p ((hselected p).mp hp)

end Ising2DLambda.NecSuf.KacWard
