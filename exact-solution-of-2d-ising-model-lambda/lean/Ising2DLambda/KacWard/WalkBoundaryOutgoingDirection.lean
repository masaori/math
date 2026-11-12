import Ising2DLambda.KacWard.WalkInteriorSideConstant
import Ising2DLambda.KacWard.BoundaryVertexLocalTurn
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcludedOfWalk
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- When the actual walk keeps its interior on the left, the four-cell table
selects the direction of each outgoing step. -/
theorem vertexSimpleWalk_outgoing_direction_of_interior_left
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hleft : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = true)
    (j : Fin (m + 1)) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryOutgoing cells (row j.val) (col j.val) = 1) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryOutgoing cells (row j.val) (col j.val) = 3) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        cellBoundaryOutgoing cells (row j.val) (col j.val) = 0) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        cellBoundaryOutgoing cells (row j.val) (col j.val) = 2) := by
  classical
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing cells (row j.val) (col j.val) = 1) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing cells (row j.val) (col j.val) = 3) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      cellBoundaryOutgoing cells (row j.val) (col j.val) = 0) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      cellBoundaryOutgoing cells (row j.val) (col j.val) = 2)
  let hstep := vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt
  have hs := Classical.choose_spec hstep
  have hside := hleft j
  change Classical.choose hstep = true at hside
  rw [hside] at hs
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk,
      Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct (row j.val) (col j.val)
  rw [← hcell (row j.val - 1) (col j.val - 1),
    ← hcell (row j.val - 1) (col j.val),
    ← hcell (row j.val) (col j.val),
    ← hcell (row j.val) (col j.val - 1)] at hdiag
  have hdiag₁ : ¬ ((row j.val - 1, col j.val - 1) ∈ cells ∧
      (row j.val - 1, col j.val) ∉ cells ∧
      (row j.val, col j.val) ∈ cells ∧
      (row j.val, col j.val - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((row j.val - 1, col j.val - 1) ∉ cells ∧
      (row j.val - 1, col j.val) ∈ cells ∧
      (row j.val, col j.val) ∉ cells ∧
      (row j.val, col j.val - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hboundary : (row j.val, col j.val) ∈ cellBoundaryVertices cells := by
    have hmem := vertexSimpleWalk_step_mem_interiorBoundary
      γ hγ hh hv hdistinct j.val j.isLt
    change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        (true, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        (true, (row j.val - 1, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        (false, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        (false, (row j.val, col j.val - 1)) ∈ planeCellBoundary cells) at hmem
    rcases hmem with h | h | h | h
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
  rcases hs with h | h | h | h
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_outgoing_unique cells (row j.val) (col j.val)
      (1 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val, col j.val) ∈ cells ∧ (row j.val, col j.val - 1) ∉ cells
        exact ⟨hi.mpr rfl, fun h => by have := ho.mp h; contradiction⟩)
    exact Or.inl ⟨hr, hc, by simpa using hu.symm⟩
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_outgoing_unique cells (row j.val) (col j.val)
      (3 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val - 1, col j.val - 1) ∈ cells ∧
          (row j.val - 1, col j.val) ∉ cells
        exact ⟨hi.mpr rfl, fun h => by have := ho.mp h; contradiction⟩)
    exact Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩)
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_outgoing_unique cells (row j.val) (col j.val)
      (0 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val - 1, col j.val) ∈ cells ∧ (row j.val, col j.val) ∉ cells
        exact ⟨hi.mpr rfl, fun h => by have := ho.mp h; contradiction⟩)
    exact Or.inr (Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩))
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_outgoing_unique cells (row j.val) (col j.val)
      (2 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val, col j.val - 1) ∈ cells ∧
          (row j.val - 1, col j.val - 1) ∉ cells
        exact ⟨hi.mpr rfl, fun h => by have := ho.mp h; contradiction⟩)
    exact Or.inr (Or.inr (Or.inr ⟨hr, hc, by simpa using hu.symm⟩))

/-- When the actual walk keeps its interior on the right, the four-cell table
selects the reverse of the incoming direction at each starting vertex. -/
theorem vertexSimpleWalk_outgoing_direction_of_interior_right
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hright : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = false)
    (j : Fin (m + 1)) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryIncoming cells (row j.val) (col j.val) = 3) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryIncoming cells (row j.val) (col j.val) = 1) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        cellBoundaryIncoming cells (row j.val) (col j.val) = 2) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        cellBoundaryIncoming cells (row j.val) (col j.val) = 0) := by
  classical
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryIncoming cells (row j.val) (col j.val) = 3) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryIncoming cells (row j.val) (col j.val) = 1) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      cellBoundaryIncoming cells (row j.val) (col j.val) = 2) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      cellBoundaryIncoming cells (row j.val) (col j.val) = 0)
  let hstep := vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt
  have hs := Classical.choose_spec hstep
  have hside := hright j
  change Classical.choose hstep = false at hside
  rw [hside] at hs
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk,
      Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct (row j.val) (col j.val)
  rw [← hcell (row j.val - 1) (col j.val - 1),
    ← hcell (row j.val - 1) (col j.val),
    ← hcell (row j.val) (col j.val),
    ← hcell (row j.val) (col j.val - 1)] at hdiag
  have hdiag₁ : ¬ ((row j.val - 1, col j.val - 1) ∈ cells ∧
      (row j.val - 1, col j.val) ∉ cells ∧
      (row j.val, col j.val) ∈ cells ∧
      (row j.val, col j.val - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((row j.val - 1, col j.val - 1) ∉ cells ∧
      (row j.val - 1, col j.val) ∈ cells ∧
      (row j.val, col j.val) ∉ cells ∧
      (row j.val, col j.val - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hboundary : (row j.val, col j.val) ∈ cellBoundaryVertices cells := by
    have hmem := vertexSimpleWalk_step_mem_interiorBoundary
      γ hγ hh hv hdistinct j.val j.isLt
    change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        (true, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        (true, (row j.val - 1, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        (false, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        (false, (row j.val, col j.val - 1)) ∈ planeCellBoundary cells) at hmem
    rcases hmem with h | h | h | h
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
  rcases hs with h | h | h | h
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_incoming_unique cells (row j.val) (col j.val)
      (3 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val, col j.val - 1) ∈ cells ∧ (row j.val, col j.val) ∉ cells
        exact ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩)
    exact Or.inl ⟨hr, hc, by simpa using hu.symm⟩
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_incoming_unique cells (row j.val) (col j.val)
      (1 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val - 1, col j.val) ∈ cells ∧
          (row j.val - 1, col j.val - 1) ∉ cells
        exact ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩)
    exact Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩)
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_incoming_unique cells (row j.val) (col j.val)
      (2 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val, col j.val) ∈ cells ∧ (row j.val - 1, col j.val) ∉ cells
        exact ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩)
    exact Or.inr (Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩))
  · obtain ⟨hr, hc, hi, ho⟩ := h
    have hu := cellBoundary_incoming_unique cells (row j.val) (col j.val)
      (0 : Fin 4) hboundary hdiag₁ hdiag₂ (by
        change (row j.val - 1, col j.val - 1) ∈ cells ∧
          (row j.val, col j.val - 1) ∉ cells
        exact ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩)
    exact Or.inr (Or.inr (Or.inr ⟨hr, hc, by simpa using hu.symm⟩))

/-- The actual incoming direction at the next vertex agrees with the
four-cell table when the interior remains on the left. -/
theorem vertexSimpleWalk_incoming_direction_of_interior_left
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hleft : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = true)
    (j : Fin (m + 1)) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 1) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 3) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 0) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 2) := by
  classical
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 1) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 3) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 0) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      cellBoundaryIncoming cells (row (j.val + 1)) (col (j.val + 1)) = 2)
  have hmem := vertexSimpleWalk_step_mem_interiorBoundary
    γ hγ hh hv hdistinct j.val j.isLt
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val - 1, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      (false, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      (false, (row j.val, col j.val - 1)) ∈ planeCellBoundary cells) at hmem
  have hsource : (row j.val, col j.val) ∈ cellBoundaryVertices cells := by
    rcases hmem with h | h | h | h
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
  have htarget : (row (j.val + 1), col (j.val + 1)) ∈ cellBoundaryVertices cells := by
    rcases hmem with h | h | h | h
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct (row (j.val + 1)) (col (j.val + 1))
  rw [← hcell (row (j.val + 1) - 1) (col (j.val + 1) - 1),
    ← hcell (row (j.val + 1) - 1) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1) - 1)] at hdiag
  have hdiag₁ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∉ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  rcases vertexSimpleWalk_outgoing_direction_of_interior_left
    γ hγ hh hv hdistinct hleft j with h | h | h | h
  · obtain ⟨hr, hc, hout⟩ := h
    change row (j.val + 1) = row j.val + 1 at hr
    change col (j.val + 1) = col j.val at hc
    change cellBoundaryOutgoing cells (row j.val) (col j.val) = 1 at hout
    have ht := cellBoundary_south_outgoing_matches_next_incoming cells
      (row j.val) (col j.val) hsource (by simpa [hr, hc] using htarget)
      (by simpa [hr, hc, sub_sub] using hdiag₁) (by simpa [hr, hc, sub_sub] using hdiag₂) hout
    exact Or.inl ⟨hr, hc, by simpa [hr, hc] using ht⟩
  · obtain ⟨hr, hc, hout⟩ := h
    change row (j.val + 1) = row j.val - 1 at hr
    change col (j.val + 1) = col j.val at hc
    change cellBoundaryOutgoing cells (row j.val) (col j.val) = 3 at hout
    have ht := cellBoundary_north_outgoing_matches_next_incoming cells
      (row j.val) (col j.val) hsource (by simpa [hr, hc] using htarget)
      (by simpa [hr, hc, sub_sub] using hdiag₁) (by simpa [hr, hc, sub_sub] using hdiag₂) hout
    exact Or.inr (Or.inl ⟨hr, hc, by simpa [hr, hc] using ht⟩)
  · obtain ⟨hr, hc, hout⟩ := h
    change row (j.val + 1) = row j.val at hr
    change col (j.val + 1) = col j.val + 1 at hc
    change cellBoundaryOutgoing cells (row j.val) (col j.val) = 0 at hout
    have ht := cellBoundary_east_outgoing_matches_next_incoming cells
      (row j.val) (col j.val) hsource (by simpa [hr, hc] using htarget)
      (by simpa [hr, hc, sub_sub] using hdiag₁) (by simpa [hr, hc, sub_sub] using hdiag₂) hout
    exact Or.inr (Or.inr (Or.inl ⟨hr, hc, by simpa [hr, hc] using ht⟩))
  · obtain ⟨hr, hc, hout⟩ := h
    change row (j.val + 1) = row j.val at hr
    change col (j.val + 1) = col j.val - 1 at hc
    change cellBoundaryOutgoing cells (row j.val) (col j.val) = 2 at hout
    have ht := cellBoundary_west_outgoing_matches_next_incoming cells
      (row j.val) (col j.val) hsource (by simpa [hr, hc] using htarget)
      (by simpa [hr, hc, sub_sub] using hdiag₁) (by simpa [hr, hc, sub_sub] using hdiag₂) hout
    exact Or.inr (Or.inr (Or.inr ⟨hr, hc, by simpa [hr, hc] using ht⟩))

