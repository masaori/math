/-
# 実数に 0 を左から掛けると 0 になる（具体版を必要十分版から導く）

具体版 `ClaimRealZeroTimesIsZero.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroMulOfRightDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_zero_times_is_zero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero
import Ising2D.NecSuf.ZeroMulOfRightDistrib

namespace Ising2D

/-- `real_zero_times_is_zero` を `NecSuf.zero_mul_of_rightDistrib`（`R := ℝ`）の特殊化として得る。 -/
theorem real_zero_times_is_zero_of_necSuf (x : ℝ) : 0 * x = 0 :=
  NecSuf.zero_mul_of_rightDistrib x

end Ising2D
