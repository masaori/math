/-
# `i(-θ)_ℂ = -(iθ_ℂ)`・`-(i(-θ)_ℂ) = iθ_ℂ`・`(cos(-θ))_ℂ = (cos θ)_ℂ`・`(sin(-θ))_ℂ = -(sin θ)_ℂ`

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_claim_i_times_negated_real_is_negation_of_i_times`（ラベル `i_times_negated_real_is_negation_of_i_times`）
- `calculation_formulae_claim_negation_of_i_times_negated_real_is_i_times`（ラベル `negation_of_i_times_negated_real_is_i_times`）
- `calculation_formulae_claim_cos_of_negated_real`（ラベル `cos_of_negated_real`）
- `calculation_formulae_claim_sin_of_negated_real`（ラベル `sin_of_negated_real`）

各定理は人手の鎖と 1 行ずつの `calc` である。
- 人手の `-(iθ_ℂ)` は `multiply_by_minus_one` の符号反転で、Lean の `-(Complex.I * (θ : ℂ))` である。
- 人手の `-1_ℂ` は `inclusion_rr_to_cc` の像 `(-1)_ℂ` で、Lean では `((-1 : ℝ) : ℂ)` と `-1 : ℂ` の
  2 つの書き方がある。行き来は略記の読み替えの段（`Complex.ofReal_neg`・`Complex.ofReal_one`）で行う。
- 分母の `2` は人手どおり `2_ℂ`（Lean の `(2 : ℂ)`）である。
- 人手 `euler_formula_cos_sin` の読み `euler_cos_real_inclusion`・`euler_sin_real_inclusion` は
  同じフォルダの `ClaimEulerFormulaCosSin.lean` にある（人手が未整備のため mathlib で受けている）。
- 人手 `multiply_by_minus_one`・`complex_numbers_form_a_field` の性質（`-(-z) = z`・`b - a = -(a - b)`・`(-x)/y = -(x/y)`）は
  具体版が Lean に無く、mathlib の `neg_one_mul`・`neg_neg`・`neg_sub`・`neg_div` で 1 段ずつ受ける。

必要十分版は置かない。`I_mul_real_neg_eq_neg_I_mul`・`neg_I_mul_real_neg_eq_I_mul` は積の結合律・可換律と `-x = (-1)x`、
`-(-z) = z` を 1 回ずつ当てるだけで、可換環で同じ段が通る（取り払える構造をこの説明以上に示す計算が無い）。
`real_inclusion_cos_neg`・`real_inclusion_sin_neg` は人手が未整備の `euler_formula_cos_sin`（mathlib で受けている）を前提にするので対象にならない。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

/-- 人手 `i_times_negated_real_is_negation_of_i_times`: `i(-θ)_ℂ = -(iθ_ℂ)`（人手の 6 行と、略記の読み替えの 1 段）。 -/
theorem I_mul_real_neg_eq_neg_I_mul (θ : ℝ) :
    Complex.I * ((-θ : ℝ) : ℂ) = -(Complex.I * (θ : ℂ)) :=
  calc Complex.I * ((-θ : ℝ) : ℂ)
      = Complex.I * (((-1) * θ : ℝ) : ℂ) := by
        rw [neg_one_mul]                          -- 1 行目: ℝ で `-a = (-1)a`（ℝ は体 `set_and_algebra_notation`、`a → θ`）
    _ = Complex.I * (((-1 : ℝ) : ℂ) * (θ : ℂ)) := by
        rw [real_inclusion_mul]                   -- 2 行目: `real_inclusion_preserves_product`（`a → -1`, `b → θ`）を右辺から左辺へ
    _ = Complex.I * ((-1 : ℂ) * (θ : ℂ)) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one] -- `(-1)_ℂ` を `-1_ℂ` と書く（`inclusion_rr_to_cc` の略記）
    _ = (Complex.I * (-1 : ℂ)) * (θ : ℂ) := by
        rw [mul_assoc]                            -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((-1 : ℂ) * Complex.I) * (θ : ℂ) := by
        rw [mul_comm Complex.I (-1 : ℂ)]          -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (-1 : ℂ) * (Complex.I * (θ : ℂ)) := by
        rw [mul_assoc]                            -- 5 行目: `complex_numbers_form_a_field` の積の結合律
    _ = -(Complex.I * (θ : ℂ)) := by
        rw [neg_one_mul]                          -- 6 行目: `multiply_by_minus_one`（`z → iθ`）を右辺から左辺へ

/-- 人手 `negation_of_i_times_negated_real_is_i_times`: `-(i(-θ)_ℂ) = iθ_ℂ`（人手の 2 行）。 -/
theorem neg_I_mul_real_neg_eq_I_mul (θ : ℝ) :
    -(Complex.I * ((-θ : ℝ) : ℂ)) = Complex.I * (θ : ℂ) :=
  calc -(Complex.I * ((-θ : ℝ) : ℂ))
      = -(-(Complex.I * (θ : ℂ))) := by
        rw [I_mul_real_neg_eq_neg_I_mul]          -- 1 行目: `i_times_negated_real_is_negation_of_i_times`
    _ = Complex.I * (θ : ℂ) := by
        rw [neg_neg]                              -- 2 行目: ℂ で `-(-z) = z`（`complex_numbers_form_a_field`、`z → iθ`）

/-- 人手 `cos_of_negated_real`: `(cos(-θ))_ℂ = (cos θ)_ℂ`（人手の 5 行）。 -/
theorem real_inclusion_cos_neg (θ : ℝ) :
    ((Real.cos (-θ) : ℝ) : ℂ) = ((Real.cos θ : ℝ) : ℂ) :=
  calc ((Real.cos (-θ) : ℝ) : ℂ)
      = (Complex.exp (Complex.I * ((-θ : ℝ) : ℂ)) + Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ)))) / 2 :=
        euler_cos_real_inclusion (-θ)             -- 1 行目: `euler_formula_cos_sin` を `-θ` に適用
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) + Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ)))) / 2 := by
        rw [I_mul_real_neg_eq_neg_I_mul θ]        -- 2 行目: `i_times_negated_real_is_negation_of_i_times`
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) + Complex.exp (Complex.I * (θ : ℂ))) / 2 := by
        rw [neg_I_mul_real_neg_eq_I_mul]          -- 3 行目: `negation_of_i_times_negated_real_is_i_times`
    _ = (Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp (-(Complex.I * (θ : ℂ)))) / 2 := by
        rw [add_comm]                             -- 4 行目: `complex_numbers_form_a_field` の和の可換律
    _ = ((Real.cos θ : ℝ) : ℂ) :=
        (euler_cos_real_inclusion θ).symm         -- 5 行目: `euler_formula_cos_sin`

/-- 人手 `sin_of_negated_real`: `(sin(-θ))_ℂ = -(sin θ)_ℂ`（人手の 6 行）。 -/
theorem real_inclusion_sin_neg (θ : ℝ) :
    ((Real.sin (-θ) : ℝ) : ℂ) = -((Real.sin θ : ℝ) : ℂ) :=
  calc ((Real.sin (-θ) : ℝ) : ℂ)
      = (Complex.exp (Complex.I * ((-θ : ℝ) : ℂ)) - Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ))))
          / (2 * Complex.I) :=
        euler_sin_real_inclusion (-θ)             -- 1 行目: `euler_formula_cos_sin` を `-θ` に適用
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) - Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ))))
          / (2 * Complex.I) := by
        rw [I_mul_real_neg_eq_neg_I_mul θ]        -- 2 行目: `i_times_negated_real_is_negation_of_i_times`
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) - Complex.exp (Complex.I * (θ : ℂ))) / (2 * Complex.I) := by
        rw [neg_I_mul_real_neg_eq_I_mul]          -- 3 行目: `negation_of_i_times_negated_real_is_i_times`
    _ = (-(Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp (-(Complex.I * (θ : ℂ))))) / (2 * Complex.I) := by
        rw [neg_sub]                              -- 4 行目: ℂ で `b - a = -(a - b)`（`complex_numbers_form_a_field`）
    _ = -((Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp (-(Complex.I * (θ : ℂ)))) / (2 * Complex.I)) := by
        rw [neg_div]                              -- 5 行目: ℂ で `(-x)/y = -(x/y)`（`complex_numbers_form_a_field`）
    _ = -((Real.sin θ : ℝ) : ℂ) := by
        rw [euler_sin_real_inclusion θ]           -- 6 行目: `euler_formula_cos_sin`

end Ising2D
