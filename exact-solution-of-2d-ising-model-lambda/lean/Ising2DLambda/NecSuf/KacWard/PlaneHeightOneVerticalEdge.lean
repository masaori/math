import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A binary height jump selects its shared edge exactly when one endpoint has height one. -/
theorem binaryHeight_vertical_edge (left right edge : ZMod 2)
    (hjump : left = right + edge) :
    ((left = 1 ∧ right ≠ 1) ∨ (left ≠ 1 ∧ right = 1)) ↔ edge = 1 := by
  have hcases (x : ZMod 2) : x = 0 ∨ x = 1 := by
    fin_cases x <;> first | exact Or.inl rfl | exact Or.inr rfl
  rcases hcases right with hr | hr <;>
  rcases hcases edge with he | he <;>
  simp [hjump, hr, he]

end Ising2DLambda.NecSuf.KacWard
