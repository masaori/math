/-
# `(a+b) + (a-b) = 2_ℂ a`・`(a+b) - (a-b) = 2_ℂ b`（ℂ、具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
- `calculation_formulae_claim_sum_plus_difference_is_twice_first_in_cc`（ラベル **`sum_plus_difference_is_twice_first_in_cc`**）
- `calculation_formulae_claim_sum_minus_difference_is_twice_second_in_cc`
  （ラベル **`sum_minus_difference_is_twice_second_in_cc`**）

## 人手証明との対応

`complex_sum_add_difference`（人手 `sum_plus_difference_is_twice_first_in_cc` の 11 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `def_complex_difference`（`z → a`, `w → b`） | `calc` の 1 段目（`sub_eq_add_neg`） |
| 2 行目: 加法の結合律を右辺から左辺へ | 2 段目（`add_assoc` を右辺から左辺へ） |
| 3 行目: 加法の結合律 | 3 段目（`add_assoc`） |
| 4 行目: 加法の可換律 | 4 段目（`add_comm b a`） |
| 5 行目: 加法の結合律を右辺から左辺へ | 5 段目（`add_assoc` を右辺から左辺へ） |
| 6 行目: 加法の結合律 | 6 段目（`add_assoc`） |
| 7 行目: 加法の逆元 | 7 段目（`add_neg_cancel`） |
| 8 行目: 加法の単位元 | 8 段目（`add_zero`） |
| 9 行目: 積の単位元を 2 か所へ右辺から左辺へ | 9 段目（`one_mul` を右辺から左辺へ） |
| 10 行目: 右からの分配律を右辺から左辺へ | 10 段目（`add_mul` を右辺から左辺へ） |
| 11 行目: `one_plus_one_is_two_in_cc` | 11 段目（`complex_one_add_one`） |

`complex_sum_sub_difference`（人手 `sum_minus_difference_is_twice_second_in_cc` の 17 行）は、各段のコメントに人手の行を書いた。

- 人手 `def_complex_difference`（`z - w := z + (-w)`）は mathlib の `sub_eq_add_neg`、`multiply_by_minus_one`（`-z := (-1_ℂ) z`）は
  `neg_one_mul` で受ける（Lean の `ℂ` の差と符号反転は mathlib の定義なので、人手の定義の式はこの 2 つの等式で読む。同じフォルダの
  `ClaimDoubleNegationAndReversedDifferenceInCC.lean` と同じ扱い）。`complex_numbers_form_a_field` の各公理は mathlib の
  `add_assoc`・`add_comm`・`add_neg_cancel`・`add_zero`・`one_mul`・`mul_assoc`・`mul_add`・`add_mul` を 1 段に 1 つずつ当てる。
  人手の「加法の逆元」の段の `-b` は `multiply_by_minus_one` の符号反転で、それが加法の逆元と一致することは
  `complex_numbers_form_a_field` の証明の段落が示している。Lean の `-b` は加法の逆元そのものなので、`add_neg_cancel` の 1 段で受ける。
- `(a+b) + (a-b) = 2a` を `ring` の 1 行で済ませない。人手の鎖の各段と対応しなくなるためである。

