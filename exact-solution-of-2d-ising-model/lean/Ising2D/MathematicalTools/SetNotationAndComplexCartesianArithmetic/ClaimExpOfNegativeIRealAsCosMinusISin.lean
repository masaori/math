/-
# `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（具体版）

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_claim_exp_of_negative_i_real_as_cos_minus_i_sin`（ラベル `exp_of_negative_i_real_as_cos_minus_i_sin`）

`exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` は人手の主鎖の 6 行と 1 段ずつの `calc` である。
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
- 主鎖の 3 行目の分配法則は mathlib の `sub_div`、
  1 行目の `2_ℂ ≠ 0_ℂ` による分数の操作は mathlib の `mul_div_cancel_left₀`、5 行目の `i ≠ 0_ℂ` による分数の操作は
  `mul_div_assoc'`・`mul_comm`・`mul_div_mul_left` の 3 つの書き換えを人手の 1 行の中で当てる。

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

/-- **人手 `exp_of_negative_i_real_as_cos_minus_i_sin`**: `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（`-iθ` は `-(iθ)`、人手の 6 行）。 -/
theorem exp_neg_I_mul_real_eq_cos_sub_I_mul_sin (θ : ℝ) :
    Complex.exp (-(Complex.I * (θ : ℂ))) = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
  set a : ℂ := Complex.exp (Complex.I * (θ : ℂ))
  set b : ℂ := Complex.exp (-(Complex.I * (θ : ℂ)))
  calc b
      = (2 * b) / 2 := (mul_div_cancel_left₀ b (two_ne_zero : (2 : ℂ) ≠ 0)).symm
                                                  -- 1 行目: `2_ℂ ≠ 0_ℂ`（`complex_numbers_form_a_field`）
    _ = ((a + b) - (a - b)) / 2 := by
        rw [exp_neg_I_prep_add_sub_sub a b]       -- 2 行目: 準備の第二の鎖を右辺から左辺へ
    _ = (a + b) / 2 - (a - b) / 2 := by
        rw [sub_div]                              -- 3 行目: 分配法則（`complex_numbers_form_a_field`）
    _ = ((Real.cos θ : ℝ) : ℂ) - (a - b) / 2 := by
        rw [euler_cos_real_inclusion θ]           -- 4 行目: `euler_formula_cos_sin` の第 1 の等式
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((a - b) / (2 * Complex.I)) := by
        rw [mul_div_assoc', mul_comm (2 : ℂ) Complex.I, mul_div_mul_left (a - b) (2 : ℂ) Complex.I_ne_zero]
                                                  -- 5 行目: `i ≠ 0_ℂ`（`complex_numbers_form_a_field`）
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [euler_sin_real_inclusion θ]           -- 6 行目: `euler_formula_cos_sin` の第 2 の等式

end Ising2D
