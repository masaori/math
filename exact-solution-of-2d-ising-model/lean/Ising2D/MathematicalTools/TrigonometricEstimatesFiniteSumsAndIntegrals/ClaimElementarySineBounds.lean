/-
# `θ/2 - sin(θ/2) ≤ θ³/48` と `c_0 θ/2 ≤ sin(θ/2) ≤ θ/2`（`0 ≤ θ ≤ π`）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_008_claim_elementary_sine_bounds`（ラベル `elementary_sine_bounds`）と `critical_claim_sine_half_angle_linear_bounds`（ラベル `sine_half_angle_linear_bounds`）

**具体版**（人手証明と同じ抽象度）。必要十分版は不要（後述）。

## mathlib の状況（調査結果）

人手証明は (R4)(R3) を 3 段重ねて `t - t³/6 ≤ sin t ≤ t`（`t ≥ 0`）を導いているが、
**mathlib はこれをそのまま持っている**。

* `Real.sin_le : 0 ≤ x → sin x ≤ x`
* `Real.sin_ge_sub_cube : 0 ≤ x → x - x^3/6 ≤ sin x`
  （`Mathlib/Analysis/SpecialFunctions/Trigonometric/Bounds.lean`）

したがって本主張に固有の内容は「`t = θ/2` と置いて `θ ∈ [0,π]` に制限する」ことだけであり、
必要十分版を別に立てる意味がない（必要十分版は mathlib の 2 つの補題そのものである）。
`π` の数値評価は `Real.pi_gt_d6` / `Real.pi_lt_d6`。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.Real.Pi.Bounds
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanTwo
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealInverseOfPositiveIsPositive

namespace Ising2D

open Real

/-- 原文の `c_0 := 1 - π²/24`。 -/
noncomputable def c0 : ℝ := 1 - Real.pi ^ 2 / 24

/-- 原文の数値評価 `0.5887 ≤ c_0 ≤ 0.5888`。 -/
theorem c0_bounds : (0.5887 : ℝ) ≤ c0 ∧ c0 ≤ 0.5888 := by
  have h1 := Real.pi_gt_d6
  have h2 := Real.pi_lt_d6
  constructor <;> · simp only [c0]; nlinarith [h1, h2, Real.pi_pos]

theorem c0_pos : 0 < c0 := by have := c0_bounds; linarith [this.1]

theorem c0_le_one : c0 ≤ 1 := by have := c0_bounds; linarith [this.2]

/-- **人手証明 `elementary_sine_bounds`**: `θ/2 - sin(θ/2) ≤ θ³/48`（`0 ≤ θ ≤ π`）。 -/
theorem elementary_sine_bounds_cube {θ : ℝ} (h0 : 0 ≤ θ) (_hπ : θ ≤ Real.pi) :
    θ / 2 - Real.sin (θ / 2) ≤ θ ^ 3 / 48 := by
  have hh : (0:ℝ) ≤ θ / 2 := by linarith
  have := Real.sin_ge_sub_cube hh
  nlinarith [this]

/-- **人手 `sine_half_angle_linear_bounds`**: `c_0 θ/2 ≤ sin(θ/2) ≤ θ/2`（`0 ≤ θ ≤ π`）。
準備の `0 < π/2` と `(θ/2)² ≤ π²/4` の鎖は人手どおり（`real_zero_less_than_two`・`def_real_strict_order`・
`real_inverse_of_positive_is_positive`・`real_product_of_positives_is_positive`・`def_real_quotient`。`pi_is_positive` は具体版が無く
`Real.pi_pos`）。上下の評価は mathlib の `Real.sin_le`・`Real.sin_ge_sub_cube` と `nlinarith` で、人手の鎖
（`argument_minus_sine_nonnegative`・`sine_cubic_lower_bound`・`real_minus_zero_is_self` を引く）と 1 対 1 でない。 -/
theorem elementary_sine_bounds_linear {θ : ℝ} (h0 : 0 ≤ θ) (hπ : θ ≤ Real.pi) :
    c0 * (θ / 2) ≤ Real.sin (θ / 2) ∧ Real.sin (θ / 2) ≤ θ / 2 := by
  have hh : (0:ℝ) ≤ θ / 2 := by linarith
  have hhπ : θ / 2 ≤ Real.pi / 2 := by linarith
  -- 準備: `0 < π/2`
  have h2ne : (2:ℝ) ≠ 0 := fun h => ((real_lt_iff_le_and_ne 0 2).1 real_zero_less_than_two).2 h.symm
                                        -- `real_zero_less_than_two` と `def_real_strict_order` の `≠` の側（`x → 0, y → 2`）
  have hinv2 : 0 < (2:ℝ)⁻¹ := real_inverse_of_positive_is_positive 2 real_zero_less_than_two
                                        -- `real_inverse_of_positive_is_positive`（`a → 2`）
  have hπhalf : 0 < Real.pi / 2 := by
    have h : 0 < Real.pi * (2:ℝ)⁻¹ :=
      real_product_of_positives_is_positive _ _ Real.pi_pos hinv2
                                        -- `pi_is_positive` と `real_product_of_positives_is_positive`（`a → π, b → 2^{-1}`）
    rwa [← real_div_eq_mul_inv Real.pi 2 h2ne] at h
                                        -- `def_real_quotient`（`y → π, z → 2`）を右辺から左辺へ
  refine ⟨?_, Real.sin_le hh⟩
  have hcube := Real.sin_ge_sub_cube hh
  have hsq : (θ / 2) ^ 2 ≤ Real.pi ^ 2 / 4 :=
    calc (θ / 2) ^ 2
        = θ / 2 * (θ / 2) := sq _
      _ ≤ θ / 2 * (Real.pi / 2) := mul_le_mul_of_nonneg_left hhπ hh
                                        -- `θ/2 ≤ π/2` の両辺に `θ/2 ≥ 0` を掛ける
      _ ≤ Real.pi / 2 * (Real.pi / 2) := mul_le_mul_of_nonneg_right hhπ hπhalf.le
                                        -- `θ/2 ≤ π/2` の両辺に準備の `π/2 > 0` を掛ける
      _ = Real.pi ^ 2 / 4 := by ring    -- ℝ の四則
  have : c0 * (θ / 2) ≤ θ / 2 - (θ / 2) ^ 3 / 6 := by
    simp only [c0]
    nlinarith [hh, hsq]
  linarith

end Ising2D
