import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A parity-changing summand makes the two endpoint cells differ. -/
theorem odd_traversal_separates_cells (left right traversals : ℕ)
    (hsum : left = right + traversals) (hodd : Odd traversals) :
    Odd left ≠ Odd right := by
  have hv := Nat.odd_iff.mp hodd
  intro heq
  have ha : left % 2 = right % 2 := by
    by_cases hl : Odd left <;> by_cases hr : Odd right <;>
      simp_all [Nat.odd_iff]
  omega

/-- A step uses one of four distinct incident edges. When every incident edge
is used at most once, its positive traversal count is odd, so it lies in the
corresponding cell boundary. -/
theorem simple_step_boundary_of_four_cases
    (north south east west : ℕ)
    (northBoundary southBoundary eastBoundary westBoundary : Prop)
    (hstep : 0 < north ∨ 0 < south ∨ 0 < east ∨ 0 < west)
    (hle : north ≤ 1 ∧ south ≤ 1 ∧ east ≤ 1 ∧ west ≤ 1)
    (hboundaryNorth : Odd north → northBoundary)
    (hboundarySouth : Odd south → southBoundary)
    (hboundaryEast : Odd east → eastBoundary)
    (hboundaryWest : Odd west → westBoundary) :
    northBoundary ∨ southBoundary ∨ eastBoundary ∨ westBoundary := by
  rcases hstep with hn | hs | he | hw
  · left
    apply hboundaryNorth
    have h : north = 1 := by omega
    simp [h]
  · right; left
    apply hboundarySouth
    have h : south = 1 := by omega
    simp [h]
  · right; right; left
    apply hboundaryEast
    have h : east = 1 := by omega
    simp [h]
  · right; right; right
    apply hboundaryWest
    have h : west = 1 := by omega
    simp [h]

end Ising2DLambda.NecSuf.KacWard
