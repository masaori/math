/-
# `|G''(κ) - (1/2π) log(1/|κ|)| ≤ 6/5`（`0 < |κ| ≤ 1/2`）— 自由エネルギーの 2 階微分の対数発散

人手証明（正本は `structured-latex/content/critical_point_and_log_divergence.ts`）:
- `critical_011_theorem_second_derivative_log_divergence`
  （ラベル `second_derivative_log_divergence`）

**具体版**（人手証明と同じ抽象度）。必要十分版は
- `Ising2D/NecSuf/DiffUnderIntegral.lean`（積分記号下の微分 = 原文の (R5)。本ファイルは import せず、
  Step 1 の `hasDerivAt_Gfun`・`hasDerivAt_Gfirst` の証明の中で (R5) を mathlib の優関数の形で受ける）
- `Ising2D/NecSuf/LogDivergentIntegral.lean`（対数発散の本体）
- `Ising2D/NecSuf/HyperbolicBounds.lean`（数値評価）

## 原文との差

原文は各段の数値評価に `cosh 0.2 ≤ 1.02007` のような外部の数値を使うが、本形式化では
`Ising2D/NecSuf/HyperbolicBounds.lean` の `cosh t ≤ (1-t²/2)⁻¹` だけを使う（`ClaimKappaOfKBasic.lean` 参照）。
そのため途中の定数は原文とわずかに異なるが、**結論の定数 `6/5` は原文のまま成立する**
（本形式化の評価では `|2πG'' - log(1/κ)| ≤ 6.9`、`6.9/2π ≤ 1.10 ≤ 6/5`)。

なお原文 Step 4 は `|R| ≤ 2δ²/π² + B + (π/2)cosh(κ/2)` と 3 項の和で抑えているが、
`R` の上界と下界は別々の項から来るので、実際には
`-(π/2)cosh(κ/2) ≤ R ≤ 2δ²/π² + B` であり和を取る必要はない（本形式化ではこちらを使う）。
-/
import Ising2D.CriticalPoint.CriticalPointAndLogDivergence.ClaimGammaDerivativesInKappa
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSineIntegralTwoSided
import Mathlib.Analysis.Calculus.ParametricIntervalIntegral
import Mathlib.Analysis.Complex.ExponentialBounds
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAtLeastOne

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-- 原文の `G(κ) := (1/4π)∫_0^{2π} γ(θ,κ) dθ`。 -/
noncomputable def Gfun (κ : ℝ) : ℝ :=
  (1 / (4 * Real.pi)) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaK θ κ

/-- `G'(κ) = (1/4π)∫_0^{2π} ∂γ/∂κ dθ`。 -/
noncomputable def Gfirst (κ : ℝ) : ℝ :=
  (1 / (4 * Real.pi)) * ∫ θ in (0:ℝ)..(2 * Real.pi), dgammaK θ κ

/-- `G''(κ) = (1/4π)∫_0^{2π} ∂²γ/∂κ² dθ`。 -/
noncomputable def Gsecond (κ : ℝ) : ℝ :=
  (1 / (4 * Real.pi)) * ∫ θ in (0:ℝ)..(2 * Real.pi), d2gammaK θ κ

theorem isOpen_ne_zero : IsOpen {x : ℝ | x ≠ 0} := isOpen_ne

set_option maxHeartbeats 1000000 in
/-- **人手証明 Step 1**（(R5) の 1 回目）: `G' = (1/4π)∫ ∂γ/∂κ`。

人手の段: `gamma_derivatives_in_kappa` (4) より `γ` と `∂γ/∂κ` は長方形 `[0,2π]×[κ₁,κ₂]` 上連続なので、
(R5) を適用する。(R5) は本文が章の冒頭（`remark_real_analysis_escape_chapter_E`）で外から持ち込むと
宣言した事実で、mathlib には連続性だけを仮定した形が無い。証明の中で、長方形がコンパクトであることから
`∂γ/∂κ` の上界 `C` を取り、mathlib の優関数の形
`intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` に定数 `C` を優関数として渡して受ける。 -/
theorem hasDerivAt_Gfun {κ : ℝ} (hκ : κ ≠ 0) : HasDerivAt Gfun (Gfirst κ) κ := by
  have hr : 0 < |κ| / 2 := by
    have := abs_pos.2 hκ
    linarith
  -- 人手 Step 1 の長方形の `κ` の側 `[κ₁,κ₂]`。人手は `0 < κ₁ ≤ κ ≤ κ₂` とだけ書き（`κ > 0` の場合）、
  -- 値を定めない。Lean は `κ₁ := κ − |κ|/2`、`κ₂ := κ + |κ|/2` に取り、`κ < 0` も同じ形で扱う。この区間は 0 を含まない
  have hrect : Metric.closedBall κ (|κ| / 2) ⊆ {x : ℝ | x ≠ 0} := by
    intro x hx hx0
    rw [Metric.mem_closedBall, hx0, Real.dist_eq, zero_sub, abs_neg] at hx
    linarith [abs_pos.2 hκ]
  -- `gamma_derivatives_in_kappa` (4): `∂γ/∂κ` は長方形 `[0,2π]×[κ₁,κ₂]` 上連続
  have hcont : ContinuousOn (fun p : ℝ × ℝ => dgammaK p.1 p.2)
      (Set.uIcc 0 (2 * Real.pi) ×ˢ Metric.closedBall κ (|κ| / 2)) :=
    continuousOn_dgammaK.mono (Set.prod_mono (Set.subset_univ _) hrect)
  -- (R5) を mathlib の優関数の形で受けるための段: コンパクトな長方形上の連続関数は有界
  obtain ⟨C, hC⟩ :=
    (isCompact_uIcc.prod (isCompact_closedBall κ (|κ| / 2))).exists_bound_of_continuousOn hcont
  -- (R5)（外から持ち込む積分記号下の微分。mathlib の優関数の形）
  have h := (intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume) (a := 0) (b := 2 * Real.pi)
    (F := fun x θ => gammaK θ x) (F' := fun x θ => dgammaK θ x) (bound := fun _ => C)
    (Metric.ball_mem_nhds κ hr)
    -- 次の 3 つは mathlib の優関数の形が求める θ についての可測性・可積分性（Lean だけの段）
    (Filter.Eventually.of_forall fun x => (continuous_gammaK_fixed x).aestronglyMeasurable)
    ((continuous_gammaK_fixed κ).intervalIntegrable _ _)
    (continuous_dgammaK_fixed hκ).aestronglyMeasurable
    (Filter.Eventually.of_forall fun θ hθ x hx =>
      hC (θ, x) (Set.mk_mem_prod (Set.uIoc_subset_uIcc hθ) (Metric.ball_subset_closedBall hx)))
    intervalIntegrable_const
    -- `gamma_derivatives_in_kappa` (2): `∂γ/∂κ` は `γ` の `κ` についての導関数（人手 Step 1 は (4) だけを引く）
    (Filter.Eventually.of_forall fun θ _ x hx =>
      hasDerivAt_gammaK θ (hrect (Metric.ball_subset_closedBall hx)))).2
  exact h.const_mul (1 / (4 * Real.pi))

