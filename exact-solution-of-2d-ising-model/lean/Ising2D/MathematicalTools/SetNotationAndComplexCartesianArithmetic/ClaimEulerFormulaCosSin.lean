/-
# `cos`・`sin` の Euler 表示の読みと `(-i)z = -(iz)`

対応する人手証明（正本は `structured-latex/content/000_calculation_formulae_30_44.ts`）:
- `calculation_formulae_045_theorem_euler_formula_cos_sin`（ラベル `euler_formula_cos_sin`）
- `calculation_formulae_claim_negative_i_times_complex_is_negation_of_i_times`
  （ラベル `negative_i_times_complex_is_negation_of_i_times`）

人手 `euler_formula_cos_sin` は主張の読みを次のとおり定める: 実数 `θ, cos θ, sin θ` は `inclusion_rr_to_cc` の像、
`-iθ` は `multiply_by_minus_one` の `-(iθ)`（Lean の `-(Complex.I * (θ : ℂ))`）、分母の `2` は `2_ℂ`（Lean の `(2 : ℂ)`）。
人手は全実数上の `cos`・`sin` と Euler の公式の導出を未整備としており、具体版が無いので、
`euler_cos_real_inclusion`・`euler_sin_real_inclusion` は mathlib の `Complex.ofReal_cos`・`Complex.ofReal_sin` と
`Complex.cos`・`Complex.sin` の定義で受ける。

`(-i)θ` の形で引く側（`factorization_of_A_theta_general` の `e_- := exp((-i)(θ)_ℂ)`）は、
`neg_I_mul_eq_neg_of_I_mul`（人手 `negative_i_times_complex_is_negation_of_i_times` の 3 行と 1 対 1）で `-(iθ)` へ書き換えてから引く。
人手 `multiply_by_minus_one`（`-z := (-1_ℂ)z`）は具体版が Lean に無く、mathlib の `neg_one_mul` で受ける。

必要十分版は置かない。`neg_I_mul_eq_neg_of_I_mul` は `multiply_by_minus_one`（`-x = (-1)x`）と積の結合律を 1 回ずつ当てるだけで、
任意の環で同じ 3 段が通る（`i` であることも ℂ であることも効かない）。取り払える構造をこの説明以上に示す計算が無いので、別のファイルを立てない。
`euler_cos_real_inclusion`・`euler_sin_real_inclusion` は人手の証明が未整備で、具体版も mathlib で受けているので必要十分版の対象にならない。
人手 `euler_formula_cos_sin` の証明の準備の `-(iθ_ℂ) = i(-θ)_ℂ` の 6 行は、Lean では `DefinitionThetaGamma.lean` の
`I_mul_real_neg_eq_neg_I_mul`（人手 `relation_of_gamma_2_theta_tilde` の同じ鎖を逆向きにした形）と鎖の形が同じだが、
`euler_cos_real_inclusion`・`euler_sin_real_inclusion` はこの補題を経由せず全体を mathlib で受けている（euler の証明の具体版は無い）。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Ising2D

/-- 人手 `euler_formula_cos_sin` の第 1 式（`cos x = (exp(ix) + exp(-ix))/2`、`-ix` は `-(ix)`、`2` は `2_ℂ`）。
人手のブロックの具体版が Lean に無いので、mathlib の `Complex.ofReal_cos` と `Complex.cos` の定義で受ける。 -/
theorem euler_cos_real_inclusion (x : ℝ) :
    ((Real.cos x : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (x : ℂ)) + Complex.exp (-(Complex.I * (x : ℂ)))) / 2 := by
  rw [Complex.ofReal_cos, Complex.cos, neg_mul, mul_comm (x : ℂ) Complex.I]

/-- 人手 `euler_formula_cos_sin` の第 2 式を同じく読んだ形（`sin x = (exp(ix) - exp(-ix))/(2i)`）。
具体版が Lean に無いので、mathlib の `Complex.ofReal_sin` と `Complex.sin` の定義で受ける。 -/
theorem euler_sin_real_inclusion (x : ℝ) :
    ((Real.sin x : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (x : ℂ)) - Complex.exp (-(Complex.I * (x : ℂ)))) / (2 * Complex.I) := by
  rw [Complex.ofReal_sin, Complex.sin, neg_mul, mul_comm (x : ℂ) Complex.I]
  field_simp
  ring_nf
  rw [Complex.I_sq]
  ring

/-- 人手 `negative_i_times_complex_is_negation_of_i_times`: `z ∈ ℂ` で `(-i)z = -(iz)`（人手の 3 行）。 -/
theorem neg_I_mul_eq_neg_of_I_mul (z : ℂ) : (-Complex.I) * z = -(Complex.I * z) :=
  calc (-Complex.I) * z
      = ((-1 : ℂ) * Complex.I) * z := by
        rw [neg_one_mul]                          -- 1 行目: `multiply_by_minus_one`（`z → i`）
    _ = (-1 : ℂ) * (Complex.I * z) := by
        rw [mul_assoc]                            -- 2 行目: `complex_numbers_form_a_field` の積の結合律
    _ = -(Complex.I * z) := by
        rw [neg_one_mul]                          -- 3 行目: `multiply_by_minus_one`（`z → iz`）を右辺から左辺へ

end Ising2D
