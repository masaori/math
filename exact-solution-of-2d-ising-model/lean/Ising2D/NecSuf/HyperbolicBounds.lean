/-
# `sinh`, `cosh`, `arsinh` の初等評価（必要十分版）

対応する人手証明のラベル: `cosh_addition_and_half_angle`, `closed_form_log_integral`
（正本は `structured-latex/content/020_critical_point.ts`）

具体版: `Ising2D/Part020/Claim001_CoshAddHalfAngle.lean`,
`Ising2D/Part020/Claim009_ClosedFormLogIntegral.lean`

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 `cosh_addition_and_half_angle` は (1) 加法定理 (2) 半角公式 (3) `sinh` の狭義単調増加
(4) `arsinh` の定義・逆関数性・微分 (5) `t ≤ sinh t ≤ t cosh t` の 5 つを、いずれも
**`exp` の定義に戻って**証明している。これらはすべて mathlib に既にあるか、
**「導関数の符号」1 つ**から出る。すなわち Ising 模型とは無関係な `ℝ` 上の 1 変数解析の事実である。

本ファイルに置くのは、mathlib に無い次の 3 つだけである。

* `sinh_le_mul_cosh` : `0 ≤ t → sinh t ≤ t * cosh t`
  （効いているのは `(t cosh t - sinh t)' = t sinh t` の符号が `t` の符号と一致すること**だけ**。
  `t` の範囲を `[0,∞)` に限らず `ℝ` 全体で単調性が言えるので、
  人手証明が `t ∈ ℝ_{≥0}` を仮定しているのは結論の向きのためだけである）
* `cosh_le_inv_one_sub` : `t^2 < 2 → cosh t ≤ (1 - t^2/2)⁻¹`
  （mathlib の `Real.cosh_le_exp_half_sq` と `1 - y ≤ exp (-y)` の 2 つだけから出る。
  人手証明が数値評価 `cosh 0.2 ≤ 1.02007` を「初等関数の数値評価」として外から持ち込んでいる箇所を、
  この不等式で置き換えられる）
* `arsinh_le_log_two_mul_add` / `log_two_mul_le_arsinh` :
  `0 < y → log (2y) ≤ arsinh y ≤ log (2y) + 1/(4y^2)`
  （効いているのは `2y ≤ y + √(y²+1) ≤ 2y + 1/(2y)` という**平方根の 2 次評価**と
  `log` の単調性・`log (1+x) ≤ x` だけである。`arsinh` の逆関数性も微分も効いていない）

**対数発散の本体（`sine_integral_two_sided` / `second_derivative_log_divergence`）に
効いているのはこのうち `arsinh y - log(2y) = O(1/y²)` だけである**（`NecSuf/LogDivergentIntegral.lean`）。
-/
import Mathlib.Analysis.SpecialFunctions.Arsinh
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.Calculus.MeanValue

namespace Ising2D.NecSuf

open Real

/-- **必要十分版**: `sinh t ≤ t cosh t`（`t ≥ 0`）。
人手証明 `cosh_addition_and_half_angle` (5) の後半。
効いているのは `(t cosh t - sinh t)' = t sinh t` の符号だけである。 -/
theorem sinh_le_mul_cosh {t : ℝ} (ht : 0 ≤ t) : Real.sinh t ≤ t * Real.cosh t := by
  have hmono : Monotone fun x : ℝ => x * Real.cosh x - Real.sinh x := by
    apply monotone_of_deriv_nonneg
    · fun_prop
    · intro x
      have h : HasDerivAt (fun x : ℝ => x * Real.cosh x - Real.sinh x)
          (1 * Real.cosh x + x * Real.sinh x - Real.cosh x) x := by
        exact ((hasDerivAt_id x).mul (Real.hasDerivAt_cosh x)).sub (Real.hasDerivAt_sinh x)
      rw [h.deriv]
      have : 0 ≤ x * Real.sinh x := by
        rcases le_total 0 x with hx | hx
        · exact mul_nonneg hx (Real.sinh_nonneg_iff.2 hx)
        · nlinarith [Real.sinh_nonpos_iff.2 hx]
      linarith
  have := hmono ht
  simpa using this

/-- **必要十分版**: `1 - y ≤ exp (-y)` から出る `exp y ≤ (1-y)⁻¹`（`y < 1`）。 -/
theorem exp_le_inv_one_sub {y : ℝ} (hy : y < 1) : Real.exp y ≤ (1 - y)⁻¹ := by
  have h1 : (0:ℝ) < 1 - y := by linarith
  have h2 : 1 - y ≤ Real.exp (-y) := by
    have := Real.add_one_le_exp (-y)
    linarith
  rw [Real.exp_neg] at h2
  rw [le_inv_comm₀ (Real.exp_pos y) h1]
  exact h2

/-- **必要十分版**: `cosh t ≤ (1 - t^2/2)⁻¹`（`t^2 < 2`）。
人手証明が「初等関数の数値評価」として外から持ち込んでいる `cosh` の上界を、
mathlib の `Real.cosh_le_exp_half_sq` だけから得る形。 -/
theorem cosh_le_inv_one_sub_sq_div_two {t : ℝ} (ht : t ^ 2 < 2) :
    Real.cosh t ≤ (1 - t ^ 2 / 2)⁻¹ :=
  (Real.cosh_le_exp_half_sq t).trans (exp_le_inv_one_sub (by linarith))

