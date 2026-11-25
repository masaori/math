/-
# `2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2 log(π/δ) + 2δ²/π² + B`

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_010_claim_sine_integral_two_sided`（ラベル `sine_integral_two_sided`）
- `critical_definition_sine_integral_constant`（ラベル `def_sine_integral_constant`）
- `critical_claim_sine_integral_constant_numerical_bound`（ラベル `sine_integral_constant_numerical_bound`）

**これが対数発散の源である。**

**具体版**（人手証明と同じ抽象度）。`sine_integral_two_sided` は人手の準備・各点の大小・下からの評価・
差の各点評価の準備・差の各点評価・差の積分の評価・上からの評価と 1 対 1 に書き、必要十分版を使わない。
必要十分版は `Ising2D/NecSuf/LogDivergentIntegral.lean`（`Ising2D.NecSuf.inv_sqrt_diff_bound`）で、
`sin` であることは効いておらず `c_0 (θ/2) ≤ w(θ) ≤ θ/2` と `θ/2 - w(θ) ≤ θ³/48` の 2 つの各点評価だけが効くことを示す。
特殊化としての導出は `ClaimSineIntegralTwoSidedFromNecSuf.lean` の `sine_integral_two_sided_of_necSuf`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimElementarySineBounds
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimClosedFormLogIntegral
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimNonnegativeRealOrderFromSquares
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

namespace Ising2D

open Real MeasureTheory intervalIntegral

/-- 人手 `def_sine_integral_constant` の `B := π²/(12 c_0(1+c_0))`。 -/
noncomputable def Bconst : ℝ := Real.pi ^ 2 / (12 * c0 * (1 + c0))

/-- 人手 `sine_integral_constant_numerical_bound` の `B ≤ 0.88`。 -/
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
  -- 人手の準備: `π > 0`（人手 `pi_is_positive` には具体版の宣言が無いので mathlib の `Real.pi_pos` で受ける）、
  -- `c₀ ≥ 0.5887 > 0`（人手 `sine_bound_constant_numerical_bounds` には欄 `lean` が無いので、
  -- `c0_bounds` から得る `c0_pos` で受ける）
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hc0 : 0 < c0 := c0_pos
  set f2 : ℝ → ℝ := fun θ => (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹ with hf2
  set f1 : ℝ → ℝ := fun θ => (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹ with hf1
  have hi2 : IntervalIntegrable f2 volume 0 Real.pi :=
    (continuous_sineIntegrand hδ).intervalIntegrable _ _
  have hi1 : IntervalIntegrable f1 volume 0 Real.pi :=
    (continuous_quadIntegrand hδ).intervalIntegrable _ _
  -- 人手の準備と各点の大小・差の各点評価。`θ ∈ [0,π]` について `p := θ/2`、`s := sin p`、
  -- `D₁ := √(δ²+p²)`、`D₂ := √(δ²+s²)` と置き、`1/D₁ ≤ 1/D₂` と `1/D₂ - 1/D₁ ≤ θ/(6c₀(1+c₀))` を示す。
  have hpt : ∀ θ ∈ Set.Icc (0:ℝ) Real.pi,
      f1 θ ≤ f2 θ ∧ f2 θ - f1 θ ≤ θ / (6 * c0 * (1 + c0)) := by
    intro θ hθ
    obtain ⟨h0, hπ⟩ := hθ
    have hlin := elementary_sine_bounds_linear h0 hπ        -- 人手 `sine_half_angle_linear_bounds`
    have hcube := elementary_sine_bounds_cube h0 hπ         -- 人手 `elementary_sine_bounds`
    have hf1θ : f1 θ = (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹ := rfl
    have hf2θ : f2 θ = (Real.sqrt (δ ^ 2 + Real.sin (θ / 2) ^ 2))⁻¹ := rfl
    set p : ℝ := θ / 2 with hp
    set s : ℝ := Real.sin p with hs
    set D1 : ℝ := Real.sqrt (δ ^ 2 + p ^ 2) with hD1
    set D2 : ℝ := Real.sqrt (δ ^ 2 + s ^ 2) with hD2
    have hp0 : 0 ≤ p := by rw [hp]; linarith
    have hcs : c0 * p ≤ s := hlin.1                          -- `c₀ p ≤ s`
    have hsp : s ≤ p := hlin.2                               -- `s ≤ p`
    -- 人手 `definition_of_sqrt_r_positive` には具体版の宣言が無いので、mathlib の
    -- `Real.sqrt_nonneg`・`Real.sq_sqrt` で受ける（`D₁, D₂ ≥ 0`、`D₁² = δ²+p²`、`D₂² = δ²+s²`）
    have hD1nn : 0 ≤ D1 := Real.sqrt_nonneg _
    have hD2nn : 0 ≤ D2 := Real.sqrt_nonneg _
    have hD1sq : D1 ^ 2 = δ ^ 2 + p ^ 2 := Real.sq_sqrt (by positivity)
    have hD2sq : D2 ^ 2 = δ ^ 2 + s ^ 2 := Real.sq_sqrt (by positivity)
    -- `p² = θ²/4` なので `D₁ = √(δ²+θ²/4)`
    have hD1eq : D1 = Real.sqrt (δ ^ 2 + θ ^ 2 / 4) := by
      rw [hD1, hp]
      congr 1
      ring
    -- `0 ≤ c₀ p ≤ s`（`c₀ > 0`、`p ≥ 0` より `c₀ p ≥ 0`）
    have hcp0 : 0 ≤ c0 * p := mul_nonneg hc0.le hp0
    have hs0 : 0 ≤ s := le_trans hcp0 hcs
    -- `δ² ≤ δ²+p² = D₁²`、`δ² ≤ δ²+s² = D₂²`（`p², s² ≥ 0`）
    have hδD1sq : δ ^ 2 ≤ D1 ^ 2 := by rw [hD1sq]; linarith [sq_nonneg p]
    have hδD2sq : δ ^ 2 ≤ D2 ^ 2 := by rw [hD2sq]; linarith [sq_nonneg s]
    -- `0 < δ ≤ D₁`、`0 < δ ≤ D₂`（人手 `nonnegative_real_order_from_squares` を `(δ, D₁)`, `(δ, D₂)` に）
    have hδD1 : δ ≤ D1 := nonnegative_real_order_from_squares hδ.le hD1nn hδD1sq
    have hδD2 : δ ≤ D2 := nonnegative_real_order_from_squares hδ.le hD2nn hδD2sq
    have hD1pos : 0 < D1 := lt_of_lt_of_le hδ hδD1
    have hD2pos : 0 < D2 := lt_of_lt_of_le hδ hδD2
    have hD1ne : D1 ≠ 0 := ne_of_gt hD1pos
    have hD2ne : D2 ≠ 0 := ne_of_gt hD2pos
    have hD12pos : 0 < D1 * D2 := mul_pos hD1pos hD2pos
    -- 各点の大小: `s² ≤ p²`
    have hss : s ^ 2 ≤ p ^ 2 :=
      calc s ^ 2
          = s * s := by ring
        _ ≤ s * p := mul_le_mul_of_nonneg_left hsp hs0      -- `s ≤ p` の両辺に `s ≥ 0` を掛ける
        _ ≤ p * p := mul_le_mul_of_nonneg_right hsp hp0     -- `s ≤ p` の両辺に `p ≥ 0` を掛ける
        _ = p ^ 2 := by ring
    -- `D₂² ≤ D₁²`
    have hD21sq : D2 ^ 2 ≤ D1 ^ 2 :=
      calc D2 ^ 2
          = δ ^ 2 + s ^ 2 := hD2sq                           -- 人手 `definition_of_sqrt_r_positive`
        _ ≤ δ ^ 2 + p ^ 2 := add_le_add le_rfl hss     -- `s² ≤ p²` の両辺に `δ²` を足す
        _ = D1 ^ 2 := hD1sq.symm                             -- 人手 `definition_of_sqrt_r_positive`
    -- `D₂ ≤ D₁`（人手 `nonnegative_real_order_from_squares` を `(D₂, D₁)` に）
    have hD21 : D2 ≤ D1 := nonnegative_real_order_from_squares hD2nn hD1nn hD21sq
    -- `1/D₁ ≤ 1/D₂`
    have hinv : 1 / D1 ≤ 1 / D2 :=
      calc 1 / D1
          = D2 * (1 / (D1 * D2)) := by field_simp             -- ℝ の四則。`D₁D₂ ≠ 0`
        _ ≤ D1 * (1 / (D1 * D2)) :=                          -- `D₂ ≤ D₁` の両辺に `1/(D₁D₂) > 0` を掛ける
            mul_le_mul_of_nonneg_right hD21 (le_of_lt (one_div_pos.2 hD12pos))
        _ = 1 / D2 := by field_simp                          -- 約分
    -- 差の各点評価の準備: `p - s ≤ p³/6`
    have hps : p - s ≤ p ^ 3 / 6 :=
      calc p - s
          = θ / 2 - Real.sin (θ / 2) := by rw [hs, hp]       -- `p, s` の置き方
        _ ≤ θ ^ 3 / 48 := hcube                              -- 人手 `elementary_sine_bounds`
        _ = p ^ 3 / 6 := by rw [hp]; ring                    -- `θ³ = 8p³` と ℚ の四則
    -- `0 ≤ p + s ≤ p + p = 2p`（`0 ≤ s ≤ p`）
    have hpsum0 : 0 ≤ p + s := add_nonneg hp0 hs0
    have hpsum : p + s ≤ 2 * p := by linarith [hsp]
    -- `p ≤ D₁`（`p² ≤ δ²+p² = D₁²` と人手 `nonnegative_real_order_from_squares` を `(p, D₁)` に）
    have hpD1 : p ≤ D1 :=
      nonnegative_real_order_from_squares hp0 hD1nn (by rw [hD1sq]; linarith [sq_nonneg δ])
    -- `(c₀p)² ≤ D₂²`
    have hcpsq : (c0 * p) ^ 2 ≤ D2 ^ 2 :=
      calc (c0 * p) ^ 2
          = c0 * p * (c0 * p) := by ring
        _ ≤ c0 * p * s := mul_le_mul_of_nonneg_left hcs hcp0 -- `c₀p ≤ s` の両辺に `c₀p ≥ 0` を掛ける
        _ ≤ s * s := mul_le_mul_of_nonneg_right hcs hs0      -- `c₀p ≤ s` の両辺に `s ≥ 0` を掛ける
        _ = s ^ 2 := by ring
        _ ≤ δ ^ 2 + s ^ 2 := le_add_of_nonneg_left (sq_nonneg δ) -- `δ² ≥ 0`
        _ = D2 ^ 2 := hD2sq.symm                             -- 人手 `definition_of_sqrt_r_positive`
    -- `c₀p ≤ D₂`（人手 `nonnegative_real_order_from_squares` を `(c₀p, D₂)` に）
    have hcpD2 : c0 * p ≤ D2 := nonnegative_real_order_from_squares hcp0 hD2nn hcpsq
    -- `p + c₀p ≤ D₁ + D₂`（辺ごとに足す）
    have hsumle : p + c0 * p ≤ D1 + D2 := add_le_add hpD1 hcpD2
    have hsumpos : 0 < D1 + D2 := add_pos hD1pos hD2pos
    have hDDDpos : 0 < D1 * D2 * (D1 + D2) := mul_pos hD12pos hsumpos
    -- `D₁D₂(D₁+D₂) ≥ c₀(1+c₀)p³`
    have hden : D1 * D2 * (D1 + D2) ≥ c0 * (1 + c0) * p ^ 3 :=
      calc D1 * D2 * (D1 + D2)
          = D1 * (D2 * (D1 + D2)) := by ring
        _ ≥ p * (D2 * (D1 + D2)) :=                          -- `p ≤ D₁` の両辺に `D₂(D₁+D₂) > 0` を掛ける
            mul_le_mul_of_nonneg_right hpD1 (mul_pos hD2pos hsumpos).le
        _ = p * (D1 + D2) * D2 := by ring
        _ ≥ p * (D1 + D2) * (c0 * p) :=                      -- `c₀p ≤ D₂` の両辺に `p(D₁+D₂) ≥ 0` を掛ける
            mul_le_mul_of_nonneg_left hcpD2 (mul_nonneg hp0 hsumpos.le)
        _ = p * (c0 * p) * (D1 + D2) := by ring
        _ ≥ p * (c0 * p) * (p + c0 * p) :=                   -- `p + c₀p ≤ D₁ + D₂` の両辺に `p·c₀p ≥ 0` を掛ける
            mul_le_mul_of_nonneg_left hsumle (mul_nonneg hp0 hcp0)
        _ = c0 * (1 + c0) * p ^ 3 := by ring                 -- ℝ の四則
    -- 差の各点評価
    have hdiff : 1 / D2 - 1 / D1 ≤ θ / (6 * c0 * (1 + c0)) := by
      rcases lt_or_eq_of_le hp0 with hppos | hpz
      · -- `p > 0` のとき
        have hK : 0 < c0 * (1 + c0) * p ^ 3 :=
          mul_pos (mul_pos hc0 (by linarith)) (pow_pos hppos 3)
        -- 分母の逆数の評価
        have hrecip : 1 / (D1 * D2 * (D1 + D2)) ≤ 1 / (c0 * (1 + c0) * p ^ 3) :=
          calc 1 / (D1 * D2 * (D1 + D2))
              = c0 * (1 + c0) * p ^ 3 / (D1 * D2 * (D1 + D2))
                  * (1 / (c0 * (1 + c0) * p ^ 3)) := by    -- ℝ の四則
                field_simp
            _ ≤ D1 * D2 * (D1 + D2) / (D1 * D2 * (D1 + D2))
                  * (1 / (c0 * (1 + c0) * p ^ 3)) :=       -- `c₀(1+c₀)p³ ≤ D₁D₂(D₁+D₂)` の両辺に正の数を掛ける
                mul_le_mul_of_nonneg_right (div_le_div_of_nonneg_right hden hDDDpos.le)
                  (one_div_pos.2 hK).le
            _ = 1 / (c0 * (1 + c0) * p ^ 3) := by          -- 約分
                rw [div_self (ne_of_gt hDDDpos), one_mul]
        calc 1 / D2 - 1 / D1
            = (D1 - D2) / (D1 * D2) := by field_simp       -- ℝ の四則。`D₁D₂ ≠ 0`
          _ = (D1 - D2) * (D1 + D2) / (D1 * D2 * (D1 + D2)) := -- 分子と分母に `D₁+D₂ > 0` を掛ける
              (mul_div_mul_right _ _ (ne_of_gt hsumpos)).symm
          _ = (D1 ^ 2 - D2 ^ 2) / (D1 * D2 * (D1 + D2)) := by ring   -- 分配律
          _ = ((δ ^ 2 + p ^ 2) - (δ ^ 2 + s ^ 2)) / (D1 * D2 * (D1 + D2)) := by
              rw [hD1sq, hD2sq]                            -- 人手 `definition_of_sqrt_r_positive`
          _ = (p ^ 2 - s ^ 2) / (D1 * D2 * (D1 + D2)) := by ring     -- ℝ の四則
          _ = (p - s) * (p + s) / (D1 * D2 * (D1 + D2)) := by ring   -- 分配律
          _ ≤ (p ^ 3 / 6) * (p + s) / (D1 * D2 * (D1 + D2)) :=      -- `p - s ≤ p³/6` に `(p+s)/(D₁D₂(D₁+D₂)) ≥ 0` を掛ける
              div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_right hps hpsum0) hDDDpos.le
          _ ≤ (p ^ 3 / 6) * (2 * p) / (D1 * D2 * (D1 + D2)) :=      -- `p + s ≤ 2p` に `(p³/6)/(D₁D₂(D₁+D₂)) ≥ 0` を掛ける
              div_le_div_of_nonneg_right
                (mul_le_mul_of_nonneg_left hpsum (by positivity)) hDDDpos.le
          _ = p ^ 4 / 3 * (1 / (D1 * D2 * (D1 + D2))) := by ring    -- ℝ の四則
          _ ≤ p ^ 4 / 3 * (1 / (c0 * (1 + c0) * p ^ 3)) :=          -- 分母の逆数の評価に `p⁴/3 ≥ 0` を掛ける
              mul_le_mul_of_nonneg_left hrecip (by positivity)
          _ = p / (3 * c0 * (1 + c0)) := by                         -- 約分。`p ≠ 0`
              have hpne : p ≠ 0 := ne_of_gt hppos
              have hc0ne : c0 ≠ 0 := ne_of_gt hc0
              have hc1ne : 1 + c0 ≠ 0 := by linarith
              field_simp
          _ = θ / (6 * c0 * (1 + c0)) := by                         -- `p = θ/2`
              rw [hp]
              have hc0ne : c0 ≠ 0 := ne_of_gt hc0
              have hc1ne : 1 + c0 ≠ 0 := by linarith
              field_simp
              ring
      · -- `p = 0` のとき: `s = sin 0 = 0 = p` なので `D₂ = D₁`、`θ = 2p = 0`
        -- （人手 `sine_zero` には具体版の宣言が無いので mathlib の `Real.sin_zero` で受ける）
        have hsp' : s = p := by rw [hs, ← hpz, Real.sin_zero]
        have hDe : D2 = D1 := by rw [hD2, hD1, hsp']
        have hθ0 : θ = 0 := by linarith [hp, hpz]
        rw [hDe, hθ0, sub_self, zero_div]
    have he1 : f1 θ = 1 / D1 := by rw [hf1θ, ← hD1eq, one_div]
    have he2 : f2 θ = 1 / D2 := by rw [hf2θ, hD2, hs, hp, one_div]
    rw [he1, he2]
    exact ⟨hinv, hdiff⟩
  have hsub : IntervalIntegrable (fun θ => f2 θ - f1 θ) volume 0 Real.pi := hi2.sub hi1
  constructor
  · -- 下からの評価
    calc 2 * Real.log (Real.pi / δ)
        ≤ ∫ θ in (0:ℝ)..Real.pi, f1 θ :=                     -- 人手 `log_integral_two_sided_bounds` の下からの評価
          (integral_inv_sqrt_pi_bounds hδ).1
      _ ≤ ∫ θ in (0:ℝ)..Real.pi, f2 θ :=                     -- (R3) の単調性と、各点で `1/D₁ ≤ 1/D₂`
          intervalIntegral.integral_mono_on hpi.le hi1 hi2 (fun θ hθ => (hpt θ hθ).1)
  · -- 差の積分の評価
    have hlin : IntervalIntegrable (fun θ : ℝ => θ / (6 * c0 * (1 + c0))) volume 0 Real.pi := by
      apply Continuous.intervalIntegrable
      fun_prop
    have hc1 : 0 < 1 + c0 := by linarith
    have hdiffint : (∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ)) ≤ Bconst :=
      calc (∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ))
          ≤ ∫ θ in (0:ℝ)..Real.pi, θ / (6 * c0 * (1 + c0)) := -- (R3) の単調性と、差の各点評価
            intervalIntegral.integral_mono_on hpi.le hsub hlin (fun θ hθ => (hpt θ hθ).2)
        _ = ∫ θ in (0:ℝ)..Real.pi, (6 * c0 * (1 + c0))⁻¹ * θ := by
            congr 1
            funext θ
            rw [div_eq_inv_mul]
        _ = (6 * c0 * (1 + c0))⁻¹ * ∫ θ in (0:ℝ)..Real.pi, θ := -- (R3) の線型性
            intervalIntegral.integral_const_mul _ _
        _ = (6 * c0 * (1 + c0))⁻¹ * (Real.pi ^ 2 / 2 - 0 ^ 2 / 2) := by -- (R4) を `F(θ) = θ²/2` に（(R4) には具体版の宣言が無いので mathlib の `integral_id` で受ける）
            rw [integral_id, sub_div]
        _ = Real.pi ^ 2 / (12 * c0 * (1 + c0)) := by          -- ℝ の四則
            field_simp
            ring
        _ = Bconst := rfl                                     -- 人手 `def_sine_integral_constant`
    -- 上からの評価
    calc (∫ θ in (0:ℝ)..Real.pi, f2 θ)
        = ∫ θ in (0:ℝ)..Real.pi, (f1 θ + (f2 θ - f1 θ)) := by -- ℝ の四則を各点で
          congr 1
          funext θ
          ring
      _ = (∫ θ in (0:ℝ)..Real.pi, f1 θ) + ∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ) := -- (R3) の線型性
          intervalIntegral.integral_add hi1 hsub
      _ ≤ (2 * Real.log (Real.pi / δ) + 2 * δ ^ 2 / Real.pi ^ 2)
            + ∫ θ in (0:ℝ)..Real.pi, (f2 θ - f1 θ) :=        -- 人手 `log_integral_two_sided_bounds` の上からの評価
          add_le_add (integral_inv_sqrt_pi_bounds hδ).2 le_rfl
      _ ≤ (2 * Real.log (Real.pi / δ) + 2 * δ ^ 2 / Real.pi ^ 2) + Bconst := -- 差の積分の評価
          add_le_add le_rfl hdiffint

end

end Ising2D
