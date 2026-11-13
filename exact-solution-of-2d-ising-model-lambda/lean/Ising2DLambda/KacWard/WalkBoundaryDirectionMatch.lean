import Ising2DLambda.KacWard.WalkBoundaryOutgoingDirection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- At a departure vertex, the direction of a walk that keeps its interior
on the left is the outgoing direction selected by the four-cell table. -/
theorem vertexSimpleWalk_outgoing_direction_eq_boundary_left
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
    directionNumber (γ j) =
      cellBoundaryOutgoing (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
        (planeLift γ j.castSucc).1 (planeLift γ j.castSucc).2 := by
  classical
  let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
  let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
  have h0 : Fin.ofNat (m + 2) j.val = j.castSucc := by
    apply Fin.ext
    simp
  have h1 : Fin.ofNat (m + 2) (j.val + 1) = j.succ := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : j.val + 1 < m + 2)]
  have hstep : orientedEdgeLatticeStep (γ j) =
      (row (j.val + 1) - row j.val, col (j.val + 1) - col j.val) := by
    have hs := planeLift_succ γ j
    rw [← h0, ← h1] at hs
    apply Prod.ext
    · have := congrArg Prod.fst hs
      dsimp [row] at *
      omega
    · have := congrArg Prod.snd hs
      dsimp [col] at *
      omega
  have hout := vertexSimpleWalk_outgoing_direction_of_interior_left
    γ hγ hh hv hdistinct hleft j
  change (row (j.val + 1) = row j.val + 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing _ (row j.val) (col j.val) = 1) ∨
    (row (j.val + 1) = row j.val - 1 ∧ col (j.val + 1) = col j.val ∧
      cellBoundaryOutgoing _ (row j.val) (col j.val) = 3) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val + 1 ∧
      cellBoundaryOutgoing _ (row j.val) (col j.val) = 0) ∨
    (row (j.val + 1) = row j.val ∧ col (j.val + 1) = col j.val - 1 ∧
      cellBoundaryOutgoing _ (row j.val) (col j.val) = 2) at hout
  rcases hout with h | h | h | h
  · obtain ⟨hr, hc, hd⟩ := h
    have hs : orientedEdgeLatticeStep (γ j) = (1, 0) := by
      rw [hstep]
      simp [hr, hc]
    rw [← orientedEdgeLatticeStep_direction, hs]
    simpa [row, col, h0, unitStepDirection] using hd.symm
  · obtain ⟨hr, hc, hd⟩ := h
    have hs : orientedEdgeLatticeStep (γ j) = (-1, 0) := by
      rw [hstep]
      simp [hr, hc]
    rw [← orientedEdgeLatticeStep_direction, hs]
    simpa [row, col, h0, unitStepDirection] using hd.symm
  · obtain ⟨hr, hc, hd⟩ := h
    have hs : orientedEdgeLatticeStep (γ j) = (0, 1) := by
      rw [hstep]
      simp [hr, hc]
    rw [← orientedEdgeLatticeStep_direction, hs]
    simpa [row, col, h0, unitStepDirection] using hd.symm
  · obtain ⟨hr, hc, hd⟩ := h
    have hs : orientedEdgeLatticeStep (γ j) = (0, -1) := by
      rw [hstep]
      simp [hr, hc]
    rw [← orientedEdgeLatticeStep_direction, hs]
    simpa [row, col, h0, unitStepDirection] using hd.symm

end Ising2DLambda.KacWard
