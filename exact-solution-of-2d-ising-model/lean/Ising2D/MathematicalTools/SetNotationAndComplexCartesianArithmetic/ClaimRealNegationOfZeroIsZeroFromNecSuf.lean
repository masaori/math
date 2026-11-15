/-
# 実数の 0 の符号を反転しても 0 である（具体版を必要十分版から導く）

具体版 `ClaimRealNegationOfZeroIsZero.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegZeroOfAddComm.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_negation_of_zero_is_zero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfZeroIsZero
import Ising2D.NecSuf.NegZeroOfAddComm

namespace Ising2D

/-- `real_negation_of_zero_is_zero` を `NecSuf.neg_zero_of_addComm`（`R := ℝ`）の特殊化として得る。 -/
theorem real_negation_of_zero_is_zero_of_necSuf : -(0 : ℝ) = 0 :=
  NecSuf.neg_zero_of_addComm add_zero add_comm add_neg_cancel

end Ising2D
