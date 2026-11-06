import Ising2DLambda.KacWard.HeightOneBoundarySignedWalk
import Ising2DLambda.KacWard.WalkEqualsCellBoundary

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- A vertex-simple closed walk with both seam parities zero bounds the height-one cells,
up to orientation, so its two integer winding numbers vanish. -/
theorem vertexSimple_zero_seam_winding (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    horizontalDirectedWindingNumber γ = 0 ∧
      verticalDirectedWindingNumber γ = 0 := by
  obtain ⟨ε, hε, hcoeff⟩ := heightOneBoundary_signed_walk L m γ hγ hcontact hh hv
  exact walk_signed_boundary_winding_zero L m γ (heightOneCells L m γ) ε hε hcoeff

end Ising2DLambda.KacWard
