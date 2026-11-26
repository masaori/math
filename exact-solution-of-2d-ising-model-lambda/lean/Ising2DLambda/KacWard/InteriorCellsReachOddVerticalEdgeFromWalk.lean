import Ising2DLambda.KacWard.InteriorCellsReachOddVerticalEdge
import Ising2DLambda.KacWard.OddRayInteriorCells
import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum
import Ising2DLambda.KacWard.OneSidedClosureProjectionWindingFromWalk

namespace Ising2DLambda.KacWard

/-- An interior cell of the actual lifted walk reaches a traversed vertical edge
along a row of interior cells. -/
theorem oddRayInteriorCellsOfWalk_reachOddVerticalEdge {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r c : ℤ)
    (hinside : (r, c) ∈ oddRayInteriorCellsOfWalk γ hγ hh hv) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∃ g : ℤ, c < g ∧
      (∀ j : ℤ, c ≤ j → j < g → (r, j) ∈ oddRayInteriorCellsOfWalk γ hγ hh hv) ∧
      (r, g) ∉ oddRayInteriorCellsOfWalk γ hγ hh hv ∧
      Odd (verticalEdgeTraversalCount (m + 1) row col r g) ∧
      0 < verticalEdgeTraversalCount (m + 1) row col r g := by
  dsimp only
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  let cols := (Finset.range (m + 1)).image col
  have hcols : cols.Nonempty := Finset.image_nonempty.mpr
    ⟨0, Finset.mem_range.mpr (by omega)⟩
  let cMax := cols.max' hcols
  have hcol : ∀ k < m + 1, col k ≤ cMax := by
    intro k hk
    apply Finset.le_max' cols
    exact Finset.mem_image.mpr ⟨k, Finset.mem_range.mpr hk, rfl⟩
  have hodd : Odd (rightRayCrossingCount (m + 1) row col r c) := by
    change Odd (rightRayVerticalCrossingCount γ hγ r c) at hinside
    rwa [rightRayVerticalCrossingCount_eq_coordinateSum] at hinside
  obtain ⟨g, hcg, hrow, houtside, hoddEdge, hpositive⟩ :=
    interiorCells_reachOddVerticalEdge (m + 1) row col r c cMax hcol hodd
  refine ⟨g, hcg, ?_, ?_, hoddEdge, hpositive⟩
  · intro j hcj hjg
    change Odd (rightRayVerticalCrossingCount γ hγ r j)
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
    exact hrow j hcj hjg
  · change ¬ Odd (rightRayVerticalCrossingCount γ hγ r g)
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
    exact houtside

end Ising2DLambda.KacWard
