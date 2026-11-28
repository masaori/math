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
`integral_inv_sqrt_pi`・`arsinh_log_bounds`・`integral_inv_pow_three_half_pi` は人手の鎖と 1 対 1 に書き、必要十分版を
使わない（特殊化としての導出は `ClaimClosedFormLogIntegralFromNecSuf.lean` の `integral_inv_sqrt_pi_of_necSuf`・
`arsinh_log_bounds_of_necSuf`・`integral_inv_pow_three_half_pi_of_necSuf`）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfPositivesIsPositive
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealSquareIsNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealInverseOfPositiveIsPositive
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanTwo
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealQuotient
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealStrictOrder
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfProduct
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRealLogStrictlyIncreasing
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSqrtOfRealOneIsOne
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSqrtOfPositiveRealIsPositive
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusZeroIsSelf
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

namespace Ising2D

open Real MeasureTheory

/-- **人手証明 `closed_form_log_integral`**:
`∫_0^π dθ/√(δ² + θ²/4) = 2 arcsinh(π/(2δ))`。

人手の準備・`F'` の鎖・`F(0)` の鎖・積分の鎖と 1 対 1 に書く。人手が引く主張のうち
`definition_of_sqrt_r_positive`・`sqrt_nonnegative_existence_uniqueness`・`remark_real_analysis_facts_R3_R4`・
`scalar_exp_zero`・`def_real_logarithm_positive` には具体版の宣言が無いので、証明の中の段で受ける。
`arcsinh_derivative` にも具体版の宣言が無いので、`hasDerivAt_arsinh_form`（mathlib の `Real.hasDerivAt_arsinh` の
言い換え）で受ける。`W(θ)² = δ²+θ²/4` は mathlib の `Real.sq_sqrt`、平方根の一意性は `Real.sqrt_eq_iff_eq_sq`、
微分の公式は mathlib の `hasDerivAt_id`・`hasDerivAt_id'`・`HasDerivAt.mul`・`HasDerivAt.div_const`・`HasDerivAt.const_add`・
`HasDerivAt.const_mul`・`HasDerivAt.comp`・`HasDerivAt.sqrt`・`HasDerivAt.inv`、「微分可能な関数は連続」は
`HasDerivAt.continuousAt`、(R4) は `intervalIntegral.integral_eq_sub_of_hasDerivAt`、`exp 0 = 1` は
`Real.exp_zero`、`log(exp x) = x` は `Real.log_exp` で受ける。準備の `0 < δ²` は人手の鎖どおり
`real_product_of_positives_is_positive` と `square_of_real_number_is_product` で、`δ ≠ 0`・`0 ≤ δ⁻¹`・`W(θ) > 0`・
`W(θ)/δ ≥ 0` は人手の鎖どおり `def_real_strict_order`・論理積の前半と後半・等号の対称律の対偶・
`real_inverse_of_positive_is_positive`・`sqrt_of_positive_real_is_positive`・順序と乗法の両立（`mul_nonneg`）・
`def_real_quotient` で受ける。`4 ≠ 0`・`0 ≤ 4⁻¹`・`0 ≤ θ²/4`・`δ² ≤ δ²+θ²/4`・`0 < δ²+θ²/4` も人手の鎖どおり、
有理数の大小比較の `0 < 4`（`norm_num`）・`real_square_is_nonnegative`・加法の単位元（`zero_add`）・順序と加法の両立
（`add_le_add_left`）・加法の交換律（`add_comm`）・順序の推移律（`le_trans`）・反対称律（`le_antisymm`）で受ける。
人手は `θ ∈ [0,π]` について述べるが、この鎖は `θ ≥ 0` を使わないので Lean は `θ ∈ ℝ` 全体で述べる。 -/
theorem integral_inv_sqrt_pi {δ : ℝ} (hδ : 0 < δ) :
    (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹)
      = 2 * Real.arsinh (Real.pi / (2 * δ)) := by
  -- 準備: `q(θ) := θ/(2δ)`, `F(θ) := 2 arcsinh(q(θ))`, `W(θ) := √(δ² + θ²/4)`
  set q : ℝ → ℝ := fun θ => θ / (2 * δ) with hq_def
  set F : ℝ → ℝ := fun θ => 2 * Real.arsinh (q θ) with hF_def
  -- 準備の `0 < δ²` の鎖
  have hδsq : 0 < δ ^ 2 :=
    calc 0 < δ * δ := real_product_of_positives_is_positive δ δ hδ hδ
                                        -- 仮定の `0 < δ` に `real_product_of_positives_is_positive`（`a → δ, b → δ`）
      _ = δ ^ 2 := (square_of_real_number_is_product δ).symm
                                        -- `square_of_real_number_is_product`（`r → δ`）を右辺から左辺へ
  -- 準備の `δ ≠ 0` の鎖
  have hδ' : 0 ≤ δ ∧ (0 : ℝ) ≠ δ := (real_lt_iff_le_and_ne 0 δ).mp hδ
                                        -- `def_real_strict_order`（`x → 0, y → δ`）
  have hδne : δ ≠ 0 := fun h => hδ'.2 h.symm
                                        -- 論理積の後半と、等号の対称律（`x → δ, y → 0`）の対偶
  -- 準備の `0 ≤ δ⁻¹` の鎖
  have hδinv : 0 ≤ δ⁻¹ :=
    ((real_lt_iff_le_and_ne 0 δ⁻¹).mp (real_inverse_of_positive_is_positive δ hδ)).1
                                        -- `real_inverse_of_positive_is_positive`（`a → δ`）、
                                        -- `def_real_strict_order`（`x → 0, y → δ⁻¹`）、論理積の前半
  -- 準備の `4 ≠ 0` と `0 ≤ 4⁻¹` の鎖
  have h4 : (0 : ℝ) < 4 := by norm_num  -- 有理数の大小比較の `0 < 4`
  have h4' : 0 ≤ (4 : ℝ) ∧ (0 : ℝ) ≠ 4 := (real_lt_iff_le_and_ne 0 4).mp h4
                                        -- `def_real_strict_order`（`x → 0, y → 4`）
  have h4ne : (4 : ℝ) ≠ 0 := fun h => h4'.2 h.symm
                                        -- 論理積の後半と、等号の対称律（`x → 4, y → 0`）の対偶
  have h4inv : 0 ≤ (4 : ℝ)⁻¹ :=
    ((real_lt_iff_le_and_ne 0 (4 : ℝ)⁻¹).mp (real_inverse_of_positive_is_positive 4 h4)).1
                                        -- `real_inverse_of_positive_is_positive`（`a → 4`）、
                                        -- `def_real_strict_order`（`x → 0, y → 4⁻¹`）、論理積の前半
  -- 準備の `0 ≤ θ²/4` の鎖
  have hθ4 : ∀ θ : ℝ, 0 ≤ θ ^ 2 / 4 := fun θ => by
    have h : 0 ≤ θ ^ 2 * (4 : ℝ)⁻¹ := mul_nonneg (real_square_is_nonnegative θ) h4inv
                                        -- `real_square_is_nonnegative`（`r → θ`）と順序と乗法の両立（`x → θ², y → 4⁻¹`）
    rw [real_div_eq_mul_inv (θ ^ 2) 4 h4ne]
                                        -- `def_real_quotient`（`y → θ², z → 4`）を右辺から左辺へ。`4 ≠ 0`
    exact h
  -- 準備の `δ² ≤ δ² + θ²/4` の鎖
  have hδle : ∀ θ : ℝ, δ ^ 2 ≤ δ ^ 2 + θ ^ 2 / 4 := fun θ =>
    calc δ ^ 2 = 0 + δ ^ 2 := (zero_add (δ ^ 2)).symm
                                        -- 加法の単位元 `0 + x = x`（`x → δ²`）を右辺から左辺へ
      _ ≤ θ ^ 2 / 4 + δ ^ 2 := add_le_add_left (hθ4 θ) (δ ^ 2)
                                        -- 順序と加法の両立（`x → 0, y → θ²/4, t → δ²`）
      _ = δ ^ 2 + θ ^ 2 / 4 := add_comm (θ ^ 2 / 4) (δ ^ 2)
                                        -- 加法の交換律（`x → θ²/4, y → δ²`）
  -- 準備の `0 < δ² + θ²/4` の鎖
  have hδsq' : 0 ≤ δ ^ 2 ∧ (0 : ℝ) ≠ δ ^ 2 := (real_lt_iff_le_and_ne 0 (δ ^ 2)).mp hδsq
                                        -- `def_real_strict_order`（`x → 0, y → δ²`）
  have hrad_le : ∀ θ : ℝ, 0 ≤ δ ^ 2 + θ ^ 2 / 4 := fun θ => le_trans hδsq'.1 (hδle θ)
                                        -- 順序の推移律（`x → 0, y → δ², t → δ² + θ²/4`）
  have hrad_ne : ∀ θ : ℝ, (0 : ℝ) ≠ δ ^ 2 + θ ^ 2 / 4 := fun θ e => by
    have h1 : δ ^ 2 ≤ 0 := by rw [e]; exact hδle θ
                                        -- 上の `δ² ≤ δ² + θ²/4` の右辺に代入
    have h2 : δ ^ 2 = 0 := le_antisymm h1 hδsq'.1
                                        -- 上の `0 ≤ δ²` と順序の反対称律（`x → δ², y → 0`）
    exact hδsq'.2 h2.symm              -- 等号の対称律で `0 = δ²`。上の `0 ≠ δ²` に反する
  have hrad : ∀ θ : ℝ, 0 < δ ^ 2 + θ ^ 2 / 4 := fun θ =>
    (real_lt_iff_le_and_ne 0 _).mpr ⟨hrad_le θ, hrad_ne θ⟩
                                        -- `def_real_strict_order`（`x → 0, y → δ² + θ²/4`）を右辺から左辺へ
  -- `0 ≤ δ² + θ²/4` なので `W(θ) := √(δ² + θ²/4)` と置く
  set W : ℝ → ℝ := fun θ => Real.sqrt (δ ^ 2 + θ ^ 2 / 4) with hW_def
  -- `W(θ)² = δ² + θ²/4`（`definition_of_sqrt_r_positive`）
  have hWsq : ∀ θ : ℝ, W θ ^ 2 = δ ^ 2 + θ ^ 2 / 4 := fun θ => Real.sq_sqrt (hrad_le θ)
  -- `0 < W(θ)`、したがって `0 ≤ W(θ)` と `W(θ) ≠ 0`
  have hWpos : ∀ θ : ℝ, 0 < W θ := fun θ => sqrt_of_positive_real_is_positive _ (hrad θ)
                                        -- `sqrt_of_positive_real_is_positive`（`x → δ² + θ²/4`）と `W` の置き方
  have hWle_ne : ∀ θ : ℝ, 0 ≤ W θ ∧ W θ ≠ 0 := fun θ =>
    have h : 0 ≤ W θ ∧ (0 : ℝ) ≠ W θ := (real_lt_iff_le_and_ne 0 (W θ)).mp (hWpos θ)
                                        -- `def_real_strict_order`（`x → 0, y → W(θ)`）
    ⟨h.1, fun e => h.2 e.symm⟩         -- 等号の対称律（`x → W(θ), y → 0`）の対偶を後半に
  have hWnonneg : ∀ θ : ℝ, 0 ≤ W θ := fun θ => (hWle_ne θ).1
  have hWne : ∀ θ : ℝ, W θ ≠ 0 := fun θ => (hWle_ne θ).2
  -- 本文の準備の `W(θ)/δ ≥ 0`
  have hWdnonneg : ∀ θ : ℝ, 0 ≤ W θ / δ := fun θ => by
    have h : 0 ≤ W θ * δ⁻¹ := mul_nonneg (hWnonneg θ) hδinv
                                        -- 順序と乗法の両立（`x → W(θ), y → δ⁻¹`。`set_and_algebra_notation`）
    rw [real_div_eq_mul_inv (W θ) δ hδne]
                                        -- `def_real_quotient`（`y → W(θ), z → δ`）を右辺から左辺へ。`δ ≠ 0`
    exact h
  -- `(W(θ)/δ)² = q(θ)² + 1`
  have hWdsq : ∀ θ : ℝ, (W θ / δ) ^ 2 = q θ ^ 2 + 1 := by
    intro θ
    calc (W θ / δ) ^ 2 = W θ ^ 2 / δ ^ 2 := by rw [div_pow]
                                        -- ℝ の四則
      _ = (δ ^ 2 + θ ^ 2 / 4) / δ ^ 2 := by rw [hWsq θ]
                                        -- `definition_of_sqrt_r_positive`
      _ = (θ / (2 * δ)) ^ 2 + 1 := by field_simp; ring
                                        -- ℝ の四則。`δ ≠ 0`
      _ = q θ ^ 2 + 1 := rfl            -- `q` の置き方
  -- `sqrt_nonnegative_existence_uniqueness` の一意性: `√(q(θ)²+1) = W(θ)/δ`
  have hsqrtq : ∀ θ : ℝ, Real.sqrt (q θ ^ 2 + 1) = W θ / δ := fun θ =>
    (Real.sqrt_eq_iff_eq_sq (by positivity) (hWdnonneg θ)).mpr
      (hWdsq θ).symm
  -- 微分の公式（定数倍と恒等関数。`θ/(2δ)` は恒等関数の `1/(2δ)` 倍）: `q'(θ) = 1/(2δ)`
  have hq' : ∀ θ : ℝ, HasDerivAt q (1 / (2 * δ)) θ := by
    intro θ
    have h := (hasDerivAt_id θ).div_const (2 * δ)
    simpa [hq_def] using h
  -- `F'(θ) = 1/W(θ)`
  have hF' : ∀ θ : ℝ, HasDerivAt F (W θ)⁻¹ θ := by
    intro θ
    -- 本文の `F'` の鎖の 1〜3 行目: 微分の公式の定数倍と合成（`arcsinh_derivative` より `arcsinh` は微分可能で
    -- `arcsinh'(q(θ)) = 1/√(q(θ)²+1)`）と `q'(θ) = 1/(2δ)`。`HasDerivAt` は導関数の値と組で出るので一段になる
    have hcomp : HasDerivAt F (2 * ((1 / Real.sqrt (q θ ^ 2 + 1)) * (1 / (2 * δ)))) θ :=
      ((hasDerivAt_arsinh_form (q θ)).comp θ (hq' θ)).const_mul 2
    have hval : 2 * ((1 / Real.sqrt (q θ ^ 2 + 1)) * (1 / (2 * δ))) = (W θ)⁻¹ :=
      calc 2 * ((1 / Real.sqrt (q θ ^ 2 + 1)) * (1 / (2 * δ)))
          = 2 * ((1 / (W θ / δ)) * (1 / (2 * δ))) := by rw [hsqrtq θ]
                                        -- `√(q(θ)²+1) = W(θ)/δ`
        _ = 2 * ((δ / W θ) * (1 / (2 * δ))) := by rw [one_div_div]
                                        -- ℝ の四則。`W(θ) ≠ 0`
        _ = (W θ)⁻¹ := by field_simp    -- 約分
    rw [hval] at hcomp
    exact hcomp
  -- `W` は平方根と `ℝ_{>0}` に値をとる微分可能な関数 `θ ↦ δ² + θ²/4` の合成なので微分可能
  have hW' : ∀ θ : ℝ,
      HasDerivAt W (((1 * θ + θ * 1) / 4) / (2 * Real.sqrt (δ ^ 2 + θ ^ 2 / 4))) θ := by
    intro θ
    -- `θ²` は恒等関数どうしの積なので、積の微分の公式で `(θ·θ)' = 1·θ + θ·1`
    have hmul : HasDerivAt (fun t : ℝ => t ^ 2) (1 * θ + θ * 1) θ := by
      have h : HasDerivAt (fun t : ℝ => t * t) (1 * θ + θ * 1) θ :=
        (hasDerivAt_id' θ).mul (hasDerivAt_id' θ)
      have e : (fun t : ℝ => t * t) = fun t : ℝ => t ^ 2 := by
        funext t; rw [pow_two]
      rw [e] at h
      exact h
    have hinner : HasDerivAt (fun t : ℝ => δ ^ 2 + t ^ 2 / 4) ((1 * θ + θ * 1) / 4) θ :=
      (hmul.div_const 4).const_add (δ ^ 2)
                                        -- 微分の公式（定数倍と、定数との和）
    exact hinner.sqrt (ne_of_gt (hrad θ))
                                        -- 微分の公式（平方根と合成）
  -- `F' = 1/W` は分母が 0 でない商なので微分可能、したがって連続（微分の公式）
  have hcont : ContinuousOn (fun θ : ℝ => (W θ)⁻¹) (Set.uIcc 0 Real.pi) := by
    intro θ _
    exact ((hW' θ).inv (hWne θ)).continuousAt.continuousWithinAt
                                        -- 商の微分の公式と「微分可能な関数は連続」
  -- `F(0) = 0`
  have hF0 : F 0 = 0 :=
    calc F 0 = 2 * Real.arsinh 0 := by simp [hF_def, hq_def]
                                        -- `q(0) = 0`
      _ = 2 * Real.log (0 + Real.sqrt (0 ^ 2 + 1)) := by rw [arsinh_eq_log_form 0]
                                        -- `def_arcsinh`
      _ = 2 * Real.log (Real.sqrt 1) := by norm_num
                                        -- ℝ の四則
      _ = 2 * Real.log 1 := by rw [sqrt_of_real_one_is_one]
                                        -- `sqrt_of_real_one_is_one`
      _ = 2 * Real.log (Real.exp 0) := by rw [Real.exp_zero]
                                        -- `scalar_exp_zero`
      _ = 2 * 0 := by rw [Real.log_exp 0]
                                        -- `def_real_logarithm_positive` の `log(exp x) = x`
      _ = 0 := by ring
  calc (∫ θ in (0:ℝ)..Real.pi, (Real.sqrt (δ ^ 2 + θ ^ 2 / 4))⁻¹)
      = ∫ θ in (0:ℝ)..Real.pi, (W θ)⁻¹ := rfl
                                        -- `W` の置き方
    _ = F Real.pi - F 0 :=
          intervalIntegral.integral_eq_sub_of_hasDerivAt (fun θ _ => hF' θ)
            hcont.intervalIntegrable    -- 本文の `∫F'` への書き換え（`F'(θ) = 1/W(θ)`）と (R4) を `F` に
    _ = 2 * Real.arsinh (Real.pi / (2 * δ)) - F 0 := rfl
                                        -- `F` と `q` の置き方
    _ = 2 * Real.arsinh (Real.pi / (2 * δ)) - 0 := by rw [hF0]
                                        -- `F(0) = 0`
    _ = 2 * Real.arsinh (Real.pi / (2 * δ)) :=
          real_minus_zero_is_self _     -- `real_minus_zero_is_self`（`a → 2 arcsinh(π/(2δ))`）

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

人手の準備・`w'`・`r'`・`G'` の鎖・`G'` の連続性・正値性の段・背理法の鎖・`1/r(π)` の鎖・積分の鎖と 1 対 1 に書く。
3/2 乗は `def_three_halves_power` どおり `w·√w` と書く。人手が引く主張のうち `pi_is_positive`・
`definition_of_sqrt_r_positive`・`remark_real_analysis_facts_R3_R4`・`set_and_algebra_notation` には具体版の宣言が
無いので、証明の中の段で受ける。`π > 0` は mathlib の `Real.pi_pos`、`r(θ)² = w(θ)` は mathlib の `Real.sq_sqrt`、
微分の公式は mathlib の `hasDerivAt_id'`・`HasDerivAt.mul`・`HasDerivAt.const_mul`・`HasDerivAt.div_const`・
`HasDerivAt.const_add`・`HasDerivAt.sqrt`・`HasDerivAt.div`・`HasDerivAt.inv`（商 `1/x` を逆数で書く）、「微分可能な関数は連続」は
`HasDerivAt.continuousAt`、(R4) は `intervalIntegral.integral_eq_sub_of_hasDerivAt`、`r(θ) ≥ 0` は `Real.sqrt_nonneg`、
順序体の積の正値性は `real_product_of_positives_is_positive`、準備の `δ² = δδ` は `square_of_real_number_is_product`、逆数の正値性は `real_inverse_of_positive_is_positive`、
商は `def_real_quotient` の具体版 `real_div_eq_mul_inv` で受ける。 -/
theorem integral_inv_pow_three_half_pi {δ a : ℝ} (hδ : 0 < δ) (ha : 0 < a) :
    (∫ θ in (0:ℝ)..Real.pi,
        ((δ ^ 2 + a ^ 2 * θ ^ 2 / 4) * Real.sqrt (δ ^ 2 + a ^ 2 * θ ^ 2 / 4))⁻¹)
      ≤ 2 / (a * δ ^ 2) := by
  -- 準備: `w(θ) := δ² + a²θ²/4`, `r(θ) := √w(θ)`, `G(θ) := θ/(δ² r(θ))`
  set w : ℝ → ℝ := fun θ => δ ^ 2 + a ^ 2 * θ ^ 2 / 4 with hw_def
  set r : ℝ → ℝ := fun θ => Real.sqrt (w θ) with hr_def
  set G : ℝ → ℝ := fun θ => θ / (δ ^ 2 * r θ) with hG_def
  have hδne : δ ≠ 0 := ne_of_gt hδ
  -- 準備の `0 < δ²` の鎖
  have hδsq : 0 < δ ^ 2 :=
    calc 0 < δ * δ := real_product_of_positives_is_positive δ δ hδ hδ
                                        -- 仮定の `0 < δ` に `real_product_of_positives_is_positive`（`a → δ, b → δ`）
      _ = δ ^ 2 := (square_of_real_number_is_product δ).symm
                                        -- `square_of_real_number_is_product`（`r → δ`）を右辺から左辺へ
  -- 上の `0 < δ²` から `w(θ) ≥ δ² > 0`
  have hw : ∀ θ : ℝ, 0 < w θ := fun θ =>
    calc 0 < δ ^ 2 := hδsq              -- 上の `0 < δ²`
      _ ≤ δ ^ 2 + a ^ 2 * θ ^ 2 / 4 := by
            have := mul_nonneg (sq_nonneg a) (sq_nonneg θ); linarith
                                        -- `a²θ²/4 ≥ 0`
  -- `r(θ)² = w(θ)`（`definition_of_sqrt_r_positive`）
  have hrsq : ∀ θ : ℝ, r θ ^ 2 = w θ := fun θ => Real.sq_sqrt (hw θ).le
  -- `def_three_halves_power` と同じ理由で `r(θ) > 0`: `r(θ) ≥ 0` と `r(θ)² = w(θ) > 0`
  have hrne : ∀ θ : ℝ, r θ ≠ 0 := by
    intro θ hr0
    have h := hrsq θ
    rw [hr0] at h
    linarith [hw θ]                     -- `0² = 0 < w(θ)` に反する
  have hrpos : ∀ θ : ℝ, 0 < r θ := fun θ =>
    lt_of_le_of_ne (Real.sqrt_nonneg _) (hrne θ).symm
  -- `w'(θ) = a²θ/2`（微分の公式の和・定数倍・積と、定数関数の導関数 0、恒等関数の導関数 1）
  have hw' : ∀ θ : ℝ, HasDerivAt w (a ^ 2 * θ / 2) θ := by
    intro θ
    have hmul : HasDerivAt (fun t : ℝ => t * t) (1 * θ + θ * 1) θ :=
      (hasDerivAt_id' θ).mul (hasDerivAt_id' θ)
    have h : HasDerivAt (fun t : ℝ => δ ^ 2 + a ^ 2 * (t * t) / 4) (a ^ 2 * (1 * θ + θ * 1) / 4) θ :=
      ((hmul.const_mul (a ^ 2)).div_const 4).const_add (δ ^ 2)
    have e : (fun t : ℝ => δ ^ 2 + a ^ 2 * (t * t) / 4) = w := by
      funext t; show _ = δ ^ 2 + a ^ 2 * t ^ 2 / 4; rw [pow_two t]
    have hv : a ^ 2 * (1 * θ + θ * 1) / 4 = a ^ 2 * θ / 2 := by ring
                                        -- ℝ の四則
    rw [e, hv] at h
    exact h
  -- `r'(θ) = a²θ/(4 r(θ))`
  have hr' : ∀ θ : ℝ, HasDerivAt r (a ^ 2 * θ / (4 * r θ)) θ := by
    intro θ
    -- 微分の公式の平方根と合成（`w(θ) > 0`）
    have h : HasDerivAt r (a ^ 2 * θ / 2 / (2 * Real.sqrt (w θ))) θ :=
      (hw' θ).sqrt (ne_of_gt (hw θ))
    have hval : a ^ 2 * θ / 2 / (2 * Real.sqrt (w θ)) = a ^ 2 * θ / (4 * r θ) :=
      calc a ^ 2 * θ / 2 / (2 * Real.sqrt (w θ))
          = 1 / (2 * r θ) * (a ^ 2 * θ / 2) := by
            ring
                                        -- `r` の置き方と `w'(θ) = a²θ/2`
        _ = a ^ 2 * θ / (4 * r θ) := by
            field_simp; ring            -- ℝ の四則
    rw [hval] at h
    exact h
  -- `G'(θ) = 1/w(θ)^{3/2}`
  have hG' : ∀ θ : ℝ, HasDerivAt G (w θ * Real.sqrt (w θ))⁻¹ θ := by
    intro θ
    have hdne : δ ^ 2 * r θ ≠ 0 := mul_ne_zero (pow_ne_zero 2 hδne) (hrne θ)
    -- 微分の公式の商と定数倍（`δ² r(θ) ≠ 0`）と `r'(θ) = a²θ/(4r(θ))`。`HasDerivAt` は導関数の値と組で出るので
    -- 本文の `G'` の鎖の 1・2 行目は一段になる
    have h : HasDerivAt G
        ((1 * (δ ^ 2 * r θ) - θ * (δ ^ 2 * (a ^ 2 * θ / (4 * r θ)))) / (δ ^ 2 * r θ) ^ 2) θ :=
      (hasDerivAt_id' θ).div ((hr' θ).const_mul (δ ^ 2)) hdne
    have hr0 := hrne θ
    have hval : (1 * (δ ^ 2 * r θ) - θ * (δ ^ 2 * (a ^ 2 * θ / (4 * r θ)))) / (δ ^ 2 * r θ) ^ 2
        = (w θ * Real.sqrt (w θ))⁻¹ :=
      calc (1 * (δ ^ 2 * r θ) - θ * (δ ^ 2 * (a ^ 2 * θ / (4 * r θ)))) / (δ ^ 2 * r θ) ^ 2
          = (δ ^ 2 * r θ - δ ^ 2 * (a ^ 2 * θ ^ 2 / (4 * r θ))) / (δ ^ 4 * r θ ^ 2) := by
            ring                        -- ℝ の四則
        _ = (δ ^ 2 * r θ ^ 2 - δ ^ 2 * (a ^ 2 * θ ^ 2 / 4)) / (δ ^ 4 * r θ ^ 3) := by
            field_simp                  -- 分子と分母に `r(θ)` を掛ける
        _ = δ ^ 2 * (r θ ^ 2 - a ^ 2 * θ ^ 2 / 4) / (δ ^ 4 * r θ ^ 3) := by
            rw [mul_sub]                -- 分配律
        _ = δ ^ 2 * δ ^ 2 / (δ ^ 4 * r θ ^ 3) := by
            rw [hrsq θ, hw_def]; ring   -- `r(θ)² = w(θ) = δ² + a²θ²/4`
        _ = 1 / (r θ ^ 2 * r θ) := by
            field_simp                  -- 約分
        _ = 1 / (w θ * Real.sqrt (w θ)) := by
            rw [hrsq θ]                 -- `r(θ)² = w(θ)` と `r` の置き方
        _ = (w θ * Real.sqrt (w θ))⁻¹ := one_div _
                                        -- `def_three_halves_power`
    rw [hval] at h
    exact h
  -- `G'` は分母が 0 でない微分可能な関数の商なので微分可能、したがって連続（微分の公式）
  have hcont : ContinuousOn (fun θ : ℝ => (w θ * Real.sqrt (w θ))⁻¹) (Set.uIcc 0 Real.pi) := by
    intro θ _
    exact (((hw' θ).mul (hr' θ)).inv (mul_ne_zero (ne_of_gt (hw θ)) (hrne θ))).continuousAt.continuousWithinAt
                                        -- 積と商（`1/x` を逆数で書く）の微分の公式と「微分可能な関数は連続」
  -- 正値性の段
  have hpi : 0 < Real.pi := Real.pi_pos -- `pi_is_positive`
  have hapi : 0 < a * Real.pi := real_product_of_positives_is_positive a Real.pi ha hpi
                                        -- `real_product_of_positives_is_positive`（`a → a, b → π`）
  have hapine : a * Real.pi ≠ 0 := fun h => ((real_lt_iff_le_and_ne 0 _).1 hapi).2 h.symm
                                        -- `def_real_strict_order` の `≠` の側（`x → 0, y → aπ`）と等号の対称律
  have hapi2 : 0 < a * Real.pi / 2 := by
    have h : 0 < a * Real.pi * (1 / 2) := real_product_of_positives_is_positive _ _ hapi (by norm_num)
                                        -- `0 < 1/2`（有理数の大小比較）と `real_product_of_positives_is_positive`
    rwa [mul_one_div] at h
  have hapir : 0 < a * Real.pi * r Real.pi := real_product_of_positives_is_positive _ _ hapi (hrpos Real.pi)  -- 同じ理由（`b → r(π)`）
  have hapirne : a * Real.pi * r Real.pi ≠ 0 := fun h => ((real_lt_iff_le_and_ne 0 _).1 hapir).2 h.symm
                                        -- `def_real_strict_order` の `≠` の側（`x → 0, y → aπr(π)`）と等号の対称律
  have hinvapir : 0 < (a * Real.pi * r Real.pi)⁻¹ := real_inverse_of_positive_is_positive _ hapir
                                        -- `real_inverse_of_positive_is_positive`（`a → aπr(π)`）
  have h2apir : 0 < 2 / (a * Real.pi * r Real.pi) := by
    have h : 0 < 2 * (a * Real.pi * r Real.pi)⁻¹ :=
      real_product_of_positives_is_positive _ _ real_zero_less_than_two hinvapir
                                        -- `real_zero_less_than_two` と `real_product_of_positives_is_positive`（`a → 2, b → (aπr(π))^{-1}`）
    rwa [← real_div_eq_mul_inv 2 _ hapirne] at h
                                        -- `def_real_quotient`（`y → 2, z → aπr(π)`）を右辺から左辺へ
  have hδ2ne : δ ^ 2 ≠ 0 := fun h => ((real_lt_iff_le_and_ne 0 _).1 hδsq).2 h.symm
                                        -- `def_real_strict_order` の `≠` の側（`x → 0, y → δ²`）と等号の対称律
  have hinvδ2 : 0 < (δ ^ 2)⁻¹ := real_inverse_of_positive_is_positive _ hδsq
                                        -- `real_inverse_of_positive_is_positive`（`a → δ²`）
  have hpiδ2 : 0 < Real.pi / δ ^ 2 := by
    have h : 0 < Real.pi * (δ ^ 2)⁻¹ := real_product_of_positives_is_positive _ _ hpi hinvδ2
                                        -- `real_product_of_positives_is_positive`（`a → π, b → (δ²)^{-1}`）
    rwa [← real_div_eq_mul_inv Real.pi _ hδ2ne] at h
                                        -- `def_real_quotient`（`y → π, z → δ²`）を右辺から左辺へ
  -- 背理法: `r(π) ≤ aπ/2` なら `r(π)² < r(π)²`
  have hrgt : a * Real.pi / 2 < r Real.pi := by
    by_contra hle
    have hle' : r Real.pi ≤ a * Real.pi / 2 := not_lt.1 hle
    have hlt : r Real.pi ^ 2 < r Real.pi ^ 2 :=
      calc r Real.pi ^ 2 = r Real.pi * r Real.pi := pow_two _
        _ ≤ a * Real.pi / 2 * r Real.pi :=
              mul_le_mul_of_nonneg_right hle' (hrpos Real.pi).le
                                        -- 仮定の両辺に `r(π) > 0` を掛ける
        _ ≤ a * Real.pi / 2 * (a * Real.pi / 2) :=
              mul_le_mul_of_nonneg_left hle' hapi2.le
                                        -- 仮定の両辺に上の `aπ/2 > 0` を掛ける
        _ = a ^ 2 * Real.pi ^ 2 / 4 := by ring
        _ < δ ^ 2 + a ^ 2 * Real.pi ^ 2 / 4 := by linarith
                                        -- 上の `δ² > 0`
        _ = r Real.pi ^ 2 := (hrsq Real.pi).symm
                                        -- `r(π)² = w(π)`
    exact lt_irrefl _ hlt
  -- `1/r(π) ≤ 2/(aπ)`
  have hrπne : r Real.pi ≠ 0 := hrne Real.pi
  have hinvr : 1 / r Real.pi ≤ 2 / (a * Real.pi) :=
    calc 1 / r Real.pi
        = a * Real.pi / 2 * (2 / (a * Real.pi * r Real.pi)) := by
          field_simp                    -- ℝ の四則。上の `aπ ≠ 0` と `r(π) > 0`
      _ ≤ r Real.pi * (2 / (a * Real.pi * r Real.pi)) :=
          mul_le_mul_of_nonneg_right hrgt.le h2apir.le
                                        -- `aπ/2 < r(π)` の両辺に上の `2/(aπ r(π)) > 0` を掛ける
      _ = 2 / (a * Real.pi) := by
          field_simp                    -- 約分
  calc (∫ θ in (0:ℝ)..Real.pi,
          ((δ ^ 2 + a ^ 2 * θ ^ 2 / 4) * Real.sqrt (δ ^ 2 + a ^ 2 * θ ^ 2 / 4))⁻¹)
      = ∫ θ in (0:ℝ)..Real.pi, (w θ * Real.sqrt (w θ))⁻¹ := rfl
                                        -- `w` の置き方
    _ = G Real.pi - G 0 :=
          intervalIntegral.integral_eq_sub_of_hasDerivAt (fun θ _ => hG' θ)
            hcont.intervalIntegrable    -- 本文の `∫G'` への書き換え（`G'(θ) = 1/w(θ)^{3/2}`）と (R4) を `G` に
    _ = Real.pi / (δ ^ 2 * r Real.pi) - 0 / (δ ^ 2 * r 0) := rfl
                                        -- `G` の置き方
    _ = Real.pi / δ ^ 2 * (1 / r Real.pi) := by
          rw [zero_div, sub_zero]; ring -- ℝ の四則
    _ ≤ Real.pi / δ ^ 2 * (2 / (a * Real.pi)) :=
          mul_le_mul_of_nonneg_left hinvr hpiδ2.le
                                        -- `1/r(π) ≤ 2/(aπ)` の両辺に上の `π/δ² > 0` を掛ける
    _ = 2 / (a * δ ^ 2) := by
          field_simp                    -- 約分

end Ising2D
