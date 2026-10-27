import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The calculation needs only a nonzero field and a sign of square one. -/
theorem twistedMode_wrapPhase_necSuf {F : Type*} [Field F]
    (L : ℕ) (hL : 1 ≤ L) (σ z : F)
    (hσ : σ * σ = 1) (hz : z ^ L = σ) :
    σ * z ^ 0 = z ^ L ∧ σ * z ^ (L - 1) = z⁻¹ := by
  have hσ0 : σ ≠ 0 := by
    intro h
    simp [h] at hσ
  have hz0 : z ≠ 0 := by
    intro h
    have hzero : (0 : F) ^ L = σ := by simpa [h] using hz
    have : σ = 0 := by simpa [Nat.ne_of_gt hL] using hzero.symm
    exact hσ0 this
  constructor
  · calc
      σ * z ^ 0 = σ := by rw [pow_zero, mul_one]
      _ = z ^ L := hz.symm
  · have hmul : (σ * z ^ (L - 1)) * z = 1 := by
      calc
        (σ * z ^ (L - 1)) * z = σ * (z ^ (L - 1) * z) := mul_assoc _ _ _
        _ = σ * z ^ ((L - 1) + 1) := by rw [pow_succ]
        _ = σ * z ^ L := by rw [Nat.sub_add_cancel hL]
        _ = σ * σ := by rw [hz]
        _ = 1 := hσ
    calc
      σ * z ^ (L - 1) = (σ * z ^ (L - 1)) * (z * z⁻¹) := by rw [mul_inv_cancel₀ hz0, mul_one]
      _ = ((σ * z ^ (L - 1)) * z) * z⁻¹ := by simp only [mul_assoc]
      _ = z⁻¹ := by rw [hmul, one_mul]

end Ising2DLambda.NecSuf.KacWard
