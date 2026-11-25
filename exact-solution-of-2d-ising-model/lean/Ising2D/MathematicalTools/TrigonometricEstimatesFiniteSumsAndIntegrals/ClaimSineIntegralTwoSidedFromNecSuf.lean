/-
# `2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2 log(π/δ) + 2δ²/π² + B`（具体版を必要十分版から導く）

具体版 `ClaimSineIntegralTwoSided.lean` の `sine_integral_two_sided` の主張を、必要十分版
`Ising2D/NecSuf/LogDivergentIntegral.lean` の各点評価 `inv_sqrt_diff_bound` の `a = 1/2`, `c₀ = c_0`, `C = 1/48`,
`w = sin(θ/2)` への特殊化から得る（人手のラベルは `sine_integral_two_sided`）。上界の定数 `B = π²/(12 c_0(1+c_0))` は
必要十分版の `C b²/(c_0(1+c_0)a²)` に `a = 1/2, b = π, C = 1/48` を入れたものと厳密に一致する。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSineIntegralTwoSided
import Ising2D.NecSuf.LogDivergentIntegral

namespace Ising2D

open Real MeasureTheory intervalIntegral

section
variable {δ : ℝ}

/-- `sine_integral_two_sided` を、各点評価 `NecSuf.inv_sqrt_diff_bound` の `a = 1/2`, `c₀ = c_0`, `C = 1/48`,
`w = sin(θ/2)` への特殊化から得る。 -/
theorem sine_integral_two_sided_of_necSuf (hδ : 0 < δ) :
    2 * Real.log (Real.pi / δ)
        ≤ (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹) ∧
      (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹)
        ≤ 2 * Real.log (Real.pi / δ) + 2 * δ ^ 2 / Real.pi ^ 2 + Bconst := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hc0 : 0 < c0 := c0_pos
  set f2 : ℝ → ℝ := fun θ => (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹ with hf2
  set f1 : ℝ → ℝ := fun θ => (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹ with hf1
  have hi2 : IntervalIntegrable f2 volume 0 Real.pi :=
    (continuous_sineIntegrand hδ).intervalIntegrable _ _
  have hi1 : IntervalIntegrable f1 volume 0 Real.pi :=
    (continuous_quadIntegrand hδ).intervalIntegrable _ _
  -- 各点評価（必要十分版の特殊化）
  have hpt : ∀ θ ∈ Set.Icc (0:ℝ) Real.pi,
      0 ≤ f2 θ - f1 θ ∧ f2 θ - f1 θ ≤ θ / (6 * c0 * (1 + c0)) := by
    intro θ hθ
    obtain ⟨h0, hπ⟩ := hθ
    have hlow : c0 * ((1/2 : ℝ) * θ) ≤ Real.sin (θ / 2) := by
      have := (elementary_sine_bounds_linear h0 hπ).1
      calc c0 * ((1/2 : ℝ) * θ) = c0 * (θ / 2) := by ring
        _ ≤ Real.sin (θ / 2) := this
    have hhigh : Real.sin (θ / 2) ≤ (1/2 : ℝ) * θ := by
      have := (elementary_sine_bounds_linear h0 hπ).2
      linarith
    have hcube : (1/2 : ℝ) * θ - Real.sin (θ / 2) ≤ (1/48 : ℝ) * θ ^ 3 := by
      have := elementary_sine_bounds_cube h0 hπ
      linarith
    obtain ⟨hup, hlo⟩ := NecSuf.inv_sqrt_diff_bound (δ := δ) (a := 1/2) (c₀ := c0)
      (C := 1/48) (θ := θ) (w := Real.sin (θ / 2)) hδ (by norm_num) hc0 h0 hlow hhigh hcube
    have heq : δ ^ 2 + ((1/2 : ℝ) * θ) ^ 2 = δ ^ 2 + θ ^ 2 / 4 := by ring
    rw [heq] at hup hlo
    have hM : 2 * (1/48 : ℝ) * θ / (c0 * (1 + c0) * (1/2 : ℝ) ^ 2)
        = θ / (6 * c0 * (1 + c0)) := by
      field_simp; ring
    rw [hM] at hup
    exact ⟨hlo, hup⟩
  constructor
  · -- 下からの評価
    have hmono : (∫ θ in (0:ℝ)..Real.pi, f1 θ) ≤ ∫ θ in (0:ℝ)..Real.pi, f2 θ := by
      refine intervalIntegral.integral_mono_on hpi.le hi1 hi2 ?_
      intro θ hθ
      have := (hpt θ hθ).1
      linarith
    have := (integral_inv_sqrt_pi_bounds hδ).1
    linarith [hmono, this]
  · -- 上からの評価
    have hlin : IntervalIntegrable (fun θ : ℝ => θ / (6 * c0 * (1 + c0))) volume 0 Real.pi := by
      apply Continuous.intervalIntegrable
      fun_prop
    have hsub : IntervalIntegrable (fun θ => f2 θ - f1 θ) volume 0 Real.pi := hi2.sub hi1
    have hdiff : (∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ))
        ≤ ∫ θ in (0:ℝ)..Real.pi, θ / (6 * c0 * (1 + c0)) := by
      refine intervalIntegral.integral_mono_on hpi.le hsub hlin ?_
      intro θ hθ
      exact (hpt θ hθ).2
    have hval : (∫ θ in (0:ℝ)..Real.pi, θ / (6 * c0 * (1 + c0))) = Bconst := by
      have : (fun θ : ℝ => θ / (6 * c0 * (1 + c0)))
          = fun θ : ℝ => (6 * c0 * (1 + c0))⁻¹ * θ := by
        funext θ; rw [div_eq_inv_mul]
      rw [this, intervalIntegral.integral_const_mul, integral_id]
      rw [Bconst]
      field_simp
      ring
    have hsplit : (∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ))
        = (∫ θ in (0:ℝ)..Real.pi, f2 θ) - ∫ θ in (0:ℝ)..Real.pi, f1 θ :=
      intervalIntegral.integral_sub hi2 hi1
    have hupper := (integral_inv_sqrt_pi_bounds hδ).2
    rw [hval] at hdiff
    rw [hsplit] at hdiff
    linarith [hdiff, hupper]

end

end Ising2D
