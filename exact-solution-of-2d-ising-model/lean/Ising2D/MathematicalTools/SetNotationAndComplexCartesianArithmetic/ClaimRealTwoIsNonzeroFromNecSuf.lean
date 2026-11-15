/-
# 実数の 2 は 0 でない（具体版を必要十分版から導く）

具体版 `ClaimRealTwoIsNonzero.lean` の主張を、必要十分版
`Ising2D/NecSuf/NeZeroOfZeroLt.lean` の `R := ℝ`・`t := 2` の特殊化として得る。
`0 < 2` の仮定には、具体版と同じく `real_zero_less_than_two` を渡す。
人手のラベルは `real_two_is_nonzero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwoIsNonzero
import Ising2D.NecSuf.NeZeroOfZeroLt

namespace Ising2D

/-- `real_two_is_nonzero` を `NecSuf.ne_zero_of_zero_lt`（`R := ℝ`, `t := 2`）の特殊化として得る。 -/
theorem real_two_is_nonzero_of_necSuf : (2 : ℝ) ≠ 0 :=
  NecSuf.ne_zero_of_zero_lt real_zero_less_than_two
    (fun _ _ h => (lt_iff_le_and_ne.mp h).2)

end Ising2D
