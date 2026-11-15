/-
# 正の実数の乗法の逆元は正（具体版を必要十分版から導く）

具体版 `ClaimRealInverseOfPositiveIsPositive.lean` の主張を、必要十分版
`Ising2D/NecSuf/InvPosOfOrderedAxioms.lean` の `R := ℝ` の特殊化として得る。
`x·0 = 0`・`(−1)·x = −x`・`0 < 1` の仮定には、具体版と同じく `real_times_zero_is_zero`・
`real_minus_one_times_is_negation`・`real_zero_less_than_one` を渡す。
人手のラベルは `real_inverse_of_positive_is_positive`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealInverseOfPositiveIsPositive
import Ising2D.NecSuf.InvPosOfOrderedAxioms

namespace Ising2D

/-- `real_inverse_of_positive_is_positive` を `NecSuf.inv_pos_of_orderedAxioms`（`R := ℝ`）の特殊化として得る。 -/
theorem real_inverse_of_positive_is_positive_of_necSuf (a : ℝ) (ha : 0 < a) : 0 < a⁻¹ :=
  NecSuf.inv_pos_of_orderedAxioms zero_ne_one real_zero_less_than_one
    (fun _ hx => mul_inv_cancel₀ hx) real_times_zero_is_zero real_minus_one_times_is_negation
    mul_assoc mul_comm add_neg_cancel zero_add add_comm
    (fun _ _ c h => add_lt_add_left h c) (fun _ _ hx hy => mul_pos hx hy) a ha

end Ising2D
