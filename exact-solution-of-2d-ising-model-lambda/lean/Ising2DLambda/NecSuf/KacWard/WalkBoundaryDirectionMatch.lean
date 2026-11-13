import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- The four direction pairs in a right-hand boundary table differ by two modulo four.
The table pairs are required because the direction and boundary maps are otherwise arbitrary. -/
theorem right_boundary_direction_match
    {I : Type*} (direction boundary : I → ZMod 4)
    (hcases : ∀ j, (direction j = 1 ∧ boundary j = 3) ∨
      (direction j = 3 ∧ boundary j = 1) ∨
      (direction j = 0 ∧ boundary j = 2) ∨
      (direction j = 2 ∧ boundary j = 0))
    (j : I) : direction j + 2 = boundary j := by
  rcases hcases j with h | h | h | h
  · rcases h with ⟨hd, hb⟩
    rw [hd, hb]
    decide
  · rcases h with ⟨hd, hb⟩
    rw [hd, hb]
    decide
  · rcases h with ⟨hd, hb⟩
    rw [hd, hb]
    decide
  · rcases h with ⟨hd, hb⟩
    rw [hd, hb]
    decide

end Ising2DLambda.NecSuf.KacWard
