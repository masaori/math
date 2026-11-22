/-
# `i i = -1_ℂ`・`(-i) i = 1_ℂ`（具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
- `calculation_formulae_claim_i_times_i_is_minus_one_in_cc`（ラベル **`i_times_i_is_minus_one_in_cc`**）
- `calculation_formulae_claim_negative_i_times_i_is_one_in_cc`（ラベル **`negative_i_times_i_is_one_in_cc`**）

## 人手証明との対応

`complex_I_mul_I`（人手 `i_times_i_is_minus_one_in_cc` の 10 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `def_imaginary_unit` を 2 か所へ | `calc` の 1 段目（`complex_I_eq_mk`） |
| 2 行目: `definition_of_cc` の積 | 2 段目（`complex_mk_mul_mk`） |
| 3 行目: `real_zero_times_is_zero`（`x → 0`） | 3 段目（`real_zero_times_is_zero 0`） |
| 4 行目: `1` は `ℝ` の乗法の単位元 `1·x = x`（`x → 1`。`set_and_algebra_notation`） | 4 段目（`one_mul 1`） |
| 5 行目: `real_zero_times_is_zero`（`x → 1`） | 5 段目（`real_zero_times_is_zero 1`） |
| 6 行目: `real_times_zero_is_zero`（`x → 1`） | 6 段目（`real_times_zero_is_zero 1`） |
| 7 行目: `0` は `ℝ` の加法の単位元 `x + 0 = x`（`x → 0`。`set_and_algebra_notation`） | 7 段目（`add_zero 0`） |
| 8 行目: `def_real_difference`（`y → 0, z → 1`） | 8 段目（`real_sub_eq_add_neg 0 1`） |
| 9 行目: `0` は `ℝ` の加法の単位元 `0 + x = x`（`x → -1`。`set_and_algebra_notation`） | 9 段目（`zero_add (-1)`） |
| 10 行目: `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1` | 10 段目（`complex_ofReal_eq_mk` を右辺から左辺へ。Lean の右辺は `((-1 : ℝ) : ℂ)`） |

`complex_neg_I_mul_I`（人手 `negative_i_times_i_is_one_in_cc` の 4 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → i`） | `calc` の 1 段目（`neg_I_mul_eq_neg_of_I_mul`） |
| 2 行目: `i_times_i_is_minus_one_in_cc` | 2 段目（`complex_I_mul_I`） |
| 3 行目: `multiply_by_minus_one`（`z → -1_ℂ`） | 3 段目（`complex_neg_eq_ofReal_neg_one_mul`） |
| 4 行目: `minus_one_times_minus_one_is_one_in_cc` | 4 段目（`complex_minus_one_mul_minus_one`。その主張は `-1_ℂ` を `-(1 : ℂ)` と書くので、`Complex.ofReal_neg`・`Complex.ofReal_one` で読み替えてから当てる） |

- この 2 つの主張を引くのは、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean` の
  `pauliComb_coeff_y_eq_zero`（人手 `Z_Y_linearly_independent` の Step 1 の `c_y = 0_ℂ` の鎖）と、人手 `Z_Y_generate_algebra` の
  Step 1 の第 3 式（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` の `pauliX_eq`）・
  Step 3 の `R_{12}`・`R_{21}` の鎖（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` の
  `pauliDecompRhs_apply_01`・`_10`）である。

必要十分版は置かない。`i_times_i_is_minus_one_in_cc` は `definition_of_cc` の積の式で具体的な数を計算するだけで、
取り払える構造をこの説明以上に示す計算が無い（`complex_minus_one_mul_minus_one` と同じ扱い）。
`negative_i_times_i_is_one_in_cc` は 4 行とも引いた等式（`negative_i_times_complex_is_negation_of_i_times`・
`i_times_i_is_minus_one_in_cc`・`multiply_by_minus_one`・`minus_one_times_minus_one_is_one_in_cc`）の連鎖だけで閉じ、
効いている構造はその 4 つの等式で尽きている（加法・積の結合律・可換律・`i` が複素数であることは使わない）。
これを必要十分版として書き直しても、この 4 つの等式を仮定に並べるだけで新しく示すことが無い（`neg_I_mul_eq_neg_of_I_mul` と同じ扱い）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexNumbers
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexNegationAndDifference
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealDifference
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero

