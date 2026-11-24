/-
具体版が必要十分版の特殊化として得られることの導出。

四辺の通過回数・訪問回数と、入る辺と出る辺の正値性を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.WalkLiftVertexIncidentEdges
import Ising2DLambda.NecSuf.KacWard.LiftedWalkVertexIncidentEdges

namespace Ising2DLambda.KacWard

/-- `claim_lifted_walk_vertex_incident_edges_traversed_at_most_once` を必要十分版から導く。 -/
theorem liftedWalkCoordinates_incident_counts_le_one_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∀ j < m + 1,
      verticalEdgeTraversalCount (m + 1) row col (row j - 1) (col j) ≤ 1 ∧
      verticalEdgeTraversalCount (m + 1) row col (row j) (col j) ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col (row j) (col j - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col (row j) (col j) ≤ 1 := by
  intro row col j hj
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  exact Ising2DLambda.NecSuf.KacWard.four_incident_counts_le_one_necSuf _ _ _ _
    (vertexVisitCount (m + 1) row col (row j) (col j))
    (vertexIncidentEdgeTraversal_even (m + 1) row col (row j) (col j)
      (liftedWalkCoordinates_unit γ) hclosed.1 hclosed.2)
    (vertexVisitCount_eq_one_of_distinct (m + 1) row col j hj
      (liftedWalkCoordinates_distinct γ hdistinct))
    (liftedWalkCoordinates_incident_distinct_positive γ hγ hh hv j hj)

end Ising2DLambda.KacWard
