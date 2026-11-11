import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Odd traversal of a horizontal edge separates the two cells that meet there. -/
theorem horizontalEdge_oddRay_boundary
    (n : ℕ) (row col : ℕ → ℤ) (cells : Finset GridCell)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hcell : ∀ r c : ℤ, (r, c) ∈ cells ↔ Odd (rightRayCrossingCount n row col r c))
    (r c : ℤ)
    (hodd : Odd (horizontalEdgeTraversalCount n row col (r + 1) c)) :
    (false, (r + 1, c)) ∈ planeCellBoundary cells := by
  have hparity := verticallyAdjacentCells_boundaryParity n row col r c
    hclosedRow hclosedCol hunit
  have hdiff : ((r, c) ∈ cells ∧ (r + 1, c) ∉ cells) ∨
      ((r, c) ∉ cells ∧ (r + 1, c) ∈ cells) := by
    rw [hcell r c, hcell (r + 1) c]
    simp only [Nat.odd_iff]
    have hh := Nat.odd_iff.mp hodd
    omega
  have hedge : (false, (r + 1, c)) ∈ cellEdges cells := by
    apply (horizontalEdge_mem_cellEdges_iff cells (r + 1) c).2
    rcases hdiff with h | h
    · right
      simpa using h.1
    · exact Or.inl h.2
  simp only [planeCellBoundary, Finset.mem_filter, hedge, Bool.false_eq_true,
    ↓reduceIte, true_and]
  rcases hdiff with h | h
  · right
    exact ⟨h.2, by simpa using h.1⟩
  · left
    exact ⟨h.2, by simpa using h.1⟩

/-- The same parity statement for the finite odd-ray cell set of an actual walk. -/
theorem horizontalEdge_oddRay_boundary_ofWalk
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r c : ℤ)
    (hodd : Odd (horizontalEdgeTraversalCount (m + 1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2) (r + 1) c)) :
    (false, (r + 1, c)) ∈ planeCellBoundary
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hclosed := walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv
  have hunit := walkSideInteriorBandFromWalk_coordinate_unit γ
  apply horizontalEdge_oddRay_boundary (m + 1) row col
    (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    hclosed.1 hclosed.2 hunit ?_ r c hodd
  intro a b
  simp only [Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
  rw [rightRayVerticalCrossingCount_eq_coordinateSum]

end Ising2DLambda.KacWard