set_option maxHeartbeats 1000000 in
/-- **人手証明 Step 1**（(R5) の 2 回目）: `G'' = (1/4π)∫ ∂²γ/∂κ²`。

人手の段は 1 回目と同じで、`gamma_derivatives_in_kappa` (4) の `∂γ/∂κ` と `∂²γ/∂κ²` の長方形上の連続性に
(R5) を適用する。(R5) の受け方も 1 回目と同じ。 -/
theorem hasDerivAt_Gfirst {κ : ℝ} (hκ : κ ≠ 0) : HasDerivAt Gfirst (Gsecond κ) κ := by
  have hr : 0 < |κ| / 2 := by
    have := abs_pos.2 hκ
    linarith
  -- 人手 Step 1 の長方形の `κ` の側 `[κ₁,κ₂]`。人手は `0 < κ₁ ≤ κ ≤ κ₂` とだけ書き（`κ > 0` の場合）、
  -- 値を定めない。Lean は `κ₁ := κ − |κ|/2`、`κ₂ := κ + |κ|/2` に取り、`κ < 0` も同じ形で扱う。この区間は 0 を含まない
  have hrect : Metric.closedBall κ (|κ| / 2) ⊆ {x : ℝ | x ≠ 0} := by
    intro x hx hx0
    rw [Metric.mem_closedBall, hx0, Real.dist_eq, zero_sub, abs_neg] at hx
    linarith [abs_pos.2 hκ]
  -- `gamma_derivatives_in_kappa` (4): `∂²γ/∂κ²` は長方形 `[0,2π]×[κ₁,κ₂]` 上連続
  have hcont : ContinuousOn (fun p : ℝ × ℝ => d2gammaK p.1 p.2)
      (Set.uIcc 0 (2 * Real.pi) ×ˢ Metric.closedBall κ (|κ| / 2)) :=
    continuousOn_d2gammaK.mono (Set.prod_mono (Set.subset_univ _) hrect)
  -- (R5) を mathlib の優関数の形で受けるための段: コンパクトな長方形上の連続関数は有界
  obtain ⟨C, hC⟩ :=
    (isCompact_uIcc.prod (isCompact_closedBall κ (|κ| / 2))).exists_bound_of_continuousOn hcont
  -- (R5)（外から持ち込む積分記号下の微分。mathlib の優関数の形）
  have h := (intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume) (a := 0) (b := 2 * Real.pi)
    (F := fun x θ => dgammaK θ x) (F' := fun x θ => d2gammaK θ x) (bound := fun _ => C)
    (Metric.ball_mem_nhds κ hr)
    -- 次の 3 つは mathlib の優関数の形が求める θ についての可測性・可積分性（Lean だけの段）
    (Filter.eventually_of_mem (Metric.ball_mem_nhds κ hr) fun x hx =>
      (continuous_dgammaK_fixed (hrect (Metric.ball_subset_closedBall hx))).aestronglyMeasurable)
    ((continuous_dgammaK_fixed hκ).intervalIntegrable _ _)
    (continuous_d2gammaK_fixed hκ).aestronglyMeasurable
    (Filter.Eventually.of_forall fun θ hθ x hx =>
      hC (θ, x) (Set.mk_mem_prod (Set.uIoc_subset_uIcc hθ) (Metric.ball_subset_closedBall hx)))
    intervalIntegrable_const
    -- `gamma_derivatives_in_kappa` (2): `∂²γ/∂κ²` は `∂γ/∂κ` の `κ` についての導関数（人手 Step 1 は (4) だけを引く）
    (Filter.Eventually.of_forall fun θ _ x hx =>
      hasDerivAt_dgammaK θ (hrect (Metric.ball_subset_closedBall hx)))).2
  exact h.const_mul (1 / (4 * Real.pi))

/-- **人手証明 Step 1 の帰結**: `|G'(κ)| ≤ 1/2`。 -/
theorem abs_Gfirst_le {κ : ℝ} (hκ : κ ≠ 0) : |Gfirst κ| ≤ 1 / 2 := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hbound : ‖∫ θ in (0:ℝ)..(2 * Real.pi), dgammaK θ κ‖ ≤ 1 * |2 * Real.pi - 0| := by
    refine intervalIntegral.norm_integral_le_of_norm_le_const ?_
    intro t _
    simpa [Real.norm_eq_abs] using abs_dgammaK_le_one t hκ
  simp only [Real.norm_eq_abs] at hbound
  rw [Gfirst, abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ 1 / (4 * Real.pi))]
  rw [abs_of_nonneg (by linarith [Real.pi_pos] : (0:ℝ) ≤ 2 * Real.pi - 0)] at hbound
  rw [div_mul_eq_mul_div, div_le_div_iff₀ (by positivity) (by norm_num)]
  nlinarith [hbound, hpi]

/-! ## Step 2: 半区間への折り返し -/

theorem Sfun_two_pi_sub (θ κ : ℝ) : Sfun (2 * Real.pi - θ) κ = Sfun θ κ := by
  simp only [Sfun]
  congr 2
  rw [show (2 * Real.pi - θ) / 2 = Real.pi - θ / 2 by ring, Real.sin_pi_sub]

theorem d2gammaK_two_pi_sub (θ κ : ℝ) : d2gammaK (2 * Real.pi - θ) κ = d2gammaK θ κ := by
  simp only [d2gammaK, Qfun, Sfun_two_pi_sub]

/-- **人手証明 Step 2**（(R6) の使用）: `∫_0^{2π} = 2∫_0^{π}`。 -/
theorem integral_fold {κ : ℝ} (hκ : κ ≠ 0) :
    (∫ θ in (0:ℝ)..(2 * Real.pi), d2gammaK θ κ)
      = 2 * ∫ θ in (0:ℝ)..Real.pi, d2gammaK θ κ := by
  have hcont : Continuous fun θ : ℝ => d2gammaK θ κ := continuous_d2gammaK_fixed hκ
  have hsplit : (∫ θ in (0:ℝ)..Real.pi, d2gammaK θ κ)
      + (∫ θ in Real.pi..(2 * Real.pi), d2gammaK θ κ)
      = ∫ θ in (0:ℝ)..(2 * Real.pi), d2gammaK θ κ :=
    intervalIntegral.integral_add_adjacent_intervals
      (hcont.intervalIntegrable _ _) (hcont.intervalIntegrable _ _)
  have hrefl : (∫ θ in Real.pi..(2 * Real.pi), d2gammaK θ κ)
      = ∫ θ in (0:ℝ)..Real.pi, d2gammaK θ κ := by
    have h := intervalIntegral.integral_comp_sub_left (a := (0:ℝ)) (b := Real.pi)
      (fun θ => d2gammaK θ κ) (2 * Real.pi)
    simp only [d2gammaK_two_pi_sub] at h
    rw [show (2 * Real.pi - Real.pi) = Real.pi by ring,
      show (2 * Real.pi - 0) = 2 * Real.pi by ring] at h
    exact h.symm
  rw [hrefl] at hsplit
  linarith [hsplit]

