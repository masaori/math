/-
# 実数に右から符号を反転した実数を掛けると、積の符号が反転する（具体版を必要十分版から導く）

具体版 `ClaimRealTimesNegationIsNegationOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulNegOfCommRightDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_times_negation_is_negation_of_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesNegationIsNegationOfProduct
import Ising2D.NecSuf.MulNegOfCommRightDistrib

namespace Ising2D

/-- `real_times_negation_is_negation_of_product` を `NecSuf.mul_neg_of_comm_rightDistrib`（`R := ℝ`、
`1·a = a` は `one_mul`）の特殊化として得る。 -/
theorem real_times_negation_is_negation_of_product_of_necSuf (x t : ℝ) : x * (-t) = -(x * t) :=
  NecSuf.mul_neg_of_comm_rightDistrib (fun c : ℝ => one_mul c) x t

end Ising2D
