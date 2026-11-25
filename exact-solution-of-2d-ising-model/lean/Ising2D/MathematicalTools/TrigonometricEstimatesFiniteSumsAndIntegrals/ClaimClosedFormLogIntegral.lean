/-
# `∫_0^π dθ/√(δ² + θ²/4) = 2 arcsinh(π/(2δ))` と対数評価

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_009_claim_closed_form_log_integral`（ラベル `closed_form_log_integral`）
- `critical_claim_arcsinh_two_sided_log_bounds`（ラベル `arcsinh_two_sided_log_bounds`）
- `critical_claim_log_integral_two_sided_bounds`（ラベル `log_integral_two_sided_bounds`）
- `critical_claim_three_halves_power_integral_bound`（ラベル `three_halves_power_integral_bound`）

**具体版**（人手証明と同じ抽象度＝`a = 1/2`, `b = π` に固定した形）。
必要十分版は `Ising2D/NecSuf/LogDivergentIntegral.lean`
（`Ising2D.NecSuf.integral_inv_sqrt_quad` / `integral_inv_pow_three_half_le`）と
`Ising2D/NecSuf/HyperbolicBounds.lean`
（`Ising2D.NecSuf.log_two_mul_le_arsinh` / `arsinh_le_log_two_mul_add`）。
`arsinh_log_bounds` は人手の鎖と 1 対 1 に書き、必要十分版を使わない（特殊化としての導出は
`ClaimClosedFormLogIntegralFromNecSuf.lean` の `arsinh_log_bounds_of_necSuf`）。
ほかの主張は必要十分版の特殊化として導出してある。
-/
import Ising2D.NecSuf.LogDivergentIntegral
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfProduct
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRealLogStrictlyIncreasing

namespace Ising2D

open Real MeasureTheory

/-- **人手証明 `closed_form_log_integral`**:
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

/-- **人手証明 `arcsinh_two_sided_log_bounds`**: `log(2y) ≤ arcsinh y ≤ log(2y) + 1/(4y²)`。

人手の準備・下からの評価・上からの評価の鎖と 1 対 1 に書く。人手が引く主張のうち
`definition_of_sqrt_r_positive`・`sqrt_of_square_plus_one_is_positive`・`arcsinh_argument_times_conjugate_is_one`・
`arcsinh_argument_is_positive`・`arcsinh_argument_two_sided_bounds`・`log_one_plus_at_most_argument` には具体版の宣言が
無いので、証明の中の段で受ける。`arcsinh_argument_times_conjugate_is_one`・`arcsinh_argument_is_positive`・
`arcsinh_argument_two_sided_bounds` は人手の証明の鎖どおりに書き、`s² = y²+1` は mathlib の `Real.sq_sqrt`、
`s > 0` は mathlib の `Real.sqrt_pos`、`log(1+x) ≤ x` は mathlib の `Real.log_le_sub_one_of_pos` で受ける。 -/
theorem arsinh_log_bounds {y : ℝ} (hy : 0 < y) :
    Real.log (2 * y) ≤ Real.arsinh y ∧ Real.arsinh y ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) := by
  -- 準備: `s := √(y²+1)`
  set s := Real.sqrt (y ^ 2 + 1) with hs_def
  have hspos : 0 < s := Real.sqrt_pos.2 (by positivity)
                                        -- `sqrt_of_square_plus_one_is_positive` の `s > 0`
  have h2y : 0 < 2 * y := by positivity
  -- `arcsinh_argument_times_conjugate_is_one`: `(y+s)(s-y) = 1`
  have hsq : s ^ 2 = y ^ 2 + 1 := Real.sq_sqrt (by positivity)
                                        -- `definition_of_sqrt_r_positive` の `s² = y²+1`
  have hconj : (y + s) * (s - y) = 1 :=
    calc (y + s) * (s - y) = y * s - y ^ 2 + s ^ 2 - s * y := by ring
                                        -- 分配律
      _ = s ^ 2 - y ^ 2 := by ring      -- `ys = sy` と項の並べ替え
      _ = (y ^ 2 + 1) - y ^ 2 := by rw [hsq]
                                        -- `s² = y²+1`
      _ = 1 := by ring                  -- ℝ の四則
  -- `arcsinh_argument_is_positive`: `p := y + s`, `q := s - y` について `p + q > 0` と背理法で `p > 0`
  have hys : 0 < y + s := by
    have hpq : (y + s) + (s - y) > 0 :=
      calc (y + s) + (s - y) = (y + s) + (s - y) := rfl
                                        -- `p`, `q` の置き方
        _ = 2 * s := by ring            -- ℝ の四則
        _ > 2 * 0 := by linarith        -- `s > 0` の両辺に `2 > 0` を掛ける
        _ = 0 := by ring                -- ℝ の四則
    by_contra hp
    have hp' : y + s < 0 := by
      rcases lt_or_eq_of_le (not_lt.1 hp) with h | h
      · exact h
      · rw [h, zero_mul] at hconj; exact absurd hconj (by norm_num)
                                        -- `p = 0` なら `pq = 0 ≠ 1`
    have hq : s - y < 0 := by
      by_contra hq
      have : (y + s) * (s - y) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hp'.le (not_lt.1 hq)
      linarith                          -- `q ≥ 0` なら `pq ≤ 0 < 1`
    linarith                            -- 負の実数の和は負で、`p + q > 0` に反する
  have h4 : 0 < 1 + 1 / (4 * y ^ 2) := by positivity
  -- `arcsinh_argument_two_sided_bounds` の準備: `s - y = 1/(y+s)`
  have hsub : s - y = 1 / (y + s) :=
    calc s - y = (y + s) * (s - y) / (y + s) := by field_simp
                                        -- `y + s ≠ 0` で約分の逆
      _ = 1 / (y + s) := by rw [hconj]  -- `arcsinh_argument_times_conjugate_is_one`
  -- `arcsinh_argument_two_sided_bounds` の下からの評価: `y + s ≥ 2y`
  have hlow : y + s ≥ 2 * y :=
    calc y + s = 2 * y + (s - y) := by ring
                                        -- ℝ の四則
      _ = 2 * y + 1 / (y + s) := by rw [hsub]
                                        -- 準備の鎖
      _ ≥ 2 * y := by
            have : 0 < 1 / (y + s) := by positivity
            linarith                    -- `y + s > 0` より `1/(y+s) > 0`
  -- `arcsinh_argument_two_sided_bounds` の上からの評価: `y + s ≤ 2y + 1/(2y)`
  have hinv : 1 / (y + s) ≤ 1 / (2 * y) :=
    calc 1 / (y + s) = 2 * y * (1 / ((y + s) * (2 * y))) := by field_simp
                                        -- ℝ の四則。`y+s ≠ 0`, `2y ≠ 0`
      _ ≤ (y + s) * (1 / ((y + s) * (2 * y))) :=
            mul_le_mul_of_nonneg_right hlow (by positivity)
                                        -- `2y ≤ y+s` の両辺に正の数を掛ける
      _ = 1 / (2 * y) := by field_simp  -- 約分
  have hhigh : y + s ≤ 2 * y + 1 / (2 * y) :=
    calc y + s = 2 * y + (s - y) := by ring
                                        -- ℝ の四則
      _ = 2 * y + 1 / (y + s) := by rw [hsub]
                                        -- 準備の鎖
      _ ≤ 2 * y + 1 / (2 * y) := by linarith
                                        -- `1/(y+s) ≤ 1/(2y)`
  refine ⟨?_, ?_⟩
  · -- 下からの評価
    show Real.arsinh y ≥ Real.log (2 * y)
    calc Real.arsinh y = Real.log (y + s) := arsinh_eq_log_form y
                                        -- `def_arcsinh`
      _ ≥ Real.log (2 * y) := by
            rcases lt_or_eq_of_le hlow with h | h
            · exact (real_log_strictly_increasing h2y hys h).le
                                        -- `2y < y+s` なら `real_log_strictly_increasing`
            · rw [h]                    -- `2y = y+s` なら等号
  · -- 上からの評価
    have h2y' : 0 < 2 * y + 1 / (2 * y) := by positivity
    calc Real.arsinh y = Real.log (y + s) := arsinh_eq_log_form y
                                        -- `def_arcsinh`
      _ ≤ Real.log (2 * y + 1 / (2 * y)) := by
            rcases lt_or_eq_of_le hhigh with h | h
            · exact (real_log_strictly_increasing hys h2y' h).le
                                        -- 狭義なら `real_log_strictly_increasing`
            · rw [h]                    -- 等しければ等号
      _ = Real.log (2 * y + 2 * y * (1 / (4 * y ^ 2))) := by
            congr 1; field_simp; ring   -- `1/(2y) = 2y · 1/(4y²)`。ℝ の四則
      _ = Real.log (2 * y * (1 + 1 / (4 * y ^ 2))) := by
            rw [mul_add, mul_one]       -- 分配律
      _ = Real.log (2 * y) + Real.log (1 + 1 / (4 * y ^ 2)) :=
            (real_log_of_product h2y h4).2
                                        -- `real_log_of_product`
      _ ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) := by
            have := Real.log_le_sub_one_of_pos h4
            linarith                    -- `log_one_plus_at_most_argument` を `x = 1/(4y²) ≥ 0` に

/-- **人手証明 `log_integral_two_sided_bounds`**:
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

/-- **人手証明 `three_halves_power_integral_bound`**:
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
