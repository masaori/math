/-
# 実数の 0 は 1 より小さい（具体版を必要十分版から導く）

具体版 `ClaimRealZeroLessThanOne.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroLtOneOfOrderedAxioms.lean` の `R := ℝ` の特殊化として得る。
`(−a)(−b) = ab` の仮定には、具体版と同じく `real_negation_times_negation_is_product` を渡す。
人手のラベルは `real_zero_less_than_one`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanOne
import Ising2D.NecSuf.ZeroLtOneOfOrderedAxioms

namespace Ising2D

/-- `real_zero_less_than_one` を `NecSuf.zero_lt_one_of_orderedAxioms`（`R := ℝ`）の特殊化として得る。 -/
theorem real_zero_less_than_one_of_necSuf : (0 : ℝ) < 1 :=
  NecSuf.zero_lt_one_of_orderedAxioms zero_ne_one add_neg_cancel zero_add one_mul
    (fun _ _ c h => add_lt_add_left h c) (fun _ _ ha hb => mul_pos ha hb)
    real_negation_times_negation_is_product

end Ising2D
