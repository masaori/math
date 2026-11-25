/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing
import Ising2DLambda.NecSuf.KacWard.DisjointWalkMutualCrossing

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の一行目が必要十分版 `mutualCrossing_parity` の特殊化として得られること。
通過の添字を歩道の添字、頂点を格子頂点、方向を方向番号に取る。 -/
theorem closedWalkMutualCrossingNumber_eq_vertexSum_from_necSuf {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      ∑ v, (walkHalfEdgeUse γ v 2 * walkHalfEdgeUse η v 3 +
        walkHalfEdgeUse γ v 1 * walkHalfEdgeUse η v 0) := by
  rw [closedWalkMutualCrossingNumber_eq_directionSum]
  exact Ising2DLambda.NecSuf.KacWard.mutualCrossing_parity
    (fun r => orientedTarget (γ r)) (fun s => orientedTarget (η s))
    (fun r => directionNumber (γ r)) (fun r => directionNumber (γ (closedWalkSuccessor r)))
    (fun s => directionNumber (η s)) (fun s => directionNumber (η (closedWalkSuccessor s)))
    (fun r s hv => passHalfEdges_disjoint γ hγ η hη hdisjE r s hv)

end Ising2DLambda.KacWard