/-- At the endpoint of an actual step with interior on the right, the
four-cell table selects the direction opposite to that step. -/
theorem vertexSimpleWalk_incoming_direction_of_interior_right
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hright : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = false)
    (j : Fin (m + 1)) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 3) ∨
      (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
        cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 1) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
        cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 2) ∨
      (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
        cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 0) := by
  classical
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 3) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 1) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 2) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      cellBoundaryOutgoing cells (row (j.val + 1)) (col (j.val + 1)) = 0)
  let hstep := vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt
  have hs := Classical.choose_spec hstep
  have hside := hright j
  change Classical.choose hstep = false at hside
  rw [hside] at hs
  have hmem := vertexSimpleWalk_step_mem_interiorBoundary
    γ hγ hh hv hdistinct j.val j.isLt
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val - 1, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      (false, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      (false, (row j.val, col j.val - 1)) ∈ planeCellBoundary cells) at hmem
  have htarget : (row (j.val + 1), col (j.val + 1)) ∈ cellBoundaryVertices cells := by
    rcases hmem with h | h | h | h
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
    · rw [h.1, h.2.1]
      exact Finset.mem_biUnion.mpr ⟨_, h.2.2, by simp [gridEdgeEndpoints]⟩
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct (row (j.val + 1)) (col (j.val + 1))
  rw [← hcell (row (j.val + 1) - 1) (col (j.val + 1) - 1),
    ← hcell (row (j.val + 1) - 1) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1)),
    ← hcell (row (j.val + 1)) (col (j.val + 1) - 1)] at hdiag
  have hdiag₁ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((row (j.val + 1) - 1, col (j.val + 1) - 1) ∉ cells ∧
      (row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ∧
      (row (j.val + 1), col (j.val + 1)) ∉ cells ∧
      (row (j.val + 1), col (j.val + 1) - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  rcases hs with h | h | h | h
  · obtain ⟨hr, hc, hi, ho⟩ := h
    change row (j.val + 1) = row j.val + 1 at hr
    change col (j.val + 1) = col j.val at hc
    have hu := cellBoundary_outgoing_unique cells (row (j.val + 1)) (col (j.val + 1))
      (3 : Fin 4) htarget hdiag₁ hdiag₂ (by
        change (row (j.val + 1) - 1, col (j.val + 1) - 1) ∈ cells ∧
          (row (j.val + 1) - 1, col (j.val + 1)) ∉ cells
        simpa [hr, hc] using (show (row j.val, col j.val - 1) ∈ cells ∧
          (row j.val, col j.val) ∉ cells from
          ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩))
    exact Or.inl ⟨hr, hc, by simpa using hu.symm⟩
  · obtain ⟨hr, hc, hi, ho⟩ := h
    change row (j.val + 1) = row j.val - 1 at hr
    change col (j.val + 1) = col j.val at hc
    have hu := cellBoundary_outgoing_unique cells (row (j.val + 1)) (col (j.val + 1))
      (1 : Fin 4) htarget hdiag₁ hdiag₂ (by
        change (row (j.val + 1), col (j.val + 1)) ∈ cells ∧
          (row (j.val + 1), col (j.val + 1) - 1) ∉ cells
        simpa [hr, hc] using (show (row j.val - 1, col j.val) ∈ cells ∧
          (row j.val - 1, col j.val - 1) ∉ cells from
          ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩))
    exact Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩)
  · obtain ⟨hr, hc, hi, ho⟩ := h
    change row (j.val + 1) = row j.val at hr
    change col (j.val + 1) = col j.val + 1 at hc
    have hu := cellBoundary_outgoing_unique cells (row (j.val + 1)) (col (j.val + 1))
      (2 : Fin 4) htarget hdiag₁ hdiag₂ (by
        change (row (j.val + 1), col (j.val + 1) - 1) ∈ cells ∧
          (row (j.val + 1) - 1, col (j.val + 1) - 1) ∉ cells
        simpa [hr, hc] using (show (row j.val, col j.val) ∈ cells ∧
          (row j.val - 1, col j.val) ∉ cells from
          ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩))
    exact Or.inr (Or.inr (Or.inl ⟨hr, hc, by simpa using hu.symm⟩))
  · obtain ⟨hr, hc, hi, ho⟩ := h
    change row (j.val + 1) = row j.val at hr
    change col (j.val + 1) = col j.val - 1 at hc
    have hu := cellBoundary_outgoing_unique cells (row (j.val + 1)) (col (j.val + 1))
      (0 : Fin 4) htarget hdiag₁ hdiag₂ (by
        change (row (j.val + 1) - 1, col (j.val + 1)) ∈ cells ∧
          (row (j.val + 1), col (j.val + 1)) ∉ cells
        simpa [hr, hc] using (show (row j.val - 1, col j.val - 1) ∈ cells ∧
          (row j.val, col j.val - 1) ∉ cells from
          ⟨ho.mpr rfl, fun h => by have := hi.mp h; contradiction⟩))
    exact Or.inr (Or.inr (Or.inr ⟨hr, hc, by simpa using hu.symm⟩))

end Ising2DLambda.KacWard
