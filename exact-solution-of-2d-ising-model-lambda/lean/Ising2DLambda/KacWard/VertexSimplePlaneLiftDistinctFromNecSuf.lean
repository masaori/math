import Ising2DLambda.KacWard.VertexSimplePlaneLiftDistinct
import Ising2DLambda.NecSuf.KacWard.VertexSimplePlaneLiftDistinct

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The generic projection argument specializes to the actual closed walk. -/
theorem vertexSimplePlaneLift_points_distinct_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    Function.Injective (fun i : Fin (m + 1) => planeLift γ i.castSucc) := by
  exact Ising2DLambda.NecSuf.KacWard.lift_points_injective_of_projected_vertices_injective
    (fun i : Fin (m + 1) => planeLift γ i.castSucc)
    (fun i : Fin (m + 1) => planeLiftVertex γ i.castSucc)
    (fun p : ℤ × ℤ => (residueProjection L p.1, residueProjection L p.2))
    (planeLift_projection γ hγ)
    (planeLiftVertex_injective_of_no_contacts γ hγ hcontact)

end Ising2DLambda.KacWard
