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

end Ising2DLambda.NecSuf.KacWard
