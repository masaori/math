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
  （`w^{-1}w = 1_ℂ`・`ww^{-1} = 1_ℂ`）は `inv_mul_cancel₀`・`mul_inv_cancel₀` で受ける（Lean の `ℂ` の商と逆元は mathlib の定義なので、
  人手の定義の式はこの等式で読む）。前置きの `2_ℂ ≠ 0_ℂ` は `exp_neg_I_prep_two_ne_zero`（人手の `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ` の第 1 成分の比較）、
  `i ≠ 0_ℂ` は `exp_neg_I_prep_I_ne_zero`（人手の `i = (0,1) ≠ 0_ℂ` の第 2 成分の比較）、`2_ℂi ≠ 0_ℂ` は
  `exp_neg_I_prep_two_mul_I_ne_zero`（`mul_ne_zero`。人手の「`ℂ^×` の群の積」）である。
  `ℂ` の元の等号は成分ごと（`definition_of_cc` の `ℝ^2` の元の等号）なので、仮定 `2_ℂ = 0_ℂ` から `Complex.re` を取り、
  `i = 0_ℂ` から `Complex.im` を取る。`2_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 2`（Lean の `((2 : ℝ) : ℂ)`。
  リテラル `(2 : ℂ)` との読み替えは `Complex.ofReal_ofNat`）、`(2, 0)` の第 1 成分は `Complex.ofReal_re`、
  `i = (0, 1)`（`def_imaginary_unit`）の第 2 成分は `Complex.I_im`、`0_ℂ = (0, 0)` の成分は `Complex.zero_re`・`Complex.zero_im` である。
- 人手の準備の鎖（`i(2_ℂi)^{-1} = 2_ℂ^{-1}`、6 行）は `exp_neg_I_prep_I_mul_inv_two_mul_I` で、人手の行と 1 段ずつの `calc` である。
  `complex_numbers_form_a_field` の積の公理は mathlib の `one_mul`・`mul_one`・`mul_assoc`・`mul_comm` を 1 段に 1 つずつ当てる。

必要十分版は置かない。人手の証明は未整備の `euler_formula_cos_sin`（mathlib で受けている）を前提とし、
残る段は体の四則を 1 回ずつ当てるだけである。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimSumPlusAndMinusDifferenceInCC

namespace Ising2D

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の前置きの `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ`（第 1 成分が `2 ≠ 0`）。 -/
theorem exp_neg_I_prep_two_ne_zero : (2 : ℂ) ≠ 0 := by
  intro h
  have hre : (2 : ℂ).re = (0 : ℂ).re := congrArg Complex.re h
                                      -- 仮定 `2_ℂ = 0_ℂ` の第 1 成分（`definition_of_cc` の `ℝ^2` の元の等号は成分ごと）
  have h2 : (2 : ℝ) = 0 :=
    calc (2 : ℝ)
        = ((2 : ℝ) : ℂ).re := (Complex.ofReal_re 2).symm
                                      -- `inclusion_rr_to_cc`: `2_ℂ = (2, 0)` の第 1 成分を右辺から左辺へ
      _ = (2 : ℂ).re := by rw [Complex.ofReal_ofNat]
                                      -- `2_ℂ` は略記 `r_ℂ` の `r = 2`（Lean のリテラル `(2 : ℂ)` との読み替え）
      _ = (0 : ℂ).re := hre
                                      -- 仮定の第 1 成分
      _ = 0 := Complex.zero_re
                                      -- `0_ℂ = (0, 0)` の第 1 成分
  exact two_ne_zero h2                -- 第 1 成分が `ℝ` で `2 ≠ 0`

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の前置きの `i = (0,1) ≠ 0_ℂ`（`def_imaginary_unit`。第 2 成分が `1 ≠ 0`）。 -/
theorem exp_neg_I_prep_I_ne_zero : Complex.I ≠ 0 := by
  intro h
  have him : Complex.I.im = (0 : ℂ).im := congrArg Complex.im h
                                      -- 仮定 `i = 0_ℂ` の第 2 成分（`definition_of_cc` の `ℝ^2` の元の等号は成分ごと）
  have h1 : (1 : ℝ) = 0 :=
    calc (1 : ℝ)
        = Complex.I.im := Complex.I_im.symm
                                      -- `def_imaginary_unit`: `i = (0, 1)` の第 2 成分を右辺から左辺へ
      _ = (0 : ℂ).im := him
                                      -- 仮定の第 2 成分
      _ = 0 := Complex.zero_im
                                      -- `0_ℂ = (0, 0)` の第 2 成分
  exact one_ne_zero h1                -- 第 2 成分が `ℝ` で `1 ≠ 0`

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の前置きの `2_ℂi ∈ ℂ^×`（`2_ℂ, i ∈ ℂ^×` と `multiplicative_group_of_cc` の群の積）。 -/
theorem exp_neg_I_prep_two_mul_I_ne_zero : (2 : ℂ) * Complex.I ≠ 0 :=
  mul_ne_zero exp_neg_I_prep_two_ne_zero exp_neg_I_prep_I_ne_zero

/-- 人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の準備の鎖（6 行）: `i(2_ℂi)^{-1} = 2_ℂ^{-1}`。 -/
theorem exp_neg_I_prep_I_mul_inv_two_mul_I : Complex.I * ((2 : ℂ) * Complex.I)⁻¹ = (2 : ℂ)⁻¹ :=
  calc Complex.I * ((2 : ℂ) * Complex.I)⁻¹
      = 1 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := (one_mul _).symm
                                      -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [inv_mul_cancel₀ exp_neg_I_prep_two_ne_zero]
                                      -- 2 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹)) := mul_assoc _ _ _
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 : ℂ)⁻¹ * (((2 : ℂ) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [← mul_assoc (2 : ℂ) Complex.I]
                                      -- 4 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
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
    _ = ((2 : ℂ)⁻¹ * 2) * b := by rw [inv_mul_cancel₀ exp_neg_I_prep_two_ne_zero]
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
        rw [exp_neg_I_prep_I_mul_inv_two_mul_I]   -- 17 行目: 準備の鎖を右辺から左辺へ
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
