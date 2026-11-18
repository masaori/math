/-
# 符号を反転した実数に右から実数を掛けると、積の符号が反転する（具体版を必要十分版から導く）

具体版 `ClaimRealNegationTimesIsNegationOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegMulOfRightDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_negation_times_is_negation_of_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesIsNegationOfProduct
import Ising2D.NecSuf.NegMulOfRightDistrib

namespace Ising2D

/-- `real_negation_times_is_negation_of_product` を `NecSuf.neg_mul_of_rightDistrib`（`R := ℝ`、
`1·a = a` は `one_mul`）の特殊化として得る。 -/
theorem real_negation_times_is_negation_of_product_of_necSuf (x t : ℝ) : (-x) * t = -(x * t) :=
  NecSuf.neg_mul_of_rightDistrib (fun c : ℝ => one_mul c) x t

end Ising2D
