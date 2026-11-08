import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A binary adjacent-row parity selects the edge exactly when one height is one. -/
theorem binaryHeight_horizontal_edge (top bottom edge : ZMod 2)
    (hjump : top + bottom = edge) :
    ((top = 1 ∧ bottom ≠ 1) ∨ (top ≠ 1 ∧ bottom = 1)) ↔ edge = 1 := by
  have hcases (x : ZMod 2) : x = 0 ∨ x = 1 := by
    fin_cases x <;> first | exact Or.inl rfl | exact Or.inr rfl
  rcases hcases top with ht | ht <;>
  rcases hcases bottom with hb | hb <;>
  rcases hcases edge with he | he <;>
  simp [ht, hb, he] at hjump ⊢

end Ising2DLambda.NecSuf.KacWard
