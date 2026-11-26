import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.KacWard.WalkVerticalBoundaryParity
import Ising2DLambda.KacWard.WalkStepEdgeTraversalOne
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

/-- `claim_vertically_adjacent_cells_boundary_parity` を実際の閉歩道について述べたもの。
零巻き付きから持ち上げの閉性を得て、座標の版に渡す。 -/
theorem verticallyAdjacentCells_boundaryParity_ofWalk
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (r c : ℤ) :
    (rightRayVerticalCrossingCount γ hγ r c +
      rightRayVerticalCrossingCount γ hγ (r + 1) c) % 2 =
        horizontalEdgeTraversalCount (m + 1)
          (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
          (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2) (r + 1) c % 2 := by
  -- 本文: 零巻き付きなので持ち上げの終点は始点に一致する。
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  rw [rightRayVerticalCrossingCount_eq_coordinateSum,
    rightRayVerticalCrossingCount_eq_coordinateSum]
  exact verticallyAdjacentCells_boundaryParity (m + 1) _ _ r c
    hclosed.1 hclosed.2 (liftedWalkCoordinates_unit γ)

/-- `claim_horizontal_walk_edge_odd_boundary`: 実際の閉歩道の有限な内側セル集合について、
奇数回通る横辺は境界辺である。 -/
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
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  have hcell : ∀ a b : ℤ,
      (a, b) ∈ cells ↔ Odd (rightRayVerticalCrossingCount γ hγ a b) := by
    intro a b
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
  -- 本文: 上下隣接の偶奇の主張と、共有横辺の通過回数が奇数であること。
  have hparity := verticallyAdjacentCells_boundaryParity_ofWalk γ hγ hh hv r c
  have hdiff : ((r, c) ∈ cells ∧ (r + 1, c) ∉ cells) ∨
      ((r, c) ∉ cells ∧ (r + 1, c) ∈ cells) := by
    rw [hcell r c, hcell (r + 1) c]
    simp only [Nat.odd_iff]
    have hh' := Nat.odd_iff.mp hodd
    omega
  -- 本文: 有限セル集合の境界辺の定義。
  have hedge : (false, (r + 1, c)) ∈ cellEdges cells := by
    apply (horizontalEdge_mem_cellEdges_iff cells (r + 1) c).2
    rcases hdiff with h | h
    · right
      simpa using h.1
    · exact Or.inl h.2
  change (false, (r + 1, c)) ∈ planeCellBoundary cells
  simp only [planeCellBoundary, Finset.mem_filter, hedge, Bool.false_eq_true,
    ↓reduceIte, true_and]
  rcases hdiff with h | h
  · right
    exact ⟨h.2, by simpa using h.1⟩
  · left
    exact ⟨h.2, by simpa using h.1⟩

/-- Every step of a simple closed lifted walk is an edge of its interior-cell boundary. -/
theorem vertexSimpleWalk_step_mem_interiorBoundary
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : ℕ) (hj : j < m + 1) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (row (j + 1) = row j + 1 ∧ col (j + 1) = col j ∧
      (true, (row j, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j - 1 ∧ col (j + 1) = col j ∧
      (true, (row j - 1, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j ∧ col (j + 1) = col j + 1 ∧
      (false, (row j, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j ∧ col (j + 1) = col j - 1 ∧
      (false, (row j, col j - 1)) ∈ planeCellBoundary cells) := by
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  have hle := liftedWalkCoordinates_incident_counts_le_one
    γ hγ hh hv hdistinct j hj
  have hstep := walkStep_edgeTraversal_one (m + 1) row col j hj
    (liftedWalkCoordinates_unit γ) hle
  rcases hstep with h | h | h | h
  · have ho : Odd (verticalEdgeTraversalCount (m + 1) row col (row j) (col j)) := by
      simp [h.2.2]
    exact Or.inl ⟨h.1, h.2.1, by
      simpa only [sub_add_cancel] using
        (verticalEdge_oddRay_boundary_ofWalk γ hγ hh hv (row j) (col j - 1)
          (by simpa [row, col] using ho))⟩
  · have ho : Odd (verticalEdgeTraversalCount (m + 1) row col (row j - 1) (col j)) := by
      simp [h.2.2]
    exact Or.inr (Or.inl ⟨h.1, h.2.1, by
      simpa only [sub_add_cancel] using
        (verticalEdge_oddRay_boundary_ofWalk γ hγ hh hv (row j - 1) (col j - 1)
          (by simpa [row, col] using ho))⟩)
  · have ho : Odd (horizontalEdgeTraversalCount (m + 1) row col (row j) (col j)) := by
      simp [h.2.2]
    exact Or.inr (Or.inr (Or.inl ⟨h.1, h.2.1, by
      simpa only [sub_add_cancel] using
        (horizontalEdge_oddRay_boundary_ofWalk γ hγ hh hv (row j - 1) (col j)
          (by simpa [row, col] using ho))⟩))
  · have ho : Odd (horizontalEdgeTraversalCount (m + 1) row col (row j) (col j - 1)) := by
      simp [h.2.2]
    exact Or.inr (Or.inr (Or.inr ⟨h.1, h.2.1, by
      simpa only [sub_add_cancel] using
        (horizontalEdge_oddRay_boundary_ofWalk γ hγ hh hv (row j - 1) (col j - 1)
          (by simpa [row, col] using ho))⟩))

end Ising2DLambda.KacWard
