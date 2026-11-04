import Ising2DLambda.KacWard.CellSetBoundaryCoefficients
import Ising2DLambda.NecSuf.KacWard.CellSetBoundaryCoefficients

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- The concrete horizontal coefficient is a specialization of the finite indicator sum. -/
theorem cellSetEdgeCoefficient_horizontal_from_necSuf (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (i j : ZMod L) :
    cellSetEdgeCoefficient L S (edgeOfRow L false i j) =
      (if (i, j) ∈ S then (1 : ℤ) else 0) -
      (if (i - 1, j) ∈ S then (1 : ℤ) else 0) := by
  classical
  simp only [cellSetEdgeCoefficient]
  simp_rw [cellContribution_horizontal]
  exact Ising2DLambda.NecSuf.KacWard.finiteBoundaryIndicatorDifference
    S (i, j) (i - 1, j)

/-- The concrete vertical coefficient is a specialization of the finite indicator sum. -/
theorem cellSetEdgeCoefficient_vertical_from_necSuf (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (i j : ZMod L) :
    cellSetEdgeCoefficient L S (edgeOfRow L true i j) =
      (if (i, j - 1) ∈ S then (1 : ℤ) else 0) -
      (if (i, j) ∈ S then (1 : ℤ) else 0) := by
  classical
  simp only [cellSetEdgeCoefficient]
  simp_rw [cellContribution_vertical]
  exact Ising2DLambda.NecSuf.KacWard.finiteBoundaryIndicatorDifference
    S (i, j - 1) (i, j)

end Ising2DLambda.KacWard
