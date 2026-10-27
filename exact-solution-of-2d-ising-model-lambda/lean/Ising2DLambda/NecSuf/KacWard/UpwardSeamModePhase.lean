import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A reverse vertical step uses only the period, the involutive seam sign, and a residue coordinate. -/
theorem upwardSeam_modePhase_necSuf {F : Type*} [GroupWithZero F]
    (L r : ℕ) (hL : 1 ≤ L) (hr : r < L) (σ z : F)
    (hz : z ^ L = σ) (hσ : σ * σ = 1) (hz0 : z ≠ 0) :
    (if r = L - 1 then σ else 1) * z ^ r = z⁻¹ * z ^ ((r + 1) % L) := by
  by_cases hlast : r = L - 1
  · have hrnext : r + 1 = L := by omega
    have hperiod : z ^ (L - 1) = z ^ L * z⁻¹ := by
      calc
        z ^ (L - 1) = z ^ (L - 1) * (z * z⁻¹) := by simp [hz0]
        _ = (z ^ (L - 1) * z) * z⁻¹ := by rw [mul_assoc]
        _ = z ^ L * z⁻¹ := by rw [← pow_succ, Nat.sub_add_cancel hL]
    simp [hlast, Nat.sub_add_cancel hL, hperiod, hz, ← mul_assoc, hσ]
  · have hrnext : r + 1 < L := by omega
    simp only [if_neg hlast, one_mul, Nat.mod_eq_of_lt hrnext]
    calc
      z ^ r = z⁻¹ * (z * z ^ r) := by simp [hz0]
      _ = z⁻¹ * z ^ (r + 1) := by rw [pow_succ']

end Ising2DLambda.NecSuf.KacWard
