import Ising2DLambda.Tools.FiniteSimpleGraph
import Mathlib.Combinatorics.SimpleGraph.Acyclic

namespace Ising2DLambda.Tools

open SimpleGraph

/-- An edge between vertices in distinct forest components preserves acyclicity. -/
theorem forest_addDisconnectedEdge (n : ℕ) (G F : FiniteSimpleGraph n)
    (hFG : F ≤ G) (hforest : F.IsAcyclic) (u v : Fin n)
    (huv : G.Adj u v) (hnot : ¬ F.Reachable u v) :
    (F ⊔ edge u v).IsAcyclic ∧ F ⊔ edge u v ≤ G := by
  have hFnot : ¬ F.Adj u v := fun h => hnot h.reachable
  have hdelete : (F ⊔ edge u v).deleteEdges {s(u, v)} = F := by
    simp [deleteEdges_sup, hFnot]
  constructor
  · intro w p hp
    -- A cycle using the new edge leaves an old path between its endpoints.
    by_cases he : s(u, v) ∈ p.edges
    · have hr : ((F ⊔ edge u v).deleteEdges {s(u, v)}).Reachable u v :=
        (adj_and_reachable_delete_edges_iff_exists_cycle).mpr ⟨w, p, hp, he⟩ |>.2
      exact hnot (hdelete ▸ hr)
    -- A cycle avoiding the new edge would already be a cycle in the forest.
    · have hpF : ∀ e ∈ p.edges, e ∈ F.edgeSet := by
        intro e he'
        have h : e ∈ (F ⊔ edge u v).edgeSet := p.edges_subset_edgeSet he'
        rw [edgeSet_sup, edgeSet_edge] at h
        grind
      exact hforest (p.transfer F hpF) (hp.transfer hpF)
  · exact sup_le hFG ((edge_le_iff G).2 (Or.inr huv))

end Ising2DLambda.Tools
