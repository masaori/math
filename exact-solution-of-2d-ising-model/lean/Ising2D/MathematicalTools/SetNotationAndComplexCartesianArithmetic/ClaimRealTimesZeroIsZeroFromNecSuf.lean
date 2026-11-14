/-
# 実数に 0 を右から掛けると 0 になる（具体版を必要十分版から導く）

具体版 `ClaimRealTimesZeroIsZero.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulZeroOfLeftDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_times_zero_is_zero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero
import Ising2D.NecSuf.MulZeroOfLeftDistrib

namespace Ising2D

/-- `real_times_zero_is_zero` を `NecSuf.mul_zero_of_leftDistrib`（`R := ℝ`）の特殊化として得る。 -/
theorem real_times_zero_is_zero_of_necSuf (x : ℝ) : x * 0 = 0 :=
  NecSuf.mul_zero_of_leftDistrib x

end Ising2D
