/-
# `i i = -1_ℂ`・`(-i) i = 1_ℂ`（具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
- `calculation_formulae_claim_i_times_i_is_minus_one_in_cc`（ラベル **`i_times_i_is_minus_one_in_cc`**）
- `calculation_formulae_claim_negative_i_times_i_is_one_in_cc`（ラベル **`negative_i_times_i_is_one_in_cc`**）

## 人手証明との対応

`complex_I_mul_I`（人手 `i_times_i_is_minus_one_in_cc` の 4 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `def_imaginary_unit` を 2 か所へ | `calc` の 1 段目（`Complex.I` は `⟨0, 1⟩` なので `rfl`） |
| 2 行目: `definition_of_cc` の積 | 2 段目（mathlib の `ℂ` の積の定義どおりなので `rfl`） |
| 3 行目: `ℝ` の四則 | 3 段目（`norm_num`） |
| 4 行目: `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1` | 4 段目（`Complex.ofReal_neg`・`Complex.ofReal_one`） |

`complex_neg_I_mul_I`（人手 `negative_i_times_i_is_one_in_cc` の 4 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → i`） | `calc` の 1 段目（`neg_I_mul_eq_neg_of_I_mul`） |
| 2 行目: `i_times_i_is_minus_one_in_cc` | 2 段目（`complex_I_mul_I`） |
| 3 行目: `multiply_by_minus_one`（`z → -1_ℂ`） | 3 段目（`neg_one_mul` を右辺から左辺へ） |
| 4 行目: `minus_one_times_minus_one_is_one_in_cc` | 4 段目（`complex_minus_one_mul_minus_one`） |

- 2 つの鎖は、人手 `Z_Y_generate_algebra` の証明の準備 (f)・(g) と同じ鎖である。その Lean
  （`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` の `zy_prep_I_mul_I`・`zy_prep_neg_I_mul_I`）は、
  人手 `Z_Y_generate_algebra` が準備をこの 2 つの主張の参照に替えるまで残している（状態台帳の (d4c44p15f12)）。
- この 2 つの主張を引くのは、いまは `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean` の
  `pauliComb_coeff_y_eq_zero`（人手 `Z_Y_linearly_independent` の Step 1 の `c_y = 0_ℂ` の鎖）である。

必要十分版は置かない。`i_times_i_is_minus_one_in_cc` は `definition_of_cc` の積の式で具体的な数を計算するだけで、
取り払える構造をこの説明以上に示す計算が無い（`complex_minus_one_mul_minus_one` と同じ扱い）。
`negative_i_times_i_is_one_in_cc` は 4 行とも引いた等式（`negative_i_times_complex_is_negation_of_i_times`・
`i_times_i_is_minus_one_in_cc`・`multiply_by_minus_one`・`minus_one_times_minus_one_is_one_in_cc`）の連鎖だけで閉じ、
効いている構造はその 4 つの等式で尽きている（加法・積の結合律・可換律・`i` が複素数であることは使わない）。
これを必要十分版として書き直しても、この 4 つの等式を仮定に並べるだけで新しく示すことが無い（`neg_I_mul_eq_neg_of_I_mul` と同じ扱い）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC
import Mathlib.Tactic.NormNum

namespace Ising2D

/-- **人手 `i_times_i_is_minus_one_in_cc`**: `i i = -1_ℂ`（人手の 4 行）。 -/
theorem complex_I_mul_I : Complex.I * Complex.I = -1 :=
  calc Complex.I * Complex.I
      = (⟨0, 1⟩ : ℂ) * (⟨0, 1⟩ : ℂ) := rfl                             -- 1 行目: `def_imaginary_unit` を 2 か所へ
    _ = (⟨0 * 0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := rfl                   -- 2 行目: `definition_of_cc` の積
    _ = (⟨-1, 0⟩ : ℂ) := by norm_num                                  -- 3 行目: `ℝ` の四則
    _ = -1 := by
          rw [show (⟨-1, 0⟩ : ℂ) = ((-1 : ℝ) : ℂ) from rfl, Complex.ofReal_neg, Complex.ofReal_one]
                                                                      -- 4 行目: `-1_ℂ` は略記 `r_ℂ` の `r = -1`

/-- **人手 `negative_i_times_i_is_one_in_cc`**: `(-i) i = 1_ℂ`（人手の 4 行）。 -/
theorem complex_neg_I_mul_I : (-Complex.I) * Complex.I = 1 :=
  calc (-Complex.I) * Complex.I
      = -(Complex.I * Complex.I) := neg_I_mul_eq_neg_of_I_mul _         -- 1 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → i`）
    _ = -(-1) := by rw [complex_I_mul_I]                                -- 2 行目: `i_times_i_is_minus_one_in_cc`
    _ = (-1) * (-1) := (neg_one_mul (-1)).symm                          -- 3 行目: `multiply_by_minus_one`（`z → -1_ℂ`）
    _ = 1 := complex_minus_one_mul_minus_one                            -- 4 行目: `minus_one_times_minus_one_is_one_in_cc`

end Ising2D
