/-
# 整数の和の符号を反転すると、符号を反転した整数の和になる（具体版を必要十分版から導く）

具体版 `ClaimIntegerNegationOfSumIsSumOfNegations.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegAddOfAddCommGroup.lean` の `R := ℤ` の特殊化として得る。
人手のラベルは `int_negation_of_sum_is_sum_of_negations`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerNegationOfSumIsSumOfNegations
import Ising2D.NecSuf.NegAddOfAddCommGroup

namespace Ising2D

/-- `int_negation_of_sum_is_sum_of_negations` を `NecSuf.neg_add_of_addCommGroup`（`R := ℤ`）の特殊化として得る。 -/
theorem int_negation_of_sum_is_sum_of_negations_of_necSuf (x y : ℤ) : -(x + y) = (-x) + (-y) :=
  NecSuf.neg_add_of_addCommGroup x y

end Ising2D
