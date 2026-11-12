import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the local turn table and finite counting are needed for the sum. -/
theorem boundary_turn_sum {V : Type*} [DecidableEq V]
    (B : Finset V) (n : V → ℕ) (turn : V → ℤ)
    (hlocal : ∀ v ∈ B,
      turn v = -(if n v = 1 then (1 : ℤ) else 0) +
        (if n v = 3 then (1 : ℤ) else 0)) :
    (∑ v ∈ B, turn v) =
      ((B.filter fun v => n v = 3).card : ℤ) -
        (B.filter fun v => n v = 1).card := by
  calc
    (∑ v ∈ B, turn v) =
        ∑ v ∈ B, (-(if n v = 1 then (1 : ℤ) else 0) +
          (if n v = 3 then (1 : ℤ) else 0)) := by
            apply Finset.sum_congr rfl
            exact hlocal
    _ = ((B.filter fun v => n v = 3).card : ℤ) -
        (B.filter fun v => n v = 1).card := by
          simp [Finset.sum_add_distrib, sub_eq_add_neg]
          abel

end Ising2DLambda.NecSuf.KacWard
