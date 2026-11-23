/-
# 符号を反転した整数に右から整数を掛けると、積の符号が反転する（具体版を必要十分版から導く）

具体版 `ClaimIntegerNegationTimesIsNegationOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegMulOfAddGroupRightDistrib.lean` の `R := ℤ` の特殊化として得る。
人手のラベルは `int_negation_times_is_negation_of_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerNegationTimesIsNegationOfProduct
import Ising2D.NecSuf.NegMulOfAddGroupRightDistrib

namespace Ising2D

/-- `int_negation_times_is_negation_of_product` を `NecSuf.neg_mul_of_addGroup_rightDistrib`（`R := ℤ`）の特殊化として得る。 -/
theorem int_negation_times_is_negation_of_product_of_necSuf (x t : ℤ) : (-x) * t = -(x * t) :=
  NecSuf.neg_mul_of_addGroup_rightDistrib x t

end Ising2D
