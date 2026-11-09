import Ising2DLambda.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

/-- An edge with both endpoints unprocessed cannot change parity at a processed vertex. -/
theorem edgeParity_toggle_unprocessed (n : ℕ)
    (A : Finset (Sym2 (Fin n))) (U : Finset (Fin n)) (e : Sym2 (Fin n))
    (he : ∀ v : Fin n, v ∈ e → v ∈ U) (v : Fin n) (hv : v ∉ U) :
    edgeParity n (A ∆ {e}) v = edgeParity n A v := by
  classical
  have hve : v ∉ e := fun h => hv (he v h)
  have hsingle : edgeParity n ({e} : Finset (Sym2 (Fin n))) v = 0 := by
    unfold edgeParity
    rw [Finset.sum_eq_single e]
    · simp [hve]
    · intro x _ hxe
      simp [hxe]
    · simp
  rw [edgeParity_symmDiff, hsingle, add_zero]

end Ising2DLambda.Tools
