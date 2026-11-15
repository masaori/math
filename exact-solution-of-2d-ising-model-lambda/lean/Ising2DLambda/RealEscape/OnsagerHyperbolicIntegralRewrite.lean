/-
章「実数体への脱出と熱力学極限」の「分散因子の積分の Onsager 表示への書換え」
（`claim_onsager_hyperbolic_integral_form`）のうち、周期境界の密度を引く最初の一行を除いた
書換えの段の具体版。最初の一行 `f^per(q) = (1/8π²)∫∫ log_ℝ B_q` は
`theorem_periodic_density_onsager_integral` の具体版を待つので、合成の段で付ける。

  人手証明                                                          このファイル
  r := ι_{ℚ→ℝ}(q)、K_q := −½ log_ℝ r                                 `onsagerCoupling`
  c_q := (1+r²)/(2r)、s_q := (1−r²)/(2r)                             `onsagerCoshValue`・`onsagerSinhValue`
  cosh t := (e^t+e^{−t})/2、sinh t := (e^t−e^{−t})/2                 `paperCosh`・`paperSinh`
  H_q(θ₁,θ₂) := c_q² − s_q(cos θ₁ + cos θ₂)                          `onsagerHyperbolicArgument`
  e^{−2K_q} = e^{log_ℝ r} = r                                        `exp_neg_two_onsagerCoupling`
  e^{2K_q} = (e^{−2K_q})^{−1} = r^{−1}                               `exp_two_onsagerCoupling`
  cosh(2K_q) の三行、sinh(2K_q) の三行                               `paperCosh_two_onsagerCoupling`・`paperSinh_two_onsagerCoupling`
  B_q = 4r²(…) = 4r²H_q の三行                                       `dispersionAngleArgument_eq_four_mul_sq_mul`
  H_q > 0（B_q > 0 と 4r² > 0）                                      `onsagerHyperbolicArgument_pos`
  log_ℝ(4r²) = log 4 + log r² = log 2² + log r² = 2log 2 + log r²
             = 2log 2 + 2log r の四行                                `realLog_four_mul_sq`
  積分の線型性と長方形の面積 (2π)² = 4π²                             `iteratedIntegral_const_add`
  (1/8π²)∫∫ log_ℝ B_q から log 2 + log r + (1/8π²)∫∫ log_ℝ H_q までの六行
                                                                     `onsager_hyperbolic_integral_rewrite`

脱出理由: 実対数と指数評価。`ι_{ℚ→ℝ}` は Lean の型強制 `(q : ℝ)`。
実対数は `def_real_logarithm` の具体版 `realLog` とその積法則 `realLog_mul` を引く。
`B_q > 0` は `claim_dispersion_angle_log_continuous` の具体版 `dispersionAngleArgument_pos` を引く。
指数について使うのは「指数・実対数の逆写像の関係」`Real.exp_log` と「指数法則」`Real.exp_neg` だけである。
二重積分は区間積分の反復で書き、線型性には被積分関数の連続性（`claim_dispersion_angle_log_continuous`
の具体版と同じ `realLog_comp_continuous`）から得る可積分性を使う。
必要十分版の定理・定義は使わない。
-/
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Analysis.SpecialFunctions.Exp
import Ising2DLambda.RealEscape.DispersionAngleLogContinuous

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit

/-- 本文の `cosh t := (e^t+e^{−t})/2`。 -/
noncomputable def paperCosh (t : ℝ) : ℝ := (Real.exp t + Real.exp (-t)) / 2

/-- 本文の `sinh t := (e^t−e^{−t})/2`。 -/
noncomputable def paperSinh (t : ℝ) : ℝ := (Real.exp t - Real.exp (-t)) / 2

/-- `r := ι_{ℚ→ℝ}(q)` を正の実数として読んだもの。 -/
def onsagerRadius (q : ℚ) (hq0 : 0 < q) : PositiveReal :=
  ⟨(q : ℝ), by exact_mod_cast hq0⟩

/-- `K_q := −½ log_ℝ r`。 -/
noncomputable def onsagerCoupling (q : ℚ) (hq0 : 0 < q) : ℝ :=
  -(1 / 2) * realLog (onsagerRadius q hq0)

/-- `c_q := (1+r²)/(2r)`。 -/
noncomputable def onsagerCoshValue (q : ℚ) : ℝ := (1 + (q : ℝ) ^ 2) / (2 * (q : ℝ))

/-- `s_q := (1−r²)/(2r)`。 -/
noncomputable def onsagerSinhValue (q : ℚ) : ℝ := (1 - (q : ℝ) ^ 2) / (2 * (q : ℝ))

