import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

/-- Only the absence of incidence at processed vertices is needed. -/
theorem incidenceParity_toggle_unprocessed {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A : Finset E) (U : Set V) (e : E)
    (he : ∀ v : V, v ∉ U → ¬incident v e) (v : V) (hv : v ∉ U) :
    incidenceParity incident (A ∆ {e}) v = incidenceParity incident A v := by
  classical
  have hsingle : incidenceParity incident ({e} : Finset E) v = 0 := by
    unfold incidenceParity
    rw [Finset.sum_eq_single e]
    · simp [he v hv]
    · intro x _ hxe
      simp [hxe]
    · simp
  rw [incidenceParity_symmDiff, hsingle, add_zero]

end Ising2DLambda.NecSuf.Tools
