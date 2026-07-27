/-
# `2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2 log(π/δ) + 2δ²/π² + B`

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_010_claim_sine_integral_two_sided`（ラベル `sine_integral_two_sided`）

**これが対数発散の源である。**

**具体版**（人手証明と同じ抽象度）。抽象版は
`Ising2D/Abstract/LogDivergentIntegral.lean`（`Ising2D.Abstract.inv_sqrt_diff_bound` /
`integral_inv_sqrt_quad`）。抽象版が示すとおり、**`sin` であることは効いておらず**、
`c_0 (θ/2) ≤ w(θ) ≤ θ/2` と `θ/2 - w(θ) ≤ θ³/48` という 2 つの各点評価だけが効いている。
本ファイルの上界の定数 `B = π²/(12 c_0(1+c_0))` は抽象版の
`C b²/(c_0(1+c_0)a²)` に `a = 1/2, b = π, C = 1/48` を入れたものと厳密に一致する。
-/
import Ising2D.Part020.Claim008_ElementarySineBounds
import Ising2D.Part020.Claim009_ClosedFormLogIntegral

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-- 原文の `B := π²/(12 c_0(1+c_0))`。 -/
noncomputable def Bconst : ℝ := Real.pi ^ 2 / (12 * c0 * (1 + c0))

theorem Bconst_le : Bconst ≤ 0.88 := by
  have hc := c0_bounds
  have hpi := Real.pi_lt_d6
  have hpi0 := Real.pi_pos
  have hden : (11.22 : ℝ) ≤ 12 * c0 * (1 + c0) := by nlinarith [hc.1, hc.2]
  have hnum : Real.pi ^ 2 ≤ 9.8697 := by nlinarith [hpi, hpi0]
  rw [Bconst, div_le_iff₀ (by linarith)]
  nlinarith [hden, hnum]

theorem Bconst_nonneg : 0 ≤ Bconst := by
  have hc := c0_pos
  rw [Bconst]
  positivity

section
variable {δ : ℝ}

/-- 被積分関数 `1/√(δ²+sin²(θ/2))` は連続。 -/
theorem continuous_sineIntegrand (hδ : 0 < δ) :
    Continuous fun θ : ℝ => (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹ := by
  apply Continuous.inv₀
  · fun_prop
  · intro θ
    exact ne_of_gt (Real.sqrt_pos.2 (by positivity))

/-- 比較対象 `1/√(δ²+θ²/4)` は連続。 -/
theorem continuous_quadIntegrand (hδ : 0 < δ) :
    Continuous fun θ : ℝ => (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹ := by
  apply Continuous.inv₀
  · fun_prop
  · intro θ
    exact ne_of_gt (Real.sqrt_pos.2 (by positivity))

/-- **人手証明 `sine_integral_two_sided`**。 -/
theorem sine_integral_two_sided (hδ : 0 < δ) :
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
  -- 各点評価（抽象版の系）
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
      have := (elementary_sine_bounds_cube h0 hπ).2
      linarith
    obtain ⟨hup, hlo⟩ := Abstract.inv_sqrt_diff_bound (δ := δ) (a := 1/2) (c₀ := c0)
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
