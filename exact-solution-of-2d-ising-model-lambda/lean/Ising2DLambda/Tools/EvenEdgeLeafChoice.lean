import Ising2DLambda.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

/-- Toggling an edge incident to a vertex gives the unique parity-correcting choice. -/
theorem evenEdge_leafChoice (n : ℕ) (A : Finset (Sym2 (Fin n)))
    (e : Sym2 (Fin n)) (v : Fin n) (hve : v ∈ e) :
    ∃! b : Bool, edgeParity n (if b then A ∆ {e} else A) v = 0 := by
  classical
  have hsingle : edgeParity n ({e} : Finset (Sym2 (Fin n))) v = 1 := by
    unfold edgeParity
    rw [Finset.sum_eq_single e]
    · simp [hve]
    · intro x _ hxe
      simp [hxe]
    · simp
  have htoggle : edgeParity n (A ∆ {e}) v = edgeParity n A v + 1 := by
    rw [edgeParity_symmDiff, hsingle]
  have hcases : edgeParity n A v = 0 ∨ edgeParity n A v = 1 := by
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
      | false =>
        simp [ho] at hb

end Ising2DLambda.Tools
