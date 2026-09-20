/-
具体版が必要十分版の特殊化として得られることの導出。

四方向の場合分けで、各辺の四辺通過回数への寄与を始点と終点の
指示値へ書き換えたあと、閉じた有限列の必要十分版を直接適用する。
-/
import Ising2DLambda.KacWard.VertexIncidentEdgeTraversalEven

namespace Ising2DLambda.KacWard

/-- `claim_vertex_incident_edge_traversal_even` を必要十分版から導く。 -/
theorem vertexIncidentEdgeTraversal_even_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hunit : IsUnitGridWalk n row col)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0) :
    verticalEdgeTraversalCount n row col (a - 1) b +
        verticalEdgeTraversalCount n row col a b +
        horizontalEdgeTraversalCount n row col a (b - 1) +
        horizontalEdgeTraversalCount n row col a b =
      2 * vertexVisitCount n row col a b :=
  vertexIncidentEdgeTraversal_even n row col a b hunit hclosedRow hclosedCol

end Ising2DLambda.KacWard
