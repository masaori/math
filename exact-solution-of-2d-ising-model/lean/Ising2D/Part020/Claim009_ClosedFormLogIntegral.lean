/-
# `∫_0^π dθ/√(δ² + θ²/4) = 2 arcsinh(π/(2δ))` と対数評価

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_009_claim_closed_form_log_integral`（ラベル `closed_form_log_integral`）

**具体版**（人手証明と同じ抽象度＝`a = 1/2`, `b = π` に固定した形）。
必要十分版は `Ising2D/NecSuf/LogDivergentIntegral.lean`
（`Ising2D.NecSuf.integral_inv_sqrt_quad` / `integral_inv_pow_three_half_le`）と
`Ising2D/NecSuf/HyperbolicBounds.lean`
（`Ising2D.NecSuf.log_two_mul_le_arsinh` / `arsinh_le_log_two_mul_add`）。
**本ファイルの主張はすべて必要十分版の特殊化として導出してある。**
-/
import Ising2D.NecSuf.LogDivergentIntegral
import Ising2D.Part020.Claim001_CoshAddHalfAngle

namespace Ising2D

open Real MeasureTheory

/-- **人手証明 `closed_form_log_integral` (1)**:
`∫_0^π dθ/√(δ² + θ²/4) = 2 arcsinh(π/(2δ))`。
必要十分版 `NecSuf.integral_inv_sqrt_quad` の `a = 1/2`, `b = π` への特殊化。 -/
theorem integral_inv_sqrt_pi {δ : ℝ} (hδ : 0 < δ) :
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

/-- **人手証明 `closed_form_log_integral` (2) 前半**: `log(2y) ≤ arcsinh y ≤ log(2y) + 1/(4y²)`。
必要十分版そのもの。 -/
theorem arsinh_log_bounds {y : ℝ} (hy : 0 < y) :
    Real.log (2 * y) ≤ Real.arsinh y ∧ Real.arsinh y ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) :=
  ⟨NecSuf.log_two_mul_le_arsinh hy, NecSuf.arsinh_le_log_two_mul_add hy⟩

/-- **人手証明 `closed_form_log_integral` (2) 後半**:
`2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+θ²/4) ≤ 2 log(π/δ) + 2δ²/π²`。 -/
theorem integral_inv_sqrt_pi_bounds {δ : ℝ} (hδ : 0 < δ) :
    2 * Real.log (Real.pi / δ) ≤ (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹) ∧
      (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹)
        ≤ 2 * Real.log (Real.pi / δ) + 2 * δ ^ 2 / Real.pi ^ 2 := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hy : (0:ℝ) < Real.pi / (2 * δ) := by positivity
  obtain ⟨hlo, hhi⟩ := arsinh_log_bounds hy
  have hlog : Real.log (2 * (Real.pi / (2 * δ))) = Real.log (Real.pi / δ) := by
    congr 1; field_simp
  have hquad : 1 / (4 * (Real.pi / (2 * δ)) ^ 2) = δ ^ 2 / Real.pi ^ 2 := by
    field_simp; ring
  rw [hlog] at hlo hhi
  rw [hquad] at hhi
  rw [integral_inv_sqrt_pi hδ]
  have hsplit : 2 * δ ^ 2 / Real.pi ^ 2 = 2 * (δ ^ 2 / Real.pi ^ 2) := by ring
  rw [hsplit]
  constructor <;> linarith

/-- **人手証明 `closed_form_log_integral` (3)**:
`∫_0^π dθ/(δ² + a²θ²/4)^{3/2} ≤ 2/(a δ²)`。
必要十分版 `NecSuf.integral_inv_pow_three_half_le` の `A = a/2`, `b = π` への特殊化。 -/
theorem integral_inv_pow_three_half_pi {δ a : ℝ} (hδ : 0 < δ) (ha : 0 < a) :
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