namespace Ising2D

/-- **人手 `i_times_i_is_minus_one_in_cc`**: `i i = -1_ℂ`（人手の 10 行）。 -/
theorem complex_I_mul_I : Complex.I * Complex.I = ((-1 : ℝ) : ℂ) :=
  calc Complex.I * Complex.I
      = (⟨0, 1⟩ : ℂ) * (⟨0, 1⟩ : ℂ) := by rw [complex_I_eq_mk]         -- 1 行目: `def_imaginary_unit` を 2 か所へ
    _ = (⟨0 * 0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := complex_mk_mul_mk 0 1 0 1 -- 2 行目: `definition_of_cc` の積
    _ = (⟨0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := by
          rw [real_zero_times_is_zero 0]                              -- 3 行目: `real_zero_times_is_zero`（`x → 0`）
    _ = (⟨0 - 1, 0 * 1 + 1 * 0⟩ : ℂ) := by rw [one_mul (1 : ℝ)]       -- 4 行目: `ℝ` の乗法の単位元 `1·x = x`（`x → 1`）
    _ = (⟨0 - 1, 0 + 1 * 0⟩ : ℂ) := by rw [real_zero_times_is_zero 1] -- 5 行目: `real_zero_times_is_zero`（`x → 1`）
    _ = (⟨0 - 1, 0 + 0⟩ : ℂ) := by rw [real_times_zero_is_zero 1]     -- 6 行目: `real_times_zero_is_zero`（`x → 1`）
    _ = (⟨0 - 1, 0⟩ : ℂ) := by rw [add_zero (0 : ℝ)]                  -- 7 行目: `ℝ` の加法の単位元 `x + 0 = x`（`x → 0`）
    _ = (⟨0 + -1, 0⟩ : ℂ) := by rw [real_sub_eq_add_neg 0 1]          -- 8 行目: `def_real_difference`（`y → 0, z → 1`）
    _ = (⟨-1, 0⟩ : ℂ) := by rw [zero_add (-1 : ℝ)]                    -- 9 行目: `ℝ` の加法の単位元 `0 + x = x`（`x → -1`）
    _ = ((-1 : ℝ) : ℂ) := (complex_ofReal_eq_mk (-1)).symm            -- 10 行目: `-1_ℂ` は略記 `r_ℂ` の `r = -1`

/-- **人手 `negative_i_times_i_is_one_in_cc`**: `(-i) i = 1_ℂ`（人手の 4 行）。 -/
theorem complex_neg_I_mul_I : (-Complex.I) * Complex.I = 1 :=
  calc (-Complex.I) * Complex.I
      = -(Complex.I * Complex.I) := neg_I_mul_eq_neg_of_I_mul _         -- 1 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → i`）
    _ = -((-1 : ℝ) : ℂ) := by rw [complex_I_mul_I]                      -- 2 行目: `i_times_i_is_minus_one_in_cc`
    _ = ((-1 : ℝ) : ℂ) * ((-1 : ℝ) : ℂ) := complex_neg_eq_ofReal_neg_one_mul _ -- 3 行目: `multiply_by_minus_one`（`z → -1_ℂ`）
    _ = 1 := by
          rw [Complex.ofReal_neg, Complex.ofReal_one]                   -- 4 行目: `minus_one_times_minus_one_is_one_in_cc`
          exact complex_minus_one_mul_minus_one                         -- （その具体版は `-1_ℂ` を `-(1 : ℂ)` と書くので読み替える）

end Ising2D
