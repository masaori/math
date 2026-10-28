import Mathlib

namespace Ising2DLambda.KacWard

/-- Enumerating the four direction images gives precisely the permutations
whose selected entries do not point in the opposite direction. -/
theorem admissibleDirectionPermutations :
    ∀ σ : Equiv.Perm (ZMod 4), (∀ i : ZMod 4, σ i ≠ i + 2) ↔
      ((σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
      (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
      (σ 0 = 0 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 3) ∨
      (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
      (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
      (σ 0 = 1 ∧ σ 1 = 2 ∧ σ 2 = 3 ∧ σ 3 = 0) ∨
      (σ 0 = 3 ∧ σ 1 = 0 ∧ σ 2 = 1 ∧ σ 3 = 2) ∨
      (σ 0 = 3 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 0) ∨
      (σ 0 = 3 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 0)) := by
  decide

end Ising2DLambda.KacWard