end Ising2D

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-! ## Step 3: 2 つの項への分解 -/

/-- `J := ∫_0^π dθ/√(S(1+S))`。 -/
noncomputable def Jint (κ : ℝ) : ℝ := ∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (Qfun θ κ))⁻¹

/-- `I := ∫_0^π dθ/√S`（原文の `∫_0^π dθ/√S`）。 -/
noncomputable def Iint (κ : ℝ) : ℝ := ∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (Sfun θ κ))⁻¹

/-- `T := ∫_0^π sinh²κ cosh γ / sinh³γ dθ`。 -/
noncomputable def Tint (κ : ℝ) : ℝ :=
  ∫ θ in (0:ℝ)..Real.pi,
    Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))

theorem continuous_Jintegrand {κ : ℝ} (hκ : κ ≠ 0) :
    Continuous fun θ : ℝ => (Real.sqrt (Qfun θ κ))⁻¹ := by
  refine (continuous_sqrtQfun_fixed κ).inv₀ ?_
  intro θ; exact ne_of_gt (sqrt_Qfun_pos θ hκ)

theorem continuous_Iintegrand {κ : ℝ} (hκ : κ ≠ 0) :
    Continuous fun θ : ℝ => (Real.sqrt (Sfun θ κ))⁻¹ := by
  refine ((continuous_Sfun_fixed κ).sqrt).inv₀ ?_
  intro θ
  exact ne_of_gt (Real.sqrt_pos.2 (Sfun_pos_of_ne_zero θ hκ))

theorem continuous_Tintegrand {κ : ℝ} (hκ : κ ≠ 0) :
    Continuous fun θ : ℝ =>
      Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ)) := by
  refine Continuous.div ?_ ?_ ?_
  · exact continuous_const.mul (continuous_const.add
      (continuous_const.mul (continuous_Sfun_fixed κ)))
  · exact (continuous_const.mul (continuous_Qfun_fixed κ)).mul (continuous_sqrtQfun_fixed κ)
  · intro θ
    have h1 := Qfun_pos_of_ne_zero θ hκ
    have h2 := sqrt_Qfun_pos θ hκ
    positivity

/-- **人手証明 Step 3**: `∫_0^π ∂²γ/∂κ² dθ = (cosh κ/2) J - T`。 -/
theorem integral_d2gammaK_eq {κ : ℝ} (hκ : κ ≠ 0) :
    (∫ θ in (0:ℝ)..Real.pi, d2gammaK θ κ) = Real.cosh κ / 2 * Jint κ - Tint κ := by
  have hfun : (fun θ : ℝ => d2gammaK θ κ)
      = fun θ : ℝ => Real.cosh κ / 2 * (Real.sqrt (Qfun θ κ))⁻¹
        - Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ)) := by
    funext θ
    simp only [d2gammaK]
    congr 1
    field_simp
  rw [hfun]
  rw [intervalIntegral.integral_sub
    (((continuous_Jintegrand hκ).const_mul _).intervalIntegrable _ _)
    ((continuous_Tintegrand hκ).intervalIntegrable _ _)]
  rw [intervalIntegral.integral_const_mul]
  rfl

/-! ## Step 4: `J` の評価 -/

theorem Sfun_le_cosh_sq (θ κ : ℝ) : Sfun θ κ ≤ Real.cosh (κ / 2) ^ 2 := by
  have h := cosh_sq_eq_one_add_sinh_sq (κ / 2)
  have hs : Real.sin (θ / 2) ^ 2 ≤ 1 := by
    nlinarith [Real.sin_sq_add_cos_sq (θ / 2), sq_nonneg (Real.cos (θ / 2))]
  simp only [Sfun]
  linarith

/-- **人手証明 Step 4 の各点評価**: `0 ≤ 1/√S - 1/√(S(1+S)) ≤ cosh(κ/2)/2`。 -/
theorem inv_sqrt_diff_S_Q {θ κ : ℝ} (hκ : κ ≠ 0) :
    0 ≤ (Real.sqrt (Sfun θ κ))⁻¹ - (Real.sqrt (Qfun θ κ))⁻¹ ∧
      (Real.sqrt (Sfun θ κ))⁻¹ - (Real.sqrt (Qfun θ κ))⁻¹ ≤ Real.cosh (κ / 2) / 2 := by
  have hS : 0 < Sfun θ κ := Sfun_pos_of_ne_zero θ hκ
  set a : ℝ := Real.sqrt (Sfun θ κ) with ha
  set v : ℝ := Real.sqrt (1 + Sfun θ κ) with hv
  have hapos : 0 < a := Real.sqrt_pos.2 hS
  have hasq : a ^ 2 = Sfun θ κ := Real.sq_sqrt hS.le
  have hvsq : v ^ 2 = 1 + Sfun θ κ := Real.sq_sqrt (by linarith)
  have hv1 : 1 ≤ v := by
    rw [hv]
    have : Real.sqrt 1 ≤ Real.sqrt (1 + Sfun θ κ) := Real.sqrt_le_sqrt (by linarith)
    simpa using this
  have hQ : Real.sqrt (Qfun θ κ) = a * v := by
    rw [ha, hv, Qfun, Real.sqrt_mul hS.le]
  rw [hQ]
  have hdiff : a⁻¹ - (a * v)⁻¹ = (v - 1) / (a * v) := by
    field_simp
  rw [hdiff]
  constructor
  · positivity
  · rw [div_le_div_iff₀ (by positivity) (by norm_num)]
    have hacosh : a ≤ Real.cosh (κ / 2) := by
      rw [ha]
      have h1 : Real.sqrt (Sfun θ κ) ≤ Real.sqrt (Real.cosh (κ / 2) ^ 2) :=
        Real.sqrt_le_sqrt (Sfun_le_cosh_sq θ κ)
      rwa [Real.sqrt_sq (cosh_pos_of_two_cosh_pos _).le] at h1
    have hkey : 2 * (v - 1) ≤ a ^ 2 * v := by
      rw [hasq]
      nlinarith [hv1, hvsq]
    nlinarith [hkey, hacosh, hapos, hv1]

