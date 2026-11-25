/-
# `∫_0^π dθ/√(δ² + θ²/4) = 2 arcsinh(π/(2δ))` と `log(2y) ≤ arcsinh y ≤ log(2y) + 1/(4y²)`（具体版を必要十分版から導く）

具体版 `ClaimClosedFormLogIntegral.lean` の `integral_inv_sqrt_pi` の主張を、必要十分版
`Ising2D/NecSuf/LogDivergentIntegral.lean` の `integral_inv_sqrt_quad` の `a = 1/2`, `b = π` への特殊化として得る
（人手のラベルは `closed_form_log_integral`）。`arsinh_log_bounds` の主張を、必要十分版
`Ising2D/NecSuf/HyperbolicBounds.lean` の `log_two_mul_le_arsinh`・`arsinh_le_log_two_mul_add` の組として得る
（人手のラベルは `arcsinh_two_sided_log_bounds`）。`integral_inv_pow_three_half_pi` の主張を、必要十分版
`Ising2D/NecSuf/LogDivergentIntegral.lean` の `integral_inv_pow_three_half_le` の `A = a/2`, `b = π` への特殊化として得る
（人手のラベルは `three_halves_power_integral_bound`）。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimClosedFormLogIntegral
import Ising2D.NecSuf.HyperbolicBounds
import Ising2D.NecSuf.LogDivergentIntegral

namespace Ising2D

/-- `integral_inv_sqrt_pi` を `NecSuf.integral_inv_sqrt_quad` の `a = 1/2`, `b = π` への特殊化として得る。 -/
theorem integral_inv_sqrt_pi_of_necSuf {δ : ℝ} (hδ : 0 < δ) :
    (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹)
      = 2 * Real.arsinh (Real.pi / (2 * δ)) := by
  have h := NecSuf.integral_inv_sqrt_quad (δ := δ) (a := 1/2) (b := Real.pi) hδ (by norm_num)
  have hcongr : ∀ θ : ℝ, δ ^ 2 + ((1/2 : ℝ) * θ) ^ 2 = δ ^ 2 + θ ^ 2 / 4 := by
    intro θ; ring
  simp only [hcongr] at h
  rw [h]
  have : (1/2 : ℝ) * Real.pi / δ = Real.pi / (2 * δ) := by field_simp
  rw [this]
  field_simp

/-- `arsinh_log_bounds` を `NecSuf.log_two_mul_le_arsinh`・`NecSuf.arsinh_le_log_two_mul_add` の組として得る。 -/
theorem arsinh_log_bounds_of_necSuf {y : ℝ} (hy : 0 < y) :
    Real.log (2 * y) ≤ Real.arsinh y ∧ Real.arsinh y ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) :=
  ⟨NecSuf.log_two_mul_le_arsinh hy, NecSuf.arsinh_le_log_two_mul_add hy⟩

/-- `integral_inv_pow_three_half_pi` を `NecSuf.integral_inv_pow_three_half_le` の `A = a/2`, `b = π` への特殊化として得る。 -/
theorem integral_inv_pow_three_half_pi_of_necSuf {δ a : ℝ} (hδ : 0 < δ) (ha : 0 < a) :
    (∫ θ in (0:ℝ)..Real.pi,
        ((δ ^ 2 + a ^ 2 * θ ^ 2 / 4) * Real.sqrt (δ ^ 2 + a ^ 2 * θ ^ 2 / 4))⁻¹)
      ≤ 2 / (a * δ ^ 2) := by
  have h := NecSuf.integral_inv_pow_three_half_le (δ := δ) (a := a / 2) (b := Real.pi)
    hδ (by positivity) Real.pi_pos
  have hcongr : ∀ θ : ℝ, δ ^ 2 + ((a / 2 : ℝ) * θ) ^ 2 = δ ^ 2 + a ^ 2 * θ ^ 2 / 4 := by
    intro θ; ring
  simp only [hcongr] at h
  have hrw : 1 / (a / 2 * δ ^ 2) = 2 / (a * δ ^ 2) := by
    field_simp
  linarith [h, hrw.le, hrw.ge]

end Ising2D
