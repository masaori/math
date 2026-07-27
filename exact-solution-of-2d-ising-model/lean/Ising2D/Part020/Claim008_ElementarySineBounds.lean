/-
# `0 ≤ θ/2 - sin(θ/2) ≤ θ³/48`（`0 ≤ θ ≤ π`）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_008_claim_elementary_sine_bounds`（ラベル `elementary_sine_bounds`）

**具体版**（人手証明と同じ抽象度）。抽象版は不要（後述）。

## mathlib の状況（調査結果）

人手証明は (R4)(R3) を 3 段重ねて `t - t³/6 ≤ sin t ≤ t`（`t ≥ 0`）を導いているが、
**mathlib はこれをそのまま持っている**。

* `Real.sin_le : 0 ≤ x → sin x ≤ x`
* `Real.sin_ge_sub_cube : 0 ≤ x → x - x^3/6 ≤ sin x`
  （`Mathlib/Analysis/SpecialFunctions/Trigonometric/Bounds.lean`）

したがって本主張に固有の内容は「`t = θ/2` と置いて `θ ∈ [0,π]` に制限する」ことだけであり、
抽象版を別に立てる意味がない（抽象版は mathlib の 2 つの補題そのものである）。
`π` の数値評価は `Real.pi_gt_d6` / `Real.pi_lt_d6`。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.Real.Pi.Bounds

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

/-- **人手証明 `elementary_sine_bounds` の第 1 式**: `0 ≤ θ/2 - sin(θ/2) ≤ θ³/48`
（`0 ≤ θ ≤ π`）。 -/
theorem elementary_sine_bounds_cube {θ : ℝ} (h0 : 0 ≤ θ) (_hπ : θ ≤ Real.pi) :
    0 ≤ θ / 2 - Real.sin (θ / 2) ∧ θ / 2 - Real.sin (θ / 2) ≤ θ ^ 3 / 48 := by
  have hh : (0:ℝ) ≤ θ / 2 := by linarith
  constructor
  · linarith [Real.sin_le hh]
  · have := Real.sin_ge_sub_cube hh
    nlinarith [this]

/-- **人手証明 `elementary_sine_bounds` の第 2 式**: `c_0 θ/2 ≤ sin(θ/2) ≤ θ/2`
（`0 ≤ θ ≤ π`）。 -/
theorem elementary_sine_bounds_linear {θ : ℝ} (h0 : 0 ≤ θ) (hπ : θ ≤ Real.pi) :
    c0 * (θ / 2) ≤ Real.sin (θ / 2) ∧ Real.sin (θ / 2) ≤ θ / 2 := by
  have hh : (0:ℝ) ≤ θ / 2 := by linarith
  refine ⟨?_, Real.sin_le hh⟩
  have hcube := Real.sin_ge_sub_cube hh
  have hsq : (θ / 2) ^ 2 ≤ Real.pi ^ 2 / 4 := by nlinarith [Real.pi_pos]
  have : c0 * (θ / 2) ≤ θ / 2 - (θ / 2) ^ 3 / 6 := by
    simp only [c0]
    nlinarith [hh, hsq]
  linarith

end Ising2D
