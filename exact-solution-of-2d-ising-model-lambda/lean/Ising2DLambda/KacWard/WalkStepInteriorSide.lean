import Ising2DLambda.KacWard.WalkHorizontalBoundaryParity

namespace Ising2DLambda.KacWard

/-- For each actual step, exactly one of its adjacent cells is interior;
`left = true` records that the interior cell lies to its left. -/
theorem vertexSimpleWalk_step_interior_side
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
    ∃ left : Bool,
      (row (j + 1) = row j + 1 ∧ col (j + 1) = col j ∧
        ((row j, col j) ∈ cells ↔ left = true) ∧
        ((row j, col j - 1) ∈ cells ↔ left = false)) ∨
      (row (j + 1) = row j - 1 ∧ col (j + 1) = col j ∧
        ((row j - 1, col j - 1) ∈ cells ↔ left = true) ∧
        ((row j - 1, col j) ∈ cells ↔ left = false)) ∨
      (row (j + 1) = row j ∧ col (j + 1) = col j + 1 ∧
        ((row j - 1, col j) ∈ cells ↔ left = true) ∧
        ((row j, col j) ∈ cells ↔ left = false)) ∨
      (row (j + 1) = row j ∧ col (j + 1) = col j - 1 ∧
        ((row j, col j - 1) ∈ cells ↔ left = true) ∧
        ((row j - 1, col j - 1) ∈ cells ↔ left = false)) := by
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  have hstep := vertexSimpleWalk_step_mem_interiorBoundary γ hγ hh hv hdistinct j hj
  change (row (j + 1) = row j + 1 ∧ col (j + 1) = col j ∧
      (true, (row j, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j - 1 ∧ col (j + 1) = col j ∧
      (true, (row j - 1, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j ∧ col (j + 1) = col j + 1 ∧
      (false, (row j, col j)) ∈ planeCellBoundary cells) ∨
    (row (j + 1) = row j ∧ col (j + 1) = col j - 1 ∧
      (false, (row j, col j - 1)) ∈ planeCellBoundary cells) at hstep
  rcases hstep with h | h | h | h
  · have hs := (Finset.mem_filter.mp h.2.2).2
    dsimp at hs
    rcases hs with hs | hs
    · refine ⟨true, Or.inl ⟨h.1, h.2.1, ?_, ?_⟩⟩
      · simpa [row, col, cells] using hs.1
      · simpa [row, col, cells] using hs.2
    · refine ⟨false, Or.inl ⟨h.1, h.2.1, ?_, ?_⟩⟩
      · simpa [row, col, cells] using hs.1
      · simpa [row, col, cells] using hs.2
  · have hs := (Finset.mem_filter.mp h.2.2).2
    dsimp at hs
    rcases hs with hs | hs
    · refine ⟨false, Or.inr (Or.inl ⟨h.1, h.2.1, ?_, ?_⟩)⟩
      · simpa [row, col, cells] using hs.2
      · simpa [row, col, cells] using hs.1
    · refine ⟨true, Or.inr (Or.inl ⟨h.1, h.2.1, ?_, ?_⟩)⟩
      · simpa [row, col, cells] using hs.2
      · simpa [row, col, cells] using hs.1
  · have hs := (Finset.mem_filter.mp h.2.2).2
    dsimp at hs
    rcases hs with hs | hs
    · refine ⟨false, Or.inr (Or.inr (Or.inl ⟨h.1, h.2.1, ?_, ?_⟩))⟩
      · simpa [row, col, cells] using hs.2
      · simpa [row, col, cells] using hs.1
    · refine ⟨true, Or.inr (Or.inr (Or.inl ⟨h.1, h.2.1, ?_, ?_⟩))⟩
      · simpa [row, col, cells] using hs.2
      · simpa [row, col, cells] using hs.1
  · have hs := (Finset.mem_filter.mp h.2.2).2
    dsimp at hs
    rcases hs with hs | hs
    · refine ⟨true, Or.inr (Or.inr (Or.inr ⟨h.1, h.2.1, ?_, ?_⟩))⟩
      · simpa [row, col, cells] using hs.1
      · simpa [row, col, cells] using hs.2
    · refine ⟨false, Or.inr (Or.inr (Or.inr ⟨h.1, h.2.1, ?_, ?_⟩))⟩
      · simpa [row, col, cells] using hs.1
      · simpa [row, col, cells] using hs.2

end Ising2DLambda.KacWard
