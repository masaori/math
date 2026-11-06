import Ising2DLambda.KacWard.VertexSimpleBoundaryDistinctPassPropagation
import Ising2DLambda.NecSuf.KacWard.CyclicCoefficientPropagation

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The necessary and sufficient cyclic induction specializes to the actual boundary
coefficients after the local lattice step has been established. -/
theorem vertexSimple_boundary_nonloop_propagation_from_necSuf {L m : ℕ} [NeZero L]
    (hL : 2 ≤ L) (γ : Fin (m + 1) → OrientedEdge L)
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
  have hstep : ∀ k, f k = f (Ising2DLambda.NecSuf.KacWard.cyclicSuccessor k) := by
    intro k
    rw [← closedWalkSuccessor_from_necSuf]
    exact vertexSimple_boundary_distinct_pass_propagation L m γ hγ hcontact hh hv k
      (closedWalk_nonloop_successor_distinct_base hL γ hγ k)
      (oriented_edge_nonloop_of_two_le hL (γ k))
      (oriented_edge_nonloop_of_two_le hL (γ (closedWalkSuccessor k))).symm
  exact Ising2DLambda.NecSuf.KacWard.cyclic_coefficient_propagation f hstep

end Ising2DLambda.KacWard
