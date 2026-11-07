import Ising2DLambda.KacWard.InteriorCellsReachOddVerticalEdgeFromWalk
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The consecutive interior cells in a row give a finite edge path. -/
theorem interiorRow_path (S : Set (ℤ × ℤ)) (r c g : ℤ)
    (hcg : c < g)
    (hrow : ∀ j : ℤ, c ≤ j → j < g → (r, j) ∈ S) :
    Relation.ReflTransGen
      (fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b)
      (r, c) (r, g - 1) := by
  let step := fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b
  have hpath : ∀ d : ℕ, c + (d : ℤ) < g →
      Relation.ReflTransGen step (r, c) (r, c + d) := by
    intro d
    induction d with
    | zero =>
        intro _
        simpa using (Relation.ReflTransGen.refl :
          Relation.ReflTransGen step (r, c) (r, c))
    | succ d ih =>
        intro hbound
        have hprev : c + (d : ℤ) < g := by omega
        have hnext : c + ((d + 1 : ℕ) : ℤ) < g := hbound
        have hsingle : Relation.ReflTransGen step
            (r, c + (d : ℤ)) (r, c + ((d + 1 : ℕ) : ℤ)) := by
          apply Relation.ReflTransGen.single
          refine ⟨hrow _ (by omega) hprev, hrow _ (by omega) hnext, ?_⟩
          left
          constructor
          · rfl
          · right
            omega
        exact (ih hprev).trans hsingle
  have hnonneg : 0 ≤ g - 1 - c := by omega
  have htarget : c + ((Int.toNat (g - 1 - c) : ℕ) : ℤ) = g - 1 := by
    omega
  simpa only [htarget] using hpath (Int.toNat (g - 1 - c)) (by omega)

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

/-- Every interior cell of the actual closed walk reaches its interior band along its row. -/
theorem interiorCellOfWalk_reaches_band {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r c : ℤ)
    (hinside : (r, c) ∈ oddRayInteriorCellsOfWalk γ hγ hh hv) :
    ∃ b ∈ walkSideInteriorBandFromWalk γ hγ hh hv,
      Relation.ReflTransGen
        (fun a b => a ∈ oddRayInteriorCellsOfWalk γ hγ hh hv ∧
          b ∈ oddRayInteriorCellsOfWalk γ hγ hh hv ∧ CellEdgeAdjacent a b)
        (r, c) b := by
  obtain ⟨g, hcg, hrow, _, _, htraversed⟩ :=
    oddRayInteriorCellsOfWalk_reachOddVerticalEdge γ hγ hh hv r c hinside
  have hlast : (r, g - 1) ∈ oddRayInteriorCellsOfWalk γ hγ hh hv :=
    hrow (g - 1) (by omega) (by omega)
  refine ⟨(r, g - 1),
    interiorCellOfWalk_of_traversedVerticalEdge_mem_band γ hγ hh hv r g
      hlast htraversed, ?_⟩
  exact interiorRow_path _ r c g hcg hrow

/-- Every interior cell of a one-sided closure projection reaches its interior band. -/
theorem oneSidedClosureProjectionFromWalk_interior_reaches_band
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
        ∀ p ∈ oddRayInteriorCellsOfWalk Γ hΓ hh hv,
          ∃ b ∈ walkSideInteriorBandFromWalk Γ hΓ hh hv,
            Relation.ReflTransGen
              (fun a b => a ∈ oddRayInteriorCellsOfWalk Γ hΓ hh hv ∧
                b ∈ oddRayInteriorCellsOfWalk Γ hΓ hh hv ∧ CellEdgeAdjacent a b)
              p b := by
  obtain ⟨k₀, hprojection⟩ :=
    oneSidedClosureProjectionFromWalk_winding_zero γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hprojection t c ht hc
  dsimp only at hp ⊢
  refine ⟨hp.1, hp.2.2, hp.2.1, ?_⟩
  rintro ⟨r, c'⟩ hinside
  exact interiorCellOfWalk_reaches_band _ hp.1 hp.2.2 hp.2.1 r c' hinside

end Ising2DLambda.KacWard
