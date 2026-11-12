import Ising2DLambda.KacWard.WalkHorizontalBoundaryParity
import Ising2DLambda.KacWard.CellBoundaryVertices
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Every departure point of the actual simple closed lifted walk is a vertex
of the boundary of its interior cells. -/
theorem vertexSimpleWalk_liftPoint_mem_boundaryVertices
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : Fin (m + 1)) :
    planeLift γ j.castSucc ∈ cellBoundaryVertices
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset := by
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  have hj : j.val < m + 1 := j.isLt
  have hstep := vertexSimpleWalk_step_mem_interiorBoundary
    γ hγ hh hv hdistinct j.val hj
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      (true, (row j.val - 1, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      (false, (row j.val, col j.val)) ∈ planeCellBoundary cells) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      (false, (row j.val, col j.val - 1)) ∈ planeCellBoundary cells) at hstep
  have hindex : Fin.ofNat (m + 2) j.val = j.castSucc := by
    apply Fin.ext
    simp
  have hpoint : (row j.val, col j.val) ∈ cellBoundaryVertices cells := by
    rcases hstep with h | h | h | h
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2,
        by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2,
        by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2,
        by simp [gridEdgeEndpoints]⟩
    · exact Finset.mem_biUnion.mpr ⟨_, h.2.2,
        by simp [gridEdgeEndpoints]⟩
  simpa only [row, col, hindex, Prod.mk.eta, cells] using hpoint

/-- An edge of the actual finite interior-cell boundary is crossed an odd
number of times by the lifted walk. -/
theorem interiorCellsOfWalk_boundaryEdge_odd_traversal
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (edge : GridEdge)
    (hedge : edge ∈ planeCellBoundary
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    if edge.1 then
      Odd (verticalEdgeTraversalCount (m + 1) row col edge.2.1 edge.2.2)
    else
      Odd (horizontalEdgeTraversalCount (m + 1) row col edge.2.1 edge.2.2) := by
  dsimp only
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  have hcell (r c : ℤ) : (r, c) ∈ cells ↔
      Odd (rightRayCrossingCount (m + 1) row col r c) := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk,
      Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  rcases edge with ⟨axis, ⟨r, c⟩⟩
  cases axis
  · have hdiff := (Finset.mem_filter.mp hedge).2
    dsimp at hdiff
    have hparity := verticallyAdjacentCells_boundaryParity
      (m + 1) row col (r - 1) c
      (walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv).1
      (walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv).2
      (walkSideInteriorBandFromWalk_coordinate_unit γ)
    simp only [sub_add_cancel] at hparity
    rw [hcell r c, hcell (r - 1) c] at hdiff
    simp only [Nat.odd_iff] at hdiff ⊢
    change horizontalEdgeTraversalCount (m + 1) row col r c % 2 = 1
    omega
  · have hdiff := (Finset.mem_filter.mp hedge).2
    dsimp at hdiff
    have hparity := rightRayCrossingCount_adjacent
      (m + 1) row col r (c - 1)
    simp only [sub_add_cancel] at hparity
    rw [hcell r c, hcell r (c - 1)] at hdiff
    simp only [Nat.odd_iff] at hdiff ⊢
    change verticalEdgeTraversalCount (m + 1) row col r c % 2 = 1
    omega

end Ising2DLambda.KacWard
