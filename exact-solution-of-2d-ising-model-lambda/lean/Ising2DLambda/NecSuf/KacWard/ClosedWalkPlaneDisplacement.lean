import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The representative differences around a finite closed sequence telescope. -/
theorem closed_sequence_displacement_sum (n : ℕ) (L : ℤ)
    (r : Fin (n + 1) → ℤ) (d c : Fin n → ℤ)
    (hclose : r (Fin.last n) = r 0)
    (hstep : ∀ k : Fin n,
      r k.succ - r k.castSucc = d k - L * c k) :
    (∑ k : Fin n, d k) = L * ∑ k : Fin n, c k := by
  have hsum : ∑ k : Fin n, (d k - L * c k) = 0 := by
    calc
      _ = ∑ k : Fin n, (r k.succ - r k.castSucc) := by
        apply Finset.sum_congr rfl
        intro k _
        exact (hstep k).symm
      _ = ∑ k : Fin n,
          (r (Fin.ofNat (n + 1) (k.val + 1)) - r (Fin.ofNat (n + 1) k.val)) := by
        apply Finset.sum_congr rfl
        intro k _
        congr 1 <;> apply congrArg r <;> apply Fin.ext <;>
          simp [Fin.ofNat, Nat.mod_eq_of_lt, k.isLt, Nat.lt_succ_of_lt k.isLt]
      _ = ∑ k ∈ Finset.range n,
          (r (Fin.ofNat (n + 1) (k + 1)) - r (Fin.ofNat (n + 1) k)) := by
        exact Fin.sum_univ_eq_sum_range
          (fun k : ℕ =>
            r (Fin.ofNat (n + 1) (k + 1)) - r (Fin.ofNat (n + 1) k)) n
      _ = r (Fin.last n) - r 0 := by
        have ht := Finset.sum_range_sub
          (fun k : ℕ => r (Fin.ofNat (n + 1) k)) n
        have hlast : Fin.ofNat (n + 1) n = Fin.last n := by
          apply Fin.ext
          simp [Fin.ofNat]
        have hzero : Fin.ofNat (n + 1) 0 = 0 := by
          apply Fin.ext
          simp [Fin.ofNat]
        simpa only [hlast, hzero] using ht
      _ = 0 := by rw [hclose]; ring
  simp only [Finset.sum_sub_distrib, ← Finset.mul_sum] at hsum
  omega

end Ising2DLambda.NecSuf.KacWard
