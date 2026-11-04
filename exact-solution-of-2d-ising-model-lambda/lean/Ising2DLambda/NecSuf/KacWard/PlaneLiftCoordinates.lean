import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- An integer lift has a coordinate equal to the chosen endpoint representative
    plus the accumulated seam corrections. -/
theorem lift_coordinates_necSuf (m : ℕ) (L : ℤ)
    (p v : Fin (m + 2) → ℤ) (d c : Fin (m + 1) → ℤ)
    (hzero : p 0 = v 0)
    (hp : ∀ k : Fin (m + 1), p k.succ = p k.castSucc + d k)
    (hv : ∀ k : Fin (m + 1), v k.succ - v k.castSucc = d k - L * c k)
    (k : Fin (m + 2)) :
    p k = v k + L * ∑ t ∈ Finset.range k.val, c (Fin.ofNat (m + 1) t) := by
  induction k using Fin.induction with
  | zero => simpa using hzero
  | succ k ih =>
    have hfin : Fin.ofNat (m + 1) k.val = k := by
      apply Fin.ext
      simp [Fin.ofNat, Nat.mod_eq_of_lt k.isLt]
    rw [hp k, ih]
    simp only [Fin.val_succ, Fin.val_castSucc, Finset.sum_range_succ, hfin]
    have h := hv k
    ring_nf at h ⊢
    omega

end Ising2DLambda.NecSuf.KacWard
