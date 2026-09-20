/- 具体版が必要十分版の平面格子点・トーラス辺への特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.PlaneSimpleCycleTorusProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `claim_plane_simple_cycle_projection_closed_nonbacktracking` を必要十分版から導いたもの。 -/
theorem planeSimpleCycleProjection_closedNonbacktracking_from_necSuf
    (L : ℕ) [NeZero L] {I : Type*}
    (next : I → I) (W : I → ℤ × ℤ) (projectedEdge : I → OrientedEdge L)
    (hsource : ∀ i, orientedSource (projectedEdge i) = planeVertexProjection L (W i))
    (htarget : ∀ i, orientedTarget (projectedEdge i) = planeVertexProjection L (W (next i)))
    (hvertex : Function.Injective W)
    (hreverse : ∀ i, projectedEdge (next i) = reversal (projectedEdge i) →
      W (next (next i)) = W i)
    (hnextTwo : ∀ i, next (next i) ≠ i) :
    (∀ i, orientedTarget (projectedEdge i) = orientedSource (projectedEdge (next i))) ∧
      (∀ i, projectedEdge (next i) ≠ reversal (projectedEdge i)) :=
  planeSimpleCycleProjection_closedNonbacktracking
    L next W projectedEdge hsource htarget hvertex hreverse hnextTwo

end Ising2DLambda.KacWard
