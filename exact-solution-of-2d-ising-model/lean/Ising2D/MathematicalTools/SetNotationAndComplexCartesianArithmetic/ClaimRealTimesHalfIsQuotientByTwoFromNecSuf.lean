/-
# 実数に 1/2 を掛けると 2 で割った商になる（具体版を必要十分版から導く）

具体版 `ClaimRealTimesHalfIsQuotientByTwo.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulOneDivEqDiv.lean` の `R := ℝ`、`t := 2` の特殊化として得る。
商の定義の仮定には `def_real_quotient` を読む `div_eq_mul_inv` を、左単位元の仮定には `one_mul` を渡す。
人手のラベルは `real_times_half_is_quotient_by_two`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesHalfIsQuotientByTwo
import Ising2D.NecSuf.MulOneDivEqDiv

namespace Ising2D

/-- `real_times_half_is_quotient_by_two` を `NecSuf.mul_one_div_eq_div'`（`R := ℝ`、`t := 2`）の特殊化として得る。 -/
theorem real_times_half_is_quotient_by_two_of_necSuf (a : ℝ) : a * (1 / 2) = a / 2 :=
  NecSuf.mul_one_div_eq_div' a (2 : ℝ) div_eq_mul_inv one_mul

end Ising2D
