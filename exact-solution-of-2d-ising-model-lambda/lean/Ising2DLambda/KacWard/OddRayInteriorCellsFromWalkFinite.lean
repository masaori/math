import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum
import Ising2DLambda.KacWard.OddRayInteriorCells
import Ising2DLambda.KacWard.PlaneLiftEndpointWinding
import Ising2DLambda.KacWard.OneSidedClosureProjectionWindingFromWalk

namespace Ising2DLambda.KacWard

/-- The actual lift has finitely many vertices, so its row and column coordinates
have bounds. The ray parity proof uses the row endpoint and unit steps. -/
theorem oddRayInteriorCellsOfWalk_finite {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    (oddRayInteriorCellsOfWalk γ hγ hh hv).Finite := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  let rows := (Finset.range (m + 2)).image row
  let cols := (Finset.range (m + 2)).image col
  have hrows : rows.Nonempty := Finset.image_nonempty.mpr
    ⟨0, Finset.mem_range.mpr (by omega)⟩
  have hcols : cols.Nonempty := Finset.image_nonempty.mpr
    ⟨0, Finset.mem_range.mpr (by omega)⟩
  let rMin := rows.min' hrows
  let rMax := rows.max' hrows
  let cMin := cols.min' hcols
  let cMax := cols.max' hcols
  have hrow : ∀ k ≤ m + 1, rMin ≤ row k ∧ row k ≤ rMax := by
    intro k hk
    have hmem : row k ∈ rows := Finset.mem_image.mpr
      ⟨k, Finset.mem_range.mpr (by omega), rfl⟩
    exact ⟨Finset.min'_le rows _ hmem, Finset.le_max' rows _ hmem⟩
  have hcol : ∀ k < m + 1, cMin ≤ col k ∧ col k ≤ cMax := by
    intro k hk
    have hmem : col k ∈ cols := Finset.mem_image.mpr
      ⟨k, Finset.mem_range.mpr (by omega), rfl⟩
    exact ⟨Finset.min'_le cols _ hmem, Finset.le_max' cols _ hmem⟩
  have hclosed : row (m + 1) = row 0 := by
    have h := planeLift_endpoint_winding γ hγ
    rw [hv, hh] at h
    have h' := congrArg Prod.fst h
    simpa [row] using h'
  have hstep : ∀ k < m + 1, row (k + 1) - row k = -1 ∨
      row (k + 1) - row k = 0 ∨ row (k + 1) - row k = 1 := by
    intro k hk
    have h0 : Fin.ofNat (m + 2) k = (⟨k, by omega⟩ : Fin (m + 1)).castSucc := by
      apply Fin.ext
      simp [Nat.mod_eq_of_lt (by omega : k < m + 2)]
    have h1 : Fin.ofNat (m + 2) (k + 1) = (⟨k, by omega⟩ : Fin (m + 1)).succ := by
      apply Fin.ext
      simp [Nat.mod_eq_of_lt (by omega : k + 1 < m + 2)]
    have hs := planeLift_succ γ (⟨k, hk⟩ : Fin (m + 1))
    have hu := orientedEdgeLatticeStep_unit (γ (⟨k, hk⟩ : Fin (m + 1)))
    have hsrow : row (k + 1) = row k + (orientedEdgeLatticeStep (γ ⟨k, hk⟩)).1 := by
      simpa only [row, h0, h1, Prod.fst_add] using congrArg Prod.fst hs
    rcases hu with hu | hu | hu | hu <;>
      rw [hu] at hsrow <;> simp only at hsrow <;> omega
  have hfinite := oddRayInteriorCells_finite (m + 1) row col
    rMin rMax cMin cMax hrow hcol hclosed hstep
  have heq : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  rw [heq]
  exact hfinite


/-- The projected edge sequence of an actual one-sided closure has only finitely
many odd-ray interior cells. -/
theorem oneSidedClosureProjectionFromWalk_interior_finite {L m : ℕ} [NeZero L]
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
        (oddRayInteriorCellsOfWalk Γ hΓ hh hv).Finite := by
  obtain ⟨k₀, hprojection⟩ :=
    oneSidedClosureProjectionFromWalk_winding_zero γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hprojection t c ht hc
  dsimp only at hp ⊢
  exact ⟨hp.1, hp.2.2, hp.2.1,
    oddRayInteriorCellsOfWalk_finite _ hp.1 hp.2.2 hp.2.1⟩

end Ising2DLambda.KacWard
