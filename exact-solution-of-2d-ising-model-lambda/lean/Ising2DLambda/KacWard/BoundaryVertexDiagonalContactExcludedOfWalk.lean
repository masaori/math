import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcluded
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- The four cells around any lattice vertex of an actual simple closed walk
cannot occupy only a diagonal pair. -/
theorem boundaryVertex_diagonalContactExcluded_ofWalk {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (a b : ℤ) :
    DiagonalCellPairsExcluded
      (rightRayVerticalCrossingCount γ hγ (a - 1) (b - 1) % 2)
      (rightRayVerticalCrossingCount γ hγ (a - 1) b % 2)
      (rightRayVerticalCrossingCount γ hγ a b % 2)
      (rightRayVerticalCrossingCount γ hγ a (b - 1) % 2) := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hclosed := walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv
  have hunit := walkSideInteriorBandFromWalk_coordinate_unit γ
  have hcoord := walkSideInteriorBandFromWalk_coordinate_distinct γ hdistinct
  have hbounds :
      verticalEdgeTraversalCount (m + 1) row col (a - 1) b ≤ 1 ∧
      verticalEdgeTraversalCount (m + 1) row col a b ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col a (b - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col a b ≤ 1 := by
    by_cases hvisited : ∃ j, j < m + 1 ∧ row j = a ∧ col j = b
    · obtain ⟨j, hj, hr, hc⟩ := hvisited
      have hlocal := walkSideInteriorBandFromWalk_coordinate_incident_counts_le_one
        γ hγ hh hv hdistinct j hj
      change (planeLift γ (Fin.ofNat (m + 2) j)).1 = a at hr
      change (planeLift γ (Fin.ofNat (m + 2) j)).2 = b at hc
      simpa only [hr, hc] using hlocal
    · have hzero : vertexVisitCount (m + 1) row col a b = 0 := by
        unfold vertexVisitCount
        apply Finset.sum_eq_zero
        intro j hj
        have hjlt : j < m + 1 := Finset.mem_range.mp hj
        simp only [ite_eq_right_iff]
        intro hpoint
        exact False.elim (hvisited ⟨j, hjlt, hpoint⟩)
      have hsum := vertexIncidentEdgeTraversal_even
        (m + 1) row col a b hunit hclosed.1 hclosed.2
      omega
  have hresult := boundaryVertex_diagonalContactExcluded
    (m + 1) row col a b hclosed.1 hclosed.2 hunit hcoord
    hbounds.1 hbounds.2.1 hbounds.2.2.1 hbounds.2.2.2
  simpa only [rightRayVerticalCrossingCount_eq_coordinateSum] using hresult

end Ising2DLambda.KacWard
