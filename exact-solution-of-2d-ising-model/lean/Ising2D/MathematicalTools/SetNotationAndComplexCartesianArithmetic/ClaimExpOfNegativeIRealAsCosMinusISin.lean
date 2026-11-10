/-
# `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（具体版）

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_claim_exp_of_negative_i_real_as_cos_minus_i_sin`（ラベル `exp_of_negative_i_real_as_cos_minus_i_sin`）

`exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` は人手の主鎖の 22 行と 1 段ずつの `calc` である。
- 人手の `-iθ_ℂ` は `euler_formula_cos_sin` の読みのとおり `-(iθ_ℂ)`（Lean の `-(Complex.I * (θ : ℂ))`）、
  分母の `2` は `2_ℂ`（Lean の `(2 : ℂ)`）である。人手の `a`・`b` は `set` で置く。
- 人手 `euler_formula_cos_sin` の読み `euler_cos_real_inclusion`・`euler_sin_real_inclusion` は同じフォルダの
  `ClaimEulerFormulaCosSin.lean` にある（人手が全実数上の `cos`・`sin` を未整備とするため mathlib で受けている）。
- 人手の準備の第一の鎖（`1_ℂ + 1_ℂ = 2_ℂ`、4 行）は `exp_neg_I_prep_one_add_one`、
  準備の第二の鎖（`(a+b) - (a-b) = 2_ℂ b`、17 行）は `exp_neg_I_prep_add_sub_sub` で、どちらも人手の行と 1 段ずつの `calc` である。
  主鎖の 2 行目は第二の鎖を右辺から左辺へ引く。
- 人手 `def_complex_difference`（`z - w := z + (-w)`）は mathlib の `sub_eq_add_neg`、
  `multiply_by_minus_one`（`-z := (-1_ℂ) z`）は mathlib の `neg_one_mul` を右辺から左辺へ当てて受ける
  （Lean の `ℂ` の差と符号反転は mathlib の定義なので、人手の定義の式はこの 2 つの等式で読む。ほかのファイルと同じ）。
  `complex_numbers_form_a_field` の各公理は mathlib の `mul_add`・`add_mul`・`mul_assoc`・`one_mul`・`add_assoc`・`add_comm`・
  `add_neg_cancel`・`add_zero` を 1 段に 1 つずつ当てる。`(-1_ℂ)(-1_ℂ) = 1_ℂ` は `complex_minus_one_mul_minus_one`、
  `real_inclusion_preserves_sum` は `real_inclusion_add` である。
- 人手 `def_complex_quotient`（`z/w := zw^{-1}`）は mathlib の `div_eq_mul_inv`、`multiplicative_group_of_cc` の逆元
  （`w^{-1}w = 1_ℂ`・`ww^{-1} = 1_ℂ`）は `inv_mul_cancel₀`・`mul_inv_cancel₀` で受ける（Lean の `ℂ` の商と逆元は mathlib の定義なので、
  人手の定義の式はこの等式で読む）。前置きの `2_ℂ, i ≠ 0_ℂ` は `two_ne_zero`・`Complex.I_ne_zero`、`2_ℂi ≠ 0_ℂ` は
  `exp_neg_I_prep_two_mul_I_ne_zero`（`mul_ne_zero`。人手の「`ℂ^×` の群の積」）である。
- 人手の準備の第三の鎖（`i(2_ℂi)^{-1} = 2_ℂ^{-1}`、6 行）は `exp_neg_I_prep_I_mul_inv_two_mul_I` で、人手の行と 1 段ずつの `calc` である。
  `complex_numbers_form_a_field` の積の公理は mathlib の `one_mul`・`mul_one`・`mul_assoc`・`mul_comm` を 1 段に 1 つずつ当てる。

必要十分版は置かない。人手の証明は未整備の `euler_formula_cos_sin`（mathlib で受けている）を前提とし、
残る段は体の四則を 1 回ずつ当てるだけである。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の準備の第一の鎖（4 行）: `1_ℂ + 1_ℂ = 2_ℂ`。
Lean の `(1 : ℂ)`・`(2 : ℂ)` が人手の略記 `1_ℂ`・`2_ℂ`、`((r : ℝ) : ℂ)` が `r_ℂ` である。 -/
theorem exp_neg_I_prep_one_add_one : (1 : ℂ) + 1 = 2 :=
  calc (1 : ℂ) + 1
      = ((1 : ℝ) : ℂ) + ((1 : ℝ) : ℂ) := by rw [Complex.ofReal_one]   -- 1 行目: `1_ℂ` は略記 `r_ℂ` の `r = 1` を 2 か所へ
    _ = ((1 + 1 : ℝ) : ℂ) := real_inclusion_add 1 1                   -- 2 行目: `real_inclusion_preserves_sum`（`a → 1`, `b → 1`）
    _ = ((2 : ℝ) : ℂ) := by rw [one_add_one_eq_two]                    -- 3 行目: ℝ で `1 + 1 = 2`
    _ = 2 := Complex.ofReal_ofNat 2                                    -- 4 行目: `2_ℂ` は略記 `r_ℂ` の `r = 2`

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の準備の第二の鎖（17 行）: `(a+b) - (a-b) = 2_ℂ b`。 -/
theorem exp_neg_I_prep_add_sub_sub (a b : ℂ) : (a + b) - (a - b) = 2 * b :=
  calc (a + b) - (a - b)
      = (a + b) + (-(a - b)) := sub_eq_add_neg _ _
                                      -- 1 行目: `def_complex_difference`（`z → a+b`, `w → a-b`）
    _ = (a + b) + (-(a + (-b))) := by rw [sub_eq_add_neg a b]
                                      -- 2 行目: `def_complex_difference`（`z → a`, `w → b`）
    _ = (a + b) + (-1) * (a + (-b)) := by rw [neg_one_mul (a + (-b))]
                                      -- 3 行目: `multiply_by_minus_one`（`z → a+(-b)`）
    _ = (a + b) + ((-1) * a + (-1) * (-b)) := by rw [mul_add]
                                      -- 4 行目: `complex_numbers_form_a_field` の左からの分配律
    _ = (a + b) + ((-1) * a + (-1) * ((-1) * b)) := by rw [neg_one_mul b]
                                      -- 5 行目: `multiply_by_minus_one`（`z → b`）
    _ = (a + b) + ((-1) * a + ((-1) * (-1)) * b) := by rw [← mul_assoc (-1 : ℂ) (-1) b]
                                      -- 6 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (a + b) + ((-1) * a + 1 * b) := by rw [complex_minus_one_mul_minus_one]
                                      -- 7 行目: `minus_one_times_minus_one_is_one_in_cc`
    _ = (a + b) + ((-1) * a + b) := by rw [one_mul b]
                                      -- 8 行目: `complex_numbers_form_a_field` の積の単位元
    _ = (a + b) + ((-a) + b) := by rw [neg_one_mul a]
                                      -- 9 行目: `multiply_by_minus_one`（`z → a`）を右辺から左辺へ
    _ = ((a + b) + (-a)) + b := (add_assoc _ _ _).symm
                                      -- 10 行目: `complex_numbers_form_a_field` の加法の結合律
    _ = ((b + a) + (-a)) + b := by rw [add_comm a b]
                                      -- 11 行目: `complex_numbers_form_a_field` の加法の可換律
    _ = (b + (a + (-a))) + b := by rw [add_assoc b a (-a)]
                                      -- 12 行目: `complex_numbers_form_a_field` の加法の結合律
    _ = (b + 0) + b := by rw [add_neg_cancel a]
                                      -- 13 行目: `complex_numbers_form_a_field` の加法の逆元
    _ = b + b := by rw [add_zero b]
                                      -- 14 行目: `complex_numbers_form_a_field` の加法の単位元
    _ = 1 * b + 1 * b := by rw [one_mul b]
                                      -- 15 行目: `complex_numbers_form_a_field` の積の単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * b := (add_mul _ _ _).symm
                                      -- 16 行目: `complex_numbers_form_a_field` の右からの分配律を右辺から左辺へ
    _ = 2 * b := by rw [exp_neg_I_prep_one_add_one]
                                      -- 17 行目: 準備の第一の鎖

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の前置きの `2_ℂi ∈ ℂ^×`（`2_ℂ, i ∈ ℂ^×` と `multiplicative_group_of_cc` の群の積）。 -/
theorem exp_neg_I_prep_two_mul_I_ne_zero : (2 : ℂ) * Complex.I ≠ 0 :=
  mul_ne_zero two_ne_zero Complex.I_ne_zero

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の準備の第三の鎖（6 行）: `i(2_ℂi)^{-1} = 2_ℂ^{-1}`。 -/
theorem exp_neg_I_prep_I_mul_inv_two_mul_I : Complex.I * ((2 : ℂ) * Complex.I)⁻¹ = (2 : ℂ)⁻¹ :=
  calc Complex.I * ((2 : ℂ) * Complex.I)⁻¹
      = 1 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := (one_mul _).symm
                                      -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [inv_mul_cancel₀ (two_ne_zero : (2 : ℂ) ≠ 0)]
                                      -- 2 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹)) := mul_assoc _ _ _
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 : ℂ)⁻¹ * (((2 : ℂ) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [← mul_assoc (2 : ℂ) Complex.I]
                                      -- 4 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 : ℂ)⁻¹ * 1 := by rw [mul_inv_cancel₀ exp_neg_I_prep_two_mul_I_ne_zero]
                                      -- 5 行目: `multiplicative_group_of_cc` の逆元（`2_ℂi ∈ ℂ^×`）
    _ = (2 : ℂ)⁻¹ := mul_one _
                                      -- 6 行目: `complex_numbers_form_a_field` の積の単位元

/-- **人手 `exp_of_negative_i_real_as_cos_minus_i_sin`**: `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（`-iθ` は `-(iθ)`、人手の主鎖の 22 行）。 -/
theorem exp_neg_I_mul_real_eq_cos_sub_I_mul_sin (θ : ℝ) :
    Complex.exp (-(Complex.I * (θ : ℂ))) = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
  set a : ℂ := Complex.exp (Complex.I * (θ : ℂ))
  set b : ℂ := Complex.exp (-(Complex.I * (θ : ℂ)))
  calc b
      = 1 * b := (one_mul b).symm
                                                  -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * b := by rw [inv_mul_cancel₀ (two_ne_zero : (2 : ℂ) ≠ 0)]
                                                  -- 2 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * b) := mul_assoc _ _ _
                                                  -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 * b) * (2 : ℂ)⁻¹ := mul_comm _ _
                                                  -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (2 * b) / 2 := (div_eq_mul_inv _ _).symm
                                                  -- 5 行目: `def_complex_quotient`（`z → 2_ℂb`, `w → 2_ℂ`）を右辺から左辺へ
    _ = ((a + b) - (a - b)) / 2 := by rw [exp_neg_I_prep_add_sub_sub a b]
                                                  -- 6 行目: 準備の第二の鎖を右辺から左辺へ
    _ = ((a + b) - (a - b)) * (2 : ℂ)⁻¹ := div_eq_mul_inv _ _
                                                  -- 7 行目: `def_complex_quotient`（`z → (a+b)-(a-b)`, `w → 2_ℂ`）
    _ = ((a + b) + (-(a - b))) * (2 : ℂ)⁻¹ := by rw [sub_eq_add_neg (a + b) (a - b)]
                                                  -- 8 行目: `def_complex_difference`（`z → a+b`, `w → a-b`）
    _ = (a + b) * (2 : ℂ)⁻¹ + (-(a - b)) * (2 : ℂ)⁻¹ := add_mul _ _ _
                                                  -- 9 行目: `complex_numbers_form_a_field` の右からの分配律
    _ = (a + b) * (2 : ℂ)⁻¹ + ((-1) * (a - b)) * (2 : ℂ)⁻¹ := by rw [neg_one_mul (a - b)]
                                                  -- 10 行目: `multiply_by_minus_one`（`z → a-b`）
    _ = (a + b) * (2 : ℂ)⁻¹ + (-1) * ((a - b) * (2 : ℂ)⁻¹) := by rw [mul_assoc (-1 : ℂ) (a - b)]
                                                  -- 11 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (a + b) * (2 : ℂ)⁻¹ + (-((a - b) * (2 : ℂ)⁻¹)) := by rw [neg_one_mul ((a - b) * (2 : ℂ)⁻¹)]
                                                  -- 12 行目: `multiply_by_minus_one`（`z → (a-b)2_ℂ^{-1}`）を右辺から左辺へ
    _ = (a + b) * (2 : ℂ)⁻¹ - (a - b) * (2 : ℂ)⁻¹ := (sub_eq_add_neg _ _).symm
                                                  -- 13 行目: `def_complex_difference` を右辺から左辺へ
    _ = (a + b) / 2 - (a - b) / 2 := by rw [div_eq_mul_inv (a + b), div_eq_mul_inv (a - b)]
                                                  -- 14 行目: `def_complex_quotient` を 2 か所へ右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - (a - b) / 2 := by rw [euler_cos_real_inclusion θ]
                                                  -- 15 行目: `euler_formula_cos_sin` の第 1 の等式を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - (a - b) * (2 : ℂ)⁻¹ := by rw [div_eq_mul_inv (a - b)]
                                                  -- 16 行目: `def_complex_quotient`（`z → a-b`, `w → 2_ℂ`）
    _ = ((Real.cos θ : ℝ) : ℂ) - (a - b) * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [exp_neg_I_prep_I_mul_inv_two_mul_I]   -- 17 行目: 準備の第三の鎖を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - ((a - b) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [mul_assoc (a - b) Complex.I]          -- 18 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((Real.cos θ : ℝ) : ℂ) - (Complex.I * (a - b)) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [mul_comm (a - b) Complex.I]           -- 19 行目: `complex_numbers_form_a_field` の積の可換律
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((a - b) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [mul_assoc Complex.I (a - b)]          -- 20 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((a - b) / (2 * Complex.I)) := by
        rw [div_eq_mul_inv (a - b)]               -- 21 行目: `def_complex_quotient`（`z → a-b`, `w → 2_ℂi`）を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [euler_sin_real_inclusion θ]           -- 22 行目: `euler_formula_cos_sin` の第 2 の等式を右辺から左辺へ

end Ising2D
