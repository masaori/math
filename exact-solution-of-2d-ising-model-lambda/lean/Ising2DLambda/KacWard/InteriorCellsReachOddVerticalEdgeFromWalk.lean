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

/-- The actual one-sided closure satisfies the row-reach condition for every
interior cell of its projected edge sequence. -/
theorem oneSidedClosureProjectionFromWalk_interior_reachesOddVerticalEdge
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let Γ : Fin (N - 1 + 1) → OrientedEdge L := fun j =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
      ∃ (hΓ : closedNonbacktrackingWalk Γ)
        (hh : horizontalDirectedWindingNumber Γ = 0)
        (hv : verticalDirectedWindingNumber Γ = 0),
        ∀ r c : ℤ, (r, c) ∈ oddRayInteriorCellsOfWalk Γ hΓ hh hv →
          let row : ℕ → ℤ := fun j => (planeLift Γ (Fin.ofNat (N - 1 + 2) j)).1
          let col : ℕ → ℤ := fun j => (planeLift Γ (Fin.ofNat (N - 1 + 2) j)).2
          ∃ g : ℤ, c < g ∧
            (∀ j : ℤ, c ≤ j → j < g →
              (r, j) ∈ oddRayInteriorCellsOfWalk Γ hΓ hh hv) ∧
            (r, g) ∉ oddRayInteriorCellsOfWalk Γ hΓ hh hv ∧
            Odd (verticalEdgeTraversalCount (N - 1 + 1) row col r g) ∧
            0 < verticalEdgeTraversalCount (N - 1 + 1) row col r g := by
  obtain ⟨k₀, hprojection⟩ :=
    oneSidedClosureProjectionFromWalk_winding_zero γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hprojection t c ht hc
  dsimp only at hp ⊢
  refine ⟨hp.1, hp.2.2, hp.2.1, ?_⟩
  intro r c' hinside
  exact oddRayInteriorCellsOfWalk_reachOddVerticalEdge _ hp.1 hp.2.2 hp.2.1 r c' hinside

end Ising2DLambda.KacWard