/-- `H_q(θ₁,θ₂) := c_q² − s_q(cos θ₁ + cos θ₂)`。 -/
noncomputable def onsagerHyperbolicArgument (q : ℚ) (θ₁ θ₂ : ℝ) : ℝ :=
  onsagerCoshValue q ^ 2 - onsagerSinhValue q * (Real.cos θ₁ + Real.cos θ₂)

/-- 一つ目の式鎖: `e^{−2K_q} = e^{log_ℝ r} = r`。 -/
theorem exp_neg_two_onsagerCoupling (q : ℚ) (hq0 : 0 < q) :
    Real.exp (-(2 * onsagerCoupling q hq0)) = (q : ℝ) := by
  calc Real.exp (-(2 * onsagerCoupling q hq0))
      = Real.exp (realLog (onsagerRadius q hq0)) := by
        -- K_q の定義
        unfold onsagerCoupling; ring_nf
    _ = (q : ℝ) := by
        -- r > 0 と指数・実対数の逆写像の関係
        unfold realLog
        exact Real.exp_log (onsagerRadius q hq0).2

/-- 一つ目の式鎖の後半: `e^{2K_q} = (e^{−2K_q})^{−1} = r^{−1}`。 -/
theorem exp_two_onsagerCoupling (q : ℚ) (hq0 : 0 < q) :
    Real.exp (2 * onsagerCoupling q hq0) = (q : ℝ)⁻¹ := by
  calc Real.exp (2 * onsagerCoupling q hq0)
      = (Real.exp (-(2 * onsagerCoupling q hq0)))⁻¹ := by
        -- ℝ 上の指数法則
        rw [Real.exp_neg, inv_inv]
    _ = (q : ℝ)⁻¹ := by
        -- 直前の等式
        rw [exp_neg_two_onsagerCoupling]

/-- 二つ目の式鎖の前半: `cosh(2K_q) = (e^{2K_q}+e^{−2K_q})/2 = (r^{−1}+r)/2 = c_q`。 -/
theorem paperCosh_two_onsagerCoupling (q : ℚ) (hq0 : 0 < q) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q := by
  have hr : (q : ℝ) ≠ 0 := ne_of_gt (by exact_mod_cast hq0)
  calc paperCosh (2 * onsagerCoupling q hq0)
      = (Real.exp (2 * onsagerCoupling q hq0) + Real.exp (-(2 * onsagerCoupling q hq0))) / 2 := rfl
    _ = ((q : ℝ)⁻¹ + (q : ℝ)) / 2 := by
        rw [exp_two_onsagerCoupling, exp_neg_two_onsagerCoupling]
    _ = onsagerCoshValue q := by
        -- c_q の定義（r ≠ 0 と ℝ の四則）
        unfold onsagerCoshValue; field_simp

/-- 二つ目の式鎖の後半: `sinh(2K_q) = (e^{2K_q}−e^{−2K_q})/2 = (r^{−1}−r)/2 = s_q`。 -/
theorem paperSinh_two_onsagerCoupling (q : ℚ) (hq0 : 0 < q) :
    paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q := by
  have hr : (q : ℝ) ≠ 0 := ne_of_gt (by exact_mod_cast hq0)
  calc paperSinh (2 * onsagerCoupling q hq0)
      = (Real.exp (2 * onsagerCoupling q hq0) - Real.exp (-(2 * onsagerCoupling q hq0))) / 2 := rfl
    _ = ((q : ℝ)⁻¹ - (q : ℝ)) / 2 := by
        rw [exp_two_onsagerCoupling, exp_neg_two_onsagerCoupling]
    _ = onsagerSinhValue q := by
        -- s_q の定義（r ≠ 0 と ℝ の四則）
        unfold onsagerSinhValue; field_simp

/-- 三つ目の式鎖: `B_q = 4r²((1+r²)²/(4r²) − (1−r²)/(2r)·(cos θ₁+cos θ₂)) = 4r²H_q`。 -/
theorem dispersionAngleArgument_eq_four_mul_sq_mul (q : ℚ) (hq0 : 0 < q) (θ₁ θ₂ : ℝ) :
    dispersionAngleArgument q θ₁ θ₂ = 4 * (q : ℝ) ^ 2 * onsagerHyperbolicArgument q θ₁ θ₂ := by
  have hr : (q : ℝ) ≠ 0 := ne_of_gt (by exact_mod_cast hq0)
  calc dispersionAngleArgument q θ₁ θ₂
      = (1 + (q : ℝ) ^ 2) ^ 2 - 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) * (Real.cos θ₁ + Real.cos θ₂) := rfl
    _ = 4 * (q : ℝ) ^ 2 * ((1 + (q : ℝ) ^ 2) ^ 2 / (4 * (q : ℝ) ^ 2)
          - (1 - (q : ℝ) ^ 2) / (2 * (q : ℝ)) * (Real.cos θ₁ + Real.cos θ₂)) := by
        -- r > 0 と実数の四則
        field_simp; ring
    _ = 4 * (q : ℝ) ^ 2 * onsagerHyperbolicArgument q θ₁ θ₂ := by
        -- c_q, s_q, H_q の定義
        unfold onsagerHyperbolicArgument onsagerCoshValue onsagerSinhValue
        rw [div_pow, mul_pow]; ring

