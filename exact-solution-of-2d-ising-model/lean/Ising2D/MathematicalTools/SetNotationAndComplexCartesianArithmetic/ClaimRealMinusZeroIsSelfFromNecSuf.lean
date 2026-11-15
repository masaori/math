/-
# 実数から 0 を引いても変わらない（具体版を必要十分版から導く）

具体版 `ClaimRealMinusZeroIsSelf.lean` の主張を、必要十分版
`Ising2D/NecSuf/SubZeroOfNegZero.lean` の `R := ℝ` の特殊化として得る。
`-0 = 0` の仮定には、具体版と同じく `real_negation_of_zero_is_zero` を渡す。
人手のラベルは `real_minus_zero_is_self`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusZeroIsSelf
import Ising2D.NecSuf.SubZeroOfNegZero

namespace Ising2D

/-- `real_minus_zero_is_self` を `NecSuf.sub_zero_of_negZero`（`R := ℝ`）の特殊化として得る。 -/
theorem real_minus_zero_is_self_of_necSuf (a : ℝ) : a - 0 = a :=
  NecSuf.sub_zero_of_negZero sub_eq_add_neg real_negation_of_zero_is_zero add_zero a

end Ising2D
