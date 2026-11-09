/-
# `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（具体版）

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_claim_exp_of_negative_i_real_as_cos_minus_i_sin`（ラベル `exp_of_negative_i_real_as_cos_minus_i_sin`）

`exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` は人手の 6 行と 1 段ずつの `calc` である。
- 人手の `-iθ_ℂ` は `euler_formula_cos_sin` の読みのとおり `-(iθ_ℂ)`（Lean の `-(Complex.I * (θ : ℂ))`）、
  分母の `2` は `2_ℂ`（Lean の `(2 : ℂ)`）である。人手の `a`・`b` は `set` で置く。
- 人手 `euler_formula_cos_sin` の読み `euler_cos_real_inclusion`・`euler_sin_real_inclusion` は同じフォルダの
  `ClaimEulerFormulaCosSin.lean` にある（人手が全実数上の `cos`・`sin` を未整備とするため mathlib で受けている）。
- 2 行目「ℂ の四則（`complex_numbers_form_a_field`・`def_complex_difference`）」は人手が 1 行で述べる
  `2_ℂ b = (a+b) - (a-b)` で、`ring` で閉じる。3 行目の分配法則は mathlib の `sub_div`、
  1 行目の `2_ℂ ≠ 0_ℂ` による分数の操作は mathlib の `mul_div_cancel_left₀`、5 行目の `i ≠ 0_ℂ` による分数の操作は
  `mul_div_assoc'`・`mul_comm`・`mul_div_mul_left` の 3 つの書き換えを人手の 1 行の中で当てる。

必要十分版は置かない。人手の証明は未整備の `euler_formula_cos_sin`（mathlib で受けている）を前提とし、
残る段は体の四則を 1 回ずつ当てるだけである。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin

namespace Ising2D

/-- **人手 `exp_of_negative_i_real_as_cos_minus_i_sin`**: `exp(-iθ_ℂ) = (cos θ)_ℂ - i(sin θ)_ℂ`（`-iθ` は `-(iθ)`、人手の 6 行）。 -/
theorem exp_neg_I_mul_real_eq_cos_sub_I_mul_sin (θ : ℝ) :
    Complex.exp (-(Complex.I * (θ : ℂ))) = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
  set a : ℂ := Complex.exp (Complex.I * (θ : ℂ))
  set b : ℂ := Complex.exp (-(Complex.I * (θ : ℂ)))
  calc b
      = (2 * b) / 2 := (mul_div_cancel_left₀ b (two_ne_zero : (2 : ℂ) ≠ 0)).symm
                                                  -- 1 行目: `2_ℂ ≠ 0_ℂ`（`complex_numbers_form_a_field`）
    _ = ((a + b) - (a - b)) / 2 := by
        congr 1; ring                             -- 2 行目: ℂ の四則（`complex_numbers_form_a_field`・`def_complex_difference`）
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
