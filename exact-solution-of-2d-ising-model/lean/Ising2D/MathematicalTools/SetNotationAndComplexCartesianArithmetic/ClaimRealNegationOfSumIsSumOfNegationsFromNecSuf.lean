/-
# 実数の和の符号を反転すると、符号を反転した実数の和になる（具体版を必要十分版から導く）

具体版 `ClaimRealNegationOfSumIsSumOfNegations.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegAddOfDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_negation_of_sum_is_sum_of_negations`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfSumIsSumOfNegations
import Ising2D.NecSuf.NegAddOfDistrib

namespace Ising2D

/-- `real_negation_of_sum_is_sum_of_negations` を `NecSuf.neg_add_of_distrib`（`R := ℝ`、
`1·a = a` は `one_mul`）の特殊化として得る。 -/
theorem real_negation_of_sum_is_sum_of_negations_of_necSuf (x y : ℝ) : -(x + y) = (-x) + (-y) :=
  NecSuf.neg_add_of_distrib (fun c : ℝ => one_mul c) x y

end Ising2D