/-- **人手証明 Step 4**: `|J - I| ≤ π cosh(κ/2)/2`。 -/
theorem abs_Jint_sub_Iint {κ : ℝ} (hκ : κ ≠ 0) :
    0 ≤ Iint κ - Jint κ ∧ Iint κ - Jint κ ≤ Real.pi * Real.cosh (κ / 2) / 2 := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hiI : IntervalIntegrable (fun θ : ℝ => (Real.sqrt (Sfun θ κ))⁻¹) volume 0 Real.pi :=
    (continuous_Iintegrand hκ).intervalIntegrable _ _
  have hiJ : IntervalIntegrable (fun θ : ℝ => (Real.sqrt (Qfun θ κ))⁻¹) volume 0 Real.pi :=
    (continuous_Jintegrand hκ).intervalIntegrable _ _
  have hsub : Iint κ - Jint κ
      = ∫ θ in (0:ℝ)..Real.pi,
          ((Real.sqrt (Sfun θ κ))⁻¹ - (Real.sqrt (Qfun θ κ))⁻¹) :=
    (intervalIntegral.integral_sub hiI hiJ).symm
  rw [hsub]
  constructor
  · refine intervalIntegral.integral_nonneg hpi.le ?_
    intro θ _
    exact (inv_sqrt_diff_S_Q hκ).1
  · have hle : (∫ θ in (0:ℝ)..Real.pi,
        ((Real.sqrt (Sfun θ κ))⁻¹ - (Real.sqrt (Qfun θ κ))⁻¹))
        ≤ ∫ _θ in (0:ℝ)..Real.pi, Real.cosh (κ / 2) / 2 := by
      refine intervalIntegral.integral_mono_on hpi.le (hiI.sub hiJ)
        (continuous_const.intervalIntegrable _ _) ?_
      intro θ _
      exact (inv_sqrt_diff_S_Q hκ).2
    rw [intervalIntegral.integral_const] at hle
    simp only [smul_eq_mul, sub_zero] at hle
    linarith [hle]

end Ising2D

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-! ## Step 5: `T` の評価 -/

/-- 各点評価の第 1 段: `(1+2S)/(8Q√Q) ≤ 1/(4S√S)`。 -/
theorem coshgamma_div_sinhgamma_cube_le {θ κ : ℝ} (hκ : κ ≠ 0) :
    (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))
      ≤ 1 / (4 * Sfun θ κ * Real.sqrt (Sfun θ κ)) := by
  have hS : 0 < Sfun θ κ := Sfun_pos_of_ne_zero θ hκ
  set a : ℝ := Real.sqrt (Sfun θ κ) with ha
  set v : ℝ := Real.sqrt (1 + Sfun θ κ) with hv
  have hapos : 0 < a := Real.sqrt_pos.2 hS
  have hasq : a ^ 2 = Sfun θ κ := Real.sq_sqrt hS.le
  have hvsq : v ^ 2 = 1 + Sfun θ κ := Real.sq_sqrt (by linarith)
  have hv1 : 1 ≤ v := by
    rw [hv]
    have : Real.sqrt 1 ≤ Real.sqrt (1 + Sfun θ κ) := Real.sqrt_le_sqrt (by linarith)
    simpa using this
  have hQ : Real.sqrt (Qfun θ κ) = a * v := by
    rw [ha, hv, Qfun, Real.sqrt_mul hS.le]
  have hQval : Qfun θ κ = Sfun θ κ * (1 + Sfun θ κ) := rfl
  rw [hQ, hQval]
  rw [div_le_div_iff₀ (by positivity) (by positivity)]
  have hkey : 1 + 2 * Sfun θ κ ≤ 2 * (1 + Sfun θ κ) * v := by
    nlinarith [hv1, hvsq]
  nlinarith [mul_le_mul_of_nonneg_left hkey
    (show (0:ℝ) ≤ 4 * Sfun θ κ * a by positivity), hapos, hS, hv1]

/-- 各点評価の第 2 段（単調性）。 -/
theorem inv_pow_three_half_mono {w S : ℝ} (hw : 0 < w) (hle : w ≤ S) :
    1 / (4 * S * Real.sqrt S) ≤ 1 / (4 * w * Real.sqrt w) := by
  have hS : 0 < S := lt_of_lt_of_le hw hle
  have hsw : 0 < Real.sqrt w := Real.sqrt_pos.2 hw
  have hsS : 0 < Real.sqrt S := Real.sqrt_pos.2 hS
  have hsle : Real.sqrt w ≤ Real.sqrt S := Real.sqrt_le_sqrt hle
  rw [div_le_div_iff₀ (by positivity) (by positivity)]
  nlinarith [hsle, hsw, hw, hle]

/-- **人手証明 Step 5**: `0 ≤ T ≤ 2 cosh²(κ/2)/c_0`。 -/
theorem Tint_le {κ : ℝ} (hκ : 0 < κ) :
    0 ≤ Tint κ ∧ Tint κ ≤ 2 * Real.cosh (κ / 2) ^ 2 / c0 := by
  have hκ0 : κ ≠ 0 := ne_of_gt hκ
  have hδ : 0 < Real.sinh (κ / 2) := real_sinh_pos_of_pos (by linarith)
  have hc0 : 0 < c0 := c0_pos
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hiT : IntervalIntegrable (fun θ : ℝ =>
      Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ)))
      volume 0 Real.pi := (continuous_Tintegrand hκ0).intervalIntegrable _ _
  have hcompare : IntervalIntegrable (fun θ : ℝ => Real.sinh κ ^ 2 / 4 *
      ((Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4)
        * Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4))⁻¹) volume 0 Real.pi := by
    apply Continuous.intervalIntegrable
    refine continuous_const.mul (Continuous.inv₀ ?_ ?_)
    · fun_prop
    · intro θ
      have h1 : (0:ℝ) < Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4 := by positivity
      have h2 : 0 < Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4) :=
        Real.sqrt_pos.2 h1
      positivity
  constructor
  · refine intervalIntegral.integral_nonneg hpi.le ?_
    intro θ _
    have h1 := Qfun_pos_of_ne_zero θ hκ0
    have h2 := sqrt_Qfun_pos θ hκ0
    have h3 := (Sfun_nonneg θ κ)
    positivity
  · -- 各点評価
    have hpt : ∀ θ ∈ Set.Icc (0:ℝ) Real.pi,
        Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))
          ≤ Real.sinh κ ^ 2 / 4 *
            ((Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4)
              * Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4))⁻¹ := by
      intro θ hθ
      obtain ⟨h0, hπ⟩ := hθ
      set w : ℝ := Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4 with hw
      have hwpos : 0 < w := by rw [hw]; positivity
      have hwle : w ≤ Sfun θ κ := by
        have hsin := (elementary_sine_bounds_linear h0 hπ).1
        have hc0nn : (0:ℝ) ≤ c0 * (θ / 2) := mul_nonneg c0_pos.le (by linarith)
        have hsin0 : 0 ≤ Real.sin (θ / 2) := le_trans hc0nn hsin
        have hsq : (c0 * (θ / 2)) ^ 2 ≤ Real.sin (θ / 2) ^ 2 := by
          have h := mul_self_le_mul_self hc0nn hsin
          nlinarith [h]
        simp only [Sfun, hw]
        nlinarith [hsq]
      have h1 := coshgamma_div_sinhgamma_cube_le (θ := θ) hκ0
      have h2 := inv_pow_three_half_mono hwpos hwle
      have hsinh2 : (0:ℝ) ≤ Real.sinh κ ^ 2 := sq_nonneg _
      have hchain : (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))
          ≤ 1 / (4 * w * Real.sqrt w) := le_trans h1 h2
      have hrw : Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))
          = Real.sinh κ ^ 2 * ((1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))) := by
        ring
      have hrw2 : Real.sinh κ ^ 2 / 4 * (w * Real.sqrt w)⁻¹
          = Real.sinh κ ^ 2 * (1 / (4 * w * Real.sqrt w)) := by
        field_simp
      rw [hrw, hrw2]
      exact mul_le_mul_of_nonneg_left hchain hsinh2
    have hmono := intervalIntegral.integral_mono_on hpi.le hiT hcompare hpt
    have hconst : (∫ θ in (0:ℝ)..Real.pi, Real.sinh κ ^ 2 / 4 *
        ((Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4)
          * Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4))⁻¹)
        = Real.sinh κ ^ 2 / 4 * ∫ θ in (0:ℝ)..Real.pi,
          ((Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4)
            * Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4))⁻¹ :=
      intervalIntegral.integral_const_mul _ _
    have hint := integral_inv_pow_three_half_pi (δ := Real.sinh (κ / 2)) (a := c0) hδ hc0
    have hsinhsq : Real.sinh κ ^ 2 = 4 * Real.sinh (κ / 2) ^ 2 * Real.cosh (κ / 2) ^ 2 := by
      rw [sinh_eq_two_sinh_half_mul_cosh_half κ]; ring
    have hfin : Real.sinh κ ^ 2 / 4 * (2 / (c0 * Real.sinh (κ / 2) ^ 2))
        = 2 * Real.cosh (κ / 2) ^ 2 / c0 := by
      rw [hsinhsq]
      field_simp
    have hnn : (0:ℝ) ≤ Real.sinh κ ^ 2 / 4 := by positivity
    calc Tint κ ≤ _ := hmono
      _ = Real.sinh κ ^ 2 / 4 * ∫ θ in (0:ℝ)..Real.pi,
            ((Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4)
              * Real.sqrt (Real.sinh (κ / 2) ^ 2 + c0 ^ 2 * θ ^ 2 / 4))⁻¹ := hconst
      _ ≤ Real.sinh κ ^ 2 / 4 * (2 / (c0 * Real.sinh (κ / 2) ^ 2)) :=
          mul_le_mul_of_nonneg_left hint hnn
      _ = 2 * Real.cosh (κ / 2) ^ 2 / c0 := hfin

