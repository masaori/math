import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the cyclic four element direction set is required for this support
classification; no coefficient field is needed. -/
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

end Ising2DLambda.NecSuf.KacWard
