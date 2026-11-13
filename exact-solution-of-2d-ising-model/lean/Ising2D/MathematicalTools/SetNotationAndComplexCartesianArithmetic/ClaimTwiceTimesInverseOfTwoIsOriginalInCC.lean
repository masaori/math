/-
# `(2_ℂ z) 2_ℂ^{-1} = z`（具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
（`calculation_formulae_claim_twice_times_inverse_of_two_is_original_in_cc`、ラベル **`twice_times_inverse_of_two_is_original_in_cc`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 主張の前置き: `2_ℂ = (2,0) ≠ (0,0) = 0_ℂ` なので `2_ℂ ∈ ℂ^×` | `complex_two_ne_zero_by_re`（`ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean`） |
| 1 行目: `complex_numbers_form_a_field` の積の可換律 | `calc` の 1 段目（`mul_comm 2 z`） |
| 2 行目: 積の結合律 | 2 段目（`mul_assoc`） |
| 3 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`） | 3 段目（`mul_inv_cancel₀ complex_two_ne_zero_by_re`） |
| 4 行目: 積の単位元 | 4 段目（`mul_one`） |

- Lean の `ℂ` の逆元は mathlib の定義なので、人手の逆元の式 `2_ℂ 2_ℂ^{-1} = 1_ℂ` は `mul_inv_cancel₀` で読む
  （`ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean` と同じ扱い）。
- 鎖は人手 `Z_Y_generate_algebra` の証明の準備 (a) と同じである。その Lean
  （`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` の `zy_prep_two_mul_mul_inv_two`）は、
  人手 `Z_Y_generate_algebra` が準備をこの主張の参照に替えるまで残している（状態台帳の (d4c44p15f12)）。
- この主張を引くのは、いまは `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean` の
  `pauliComb_coeff_zero_eq_zero`・`_z_`・`_x_`・`_I_mul_y_`（人手 `Z_Y_linearly_independent` の Step 1 の係数が零になる鎖）である。

必要十分版は `Ising2D/NecSuf/TwiceTimesInverseOfTwo.lean`、そこからの導出は同じフォルダの
`ClaimTwiceTimesInverseOfTwoIsOriginalInCCFromNecSuf.lean` にある。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimITimesInverseOfTwoIIsInverseOfTwoInCC

namespace Ising2D

/-- **人手 `twice_times_inverse_of_two_is_original_in_cc`**: `z ∈ ℂ` で `(2_ℂ z) 2_ℂ^{-1} = z`（人手の 4 行）。 -/
theorem complex_two_mul_mul_inv_two (z : ℂ) : (2 * z) * 2⁻¹ = z :=
  calc (2 * z) * 2⁻¹
      = (z * 2) * 2⁻¹ := by rw [mul_comm 2 z]                         -- 1 行目: 積の可換律
    _ = z * (2 * 2⁻¹) := mul_assoc _ _ _                              -- 2 行目: 積の結合律
    _ = z * 1 := by rw [mul_inv_cancel₀ complex_two_ne_zero_by_re]   -- 3 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）
    _ = z := mul_one z                                                -- 4 行目: 積の単位元

end Ising2D
