import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

/-- Only finite incidence and the parity of one incident edge are needed. -/
theorem incidenceParity_leafChoice {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A : Finset E) (e : E) (v : V) (hve : incident v e) :
    ∃! b : Bool, incidenceParity incident (if b then A ∆ {e} else A) v = 0 := by
  classical
  have hsingle : incidenceParity incident ({e} : Finset E) v = 1 := by
    unfold incidenceParity
    rw [Finset.sum_eq_single e]
    · simp [hve]
    · intro x _ hxe
      simp [hxe]
    · simp
  have htoggle : incidenceParity incident (A ∆ {e}) v =
      incidenceParity incident A v + 1 := by
    rw [incidenceParity_symmDiff, hsingle]
  have hcases : incidenceParity incident A v = 0 ∨
      incidenceParity incident A v = 1 := by
    exact (show ∀ p : ZMod 2, p = 0 ∨ p = 1 by decide) _
  rcases hcases with hz | ho
  · refine ⟨false, by simpa using hz, ?_⟩
    intro b hb
    cases b with
    | false => rfl
    | true =>
      simp only [ite_true] at hb
      rw [htoggle, hz] at hb
      simp at hb
  · refine ⟨true, ?_, ?_⟩
    · simpa [htoggle, ho, show (1 : ZMod 2) + 1 = 0 by decide]
    · intro b hb
      cases b with
      | true => rfl
      | false => simp [ho] at hb

end Ising2DLambda.NecSuf.Tools
