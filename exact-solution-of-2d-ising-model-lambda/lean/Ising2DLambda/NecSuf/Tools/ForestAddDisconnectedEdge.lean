import Mathlib.Combinatorics.SimpleGraph.Acyclic

namespace Ising2DLambda.NecSuf.Tools

open SimpleGraph

/-- The acyclicity argument does not require finiteness of the vertex type. -/
theorem forest_addDisconnectedEdge {V : Type*} (G F : SimpleGraph V)
    (hFG : F ≤ G) (hforest : F.IsAcyclic) (u v : V)
    (huv : G.Adj u v) (hnot : ¬ F.Reachable u v) :
    (F ⊔ edge u v).IsAcyclic ∧ F ⊔ edge u v ≤ G := by
  -- Acyclicity, reachability, and edge inclusion are the only needed properties.
  have hFnot : ¬ F.Adj u v := fun h => hnot h.reachable
  have hdelete : (F ⊔ edge u v).deleteEdges {s(u, v)} = F := by
    simp [deleteEdges_sup, hFnot]
  constructor
  · intro w p hp
    by_cases he : s(u, v) ∈ p.edges
    · have hr : ((F ⊔ edge u v).deleteEdges {s(u, v)}).Reachable u v :=
        (adj_and_reachable_delete_edges_iff_exists_cycle).mpr ⟨w, p, hp, he⟩ |>.2
      exact hnot (hdelete ▸ hr)
    · have hpF : ∀ e ∈ p.edges, e ∈ F.edgeSet := by
        intro e he'
        have h : e ∈ (F ⊔ edge u v).edgeSet := p.edges_subset_edgeSet he'
        rw [edgeSet_sup, edgeSet_edge] at h
        grind
      exact hforest (p.transfer F hpF) (hp.transfer hpF)
  · exact sup_le hFG ((edge_le_iff G).2 (Or.inr huv))

end Ising2DLambda.NecSuf.Tools
