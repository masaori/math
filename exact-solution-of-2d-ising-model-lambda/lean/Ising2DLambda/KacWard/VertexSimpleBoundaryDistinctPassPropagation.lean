import Ising2DLambda.KacWard.CellBoundaryTwoEdgePropagation
import Ising2DLambda.KacWard.VertexSimpleBoundaryOtherEdgesZero

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The vanishing contribution outside the two passage edges supplies the support
hypothesis of the two-edge balance argument at an actual simple walk. -/
theorem vertexSimple_boundary_distinct_pass_propagation (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (k : Fin (m + 1))
    (hdistinct : (γ k).1 ≠ (γ (closedWalkSuccessor k)).1)
    (hnotin : orientedSource (γ k) ≠ orientedTarget (γ k))
    (hnotout : orientedTarget (γ (closedWalkSuccessor k)) ≠
      orientedSource (γ (closedWalkSuccessor k))) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (γ k).1 *
        (1 - 2 * ((γ k).2.toNat : ℤ)) =
      cellSetEdgeCoefficient L (heightOneCells L m γ)
          (γ (closedWalkSuccessor k)).1 *
        (1 - 2 * ((γ (closedWalkSuccessor k)).2.toNat : ℤ)) := by
  let v := orientedTarget (γ k)
  have hnext : orientedSource (γ (closedWalkSuccessor k)) = v :=
    (Finset.mem_filter.mp (closedWalkPass_valid γ hγ k)).2.1.symm
  have hnotoutv : orientedTarget (γ (closedWalkSuccessor k)) ≠ v := by
    simpa only [hnext] using hnotout
  apply cellSetBoundary_two_edge_propagation L (heightOneCells L m γ) v
    (γ k) (γ (closedWalkSuccessor k)) hdistinct rfl hnotin hnext hnotoutv
  intro edge hfirst hsecond
  exact vertexSimple_boundary_other_edges_zero L m γ hγ hcontact hh hv
    k edge hfirst hsecond

end Ising2DLambda.KacWard
