/-
# 正の実数の加法の逆元は負（具体版を必要十分版から導く）

具体版 `ClaimRealNegationOfPositiveIsNegative.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegLtZeroOfZeroLt.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_negation_of_positive_is_negative`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfPositiveIsNegative
import Ising2D.NecSuf.NegLtZeroOfZeroLt

namespace Ising2D

/-- `real_negation_of_positive_is_negative` を `NecSuf.neg_lt_zero_of_zero_lt`（`R := ℝ`）の特殊化として得る。 -/
theorem real_negation_of_positive_is_negative_of_necSuf (a : ℝ) (ha : 0 < a) : -a < 0 :=
  NecSuf.neg_lt_zero_of_zero_lt zero_add (fun _ _ c h => add_lt_add_left h c) add_neg_cancel a ha

end Ising2D
