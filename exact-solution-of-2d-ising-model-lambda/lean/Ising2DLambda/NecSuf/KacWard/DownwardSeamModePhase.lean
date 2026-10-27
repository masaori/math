import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the period relation and the residue coordinate enter the forward vertical step. -/
theorem downwardSeam_modePhase_necSuf {F : Type*} [Monoid F]
    (L r : ℕ) (hL : 1 ≤ L) (hr : r < L) (σ z : F) (hz : z ^ L = σ) :
    (if r = L - 1 then σ else 1) * z ^ ((r + 1) % L) = z ^ (r + 1) := by
  by_cases hlast : r = L - 1
  · have hrnext : r + 1 = L := by omega
    simp only [if_pos hlast, hrnext, Nat.mod_self, pow_zero, mul_one, hz]
  · have hrnext : r + 1 < L := by omega
    simp only [if_neg hlast, Nat.mod_eq_of_lt hrnext, one_mul]

end Ising2DLambda.NecSuf.KacWard