end Ising2D

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-! ## Step 6, 7: 総合 -/

theorem two_pi_mul_Gsecond {κ : ℝ} (hκ : κ ≠ 0) :
    2 * Real.pi * Gsecond κ = Real.cosh κ / 2 * Jint κ - Tint κ := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  rw [Gsecond, integral_fold hκ, integral_d2gammaK_eq hκ]
  field_simp
  ring

set_option maxHeartbeats 1000000 in
/-- **人手証明 Step 6**: `|cosh κ · log(π/δ) - log(1/κ)| ≤ 2.27`（`0 < κ ≤ 1/2`）。 -/
theorem step6_bound {κ : ℝ} (h0 : 0 < κ) (h1 : κ ≤ 1/2) :
    |Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ)| ≤ 2.27 := by
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hpiu : Real.pi < 3.141593 := Real.pi_lt_d6
  have hδpos : 0 < Real.sinh (κ / 2) := real_sinh_pos_of_pos (by linarith)
  have hcpos : (1:ℝ) ≤ Real.cosh (κ / 2) := cosh_at_least_one _
  have hcub : Real.cosh (κ / 2) ≤ 32/31 := by
    have h := NecSuf.cosh_le_inv_one_sub_sq_div_two (t := κ / 2) (by nlinarith)
    have hd : (31:ℝ)/32 ≤ 1 - (κ / 2) ^ 2 / 2 := by nlinarith
    have hinv : (1 - (κ / 2) ^ 2 / 2)⁻¹ ≤ (31/32 : ℝ)⁻¹ := by
      apply inv_anti₀ (by norm_num) hd
    calc Real.cosh (κ / 2) ≤ (1 - (κ / 2) ^ 2 / 2)⁻¹ := h
      _ ≤ (31/32 : ℝ)⁻¹ := hinv
      _ = 32/31 := by norm_num
  have hδub : Real.sinh (κ / 2) ≤ κ / 2 * Real.cosh (κ / 2) :=
    sinh_le_mul_cosh_of_nonneg (by linarith)
  have hδlb : κ / 2 ≤ Real.sinh (κ / 2) := self_le_sinh_of_nonneg (by linarith)
  have hcoshκ1 : (1:ℝ) ≤ Real.cosh κ := cosh_at_least_one _
  have hcoshκ : Real.cosh κ ≤ 8/7 := by
    have h := NecSuf.cosh_le_inv_one_sub_sq_div_two (t := κ) (by nlinarith)
    have hd : (7:ℝ)/8 ≤ 1 - κ ^ 2 / 2 := by nlinarith
    have hinv : (1 - κ ^ 2 / 2)⁻¹ ≤ (7/8 : ℝ)⁻¹ := inv_anti₀ (by norm_num) hd
    calc Real.cosh κ ≤ (1 - κ ^ 2 / 2)⁻¹ := h
      _ ≤ (7/8 : ℝ)⁻¹ := hinv
      _ = 8/7 := by norm_num
  -- ρ の定義と評価
  set ρ : ℝ := Real.log κ - Real.log (Real.sinh (κ / 2)) - Real.log 2 with hρdef
  have hlogsplit : Real.log (Real.pi / Real.sinh (κ / 2))
      = Real.log (1 / κ) + Real.log (2 * Real.pi) + ρ := by
    rw [Real.log_div (ne_of_gt hpi) (ne_of_gt hδpos), Real.log_div one_ne_zero (ne_of_gt h0),
      Real.log_mul two_ne_zero (ne_of_gt hpi), hρdef, Real.log_one]
    ring
  have hρub : ρ ≤ 0 := by
    have h : Real.log κ ≤ Real.log (2 * Real.sinh (κ / 2)) :=
      Real.log_le_log h0 (by linarith)
    rw [Real.log_mul two_ne_zero (ne_of_gt hδpos)] at h
    rw [hρdef]; linarith
  have hρlb : -(1/31 : ℝ) ≤ ρ := by
    have h : Real.log (2 * Real.sinh (κ / 2)) ≤ Real.log (κ * Real.cosh (κ / 2)) :=
      Real.log_le_log (by linarith) (by nlinarith)
    rw [Real.log_mul two_ne_zero (ne_of_gt hδpos),
      Real.log_mul (ne_of_gt h0) (ne_of_gt (cosh_pos_of_two_cosh_pos (κ / 2)))] at h
    have hlogc : Real.log (Real.cosh (κ / 2)) ≤ 1/31 := by
      have := Real.log_le_sub_one_of_pos (cosh_pos_of_two_cosh_pos (κ / 2))
      linarith
    rw [hρdef]; linarith
  -- log(2π) の評価
  have hlog2 : Real.log 2 < 0.6931471808 := Real.log_two_lt_d9
  have hlog2pos : (0:ℝ) < Real.log 2 := by
    have := Real.log_two_gt_d9; linarith
  have hlogpi4 : Real.log (Real.pi / 4) ≤ Real.pi / 4 - 1 :=
    Real.log_le_sub_one_of_pos (by positivity)
  have hlog2pi_ub : Real.log (2 * Real.pi) ≤ 1.865 := by
    have hsplit : Real.log (2 * Real.pi) = 3 * Real.log 2 + Real.log (Real.pi / 4) := by
      rw [Real.log_div (ne_of_gt hpi) (by norm_num), Real.log_mul two_ne_zero (ne_of_gt hpi),
        show (4:ℝ) = 2 ^ 2 by norm_num, Real.log_pow]
      push_cast
      ring
    rw [hsplit]
    nlinarith [hlog2, hlogpi4, hpiu]
  have hlog2pi_nn : (0:ℝ) ≤ Real.log (2 * Real.pi) :=
    Real.log_nonneg (by nlinarith [Real.pi_gt_three])
  -- (cosh κ - 1) log(1/κ) の評価
  have hlogκ_nn : (0:ℝ) ≤ Real.log (1 / κ) := by
    apply Real.log_nonneg
    rw [le_div_iff₀ h0]; linarith
  have hcoshκ_sub : Real.cosh κ - 1 = 2 * Real.sinh (κ / 2) ^ 2 := by
    have := cosh_eq_one_add_two_sinh_half_sq κ
    linarith
  have hexp : (Real.exp 1)⁻¹ ≤ 0.36788 := by
    have h := Real.exp_one_gt_d9
    have : (0:ℝ) < Real.exp 1 := Real.exp_pos 1
    rw [inv_le_comm₀ this (by norm_num)]
    linarith
  have hklog : κ * Real.log (1 / κ) ≤ (Real.exp 1)⁻¹ := by
    have := NecSuf.mul_log_inv_le h0
    rwa [← one_div] at this
  have hsqlog : κ ^ 2 * Real.log (1 / κ) ≤ 0.18394 := by
    have h : κ * (κ * Real.log (1 / κ)) ≤ κ * (Real.exp 1)⁻¹ :=
      mul_le_mul_of_nonneg_left hklog h0.le
    nlinarith [h, hexp, h0, h1]
  have hterm1 : 0 ≤ (Real.cosh κ - 1) * Real.log (1 / κ) ∧
      (Real.cosh κ - 1) * Real.log (1 / κ) ≤ 0.099 := by
    constructor
    · nlinarith [hcoshκ_sub, hlogκ_nn, sq_nonneg (Real.sinh (κ / 2))]
    · have hcm : Real.cosh κ - 1 ≤ 0.5328 * κ ^ 2 := by
        rw [hcoshκ_sub]
        have hs2 : Real.sinh (κ / 2) ≤ κ / 2 * (32/31) := by nlinarith [hδub, hcub, h0]
        nlinarith [hs2, hδpos, h0]
      nlinarith [hcm, hlogκ_nn, hsqlog]
  -- 総合
  have hdecomp : Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ)
      = (Real.cosh κ - 1) * Real.log (1 / κ)
        + Real.cosh κ * (Real.log (2 * Real.pi) + ρ) := by
    rw [hlogsplit]; ring
  rw [hdecomp]
  set x : ℝ := Real.log (2 * Real.pi) + ρ with hxdef
  have hxub : x ≤ 1.865 := by rw [hxdef]; linarith
  have hxlb : -(1/31 : ℝ) ≤ x := by rw [hxdef]; linarith
  have hcoshpos : (0:ℝ) < Real.cosh κ := cosh_pos_of_two_cosh_pos κ
  have hprod : |Real.cosh κ * x| ≤ 2.1315 := by
    rcases le_total (0:ℝ) x with hxs | hxs
    · have hnn : (0:ℝ) ≤ Real.cosh κ * x := mul_nonneg hcoshpos.le hxs
      rw [abs_of_nonneg hnn]
      nlinarith [mul_nonneg (sub_nonneg.2 hcoshκ) hxs,
        mul_nonneg hcoshpos.le (sub_nonneg.2 hxub)]
    · have hnp : Real.cosh κ * x ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hcoshpos.le hxs
      rw [abs_of_nonpos hnp]
      nlinarith [mul_nonneg (sub_nonneg.2 hcoshκ) (by linarith : (0:ℝ) ≤ -x),
        mul_nonneg hcoshpos.le (by linarith : (0:ℝ) ≤ 1/31 - (-x))]
  have hterm1abs : |(Real.cosh κ - 1) * Real.log (1 / κ)| ≤ 0.099 := by
    rw [abs_of_nonneg hterm1.1]; exact hterm1.2
  calc |(Real.cosh κ - 1) * Real.log (1 / κ) + Real.cosh κ * x|
      ≤ |(Real.cosh κ - 1) * Real.log (1 / κ)| + |Real.cosh κ * x| := abs_add_le _ _
    _ ≤ 0.099 + 2.1315 := by linarith
    _ ≤ 2.27 := by norm_num

