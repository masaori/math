import Ising2DLambda.Tools.ConnectedGraphCrossingEdge
import Ising2DLambda.NecSuf.Tools.ConnectedGraphCrossingEdge

namespace Ising2DLambda.Tools

theorem connectedGraph_crossingEdge_from_necSuf (n : ℕ)
    (G : FiniteSimpleGraph n) (hG : FiniteGraphConnected G)
    (U : Finset (Fin n)) (hU : U.Nonempty) (hproper : U ≠ Finset.univ) :
    ∃ u v : Fin n, u ∈ U ∧ v ∉ U ∧ G.Adj u v := by
  classical
  obtain ⟨a, ha⟩ := hU
  obtain ⟨b, hb⟩ : ∃ b : Fin n, b ∉ U := by
    by_contra h
    push Not at h
    exact hproper (Finset.eq_univ_of_forall h)
  have hpre : G.Preconnected := by
    intro x y
    obtain ⟨p, _⟩ := hG.2 x y
    exact ⟨p⟩
  simpa using Ising2DLambda.NecSuf.Tools.crossingEdge_of_preconnected
    G hpre (U : Set (Fin n)) a b ha hb

end Ising2DLambda.Tools
