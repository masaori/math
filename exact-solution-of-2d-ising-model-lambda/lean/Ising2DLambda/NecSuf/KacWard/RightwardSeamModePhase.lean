import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the period relation and the residue coordinate enter the forward step. -/
theorem rightwardSeam_modePhase_necSuf {F : Type*} [Monoid F]
    (L c : ℕ) (hL : 1 ≤ L) (hc : c < L) (σ z : F) (hz : z ^ L = σ) :
    (if c = L - 1 then σ else 1) * z ^ ((c + 1) % L) = z ^ (c + 1) := by
  by_cases hlast : c = L - 1
  · have hcnext : c + 1 = L := by omega
    simp only [if_pos hlast, hcnext, Nat.mod_self, pow_zero, mul_one, hz]
  · have hcnext : c + 1 < L := by omega
    simp only [if_neg hlast, Nat.mod_eq_of_lt hcnext, one_mul]

end Ising2DLambda.NecSuf.KacWard
