import Ising2DLambda.Tools.EvenEdgeLeafChoice
import Ising2DLambda.Tools.EvenEdgeProcessedVertexParity
import Ising2DLambda.Tools.TreeEdgeToggleOutside

namespace Ising2DLambda.Tools

open scoped symmDiff

/-- One leaf choice preserves the parity and edge-selection invariants. -/
theorem evenEdge_leafStep (n : ℕ) (A E F : Finset (Sym2 (Fin n)))
    (U : Finset (Fin n)) (v : Fin n) (e : Sym2 (Fin n))
    (hve : v ∈ e)
    (heU : ∀ w : Fin n, w ∈ e → w ∈ U)
    (heF : e ∈ F) (heE : e ∈ E) (hAE : A ⊆ E)
    (hinside : ∀ f ∈ A, f ∈ F → ∃ w ∈ f, w ∉ U)
    (hprocessed : ∀ w : Fin n, w ∉ U → edgeParity n A w = 0) :
    ∃ A' : Finset (Sym2 (Fin n)),
      A' ⊆ E ∧ edgeParity n A' v = 0 ∧
      (∀ w : Fin n, w ∉ U.erase v → edgeParity n A' w = 0) ∧
      (∀ f ∈ A', f ∈ F → ∃ w ∈ f, w ∉ U.erase v) ∧
      A' ∩ (E \ F) = A ∩ (E \ F) ∧
      (A' = A ∨ A' = A ∆ {e}) := by
  classical
  obtain ⟨b, hb, _⟩ := evenEdge_leafChoice n A e v hve
  refine ⟨if b then A ∆ {e} else A, ?_, hb, ?_, ?_, ?_, ?_⟩
  -- Both possible choices remain subsets of the graph's edge set.
  · by_cases hb' : b
    · simp only [hb', ite_true]
      exact (Finset.symmDiff_subset_union).trans
        (Finset.union_subset hAE (by simpa using heE))
    · simpa [hb'] using hAE
  -- The chosen edge has no endpoint at an already processed vertex.
  · intro w hw
    by_cases hwU : w ∈ U
    · have hwv : w = v := by
        by_contra hne
        exact hw (Finset.mem_erase.mpr ⟨hne, hwU⟩)
      simpa [hwv] using hb
    · by_cases hb' : b
      · simpa [hb'] using
          (edgeParity_toggle_unprocessed n A U e heU w hwU).trans (hprocessed w hwU)
      · simpa [hb'] using hprocessed w hwU
  -- Old selected tree edges still meet a processed vertex; the new edge meets v.
  · intro f hf hfF
    by_cases hb' : b
    · simp only [hb', ite_true] at hf
      by_cases hfe : f = e
      · subst f
        exact ⟨v, hve, by simp⟩
      · have hfA : f ∈ A := by
          simpa [Finset.mem_symmDiff, hfe] using hf
        obtain ⟨w, hwf, hwU⟩ := hinside f hfA hfF
        exact ⟨w, hwf, by simp [hwU]⟩
    · have hfA : f ∈ A := by simpa [hb'] using hf
      obtain ⟨w, hwf, hwU⟩ := hinside f hfA hfF
      exact ⟨w, hwf, by simp [hwU]⟩
  -- The one-edge toggle is confined to F.
  · by_cases hb' : b
    · simpa [hb'] using treeEdge_toggle_outside n A E F e heF
    · simp [hb']
  · by_cases hb' : b
    · exact Or.inr (by simp [hb'])
    · exact Or.inl (by simp [hb'])

end Ising2DLambda.Tools
