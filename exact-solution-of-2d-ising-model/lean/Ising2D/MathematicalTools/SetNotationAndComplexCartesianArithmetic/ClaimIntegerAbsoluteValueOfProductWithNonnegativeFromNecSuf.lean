/-
# 0 以上の整数との積の絶対値（具体版を必要十分版から導く）

具体版 `ClaimIntegerAbsoluteValueOfProductWithNonnegative.lean` の主張を、必要十分版
`Ising2D/NecSuf/AbsMulOfNonnegRightOfCases.lean` の `R := ℤ`、`a := |·|` の特殊化として得る。
人手のラベルは `int_absolute_value_of_product_with_nonnegative`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueOfProductWithNonnegative
import Ising2D.NecSuf.AbsMulOfNonnegRightOfCases

namespace Ising2D

/-- `int_absolute_value_of_product_with_nonnegative` を `NecSuf.abs_mul_of_nonneg_right_of_cases`（`R := ℤ`、`a := |·|`）の特殊化として得る。 -/
theorem int_absolute_value_of_product_with_nonnegative_of_necSuf (x y : ℤ) (hy : 0 ≤ y) :
    |x * y| = |x| * y :=
  NecSuf.abs_mul_of_nonneg_right_of_cases (fun z => |z|)
    (fun z h => (int_abs_of_nonneg_and_of_not_nonneg z).1 h)
    (fun z h => (int_abs_of_nonneg_and_of_not_nonneg z).2 h)
    int_absolute_value_is_nonnegative
    (fun _ _ h1 h2 => mul_nonneg h1 h2)
    int_negation_times_is_negation_of_product
    (fun _ t h => add_le_add_left h t)
    (fun _ _ h1 h2 => le_antisymm h1 h2)
    zero_add add_neg_cancel neg_add_cancel x y hy

end Ising2D
