/-
章「Onsager 閉形式への接続」の
「格子点に接する四辺の通過回数の総和は訪問回数の二倍である」
（`claim_vertex_incident_edge_traversal_even`）の具体版のうち、本文の主張の対象である
零巻き付きの閉じた非後退辺列について述べるもの。

本文の証明と同じく、持ち上げの終点が始点に一致すること（`claim_plane_lift_endpoint_winding`）と、
持ち上げの各歩が単位格子歩であること（持ち上げの漸化式と変位の定義）を、整数列についての
数え上げ `vertexIncidentEdgeTraversal_even` に渡す。
-/
import Ising2DLambda.KacWard.WalkLiftVertexIncidentEdges

namespace Ising2DLambda.KacWard

/-- 零巻き付きの閉じた非後退辺列の平面持ち上げで、格子点に接する四辺の通過回数の総和は訪問回数の二倍である。 -/
theorem vertexIncidentEdgeTraversal_even_ofWalk {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (a b : ℤ) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    verticalEdgeTraversalCount (m + 1) row col (a - 1) b +
        verticalEdgeTraversalCount (m + 1) row col a b +
        horizontalEdgeTraversalCount (m + 1) row col a (b - 1) +
        horizontalEdgeTraversalCount (m + 1) row col a b =
      2 * vertexVisitCount (m + 1) row col a b := by
  dsimp only
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  exact vertexIncidentEdgeTraversal_even (m + 1) _ _ a b
    (liftedWalkCoordinates_unit γ) hclosed.1 hclosed.2

end Ising2DLambda.KacWard