この 2 つの主張を引くのは、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean` の
`pauliComb_coeff_zero_eq_zero`・`_z_`・`_x_`・`_I_mul_y_`（人手 `Z_Y_linearly_independent` の Step 1 の係数が零になる鎖）と、
`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` の `pauliDecompRhs_apply_00`〜`_11`
（人手 `Z_Y_generate_algebra` の Step 3 の `R_{11}`〜`R_{22}` の鎖）である。
`complex_sum_sub_difference` は `ClaimExpOfNegativeIRealAsCosMinusISin.lean` の主鎖の 6 段目も引く。
人手 `euler_formula_cos_sin` は全実数上の `cos`・`sin` が未整備で、Lean に具体版が無い（`ClaimEulerFormulaCosSin.lean` は
mathlib で受けている）。そのため、その鎖がこの 2 つの主張を引く行（人手の第 1 の等式の鎖の 6 行目と第 2 の等式の鎖の 7 行目）は Lean に対応する段が無い。

必要十分版は `Ising2D/NecSuf/SumPlusAndMinusDifference.lean`、そこからの導出は同じフォルダの
`ClaimSumPlusAndMinusDifferenceInCCFromNecSuf.lean` にある。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimOnePlusOneIsTwoInCC

namespace Ising2D

/-- **人手 `sum_plus_difference_is_twice_first_in_cc`**: `a, b ∈ ℂ` で `(a+b) + (a-b) = 2_ℂ a`（人手の 11 行）。 -/
theorem complex_sum_add_difference (a b : ℂ) : (a + b) + (a - b) = 2 * a :=
  calc (a + b) + (a - b)
      = (a + b) + (a + -b) := by rw [sub_eq_add_neg a b]        -- 1 行目: `def_complex_difference`（`z → a`, `w → b`）
    _ = ((a + b) + a) + -b := (add_assoc _ _ _).symm             -- 2 行目: 加法の結合律を右辺から左辺へ
    _ = (a + (b + a)) + -b := by rw [add_assoc a b a]            -- 3 行目: 加法の結合律
    _ = (a + (a + b)) + -b := by rw [add_comm b a]               -- 4 行目: 加法の可換律
    _ = ((a + a) + b) + -b := by rw [← add_assoc a a b]          -- 5 行目: 加法の結合律を右辺から左辺へ
    _ = (a + a) + (b + -b) := add_assoc _ _ _                    -- 6 行目: 加法の結合律
    _ = (a + a) + 0 := by rw [add_neg_cancel b]                  -- 7 行目: 加法の逆元
    _ = a + a := add_zero _                                      -- 8 行目: 加法の単位元
    _ = 1 * a + 1 * a := by rw [one_mul a]                       -- 9 行目: 積の単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * a := (add_mul _ _ _).symm                      -- 10 行目: 右からの分配律を右辺から左辺へ
    _ = 2 * a := by rw [complex_one_add_one]                     -- 11 行目: `one_plus_one_is_two_in_cc`

/-- **人手 `sum_minus_difference_is_twice_second_in_cc`**: `a, b ∈ ℂ` で `(a+b) - (a-b) = 2_ℂ b`（人手の 17 行）。 -/
theorem complex_sum_sub_difference (a b : ℂ) : (a + b) - (a - b) = 2 * b :=
  calc (a + b) - (a - b)
      = (a + b) + (-(a - b)) := sub_eq_add_neg _ _
                                      -- 1 行目: `def_complex_difference`（`z → a+b`, `w → a-b`）
    _ = (a + b) + (-(a + (-b))) := by rw [sub_eq_add_neg a b]
                                      -- 2 行目: `def_complex_difference`（`z → a`, `w → b`）
    _ = (a + b) + (-1) * (a + (-b)) := by rw [neg_one_mul (a + (-b))]
                                      -- 3 行目: `multiply_by_minus_one`（`z → a+(-b)`）
    _ = (a + b) + ((-1) * a + (-1) * (-b)) := by rw [mul_add]
                                      -- 4 行目: 左からの分配律
    _ = (a + b) + ((-1) * a + (-1) * ((-1) * b)) := by rw [neg_one_mul b]
                                      -- 5 行目: `multiply_by_minus_one`（`z → b`）
    _ = (a + b) + ((-1) * a + ((-1) * (-1)) * b) := by rw [← mul_assoc (-1 : ℂ) (-1) b]
                                      -- 6 行目: 積の結合律を右辺から左辺へ
    _ = (a + b) + ((-1) * a + 1 * b) := by rw [complex_minus_one_mul_minus_one]
                                      -- 7 行目: `minus_one_times_minus_one_is_one_in_cc`
    _ = (a + b) + ((-1) * a + b) := by rw [one_mul b]
                                      -- 8 行目: 積の単位元
    _ = (a + b) + ((-a) + b) := by rw [neg_one_mul a]
                                      -- 9 行目: `multiply_by_minus_one`（`z → a`）を右辺から左辺へ
    _ = ((a + b) + (-a)) + b := (add_assoc _ _ _).symm
                                      -- 10 行目: 加法の結合律を右辺から左辺へ
    _ = ((b + a) + (-a)) + b := by rw [add_comm a b]
                                      -- 11 行目: 加法の可換律
    _ = (b + (a + (-a))) + b := by rw [add_assoc b a (-a)]
                                      -- 12 行目: 加法の結合律
    _ = (b + 0) + b := by rw [add_neg_cancel a]
                                      -- 13 行目: 加法の逆元
    _ = b + b := by rw [add_zero b]
                                      -- 14 行目: 加法の単位元
    _ = 1 * b + 1 * b := by rw [one_mul b]
                                      -- 15 行目: 積の単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * b := (add_mul _ _ _).symm
                                      -- 16 行目: 右からの分配律を右辺から左辺へ
    _ = 2 * b := by rw [complex_one_add_one]
                                      -- 17 行目: `one_plus_one_is_two_in_cc`

end Ising2D
