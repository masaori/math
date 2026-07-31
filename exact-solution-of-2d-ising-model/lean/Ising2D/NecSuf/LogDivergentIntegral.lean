/-
# 対数発散する積分（必要十分版）

対応する人手証明のラベル: `closed_form_log_integral`, `sine_integral_two_sided`
（正本は `structured-latex/content/020_critical_point.ts`）

具体版: `Ising2D/Part020/Claim009_ClosedFormLogIntegral.lean`,
`Ising2D/Part020/Claim010_SineIntegralTwoSided.lean`

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 `sine_integral_two_sided` は

  `∫_0^π dθ / √(δ² + sin²(θ/2)) = 2 log(π/δ) + O(1)`   （`δ → +0`）

を「対数発散の源」として取り出している。**しかしこの主張に `sin` は効いていない。**
効いているのは、被積分関数の分母に現れる関数 `w` について

* `c₀ · (aθ) ≤ w(θ) ≤ aθ`（原点で `aθ` と同じオーダー。`0 < c₀ ≤ 1`）
* `aθ - w(θ) ≤ C θ³`（原点での近似の 3 次の誤差）

の 2 つ**だけ**である。この 2 条件から

  `0 ≤ ∫_0^b dθ/√(δ²+w²) - ∫_0^b dθ/√(δ²+(aθ)²) ≤ C b² / (c₀(1+c₀)a²)`

が従い、`δ` に依存しない定数で差が抑えられる。したがって発散の形は
`∫_0^b dθ/√(δ²+(aθ)²) = arsinh(ab/δ)/a` という**完全に初等的な積分**だけで決まる。
Ising 模型はもちろん、三角関数も、周期性も、`θ/2` という特別な内部関数も効いていない。

人手証明の `B = π²/(12 c₀(1+c₀))` は、この必要十分版の `C b²/(c₀(1+c₀)a²)` に
`a = 1/2`, `b = π`, `C = 1/48` を代入したものと**厳密に一致する**
（`(1/48)·π²/(c₀(1+c₀)·(1/4)) = π²/(12c₀(1+c₀))`）。すなわち人手証明の定数は最良化されていないが、
必要十分版と同じ値である。

`arsinh(y) - log(2y) ∈ [0, 1/(4y²)]` は `Ising2D/NecSuf/HyperbolicBounds.lean` にある。
-/
import Ising2D.NecSuf.HyperbolicBounds
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt

namespace Ising2D.NecSuf

open MeasureTheory intervalIntegral

/-- `√(δ² + (aθ)²) > 0`。 -/
theorem sqrt_quad_pos {δ a θ : ℝ} (hδ : 0 < δ) : 0 < Real.sqrt (δ ^ 2 + (a * θ) ^ 2) :=
  Real.sqrt_pos.2 (by positivity)

/-- `√(δ² + w²) ≥ δ > 0`。 -/
theorem le_sqrt_quad {δ w : ℝ} (hδ : 0 < δ) : δ ≤ Real.sqrt (δ ^ 2 + w ^ 2) := by
  have h : Real.sqrt (δ ^ 2) ≤ Real.sqrt (δ ^ 2 + w ^ 2) :=
    Real.sqrt_le_sqrt (by nlinarith [sq_nonneg w])
  rwa [Real.sqrt_sq hδ.le] at h

/-- `t ↦ δ² + (a t)²` の導関数。 -/
theorem hasDerivAt_quad (δ a θ : ℝ) :
    HasDerivAt (fun t : ℝ => δ ^ 2 + (a * t) ^ 2) (2 * a ^ 2 * θ) θ := by
  have hlin : HasDerivAt (fun t : ℝ => a * t) a θ := by
    simpa using (hasDerivAt_id θ).const_mul a
  have hp : HasDerivAt (fun t : ℝ => (a * t) ^ 2) (2 * (a * θ) ^ 1 * a) θ := hlin.pow 2
  have hv : 2 * (a * θ) ^ 1 * a = 2 * a ^ 2 * θ := by ring
  rw [hv] at hp
  simpa using hp.const_add (δ ^ 2)

