/-
# `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（具体版）

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_claim_exp_of_negative_i_real_as_cos_minus_i_sin`（ラベル `exp_of_negative_i_real_as_cos_minus_i_sin`）

`exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` は人手の主鎖の 22 行と 1 段ずつの `calc` である。
- 人手の `-iθ_ℂ` は `euler_formula_cos_sin` の読みのとおり `-(iθ_ℂ)`（Lean の `-(Complex.I * (θ : ℂ))`）、
  分母の `2` は `2_ℂ`（Lean の `(2 : ℂ)`）である。人手の `a`・`b` は `set` で置く。
- 人手 `euler_formula_cos_sin` の読み `euler_cos_real_inclusion`・`euler_sin_real_inclusion` は同じフォルダの
  `ClaimEulerFormulaCosSin.lean` にある（人手が全実数上の `cos`・`sin` を未整備とするため mathlib で受けている）。
- 主鎖の 6 行目が右辺から左辺へ引く人手 `sum_minus_difference_is_twice_second_in_cc`（`(a+b) - (a-b) = 2_ℂ b`）は、
  同じフォルダの `ClaimSumPlusAndMinusDifferenceInCC.lean` の `complex_sum_sub_difference` である。
- 人手 `def_complex_difference`（`z - w := z + (-w)`）は mathlib の `sub_eq_add_neg`、
  `multiply_by_minus_one`（`-z := (-1_ℂ) z`）は mathlib の `neg_one_mul` を右辺から左辺へ当てて受ける
  （Lean の `ℂ` の差と符号反転は mathlib の定義なので、人手の定義の式はこの 2 つの等式で読む。ほかのファイルと同じ）。
  `complex_numbers_form_a_field` の各公理は mathlib の `add_mul`・`mul_assoc`・`mul_comm`・`one_mul` を 1 段に 1 つずつ当てる。
- 人手 `def_complex_quotient`（`z/w := zw^{-1}`）は mathlib の `div_eq_mul_inv`、`multiplicative_group_of_cc` の逆元
  `2_ℂ^{-1}2_ℂ = 1_ℂ`（主鎖の 2 行目）は `inv_mul_cancel₀` で受ける（Lean の `ℂ` の商と逆元は mathlib の定義なので、
  人手の定義の式はこの等式で読む）。前置きの `2_ℂ ∈ ℂ^×` は、人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc` の主張の前置きの
  具体版 `complex_two_ne_zero_by_re`（`ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean`）である。前置きの `i, 2_ℂi ∈ ℂ^×` は
  主鎖の商 `(a-b)/(2_ℂi)` が定まることのためで、Lean の段では `complex_I_mul_inv_two_mul_I` の中で使う。
- 主鎖の 17 行目が右辺から左辺へ引く人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc`（`i(2_ℂi)^{-1} = 2_ℂ^{-1}`）は、
  `ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean` の `complex_I_mul_inv_two_mul_I` である。

必要十分版は置かない。人手の証明は未整備の `euler_formula_cos_sin`（mathlib で受けている）を前提とし、
残る段は体の四則を 1 回ずつ当てるだけである。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimSumPlusAndMinusDifferenceInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimITimesInverseOfTwoIIsInverseOfTwoInCC

namespace Ising2D

/-- **人手 `exp_of_negative_i_real_as_cos_minus_i_sin`**: `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（`-iθ` は `-(iθ)`、人手の主鎖の 22 行）。 -/
theorem exp_neg_I_mul_real_eq_cos_sub_I_mul_sin (θ : ℝ) :
    Complex.exp (-(Complex.I * (θ : ℂ))) = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
  set a : ℂ := Complex.exp (Complex.I * (θ : ℂ))
  set b : ℂ := Complex.exp (-(Complex.I * (θ : ℂ)))
  calc b
      = 1 * b := (one_mul b).symm
                                                  -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * b := by rw [inv_mul_cancel₀ complex_two_ne_zero_by_re]
                                                  -- 2 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * b) := mul_assoc _ _ _
                                                  -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 * b) * (2 : ℂ)⁻¹ := mul_comm _ _
                                                  -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (2 * b) / 2 := (div_eq_mul_inv _ _).symm
                                                  -- 5 行目: `def_complex_quotient`（`z → 2_ℂb`, `w → 2_ℂ`）を右辺から左辺へ
    _ = ((a + b) - (a - b)) / 2 := by rw [complex_sum_sub_difference a b]
                                                  -- 6 行目: `sum_minus_difference_is_twice_second_in_cc` を右辺から左辺へ
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
        rw [complex_I_mul_inv_two_mul_I]   -- 17 行目: `i_times_inverse_of_two_i_is_inverse_of_two_in_cc` を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - ((a - b) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [mul_assoc (a - b) Complex.I]          -- 18 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - (Complex.I * (a - b)) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [mul_comm (a - b) Complex.I]           -- 19 行目: `complex_numbers_form_a_field` の積の可換律
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((a - b) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [mul_assoc Complex.I (a - b)]          -- 20 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((a - b) / (2 * Complex.I)) := by
        rw [div_eq_mul_inv (a - b)]               -- 21 行目: `def_complex_quotient`（`z → a-b`, `w → 2_ℂi`）を右辺から左辺へ
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [euler_sin_real_inclusion θ]           -- 22 行目: `euler_formula_cos_sin` の第 2 の等式を右辺から左辺へ

end Ising2D