end Ising2D

namespace Ising2D

open Real MeasureTheory intervalIntegral

set_option maxHeartbeats 1000000 in
/-- **人手証明 `second_derivative_log_divergence` の `κ > 0` の場合**。 -/
theorem second_derivative_log_divergence_pos {κ : ℝ} (h0 : 0 < κ) (h1 : κ ≤ 1/2) :
    |Gsecond κ - (1 / (2 * Real.pi)) * Real.log (1 / κ)| ≤ 6/5 := by
  have hκ0 : κ ≠ 0 := ne_of_gt h0
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hpiu : Real.pi < 3.141593 := Real.pi_lt_d6
  have hpil : (3.141592:ℝ) < Real.pi := Real.pi_gt_d6
  have hδpos : 0 < Real.sinh (κ / 2) := real_sinh_pos_of_pos (by linarith)
  have hcpos : (1:ℝ) ≤ Real.cosh (κ / 2) := cosh_at_least_one _
  have hcub : Real.cosh (κ / 2) ≤ 32/31 := by
    have h := NecSuf.cosh_le_inv_one_sub_sq_div_two (t := κ / 2) (by nlinarith)
    have hd : (31:ℝ)/32 ≤ 1 - (κ / 2) ^ 2 / 2 := by nlinarith
    have hinv : (1 - (κ / 2) ^ 2 / 2)⁻¹ ≤ (31/32 : ℝ)⁻¹ := inv_anti₀ (by norm_num) hd
    calc Real.cosh (κ / 2) ≤ (1 - (κ / 2) ^ 2 / 2)⁻¹ := h
      _ ≤ (31/32 : ℝ)⁻¹ := hinv
      _ = 32/31 := by norm_num
  have hδub : Real.sinh (κ / 2) ≤ 8/31 := by
    have h := sinh_le_mul_cosh_of_nonneg (t := κ / 2) (by linarith)
    nlinarith [h, hcub, h0, h1]
  have hcoshκ1 : (1:ℝ) ≤ Real.cosh κ := cosh_at_least_one _
  have hcoshκ : Real.cosh κ ≤ 8/7 := by
    have h := NecSuf.cosh_le_inv_one_sub_sq_div_two (t := κ) (by nlinarith)
    have hd : (7:ℝ)/8 ≤ 1 - κ ^ 2 / 2 := by nlinarith
    have hinv : (1 - κ ^ 2 / 2)⁻¹ ≤ (7/8 : ℝ)⁻¹ := inv_anti₀ (by norm_num) hd
    calc Real.cosh κ ≤ (1 - κ ^ 2 / 2)⁻¹ := h
      _ ≤ (7/8 : ℝ)⁻¹ := hinv
      _ = 8/7 := by norm_num
  -- I の評価
  have hIeq : Iint κ
      = ∫ θ in (0:ℝ)..Real.pi,
          (Real.sqrt (Real.sinh (κ / 2) ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹ := rfl
  have hI := sine_integral_two_sided (δ := Real.sinh (κ / 2)) hδpos
  rw [← hIeq] at hI
  have hJI := abs_Jint_sub_Iint hκ0
  have hT := Tint_le h0
  -- J の評価
  have hLdef : ∀ _ : Unit, True := fun _ => trivial
  have hπc : Real.pi * Real.cosh (κ / 2) / 2 ≤ 1.622 := by nlinarith [hcub, hpiu, hpi]
  have hB := Bconst_le
  have hBnn := Bconst_nonneg
  have htail : 2 * Real.sinh (κ / 2) ^ 2 / Real.pi ^ 2 + Bconst ≤ 0.895 := by
    have hnum : 2 * Real.sinh (κ / 2) ^ 2 ≤ 0.14 := by nlinarith [hδub, hδpos]
    have hden : (9.8696 : ℝ) ≤ Real.pi ^ 2 := by nlinarith [hpil, hpi]
    have : 2 * Real.sinh (κ / 2) ^ 2 / Real.pi ^ 2 ≤ 0.0142 := by
      rw [div_le_iff₀ (by positivity)]
      nlinarith [hnum, hden]
    linarith [hB]
  have hJub : Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)) ≤ 0.895 := by
    linarith [hI.2, hJI.1, htail]
  have hJlb : -(1.622 : ℝ) ≤ Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)) := by
    linarith [hI.1, hJI.2, hπc]
  have hJabs : |Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2))| ≤ 1.622 := by
    rw [abs_le]; constructor <;> linarith
  -- T の評価
  have hTub : Tint κ ≤ 3.7 := by
    have hc0 := c0_bounds
    have hc0p := c0_pos
    have h : 2 * Real.cosh (κ / 2) ^ 2 / c0 ≤ 3.7 := by
      rw [div_le_iff₀ hc0p]
      nlinarith [hcub, hcpos, hc0.1]
    linarith [hT.2]
  -- 総合
  have hGs := two_pi_mul_Gsecond hκ0
  have hstep6 := step6_bound h0 h1
  have hdecomp : 2 * Real.pi * Gsecond κ - Real.log (1 / κ)
      = (Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ))
        + Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)))
        - Tint κ := by
    rw [hGs]; ring
  have hmid : |Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)))|
      ≤ 0.927 := by
    rw [abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ Real.cosh κ / 2)]
    have h1' : Real.cosh κ / 2 ≤ 4/7 := by linarith
    nlinarith [hJabs, abs_nonneg (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2))), h1']
  have htot : |2 * Real.pi * Gsecond κ - Real.log (1 / κ)| ≤ 6.9 := by
    rw [hdecomp]
    have hTabs : |Tint κ| ≤ 3.7 := by rw [abs_of_nonneg hT.1]; exact hTub
    calc |(Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ))
            + Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)))
            - Tint κ|
        ≤ |(Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ))
            + Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)))|
            + |Tint κ| := abs_sub _ _
      _ ≤ (|Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ)|
            + |Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2)))|)
            + |Tint κ| := by
          have := abs_add_le
            (Real.cosh κ * Real.log (Real.pi / Real.sinh (κ / 2)) - Real.log (1 / κ))
            (Real.cosh κ / 2 * (Jint κ - 2 * Real.log (Real.pi / Real.sinh (κ / 2))))
          linarith
      _ ≤ (2.27 + 0.927) + 3.7 := by linarith [hstep6, hmid, hTabs]
      _ ≤ 6.9 := by norm_num
  have hscale : Gsecond κ - (1 / (2 * Real.pi)) * Real.log (1 / κ)
      = (1 / (2 * Real.pi)) * (2 * Real.pi * Gsecond κ - Real.log (1 / κ)) := by
    field_simp
  rw [hscale, abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ 1 / (2 * Real.pi))]
  rw [div_mul_eq_mul_div, div_le_iff₀ (by positivity)]
  nlinarith [htot, hpil, abs_nonneg (2 * Real.pi * Gsecond κ - Real.log (1 / κ))]

