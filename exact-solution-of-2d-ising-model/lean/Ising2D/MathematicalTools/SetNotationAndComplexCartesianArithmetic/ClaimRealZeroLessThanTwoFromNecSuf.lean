/-
# 実数の 0 は 2 より小さい（具体版を必要十分版から導く）

具体版 `ClaimRealZeroLessThanTwo.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroLtTwoOfOrderedAxioms.lean` の `R := ℝ`・`t := 2` の特殊化として得る。
`0 < 1` の仮定には、具体版と同じく `real_zero_less_than_one` を、`1 + 1 = t` には `def_real_two` の具体版 `real_two_eq_one_add_one` の逆向きを渡す。
人手のラベルは `real_zero_less_than_two`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanTwo
import Ising2D.NecSuf.ZeroLtTwoOfOrderedAxioms

namespace Ising2D

/-- `real_zero_less_than_two` を `NecSuf.zero_lt_two_of_orderedAxioms`（`R := ℝ`, `t := 2`）の特殊化として得る。 -/
theorem real_zero_less_than_two_of_necSuf : (0 : ℝ) < 2 :=
  NecSuf.zero_lt_two_of_orderedAxioms real_zero_less_than_one zero_add
    (fun _ _ c h => add_lt_add_left h c) (fun _ _ _ hab hbc => lt_trans hab hbc)
    real_two_eq_one_add_one.symm

end Ising2D
