import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A representative of a cyclic successor wraps to zero at the last residue. -/
theorem cyclicRepresentative_increment (L : ℕ) (r : ℕ) (hr : r < L) :
    (((r + 1) % L : ℕ) : ℤ) = if (r : ℤ) ≤ (L : ℤ) - 2 then (r : ℤ) + 1 else 0 := by
  by_cases h : (r : ℤ) ≤ (L : ℤ) - 2
  · have hlt : r + 1 < L := by omega
    rw [Nat.mod_eq_of_lt hlt]
    simp [h]
  · have heq : r + 1 = L := by omega
    rw [heq, Nat.mod_self]
    simp [h]

end Ising2DLambda.NecSuf.KacWard
