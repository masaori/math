import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A boundary edge has exactly one selected adjacent cell, which determines
whether the selected cell lies on the left of the chosen traversal. -/
theorem boundary_step_interior_side (leftCell rightCell : Bool) :
    leftCell ≠ rightCell ↔
      ∃ side : Bool, leftCell = side ∧ rightCell = !side := by
  cases leftCell <;> cases rightCell <;> simp_all

end Ising2DLambda.NecSuf.KacWard
