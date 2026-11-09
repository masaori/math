import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.Tools

/-- A chosen edge cannot have all its incident vertices in the unprocessed set. -/
theorem unprocessedEdge_unselected {V E : Type*} [DecidableEq E]
    (incident : V → E → Prop) (A F : Finset E) (U : Set V) (e : E)
    (hinside : ∀ f ∈ A, f ∈ F → ∃ w : V, incident w f ∧ w ∉ U)
    (heF : e ∈ F) (heU : ∀ w : V, incident w e → w ∈ U) : e ∉ A := by
  intro heA
  obtain ⟨w, hwe, hwU⟩ := hinside e heA heF
  exact hwU (heU w hwe)

end Ising2DLambda.NecSuf.Tools