/-- **必要十分版（`closed_form_log_integral` (1)）**:
`∫_0^b dθ/√(δ² + a²θ²) = arsinh(ab/δ)/a`。
人手証明は `a = 1/2`, `b = π` の場合しか述べていないが、証明に効いているのは
`F(θ) = arsinh(aθ/δ)/a` が原始関数であることだけである。 -/
theorem integral_inv_sqrt_quad {δ a b : ℝ} (hδ : 0 < δ) (ha : 0 < a) :
    (∫ θ in (0:ℝ)..b, (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹)
      = Real.arsinh (a * b / δ) / a := by
  have hderiv : ∀ θ ∈ Set.uIcc (0:ℝ) b,
      HasDerivAt (fun t : ℝ => Real.arsinh (a * t / δ) / a)
        (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹ θ := by
    intro θ _
    have hinner : HasDerivAt (fun t : ℝ => a * t / δ) (a / δ) θ := by
      simpa [mul_div_assoc] using ((hasDerivAt_id θ).const_mul a).div_const δ
    have h : HasDerivAt (fun t : ℝ => Real.arsinh (a * t / δ))
        ((Real.sqrt (1 + (a * θ / δ) ^ 2))⁻¹ • (a / δ)) θ := hinner.arsinh
    have h2 := h.div_const a
    have hs : Real.sqrt (1 + (a * θ / δ) ^ 2) = Real.sqrt (δ ^ 2 + (a * θ) ^ 2) / δ := by
      rw [eq_div_iff (ne_of_gt hδ)]
      rw [show Real.sqrt (1 + (a * θ / δ) ^ 2) * δ
            = Real.sqrt (1 + (a * θ / δ) ^ 2) * Real.sqrt (δ ^ 2) by rw [Real.sqrt_sq hδ.le]]
      rw [← Real.sqrt_mul (by positivity)]
      congr 1
      field_simp
    have hq : 0 < Real.sqrt (δ ^ 2 + (a * θ) ^ 2) := sqrt_quad_pos hδ
    have hval : (Real.sqrt (1 + (a * θ / δ) ^ 2))⁻¹ • (a / δ) / a
        = (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹ := by
      simp only [smul_eq_mul]
      rw [hs]; field_simp
    rw [hval] at h2
    exact h2
  have hcont : ContinuousOn (fun θ : ℝ => (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹)
      (Set.uIcc 0 b) := by
    apply ContinuousOn.inv₀
    · fun_prop
    · intro θ _; exact ne_of_gt (sqrt_quad_pos hδ)
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hderiv hcont.intervalIntegrable]
  simp

/-- `∫_0^b dθ/(δ² + a²θ²)^{3/2} = b/(δ²√(δ²+a²b²))`（**必要十分版**、`closed_form_log_integral` (3)）。
`(δ²+a²θ²)^{3/2}` は `(δ²+a²θ²)·√(δ²+a²θ²)` として書く（rpow を避ける）。 -/
theorem integral_inv_pow_three_half {δ a b : ℝ} (hδ : 0 < δ) :
    (∫ θ in (0:ℝ)..b,
        ((δ ^ 2 + (a * θ) ^ 2) * Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹)
      = b / (δ ^ 2 * Real.sqrt (δ ^ 2 + (a * b) ^ 2)) := by
  have hderiv : ∀ θ ∈ Set.uIcc (0:ℝ) b,
      HasDerivAt (fun t : ℝ => t / (δ ^ 2 * Real.sqrt (δ ^ 2 + (a * t) ^ 2)))
        ((δ ^ 2 + (a * θ) ^ 2) * Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹ θ := by
    intro θ _
    have hqpos : (0:ℝ) < δ ^ 2 + (a * θ) ^ 2 := by positivity
    have hroot : HasDerivAt (fun t : ℝ => Real.sqrt (δ ^ 2 + (a * t) ^ 2))
        (2 * a ^ 2 * θ / (2 * Real.sqrt (δ ^ 2 + (a * θ) ^ 2))) θ :=
      (hasDerivAt_quad δ a θ).sqrt (ne_of_gt hqpos)
    have hden : HasDerivAt (fun t : ℝ => δ ^ 2 * Real.sqrt (δ ^ 2 + (a * t) ^ 2))
        (δ ^ 2 * (2 * a ^ 2 * θ / (2 * Real.sqrt (δ ^ 2 + (a * θ) ^ 2)))) θ :=
      hroot.const_mul _
    have hdne : δ ^ 2 * Real.sqrt (δ ^ 2 + (a * θ) ^ 2) ≠ 0 := by
      have : 0 < Real.sqrt (δ ^ 2 + (a * θ) ^ 2) := Real.sqrt_pos.2 hqpos
      positivity
    have hnum : HasDerivAt (fun t : ℝ => t) 1 θ := hasDerivAt_id θ
    have h := hnum.div hden hdne
    set s : ℝ := Real.sqrt (δ ^ 2 + (a * θ) ^ 2) with hsdef
    have hspos : 0 < s := Real.sqrt_pos.2 hqpos
    have hs2 : s ^ 2 = δ ^ 2 + (a * θ) ^ 2 := Real.sq_sqrt hqpos.le
    have hval :
        (1 * (δ ^ 2 * s) - θ * (δ ^ 2 * (2 * a ^ 2 * θ / (2 * s)))) / (δ ^ 2 * s) ^ 2
        = ((δ ^ 2 + (a * θ) ^ 2) * s)⁻¹ := by
      rw [inv_eq_one_div, div_eq_div_iff (by positivity) (by positivity)]
      field_simp
      nlinarith [hs2, hspos, hqpos]
    rw [hval] at h
    exact h
  have hcont : ContinuousOn
      (fun θ : ℝ => ((δ ^ 2 + (a * θ) ^ 2) * Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹)
      (Set.uIcc 0 b) := by
    apply ContinuousOn.inv₀
    · fun_prop
    · intro θ _
      have h1 : (0:ℝ) < δ ^ 2 + (a * θ) ^ 2 := by positivity
      have h2 : 0 < Real.sqrt (δ ^ 2 + (a * θ) ^ 2) := Real.sqrt_pos.2 h1
      positivity
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hderiv hcont.intervalIntegrable]
  simp

/-- 上の系: `∫_0^b dθ/(δ²+a²θ²)^{3/2} ≤ 1/(a δ²)`（`a, b, δ > 0`）。
人手証明 `closed_form_log_integral` (3) の（`1/2` 倍だけ強い）形。 -/
theorem integral_inv_pow_three_half_le {δ a b : ℝ} (hδ : 0 < δ) (ha : 0 < a) (hb : 0 < b) :
    (∫ θ in (0:ℝ)..b,
        ((δ ^ 2 + (a * θ) ^ 2) * Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹)
      ≤ 1 / (a * δ ^ 2) := by
  rw [integral_inv_pow_three_half hδ]
  have hge : a * b ≤ Real.sqrt (δ ^ 2 + (a * b) ^ 2) := by
    have h : Real.sqrt ((a * b) ^ 2) ≤ Real.sqrt (δ ^ 2 + (a * b) ^ 2) :=
      Real.sqrt_le_sqrt (by nlinarith [sq_nonneg δ])
    rwa [Real.sqrt_sq (by positivity)] at h
  have hspos : 0 < Real.sqrt (δ ^ 2 + (a * b) ^ 2) := sqrt_quad_pos hδ
  rw [div_le_div_iff₀ (by positivity) (by positivity)]
  nlinarith [mul_pos ha hb, sq_nonneg δ]

/-- 各点評価（**必要十分版の核**）: 仮定のもとで
`0 ≤ 1/√(δ²+w²) - 1/√(δ²+(aθ)²) ≤ 2Cθ/(c₀(1+c₀)a²)`。 -/
theorem inv_sqrt_diff_bound {δ a c₀ C θ w : ℝ} (hδ : 0 < δ) (ha : 0 < a) (hc₀ : 0 < c₀)
    (hθ : 0 ≤ θ) (hlow : c₀ * (a * θ) ≤ w) (hhigh : w ≤ a * θ) (hcube : a * θ - w ≤ C * θ ^ 3) :
    (Real.sqrt (δ ^ 2 + w ^ 2))⁻¹ - (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹
      ≤ 2 * C * θ / (c₀ * (1 + c₀) * a ^ 2) ∧
    0 ≤ (Real.sqrt (δ ^ 2 + w ^ 2))⁻¹ - (Real.sqrt (δ ^ 2 + (a * θ) ^ 2))⁻¹ := by
  set d1 : ℝ := Real.sqrt (δ ^ 2 + (a * θ) ^ 2) with hd1
  set d2 : ℝ := Real.sqrt (δ ^ 2 + w ^ 2) with hd2
  have hd1pos : 0 < d1 := Real.sqrt_pos.2 (by positivity)
  have hd2pos : 0 < d2 := Real.sqrt_pos.2 (by positivity)
  have hd1sq : d1 ^ 2 = δ ^ 2 + (a * θ) ^ 2 := Real.sq_sqrt (by positivity)
  have hd2sq : d2 ^ 2 = δ ^ 2 + w ^ 2 := Real.sq_sqrt (by positivity)
  have hwnn : 0 ≤ w := le_trans (by positivity) hlow
  have hd2le : d2 ≤ d1 := by
    rw [hd1, hd2]; exact Real.sqrt_le_sqrt (by nlinarith)
  refine ⟨?_, ?_⟩
  · rcases eq_or_lt_of_le hθ with hθ0 | hθpos
    · have hw0 : w = 0 := le_antisymm (by rw [← hθ0] at hhigh; simpa using hhigh) hwnn
      have hde : d1 = d2 := by rw [hd1, hd2, hw0, ← hθ0]; norm_num
      rw [hde]
      have h0 : (0:ℝ) ≤ 2 * C * θ / (c₀ * (1 + c₀) * a ^ 2) := by rw [← hθ0]; simp
      simpa using h0
    · have hCnn : 0 ≤ C := by
        have h3 : (0:ℝ) < θ ^ 3 := by positivity
        nlinarith [hcube, hhigh]
      have hd1ge : a * θ ≤ d1 := by
        have h : Real.sqrt ((a * θ) ^ 2) ≤ d1 := Real.sqrt_le_sqrt (by nlinarith [sq_nonneg δ])
        rwa [Real.sqrt_sq (by positivity)] at h
      have hd2ge : c₀ * (a * θ) ≤ d2 := by
        have h : Real.sqrt (w ^ 2) ≤ d2 := Real.sqrt_le_sqrt (by nlinarith [sq_nonneg δ])
        rw [Real.sqrt_sq hwnn] at h
        linarith
      have hnum : (a * θ) ^ 2 - w ^ 2 ≤ 2 * a * C * θ ^ 4 := by
        have h3 : 0 ≤ a * θ - w := by linarith
        have h4 : 0 ≤ a * θ + w := by positivity
        nlinarith
      have hprod : c₀ * (1 + c₀) * a ^ 3 * θ ^ 3 ≤ d1 * d2 * (d1 + d2) := by
        have hA : (a * θ) * (c₀ * (a * θ)) ≤ d1 * d2 :=
          mul_le_mul hd1ge hd2ge (by positivity) hd1pos.le
        have hB : (a * θ) + c₀ * (a * θ) ≤ d1 + d2 := by linarith
        have h2 : (0:ℝ) ≤ (a * θ) + c₀ * (a * θ) := by positivity
        calc c₀ * (1 + c₀) * a ^ 3 * θ ^ 3
            = ((a * θ) * (c₀ * (a * θ))) * ((a * θ) + c₀ * (a * θ)) := by ring
          _ ≤ (d1 * d2) * (d1 + d2) := mul_le_mul hA hB h2 (by positivity)
          _ = d1 * d2 * (d1 + d2) := by ring
      set M : ℝ := 2 * C * θ / (c₀ * (1 + c₀) * a ^ 2) with hM
      have hMnn : 0 ≤ M := by rw [hM]; positivity
      have hdiff : (d1 - d2) * (d1 + d2) = (a * θ) ^ 2 - w ^ 2 := by
        have hexp : (d1 - d2) * (d1 + d2) = d1 ^ 2 - d2 ^ 2 := by ring
        rw [hexp, hd1sq, hd2sq]; ring
      have hsum : 0 < d1 + d2 := by linarith
      have hkey : d1 - d2 ≤ M * (d1 * d2) := by
        refine le_of_mul_le_mul_right ?_ hsum
        rw [hdiff]
        calc (a * θ) ^ 2 - w ^ 2 ≤ 2 * a * C * θ ^ 4 := hnum
          _ = M * (c₀ * (1 + c₀) * a ^ 3 * θ ^ 3) := by rw [hM]; field_simp
          _ ≤ M * (d1 * d2 * (d1 + d2)) := mul_le_mul_of_nonneg_left hprod hMnn
          _ = M * (d1 * d2) * (d1 + d2) := by ring
      have hrw : d2⁻¹ - d1⁻¹ = (d1 - d2) / (d1 * d2) := by field_simp
      rw [hrw, div_le_iff₀ (by positivity)]
      linarith
  · have : d1⁻¹ ≤ d2⁻¹ := inv_anti₀ hd2pos hd2le
    linarith

end Ising2D.NecSuf