/-- 人手 `gamma_kappa_identity` の偶関数性の鎖（`−κ/2 = −(κ/2)`、`sinh_is_odd`（`x → κ/2`）、`(−a)² = a²`）を `Sfun` について書いたもの。 -/
theorem Sfun_neg (θ κ : ℝ) : Sfun θ (-κ) = Sfun θ κ := by
  simp only [Sfun]
  rw [show -κ / 2 = -(κ / 2) by ring, sinh_is_odd (κ / 2), neg_sq]

/-- 人手 `gamma_kappa_identity` の「`γ(θ)` は `κ` について偶関数」を、`gamma_derivatives_in_kappa` の
`γ(θ,κ) = 2 arcsinh √S`（`gammaK`）について書いたもの。 -/
theorem gammaK_neg (θ κ : ℝ) : gammaK θ (-κ) = gammaK θ κ := by
  simp only [gammaK, Sfun_neg]

/-- **人手証明 Step 0 の鎖**: `G(−κ) = G(κ)`（すべての実数 `κ`）。 -/
theorem Gfun_neg (κ : ℝ) : Gfun (-κ) = Gfun κ :=
  calc Gfun (-κ)
      = (1 / (4 * Real.pi)) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaK θ (-κ) := rfl  -- G の定義
    _ = (1 / (4 * Real.pi)) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaK θ κ := by
        simp only [gammaK_neg]  -- gamma_kappa_identity
    _ = Gfun κ := rfl  -- G の定義

