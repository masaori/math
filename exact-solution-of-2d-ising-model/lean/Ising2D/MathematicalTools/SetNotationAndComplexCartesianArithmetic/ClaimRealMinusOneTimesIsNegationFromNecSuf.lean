/-
# 実数に −1 を左から掛けると符号が反転する（具体版を必要十分版から導く）

具体版 `ClaimRealMinusOneTimesIsNegation.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegOneMulOfRightDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_minus_one_times_is_negation`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation
import Ising2D.NecSuf.NegOneMulOfRightDistrib

namespace Ising2D

/-- `real_minus_one_times_is_negation` を `NecSuf.neg_one_mul_of_rightDistrib`（`R := ℝ`、`hone_mul := one_mul`）の特殊化として得る。 -/
theorem real_minus_one_times_is_negation_of_necSuf (a : ℝ) : (-1) * a = -a :=
  NecSuf.neg_one_mul_of_rightDistrib one_mul a

end Ising2D
