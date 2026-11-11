/-
# `(a+b) + (a-b) = 2_ℂ a`・`(a+b) - (a-b) = 2_ℂ b`（具体版を必要十分版から導く）

具体版 `ClaimSumPlusAndMinusDifferenceInCC.lean` の主張を、必要十分版
`Ising2D/NecSuf/SumPlusAndMinusDifference.lean` の係数 `R := ℂ`・`two := 2_ℂ` の特殊化として得る。
人手のラベルは `sum_plus_difference_is_twice_first_in_cc`・`sum_minus_difference_is_twice_second_in_cc`。
仮定 `hsub`・`hleft` は `ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf.lean` の `complex_sub_eq_add_neg`・`complex_one_mul`、
`hneg`・`hmm` は `ClaimMatrixDoubleNegationFromNecSuf.lean` の `complex_neg_eq_neg_one_mul`・`complex_neg_one_mul_neg_one`、
`htwo` は `ClaimOnePlusOneIsTwoInCC.lean` の `complex_one_add_one`、`hinv`・`hzero` はこのファイルで与える。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimSumPlusAndMinusDifferenceInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf
import Ising2D.NecSuf.SumPlusAndMinusDifference

namespace Ising2D

/-- 必要十分版の仮定 `hinv` を `ℂ` で与える（人手の `complex_numbers_form_a_field` の加法の逆元）。 -/
theorem complex_add_neg_self (x : ℂ) : x + -x = 0 := add_neg_cancel x

/-- 必要十分版の仮定 `hzero` を `ℂ` で与える（人手の `complex_numbers_form_a_field` の加法の単位元）。 -/
theorem complex_add_zero (x : ℂ) : x + 0 = x := add_zero x

/-- `complex_sum_add_difference` を `NecSuf.sum_add_difference'`（係数 `ℂ`）の特殊化として得る。 -/
theorem complex_sum_add_difference_of_necSuf (a b : ℂ) : (a + b) + (a - b) = 2 * a :=
  NecSuf.sum_add_difference' complex_sub_eq_add_neg complex_add_neg_self complex_add_zero complex_one_mul
    2 complex_one_add_one a b

/-- `complex_sum_sub_difference` を `NecSuf.sum_sub_difference'`（係数 `ℂ`）の特殊化として得る。 -/
theorem complex_sum_sub_difference_of_necSuf (a b : ℂ) : (a + b) - (a - b) = 2 * b :=
  NecSuf.sum_sub_difference' complex_sub_eq_add_neg complex_neg_eq_neg_one_mul complex_neg_one_mul_neg_one
    complex_add_neg_self complex_add_zero complex_one_mul 2 complex_one_add_one a b

end Ising2D
