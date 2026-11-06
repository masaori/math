import Ising2DLambda.KacWard.VertexSimpleBoundaryDistinctPassPropagation
import Ising2DLambda.NecSuf.KacWard.CyclicCoefficientPropagation

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- At side length at least two, local boundary coefficient equality propagates around
the entire actual vertex-simple closed walk. -/
theorem vertexSimple_boundary_nonloop_propagation {L m : ℕ} [NeZero L] (hL : 2 ≤ L)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    ∀ k : Fin (m + 1),
      cellSetEdgeCoefficient L (heightOneCells L m γ) (γ k).1 *
          (1 - 2 * ((γ k).2.toNat : ℤ)) =
        cellSetEdgeCoefficient L (heightOneCells L m γ) (γ 0).1 *
          (1 - 2 * ((γ 0).2.toNat : ℤ)) := by
  let f : Fin (m + 1) → ℤ := fun k =>
    cellSetEdgeCoefficient L (heightOneCells L m γ) (γ k).1 *
      (1 - 2 * ((γ k).2.toNat : ℤ))
  have hstep : ∀ k, f k = f (closedWalkSuccessor k) := by
    intro k
    exact vertexSimple_boundary_distinct_pass_propagation L m γ hγ hcontact hh hv k
      (closedWalk_nonloop_successor_distinct_base hL γ hγ k)
      (oriented_edge_nonloop_of_two_le hL (γ k))
      (oriented_edge_nonloop_of_two_le hL (γ (closedWalkSuccessor k))).symm
  intro k
  change f k = f 0
  induction k using Fin.induction with
  | zero => rfl
  | succ k ih =>
      have hs : closedWalkSuccessor k.castSucc = k.succ := by
        apply Fin.ext
        simp [closedWalkSuccessor, k.isLt]
      calc
        f k.succ = f k.castSucc := by simpa only [hs] using (hstep k.castSucc).symm
        _ = f 0 := ih

end Ising2DLambda.KacWard
