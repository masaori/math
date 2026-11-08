import Ising2DLambda.KacWard.ExteriorCellSetEdgeConnected
import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum

namespace Ising2DLambda.KacWard

/-- 実際の零巻き付き閉歩道の平面持ち上げから四端と最大列の添字を選ぶ。 -/
theorem exteriorCellOfWalk_boundingRectangle_endpoints {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∃ rMin rMax cMin cMax : ℤ,
      (∀ k ≤ m + 1, rMin ≤ row k ∧ row k ≤ rMax) ∧
      (∀ k < m + 1, cMin ≤ col k ∧ col k ≤ cMax) ∧
      (∃ k < m + 1, col k = cMax) := by
  dsimp only
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hclosedRow : row (m + 1) = row 0 := by
    have h := planeLift_endpoint_winding γ hγ
    rw [hv, hh] at h
    have h' := congrArg Prod.fst h
    simpa [row] using h'
  exact closedLift_boundingRectangle_endpoints (m + 1) row col
    (by omega) hclosedRow

/-- The rectangle selected from the actual lift contains every odd-ray interior cell. -/
theorem outsideBoundingRectangle_subset_exteriorCellsOfWalk {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (rMin rMax cMin cMax : ℤ)
    (hrow : ∀ k ≤ m + 1,
      rMin ≤ (planeLift γ (Fin.ofNat (m + 2) k)).1 ∧
      (planeLift γ (Fin.ofNat (m + 2) k)).1 ≤ rMax)
    (hcol : ∀ k < m + 1,
      cMin ≤ (planeLift γ (Fin.ofNat (m + 2) k)).2 ∧
      (planeLift γ (Fin.ofNat (m + 2) k)).2 ≤ cMax) :
    outsideBoundingRectangle rMin rMax cMin cMax ⊆
      (oddRayInteriorCellsOfWalk γ hγ hh hv)ᶜ := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hclosedRow : row (m + 1) = row 0 := by
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
  have hinside : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  rw [hinside]
  exact outsideBoundingRectangle_subset_exteriorCells
    (m + 1) row col rMin rMax cMin cMax
    (by simpa only [row] using hrow) (by simpa only [col] using hcol)
    hclosedRow hstep

/-- The exterior band of a closed walk agrees with the band of its integer-indexed lift. -/
theorem walkSideExteriorBandFromWalk_eq_coordinateBand {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    walkSideExteriorBandFromWalk γ hγ hh hv =
      walkSideExteriorBand (m + 1) row col := by
  dsimp only
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hinside : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  ext p
  constructor
  · rintro ⟨hpOutside, k, hpCorner⟩
    have hk : Fin.ofNat (m + 2) k.val = k.castSucc := by
      apply Fin.ext
      simp
    refine ⟨k.val, k.isLt, ?_⟩
    change (p = (row k.val - 1, col k.val - 1) ∨
      p = (row k.val - 1, col k.val) ∨
      p = (row k.val, col k.val) ∨
      p = (row k.val, col k.val - 1)) ∧
      p ∉ oddRayInteriorCells (m + 1) row col
    exact ⟨by simpa only [row, col, hk] using hpCorner, hinside ▸ hpOutside⟩
  · rintro ⟨k, hk, hpCorner, hpOutside⟩
    let i : Fin (m + 1) := ⟨k, hk⟩
    have hi : Fin.ofNat (m + 2) k = i.castSucc := by
      apply Fin.ext
      simp [i, Nat.mod_eq_of_lt (by omega : k < m + 2)]
    refine ⟨hinside ▸ hpOutside, i, ?_⟩
    simpa only [row, col, i, hi, Set.mem_setOf_eq, Prod.mk.eta] using hpCorner

/-- An exterior cell of the actual walk reaches the outer rectangle or its exterior band. -/
theorem exteriorCellOfWalk_reaches_outer_core {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (rMin rMax cMin cMax : ℤ) (r c : ℤ)
    (hbelow : c < cMax)
    (houtside : (r, c) ∉ oddRayInteriorCellsOfWalk γ hγ hh hv) :
    ∃ b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∪
        walkSideExteriorBandFromWalk γ hγ hh hv,
      Relation.ReflTransGen
        (fun a b => a ∉ oddRayInteriorCellsOfWalk γ hγ hh hv ∧
          b ∉ oddRayInteriorCellsOfWalk γ hγ hh hv ∧ CellEdgeAdjacent a b)
        (r, c) b := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hinside : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  have hband := walkSideExteriorBandFromWalk_eq_coordinateBand γ hγ hh hv
  dsimp only at hband
  rw [hinside] at houtside ⊢
  rw [hband]
  exact exteriorCell_reaches_outer_core (m + 1) row col
    rMin rMax cMin cMax r c hbelow houtside

end Ising2DLambda.KacWard
