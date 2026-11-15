/-
# 0 を 0 でない実数で割ると 0 になる（具体版を必要十分版から導く）

具体版 `ClaimRealZeroDividedIsZero.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroDivOfZeroMul.lean` の `R := ℝ` の特殊化として得る。
`0·y = 0` の仮定には、具体版と同じく `real_zero_times_is_zero` を渡す。
人手のラベルは `real_zero_divided_is_zero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroDividedIsZero
import Ising2D.NecSuf.ZeroDivOfZeroMul

namespace Ising2D

/-- `real_zero_divided_is_zero` を `NecSuf.zero_div_of_zeroMul`（`R := ℝ`）の特殊化として得る。 -/
theorem real_zero_divided_is_zero_of_necSuf (x : ℝ) (_hx : x ≠ 0) : 0 / x = 0 :=
  NecSuf.zero_div_of_zeroMul div_eq_mul_inv real_zero_times_is_zero x

end Ising2D
