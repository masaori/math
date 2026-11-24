import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcluded
import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- `claim_boundary_vertex_diagonal_contact_excluded` を、内側セルの定義の交差数
`rightRayVerticalCrossingCount` で述べた形。具体版の座標の交差数を書き換えるだけである。 -/
theorem boundaryVertex_diagonalContactExcluded_ofWalk {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (a b : ℤ) :
    DiagonalCellPairsExcluded
      (rightRayVerticalCrossingCount γ hγ (a - 1) (b - 1) % 2)
      (rightRayVerticalCrossingCount γ hγ (a - 1) b % 2)
      (rightRayVerticalCrossingCount γ hγ a b % 2)
      (rightRayVerticalCrossingCount γ hγ a (b - 1) % 2) := by
  have hresult := boundaryVertex_diagonalContactExcluded γ hγ hh hv hdistinct a b
  simpa only [rightRayVerticalCrossingCount_eq_coordinateSum] using hresult

end Ising2DLambda.KacWard
