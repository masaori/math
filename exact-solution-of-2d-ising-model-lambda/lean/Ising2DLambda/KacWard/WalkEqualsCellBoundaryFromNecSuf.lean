import Ising2DLambda.KacWard.WalkEqualsCellBoundary
import Ising2DLambda.NecSuf.KacWard.WalkEqualsCellBoundary

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- Specialization of the basis-coefficient identity to the actual torus edge
set and the horizontal and vertical seam weights. -/
theorem walk_boundary_winding_zero_from_necSuf (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (S : Finset (ZMod L × ZMod L))
    (_hclosed : closedNonbacktrackingWalk γ)
    (hcoeff : ∀ edge : Edge L, walkEdgeCoefficient γ edge =
      cellSetEdgeCoefficient L S edge) :
    horizontalDirectedWindingNumber γ = 0 ∧
      verticalDirectedWindingNumber γ = 0 := by
  classical
  have hcoeff' (edge : Edge L) :
      (∑ k : Fin (m + 1), Ising2DLambda.NecSuf.KacWard.coefficient edge (γ k)) =
        ∑ p ∈ S,
          ((cellBoundaryEdges L p.1 p.2).map
            (Ising2DLambda.NecSuf.KacWard.coefficient edge)).sum := by
    change (∑ k : Fin (m + 1), orientedEdgeCoefficient edge (γ k)) =
      ∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map
        (orientedEdgeCoefficient edge)).sum
    exact hcoeff edge
  have hweight (weight : Edge L → ℤ) :=
    Ising2DLambda.NecSuf.KacWard.equal_coefficients_equal_weighted_evaluations
      γ S (fun p => cellBoundaryEdges L p.1 p.2) hcoeff' weight
  constructor
  · let weight : Edge L → ℤ := fun edge => (horizontalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = horizontalSeamContribution e := by
      simp [weight, horizontalSeamContribution, horizontalSeamParity, mul_comm]
    have h := hweight weight
    rw [show (∑ k : Fin (m + 1),
          (1 - 2 * ((γ k).2.toNat : ℤ)) * weight (γ k).1) =
          ∑ k : Fin (m + 1), horizontalSeamContribution (γ k) by
            apply Finset.sum_congr rfl
            intro k _
            exact hw (γ k)] at h
    simp_rw [hw] at h
    have hboundary :
        (∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map
          horizontalSeamContribution).sum) = 0 := by
      simpa [cellSetBoundaryEvaluation] using
        cellSetBoundary_horizontalSeam_sum_zero L S
    change (∑ k : Fin (m + 1), horizontalSeamContribution (γ k)) = 0
    exact h.trans hboundary
  · let weight : Edge L → ℤ := fun edge => (verticalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = verticalSeamContribution e := by
      simp [weight, verticalSeamContribution, verticalSeamParity, mul_comm]
    have h := hweight weight
    rw [show (∑ k : Fin (m + 1),
          (1 - 2 * ((γ k).2.toNat : ℤ)) * weight (γ k).1) =
          ∑ k : Fin (m + 1), verticalSeamContribution (γ k) by
            apply Finset.sum_congr rfl
            intro k _
            exact hw (γ k)] at h
    simp_rw [hw] at h
    have hboundary :
        (∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map
          verticalSeamContribution).sum) = 0 := by
      simpa [cellSetBoundaryEvaluation] using
        cellSetBoundary_verticalSeam_sum_zero L S
    change (∑ k : Fin (m + 1), verticalSeamContribution (γ k)) = 0
    exact h.trans hboundary

end Ising2DLambda.KacWard
