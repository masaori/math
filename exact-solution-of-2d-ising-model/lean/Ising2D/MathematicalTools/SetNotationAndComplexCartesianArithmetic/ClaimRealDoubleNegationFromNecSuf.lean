/-
# 実数の符号を 2 度反転するともとに戻る（具体版を必要十分版から導く）

具体版 `ClaimRealDoubleNegation.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegNegOfAddCommGroup.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_double_negation`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealDoubleNegation
import Ising2D.NecSuf.NegNegOfAddCommGroup

namespace Ising2D

/-- `real_double_negation` を `NecSuf.neg_neg_of_addCommGroup`（`R := ℝ`）の特殊化として得る。 -/
theorem real_double_negation_of_necSuf (a : ℝ) : -(-a) = a :=
  NecSuf.neg_neg_of_addCommGroup a

end Ising2D
