import Ising2DLambda.KacWard.HeightOneBoundarySignedWalkFromNecSuf
import Ising2DLambda.NecSuf.KacWard.WalkEqualsCellBoundary
import Ising2DLambda.KacWard.VertexSimpleZeroSeamWinding

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The abstract signed-coefficient argument specialized to both seam weights of the torus. -/
theorem vertexSimple_zero_seam_winding_from_necSuf (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    horizontalDirectedWindingNumber γ = 0 ∧
      verticalDirectedWindingNumber γ = 0 := by
  obtain ⟨ε, hε, hcoeff⟩ :=
    heightOneBoundary_signed_walk_from_necSuf L m γ hγ hcontact hh hv
  have hε0 : ε ≠ 0 := by
    simp only [Finset.mem_insert, Finset.mem_singleton] at hε
    rcases hε with h | h <;> simp [h]
  have hcoeff' (edge : Edge L) :
      (∑ cell ∈ heightOneCells L m γ,
        ((cellBoundaryEdges L cell.1 cell.2).map
          (Ising2DLambda.NecSuf.KacWard.coefficient edge)).sum) =
        ε * ∑ k : Fin (m + 1),
          Ising2DLambda.NecSuf.KacWard.coefficient edge (γ k) := by
    change cellSetEdgeCoefficient L (heightOneCells L m γ) edge =
      ε * walkEdgeCoefficient γ edge
    exact hcoeff edge
  constructor
  · let weight : Edge L → ℤ := fun edge => (horizontalSeamParity (edge, false) : ℤ)
    have hweight (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = horizontalSeamContribution e := by
      simp [weight, horizontalSeamContribution, horizontalSeamParity, mul_comm]
    have hboundary :
        ∑ cell ∈ heightOneCells L m γ,
          ((cellBoundaryEdges L cell.1 cell.2).map fun occurrence =>
            (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum = 0 := by
      have hfun : (fun e : OrientedEdge L =>
          (1 - 2 * (e.2.toNat : ℤ)) * weight e.1) = horizontalSeamContribution :=
        funext hweight
      simpa only [cellSetBoundaryEvaluation, ← hfun] using
        cellSetBoundary_horizontalSeam_sum_zero L (heightOneCells L m γ)
    have h := Ising2DLambda.NecSuf.KacWard.signed_coefficients_zero_weighted_evaluation
      γ (heightOneCells L m γ) (fun cell => cellBoundaryEdges L cell.1 cell.2)
      weight ε hε0 hcoeff' hboundary
    simpa [horizontalDirectedWindingNumber, weight, horizontalSeamContribution,
      horizontalSeamParity, mul_comm] using h
  · let weight : Edge L → ℤ := fun edge => (verticalSeamParity (edge, false) : ℤ)
    have hweight (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = verticalSeamContribution e := by
      simp [weight, verticalSeamContribution, verticalSeamParity, mul_comm]
    have hboundary :
        ∑ cell ∈ heightOneCells L m γ,
          ((cellBoundaryEdges L cell.1 cell.2).map fun occurrence =>
            (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum = 0 := by
      have hfun : (fun e : OrientedEdge L =>
          (1 - 2 * (e.2.toNat : ℤ)) * weight e.1) = verticalSeamContribution :=
        funext hweight
      simpa only [cellSetBoundaryEvaluation, ← hfun] using
        cellSetBoundary_verticalSeam_sum_zero L (heightOneCells L m γ)
    have h := Ising2DLambda.NecSuf.KacWard.signed_coefficients_zero_weighted_evaluation
      γ (heightOneCells L m γ) (fun cell => cellBoundaryEdges L cell.1 cell.2)
      weight ε hε0 hcoeff' hboundary
    simpa [verticalDirectedWindingNumber, weight, verticalSeamContribution,
      verticalSeamParity, mul_comm] using h

end Ising2DLambda.KacWard
