import Ising2DLambda.KacWard.InteriorCellsReachOddVerticalEdge
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

/-- A traversed vertical edge has a visited endpoint adjacent to its left cell. -/
theorem interiorCell_of_traversedVerticalEdge_mem_band
    (n : ℕ) (row col : ℕ → ℤ) (r g : ℤ)
    (hinside : (r, g - 1) ∈ oddRayInteriorCells n row col)
    (htraversed : 0 < verticalEdgeTraversalCount n row col r g) :
    (r, g - 1) ∈ walkSideInteriorBand n row col := by
  have hstep : ∃ k ∈ Finset.range n,
      crossesRowLevel row r k ∧ col k = g := by
    by_contra h
    have hzero : verticalEdgeTraversalCount n row col r g = 0 := by
      unfold verticalEdgeTraversalCount
      apply Finset.sum_eq_zero
      intro k hk
      have hk' : ¬ (crossesRowLevel row r k ∧ col k = g) := by
        intro hkg
        exact h ⟨k, hk, hkg⟩
      simp [hk']
    omega
  obtain ⟨k, hk, hrow, hcol⟩ := hstep
  have hendpoint : row k = r ∨ row k = r + 1 := by
    rcases hrow with h | h
    · exact Or.inl h.1
    · exact Or.inr h.1
  rcases hendpoint with hrowk | hrowk
  · refine ⟨k, Finset.mem_range.mp hk, ?_⟩
    change (r, g - 1) ∈ ({p | p = (row k - 1, col k - 1) ∨
      p = (row k - 1, col k) ∨ p = (row k, col k) ∨
      p = (row k, col k - 1)} ∩ oddRayInteriorCells n row col)
    exact ⟨Or.inr (Or.inr (Or.inr (by simp [hrowk, hcol]))), hinside⟩
  · refine ⟨k, Finset.mem_range.mp hk, ?_⟩
    change (r, g - 1) ∈ ({p | p = (row k - 1, col k - 1) ∨
      p = (row k - 1, col k) ∨ p = (row k, col k) ∨
      p = (row k, col k - 1)} ∩ oddRayInteriorCells n row col)
    exact ⟨Or.inl (by simp [hrowk, hcol]), hinside⟩

/-- A traversed vertical edge puts the adjacent interior cell in the actual walk's band. -/
theorem interiorCellOfWalk_of_traversedVerticalEdge_mem_band
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r g : ℤ)
    (hinside : (r, g - 1) ∈ oddRayInteriorCellsOfWalk γ hγ hh hv)
    (htraversed : 0 < verticalEdgeTraversalCount (m + 1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
      (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2) r g) :
    (r, g - 1) ∈ walkSideInteriorBandFromWalk γ hγ hh hv := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hinsideEq : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  rw [walkSideInteriorBandFromWalk_eq_coordinateBand γ hγ hh hv]
  exact interiorCell_of_traversedVerticalEdge_mem_band (m + 1) row col r g
    (hinsideEq ▸ hinside) htraversed

end Ising2DLambda.KacWard
