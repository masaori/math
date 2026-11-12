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

end Ising2DLambda.KacWard