/-- **人手証明 Step 0**: `G(κ) = G(−κ)` の右辺は `κ ↦ −κ` と `G` の合成なので、合成関数の微分より
`G'(κ) = −G'(−κ)`（`−κ` での微分可能性は Step 1 の `hasDerivAt_Gfun`）。
人手はこの等式を `κ < 0` の場合だけ述べるが、ここは `κ ≠ 0` で示す（`κ > 0` では `−κ < 0` に、Lean が `κ ≠ 0` へ広げた Step 1 の `hasDerivAt_Gfun` を当てる。人手の Step 1 は `κ > 0` だけを扱う）。
Lean の `Gfirst` は導関数ではなく積分の式なので、左辺の `Gfirst κ` が `κ` での `G` の微分であることを
Step 1 の `hasDerivAt_Gfun`（Lean は `κ ≠ 0` で示す）と微分の一意性で結ぶ。この段は人手 Step 0 には無い。 -/
theorem Gfirst_eq_neg_Gfirst_neg {κ : ℝ} (hκ : κ ≠ 0) : Gfirst κ = -Gfirst (-κ) := by
  -- 合成関数の微分（`HasDerivAt.comp`）: (κ ↦ G(−κ))' = G'(−κ)·(−1)。
  -- `(−κ)' = −1`（`hasDerivAt_neg`）は、人手が根拠として書いていない段である。
  have hcomp : HasDerivAt (Gfun ∘ Neg.neg) (Gfirst (-κ) * (-1)) κ :=
    (hasDerivAt_Gfun (neg_ne_zero.mpr hκ)).comp κ (hasDerivAt_neg κ)
  -- G(κ) = G(−κ)（上の鎖）なので、同じ関数 G の κ での微分
  have hfun : Gfun ∘ Neg.neg = Gfun := funext Gfun_neg
  rw [hfun] at hcomp
  -- 微分の一意性（`HasDerivAt.unique`）: 左は Step 1 の `hasDerivAt_Gfun` を κ に当てたもの
  calc Gfirst κ = Gfirst (-κ) * (-1) := (hasDerivAt_Gfun hκ).unique hcomp
    _ = -Gfirst (-κ) := mul_neg_one _

/-- **人手証明 Step 0 の結論の片方**: `|G'(−κ)| = |G'(κ)|`（`κ ≠ 0`）。
人手はこれで `|G'(κ)| ≤ 1/2` を `κ < 0` へ広げるが、Lean の `abs_Gfirst_le` は `κ ≠ 0` で直接成り立つので、この帰着には使わない。 -/
theorem abs_Gfirst_neg {κ : ℝ} (hκ : κ ≠ 0) : |Gfirst (-κ)| = |Gfirst κ| :=
  calc |Gfirst (-κ)| = |-Gfirst (-κ)| := (abs_neg _).symm
    _ = |Gfirst κ| := by rw [← Gfirst_eq_neg_Gfirst_neg hκ]

/-- **人手証明 Step 0**: `G'(κ) = −G'(−κ)` の右辺をもう一度 `κ` で微分すると、合成関数の微分より
`−(−1)G''(−κ) = G''(−κ)` なので `G''(κ) = G''(−κ)`（`κ ≠ 0`）。
Lean は `G'(x) = −G'(−x)` を `x ≠ 0` で示すので、それは `κ` の近く（`0` を含まない開集合 `{x ≠ 0}`。人手の範囲なら `{x < 0}`）のすべての点で成り立ち、両辺の微分が一致する
（人手はこの「近くで成り立つ」ことを書いていない）。
`Gfirst_eq_neg_Gfirst_neg` と同じく、左辺の `Gsecond κ` が `κ` での `G'` の微分であることは Step 1 の
`hasDerivAt_Gfirst`（Lean は `κ ≠ 0` で示す）と微分の一意性で結ぶ。この段は人手 Step 0 には無い。 -/
theorem Gsecond_eq_Gsecond_neg {κ : ℝ} (hκ : κ ≠ 0) : Gsecond κ = Gsecond (-κ) := by
  -- 合成関数の微分（`HasDerivAt.comp`）と符号を反転した関数の微分（`HasDerivAt.neg`、人手が根拠として書いていない段）:
  -- (κ ↦ −G'(−κ))' = −(G''(−κ)·(−1))
  have hcomp : HasDerivAt (fun x => -(Gfirst ∘ Neg.neg) x) (-(Gsecond (-κ) * (-1))) κ :=
    ((hasDerivAt_Gfirst (neg_ne_zero.mpr hκ)).comp κ (hasDerivAt_neg κ)).neg
  -- κ の近くで G' と κ ↦ −G'(−κ) は一致する（上の Gfirst_eq_neg_Gfirst_neg）
  have hev : Gfirst =ᶠ[nhds κ] fun x => -(Gfirst ∘ Neg.neg) x :=
    (isOpen_ne_zero.eventually_mem hκ).mono fun x hx => Gfirst_eq_neg_Gfirst_neg hx
  -- 近くで一致する関数は同じ微分をもつ（`HasDerivAt.congr_of_eventuallyEq`）と微分の一意性（`HasDerivAt.unique`）
  -- 人手の `−(−1)G''(−κ)` は、ここでは積の順序を入れ替えた `−(G''(−κ)·(−1))` の形で現れる
  calc Gsecond κ = -(Gsecond (-κ) * (-1)) :=
        (hasDerivAt_Gfirst hκ).unique (hcomp.congr_of_eventuallyEq hev)
    _ = -(-Gsecond (-κ)) := by rw [mul_neg_one]
    _ = Gsecond (-κ) := neg_neg _

/-- `G''(−κ) = G''(κ)`（人手 Step 0 の結論「`G''(−κ) = G''(κ)`」）。`κ ≠ 0` は `Gsecond_eq_Gsecond_neg`、
`κ = 0` は `−0 = 0`。 -/
theorem Gsecond_neg (κ : ℝ) : Gsecond (-κ) = Gsecond κ := by
  rcases eq_or_ne κ 0 with h | h
  · rw [h, neg_zero]
  · exact (Gsecond_eq_Gsecond_neg h).symm

/-- **人手証明 `second_derivative_log_divergence` そのもの**:
`0 < |κ| ≤ 1/2` で `|G''(κ) - (1/2π)log(1/|κ|)| ≤ 6/5`。 -/
theorem second_derivative_log_divergence {κ : ℝ} (h0 : κ ≠ 0) (h1 : |κ| ≤ 1/2) :
    |Gsecond κ - (1 / (2 * Real.pi)) * Real.log (1 / |κ|)| ≤ 6/5 := by
  rcases lt_or_gt_of_ne h0 with hneg | hpos
  · have hpos' : 0 < -κ := by linarith
    have habs : |κ| = -κ := abs_of_neg hneg
    rw [habs, ← Gsecond_neg κ]
    exact second_derivative_log_divergence_pos hpos' (by rw [← habs]; exact h1)
  · have habs : |κ| = κ := abs_of_pos hpos
    rw [habs]
    exact second_derivative_log_divergence_pos hpos (by rw [← habs]; exact h1)

/-- **人手証明 `second_derivative_log_divergence` の帰結**:
`G''(κ) ≥ (1/2π)log(1/|κ|) - 6/5 → +∞`（`κ → 0`）。 -/
theorem Gsecond_ge {κ : ℝ} (h0 : κ ≠ 0) (h1 : |κ| ≤ 1/2) :
    (1 / (2 * Real.pi)) * Real.log (1 / |κ|) - 6/5 ≤ Gsecond κ := by
  have h := second_derivative_log_divergence h0 h1
  have := abs_le.1 h
  linarith [this.1]

end Ising2D
