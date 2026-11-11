/-
# `i(2_ℂi)^{-1} = 2_ℂ^{-1}`（具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
（`calculation_formulae_claim_i_times_inverse_of_two_i_is_inverse_of_two_in_cc`、ラベル **`i_times_inverse_of_two_i_is_inverse_of_two_in_cc`**）

## 人手証明との対応

- 主張の前置きの `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ` は `complex_two_ne_zero_by_re`（仮定 `2_ℂ = 0_ℂ` の第 1 成分 `Complex.re` を取り、
  `ℝ` の `2 = 0` に帰す）、`i = (0,1) ≠ 0_ℂ` は `complex_I_ne_zero_by_im`（第 2 成分 `Complex.im` を取り、`ℝ` の `1 = 0` に帰す）、
  `2_ℂi ∈ ℂ^×` は `complex_two_mul_I_ne_zero`（`mul_ne_zero`。人手の `multiplicative_group_of_cc` の群の積）である。
  `ℂ` の元の等号は成分ごと（`definition_of_cc` の `ℝ^2` の元の等号）である。`2_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 2`
  （Lean の `((2 : ℝ) : ℂ)`。リテラル `(2 : ℂ)` との読み替えは `Complex.ofReal_ofNat`）、`(2, 0)` の第 1 成分は `Complex.ofReal_re`、
  `i = (0, 1)`（`def_imaginary_unit`）の第 2 成分は `Complex.I_im`、`0_ℂ = (0, 0)` の成分は `Complex.zero_re`・`Complex.zero_im` である。
- 証明の鎖の 6 行は `complex_I_mul_inv_two_mul_I` の `calc` の 6 段と 1 段ずつ対応する。`complex_numbers_form_a_field` の積の公理は
  mathlib の `one_mul`・`mul_one`・`mul_assoc` を 1 段に 1 つずつ当て、`multiplicative_group_of_cc` の逆元（`w^{-1}w = 1_ℂ`・`ww^{-1} = 1_ℂ`）は
  `inv_mul_cancel₀`・`mul_inv_cancel₀` で受ける（Lean の `ℂ` の逆元は mathlib の定義なので、人手の逆元の式はこの等式で読む）。
- この主張を引くのは `exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` の 17 段目（`ClaimExpOfNegativeIRealAsCosMinusISin.lean`）と、
  `real_inclusion_cos_add_I_mul_sin` の 6 段目（`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`。人手
  `relation_of_gamma_2_theta_tilde`・`periodicity_of_check_fermi` の準備の第一の鎖）である。

必要十分版は置かない。2 つの具体的な数についての等式で、使う構造は積の結合律・単位元と、`2_ℂ`・`2_ℂi` の逆元だけであり、
取り払える構造をこの説明以上に示す計算が無い（`complex_one_add_one` と同じ扱い）。
-/
import Mathlib.Analysis.Complex.Basic

namespace Ising2D

/-- 人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc` の主張の前置きの `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ`（第 1 成分が `2 ≠ 0`）。 -/
theorem complex_two_ne_zero_by_re : (2 : ℂ) ≠ 0 := by
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

/-- 人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc` の主張の前置きの `i = (0,1) ≠ 0_ℂ`（`def_imaginary_unit`。第 2 成分が `1 ≠ 0`）。 -/
theorem complex_I_ne_zero_by_im : Complex.I ≠ 0 := by
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

/-- 人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc` の主張の前置きの `2_ℂi ∈ ℂ^×`（`2_ℂ, i ∈ ℂ^×` と `multiplicative_group_of_cc` の群の積）。 -/
theorem complex_two_mul_I_ne_zero : (2 : ℂ) * Complex.I ≠ 0 :=
  mul_ne_zero complex_two_ne_zero_by_re complex_I_ne_zero_by_im

/-- **人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc`**: `i(2_ℂi)^{-1} = 2_ℂ^{-1}`（人手の証明の鎖の 6 行）。 -/
theorem complex_I_mul_inv_two_mul_I : Complex.I * ((2 : ℂ) * Complex.I)⁻¹ = (2 : ℂ)⁻¹ :=
  calc Complex.I * ((2 : ℂ) * Complex.I)⁻¹
      = 1 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := (one_mul _).symm
                                      -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [inv_mul_cancel₀ complex_two_ne_zero_by_re]
                                      -- 2 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹)) := mul_assoc _ _ _
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (2 : ℂ)⁻¹ * (((2 : ℂ) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [← mul_assoc (2 : ℂ) Complex.I]
                                      -- 4 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * 1 := by rw [mul_inv_cancel₀ complex_two_mul_I_ne_zero]
                                      -- 5 行目: `multiplicative_group_of_cc` の逆元（`2_ℂi ∈ ℂ^×`）
    _ = (2 : ℂ)⁻¹ := mul_one _
                                      -- 6 行目: `complex_numbers_form_a_field` の積の単位元

end Ising2D