/-- `4r² > 0`。 -/
theorem four_mul_sq_pos (q : ℚ) (hq0 : 0 < q) : 0 < 4 * (q : ℝ) ^ 2 := by
  have hr : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq0
  positivity

/-- 正値性: `B_q > 0`（`claim_dispersion_angle_log_continuous`）と `4r² > 0` から `H_q > 0`。 -/
theorem onsagerHyperbolicArgument_pos (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (θ₁ θ₂ : ℝ) :
    0 < onsagerHyperbolicArgument q θ₁ θ₂ := by
  have hB := (dispersionAngleArgument_pos q hq0 hq1 θ₁ θ₂).2.2
  rw [dispersionAngleArgument_eq_four_mul_sq_mul q hq0] at hB
  exact pos_of_mul_pos_right hB (four_mul_sq_pos q hq0).le

/-- `log_ℝ H_q(θ₁,θ₂)`。 -/
noncomputable def onsagerHyperbolicLog (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (θ : ℝ × ℝ) : ℝ :=
  realLog ⟨onsagerHyperbolicArgument q θ.1 θ.2, onsagerHyperbolicArgument_pos q hq0 hq1 θ.1 θ.2⟩

/-- `log_ℝ H_q` は連続（実余弦と四則の連続性、`def_real_logarithm` の連続性）。 -/
theorem onsagerHyperbolicLog_continuous (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    Continuous (onsagerHyperbolicLog q hq0 hq1) := by
  apply realLog_comp_continuous (fun θ : ℝ × ℝ => onsagerHyperbolicArgument q θ.1 θ.2)
  unfold onsagerHyperbolicArgument
  exact continuous_const.sub (continuous_const.mul
    ((Real.continuous_cos.comp continuous_fst).add (Real.continuous_cos.comp continuous_snd)))

/-- 四つ目の式鎖: `log_ℝ(4r²) = log 4 + log r² = log 2² + log r² = 2 log 2 + log r² = 2 log 2 + 2 log r`。 -/
theorem realLog_four_mul_sq (q : ℚ) (hq0 : 0 < q) :
    realLog ⟨4 * (q : ℝ) ^ 2, four_mul_sq_pos q hq0⟩ =
      2 * realLog ⟨2, two_pos⟩ + 2 * realLog (onsagerRadius q hq0) := by
  have hr : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq0
  calc realLog ⟨4 * (q : ℝ) ^ 2, four_mul_sq_pos q hq0⟩
      = realLog ⟨4, four_pos⟩ + realLog ⟨(q : ℝ) ^ 2, by positivity⟩ :=
        -- 積法則と r > 0
        realLog_mul ⟨4, four_pos⟩ ⟨(q : ℝ) ^ 2, by positivity⟩
    _ = realLog ⟨2 * 2, by norm_num⟩ + realLog ⟨(q : ℝ) ^ 2, by positivity⟩ := by
        -- 4 = 2²
        congr 2; apply Subtype.ext; norm_num
    _ = 2 * realLog ⟨2, two_pos⟩ + realLog ⟨(q : ℝ) ^ 2, by positivity⟩ := by
        -- 積法則
        rw [realLog_mul ⟨2, two_pos⟩ ⟨2, two_pos⟩]; ring
    _ = 2 * realLog ⟨2, two_pos⟩ + 2 * realLog (onsagerRadius q hq0) := by
        -- 積法則
        have h := realLog_mul (onsagerRadius q hq0) (onsagerRadius q hq0)
        have he : (⟨(q : ℝ) ^ 2, by positivity⟩ : PositiveReal) =
            ⟨(onsagerRadius q hq0).1 * (onsagerRadius q hq0).1,
              mul_pos (onsagerRadius q hq0).2 (onsagerRadius q hq0).2⟩ := by
          apply Subtype.ext; simp [onsagerRadius, sq]
        rw [he, h]; ring

/-- 積分の線型性と長方形の面積 `(2π)² = 4π²`: 連続な `g` について
`∫₀^{2π}∫₀^{2π} (a + g) = 4π²·a + ∫₀^{2π}∫₀^{2π} g`。 -/
theorem iteratedIntegral_const_add (a : ℝ) (g : ℝ × ℝ → ℝ) (hg : Continuous g) :
    (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi, (a + g (θ₁, θ₂))) =
      4 * Real.pi ^ 2 * a + ∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi, g (θ₁, θ₂) := by
  have hinner : ∀ θ₁ : ℝ, (∫ θ₂ in (0 : ℝ)..2 * Real.pi, (a + g (θ₁, θ₂))) =
      2 * Real.pi * a + ∫ θ₂ in (0 : ℝ)..2 * Real.pi, g (θ₁, θ₂) := by
    intro θ₁
    have hgi : IntervalIntegrable (fun θ₂ => g (θ₁, θ₂)) MeasureTheory.volume 0 (2 * Real.pi) :=
      (hg.comp (Continuous.prodMk_right θ₁)).intervalIntegrable _ _
    rw [intervalIntegral.integral_add intervalIntegrable_const hgi, intervalIntegral.integral_const]
    simp
  have hG : Continuous (fun θ₁ : ℝ => ∫ θ₂ in (0 : ℝ)..2 * Real.pi, g (θ₁, θ₂)) :=
    intervalIntegral.continuous_parametric_intervalIntegral_of_continuous'
      (f := fun θ₁ θ₂ => g (θ₁, θ₂)) (by simpa [Function.uncurry_def] using hg) _ _
  simp_rw [hinner]
  rw [intervalIntegral.integral_add intervalIntegrable_const (hG.intervalIntegrable _ _),
    intervalIntegral.integral_const]
  simp; ring

/-- `claim_onsager_hyperbolic_integral_form` の書換えの段の具体版。
`cosh(2K_q) = c_q`、`sinh(2K_q) = s_q`、`H_q > 0` と、
`(1/8π²)∫∫ log_ℝ B_q = log_ℝ 2 + log_ℝ r + (1/8π²)∫∫ log_ℝ H_q`。 -/
theorem onsager_hyperbolic_integral_rewrite (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            dispersionAngleLog q hq0 hq1 (θ₁, θ₂)) =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
  refine ⟨paperCosh_two_onsagerCoupling q hq0, paperSinh_two_onsagerCoupling q hq0,
    onsagerHyperbolicArgument_pos q hq0 hq1, ?_⟩
  set a : ℝ := realLog ⟨4 * (q : ℝ) ^ 2, four_mul_sq_pos q hq0⟩
  -- 直前の実数上の恒等式 B_q = 4r²H_q と、積法則（4r² > 0、H_q > 0）
  have hpt : ∀ θ : ℝ × ℝ, dispersionAngleLog q hq0 hq1 θ = a + onsagerHyperbolicLog q hq0 hq1 θ := by
    intro θ
    have he : (⟨dispersionAngleArgument q θ.1 θ.2,
          (dispersionAngleArgument_pos q hq0 hq1 θ.1 θ.2).2.2⟩ : PositiveReal) =
        ⟨(⟨4 * (q : ℝ) ^ 2, four_mul_sq_pos q hq0⟩ : PositiveReal).1 *
            (⟨onsagerHyperbolicArgument q θ.1 θ.2,
              onsagerHyperbolicArgument_pos q hq0 hq1 θ.1 θ.2⟩ : PositiveReal).1,
          mul_pos (four_mul_sq_pos q hq0) (onsagerHyperbolicArgument_pos q hq0 hq1 θ.1 θ.2)⟩ := by
      apply Subtype.ext
      exact dispersionAngleArgument_eq_four_mul_sq_mul q hq0 θ.1 θ.2
    unfold dispersionAngleLog onsagerHyperbolicLog
    rw [he, realLog_mul]
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  calc 1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            dispersionAngleLog q hq0 hq1 (θ₁, θ₂))
      = 1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            (a + onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂))) := by
        simp_rw [hpt]
    _ = 4 * Real.pi ^ 2 / (8 * Real.pi ^ 2) * a + 1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
        -- 積分の線型性と長方形の面積 (2π)² = 4π²
        rw [iteratedIntegral_const_add a _ (onsagerHyperbolicLog_continuous q hq0 hq1)]; ring
    _ = 1 / 2 * a + 1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
        -- ℝ の四則
        field_simp; ring
    _ = 1 / 2 * (2 * realLog ⟨2, two_pos⟩ + 2 * realLog (onsagerRadius q hq0)) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
        -- 直前の実対数の式鎖
        have h4 : a = 2 * realLog ⟨2, two_pos⟩ + 2 * realLog (onsagerRadius q hq0) :=
          realLog_four_mul_sq q hq0
        rw [h4]
    _ = realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
        -- ℝ の四則
        ring

end Ising2DLambda.RealEscape
