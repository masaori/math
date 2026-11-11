/-
# `-(-z) = z`・`b - a = -(a - b)`（具体版を必要十分版から導く）

具体版 `ClaimDoubleNegationAndReversedDifferenceInCC.lean` の主張を、必要十分版
`Ising2D/NecSuf/DoubleNegationAndReversedDifference.lean` の係数 `R := ℂ` の特殊化として得る。
人手のラベルは `double_negation_in_cc`・`reversed_difference_is_negation_of_difference_in_cc`。
仮定 `hsub`・`hleft` はこのファイルで、`hneg`・`hmm` は `ClaimMatrixDoubleNegationFromNecSuf.lean` の `complex_neg_eq_neg_one_mul`・`complex_neg_one_mul_neg_one` で与える。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimDoubleNegationAndReversedDifferenceInCC
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.NecSuf.DoubleNegationAndReversedDifference

namespace Ising2D

/-- 必要十分版の仮定 `hsub` を `ℂ` で与える（人手の `def_complex_difference`）。 -/
theorem complex_sub_eq_add_neg (x y : ℂ) : x - y = x + -y := sub_eq_add_neg x y

/-- 必要十分版の仮定 `hleft` を `ℂ` で与える（人手の `complex_numbers_form_a_field` の積の単位元）。 -/
theorem complex_one_mul (x : ℂ) : 1 * x = x := one_mul x

/-- `complex_double_negation` を `NecSuf.double_negation'`（係数 `ℂ`）の特殊化として得る。 -/
theorem complex_double_negation_of_necSuf (z : ℂ) : -(-z) = z :=
  NecSuf.double_negation' complex_neg_eq_neg_one_mul complex_neg_one_mul_neg_one complex_one_mul z

/-- `complex_reversed_difference` を `NecSuf.reversed_difference'`（係数 `ℂ`）の特殊化として得る。 -/
theorem complex_reversed_difference_of_necSuf (a b : ℂ) : b - a = -(a - b) :=
  NecSuf.reversed_difference' complex_sub_eq_add_neg complex_neg_eq_neg_one_mul complex_neg_one_mul_neg_one complex_one_mul a b

end Ising2D
