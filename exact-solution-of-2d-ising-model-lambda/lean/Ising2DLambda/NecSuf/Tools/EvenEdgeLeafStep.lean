import Ising2DLambda.NecSuf.Tools.EvenEdgeLeafChoice
import Ising2DLambda.NecSuf.Tools.EvenEdgeProcessedVertexParity
import Ising2DLambda.NecSuf.Tools.TreeEdgeToggleOutside

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

/-- The step uses only finite incidence and restriction to a set of edges. -/
theorem incidenceParity_leafStep {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A edgeSet treeEdges : Finset E) (U : Set V) (v : V) (e : E)
    (hve : incident v e) (heU : ∀ w : V, incident w e → w ∈ U)
    (heF : e ∈ treeEdges) (heE : e ∈ edgeSet) (hAE : A ⊆ edgeSet)
    (hinside : ∀ f ∈ A, f ∈ treeEdges → ∃ w : V, incident w f ∧ w ∉ U)
    (hprocessed : ∀ w : V, w ∉ U → incidenceParity incident A w = 0) :
    ∃ A' : Finset E,
      A' ⊆ edgeSet ∧ incidenceParity incident A' v = 0 ∧
      (∀ w : V, w ∉ U \ {v} → incidenceParity incident A' w = 0) ∧
      (∀ f ∈ A', f ∈ treeEdges → ∃ w : V, incident w f ∧ w ∉ U \ {v}) ∧
      A' ∩ (edgeSet \ treeEdges) = A ∩ (edgeSet \ treeEdges) ∧
      (A' = A ∨ A' = A ∆ {e}) := by
  classical
  obtain ⟨b, hb, _⟩ := incidenceParity_leafChoice incident A e v hve
  refine ⟨if b then A ∆ {e} else A, ?_, hb, ?_, ?_, ?_, ?_⟩
  -- Both possible choices remain subsets of the ambient edge set.
  · by_cases hb' : b
    · simp only [hb', ite_true]
      exact (Finset.symmDiff_subset_union).trans
        (Finset.union_subset hAE (by simpa using heE))
    · simpa [hb'] using hAE
  -- Incidence with e is absent outside U.
  · intro w hw
    by_cases hwU : w ∈ U
    · have hwv : w = v := by
        by_contra hne
        exact hw ⟨hwU, by simpa using hne⟩
      simpa [hwv] using hb
    · by_cases hb' : b
      · simpa [hb'] using
          (incidenceParity_toggle_unprocessed incident A U e
            (fun z hz h => hz (heU z h)) w hwU).trans (hprocessed w hwU)
      · simpa [hb'] using hprocessed w hwU
  -- Old chosen edges keep their witness outside U; e meets the removed vertex.
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
  -- Restriction to the complement of treeEdges is unchanged.
  · by_cases hb' : b
    · simpa [hb'] using toggle_preserves_outside A edgeSet treeEdges e heF
    · simp [hb']
  · by_cases hb' : b
    · exact Or.inr (by simp [hb'])
    · exact Or.inl (by simp [hb'])

end Ising2DLambda.NecSuf.Tools
