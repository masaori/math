import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- An odd number of vertical-edge traversals exposes that edge in the
boundary of the finite odd-ray cell set. -/
theorem verticalEdge_oddRay_boundary
    (n : ℕ) (row col : ℕ → ℤ) (cells : Finset GridCell)
    (hcell : ∀ r c : ℤ, (r, c) ∈ cells ↔ Odd (rightRayCrossingCount n row col r c))
    (r c : ℤ)
    (hodd : Odd (verticalEdgeTraversalCount n row col r (c + 1))) :
    (true, (r, c + 1)) ∈ planeCellBoundary cells := by
  have hsum := rightRayCrossingCount_adjacent n row col r c
  have hparity : (rightRayCrossingCount n row col r c) % 2 ≠
      (rightRayCrossingCount n row col r (c + 1)) % 2 := by
    have hv := Nat.odd_iff.mp hodd
    omega
  have hdiff : ((r, c) ∈ cells ∧ (r, c + 1) ∉ cells) ∨
      ((r, c) ∉ cells ∧ (r, c + 1) ∈ cells) := by
    rw [hcell r c, hcell r (c + 1)]
    simp only [Nat.odd_iff]
    omega
  have hedge : (true, (r, c + 1)) ∈ cellEdges cells := by
    apply (verticalEdge_mem_cellEdges_iff cells r (c + 1)).2
    rcases hdiff with h | h
    · right
      simpa using h.1
    · exact Or.inl h.2
  simp only [planeCellBoundary, Finset.mem_filter, hedge, ↓reduceIte, true_and]
  rcases hdiff with h | h
  · right
    exact ⟨h.2, by simpa using h.1⟩
  · left
    exact ⟨h.2, by simpa using h.1⟩

/-- The vertical boundary statement for the interior cells of an actual
closed edge sequence. -/
theorem verticalEdge_oddRay_boundary_ofWalk
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r c : ℤ)
    (hodd : Odd (verticalEdgeTraversalCount (m + 1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2) r (c + 1))) :
    (true, (r, c + 1)) ∈ planeCellBoundary
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset := by
  apply verticalEdge_oddRay_boundary (m + 1)
    (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
    (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2)
    (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset ?_ r c hodd
  intro a b
  simp only [Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
  rw [rightRayVerticalCrossingCount_eq_coordinateSum]

end Ising2DLambda.KacWard
