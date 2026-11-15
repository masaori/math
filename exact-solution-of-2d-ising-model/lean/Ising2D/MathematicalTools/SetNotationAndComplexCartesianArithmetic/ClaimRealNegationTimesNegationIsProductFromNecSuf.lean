/-
# 符号を反転した実数どうしの積は、もとの実数どうしの積に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealNegationTimesNegationIsProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegMulNegOfRightDistrib.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_negation_times_negation_is_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesNegationIsProduct
import Ising2D.NecSuf.NegMulNegOfRightDistrib

namespace Ising2D

/-- `real_negation_times_negation_is_product` を `NecSuf.neg_mul_neg_of_rightDistrib`（`R := ℝ`、
`1·a = a` は `one_mul`）の特殊化として得る。 -/
theorem real_negation_times_negation_is_product_of_necSuf (a b : ℝ) : (-a) * (-b) = a * b :=
  NecSuf.neg_mul_neg_of_rightDistrib (fun c : ℝ => one_mul c) a b

end Ising2D