/-- **必要十分版**: `1 + t^2/2 ≤ cosh t`。 -/
theorem one_add_sq_div_two_le_cosh (t : ℝ) : 1 + t ^ 2 / 2 ≤ Real.cosh t := by
  have h : Real.cosh t = 1 + 2 * Real.sinh (t / 2) ^ 2 := by
    have hcs := Real.cosh_sq (t / 2)
    have h2 := Real.cosh_two_mul (t / 2)
    rw [show 2 * (t / 2) = t by ring] at h2
    rw [h2, hcs]; ring
  have hs : (t / 2) ^ 2 ≤ Real.sinh (t / 2) ^ 2 := by
    rcases le_total 0 (t / 2) with hx | hx
    · have := Real.self_le_sinh_iff.2 hx
      nlinarith
    · have := Real.sinh_le_self_iff.2 hx
      nlinarith
  rw [h]; nlinarith

/-- 補助: `log (1 + x) ≤ x`（`0 ≤ x`）。 -/
theorem log_one_add_le {x : ℝ} (hx : 0 ≤ x) : Real.log (1 + x) ≤ x := by
  have := Real.log_le_sub_one_of_pos (x := 1 + x) (by linarith)
  linarith

/-- **必要十分版**: `log y ≤ y / e`（`0 < y`）。
人手証明が `x log(1/x)` の最大値を「導関数の符号」で求めている箇所を置き換える。 -/
theorem log_le_div_exp_one {y : ℝ} (hy : 0 < y) : Real.log y ≤ y / Real.exp 1 := by
  have he : (0:ℝ) < Real.exp 1 := Real.exp_pos 1
  have h : Real.log (y / Real.exp 1) ≤ y / Real.exp 1 - 1 :=
    Real.log_le_sub_one_of_pos (by positivity)
  rw [Real.log_div (ne_of_gt hy) (ne_of_gt he), Real.log_exp] at h
  linarith

/-- **必要十分版**: `y log (1/y) ≤ 1/e`（`0 < y`）。 -/
theorem mul_log_inv_le {y : ℝ} (hy : 0 < y) : y * Real.log y⁻¹ ≤ (Real.exp 1)⁻¹ := by
  have he : (0:ℝ) < Real.exp 1 := Real.exp_pos 1
  have h := log_le_div_exp_one (y := y⁻¹) (by positivity)
  have : y * Real.log y⁻¹ ≤ y * (y⁻¹ / Real.exp 1) := by
    exact mul_le_mul_of_nonneg_left h (le_of_lt hy)
  calc y * Real.log y⁻¹ ≤ y * (y⁻¹ / Real.exp 1) := this
    _ = (Real.exp 1)⁻¹ := by field_simp

/-- **必要十分版**: `log (2y) ≤ arsinh y`（`0 < y`）。
`arsinh y = log (y + √(1+y²))` と `2y ≤ y + √(1+y²)` から。 -/
theorem log_two_mul_le_arsinh {y : ℝ} (hy : 0 < y) : Real.log (2 * y) ≤ Real.arsinh y := by
  have hsq : y ≤ Real.sqrt (1 + y ^ 2) := by
    have h1 : Real.sqrt (y ^ 2) ≤ Real.sqrt (1 + y ^ 2) := Real.sqrt_le_sqrt (by linarith)
    rwa [Real.sqrt_sq hy.le] at h1
  have : (2:ℝ) * y ≤ y + Real.sqrt (1 + y ^ 2) := by linarith
  simpa [Real.arsinh] using Real.log_le_log (by linarith) this

/-- **必要十分版**: `arsinh y ≤ log (2y) + 1/(4y²)`（`0 < y`）。 -/
theorem arsinh_le_log_two_mul_add {y : ℝ} (hy : 0 < y) :
    Real.arsinh y ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) := by
  have hnn : (0:ℝ) ≤ y + 1 / (2 * y) := by positivity
  have hsq : Real.sqrt (1 + y ^ 2) ≤ y + 1 / (2 * y) := by
    have hle : 1 + y ^ 2 ≤ (y + 1 / (2 * y)) ^ 2 := by
      have h : (y + 1 / (2 * y)) ^ 2 = y ^ 2 + 1 + 1 / (4 * y ^ 2) := by
        field_simp; ring
      rw [h]
      have : (0:ℝ) < 1 / (4 * y ^ 2) := by positivity
      linarith
    calc Real.sqrt (1 + y ^ 2) ≤ Real.sqrt ((y + 1 / (2 * y)) ^ 2) := Real.sqrt_le_sqrt hle
      _ = y + 1 / (2 * y) := Real.sqrt_sq hnn
  have hpos : (0:ℝ) < y + Real.sqrt (1 + y ^ 2) := by
    have : (0:ℝ) ≤ Real.sqrt (1 + y ^ 2) := Real.sqrt_nonneg _
    linarith
  have h1 : Real.arsinh y ≤ Real.log (2 * y + 1 / (2 * y)) := by
    simpa [Real.arsinh] using Real.log_le_log hpos (by linarith : y + Real.sqrt (1 + y ^ 2) ≤ 2 * y + 1 / (2 * y))
  have h2 : (2:ℝ) * y + 1 / (2 * y) = (2 * y) * (1 + 1 / (4 * y ^ 2)) := by
    field_simp; ring
  rw [h2, Real.log_mul (by positivity) (by positivity)] at h1
  have h3 : Real.log (1 + 1 / (4 * y ^ 2)) ≤ 1 / (4 * y ^ 2) := log_one_add_le (by positivity)
  linarith

end Ising2D.NecSuf
