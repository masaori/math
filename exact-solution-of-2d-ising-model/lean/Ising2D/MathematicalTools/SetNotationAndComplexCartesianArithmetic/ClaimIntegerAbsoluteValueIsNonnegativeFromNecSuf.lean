/-
# 整数の絶対値は 0 以上（具体版を必要十分版から導く）

具体版 `ClaimIntegerAbsoluteValueIsNonnegative.lean` の主張を、必要十分版
`Ising2D/NecSuf/AbsNonnegOfCases.lean` の `R := ℤ`、`a := |·|` の特殊化として得る。
人手のラベルは `int_absolute_value_is_nonnegative`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueIsNonnegative
import Ising2D.NecSuf.AbsNonnegOfCases

namespace Ising2D

/-- `int_absolute_value_is_nonnegative` を `NecSuf.abs_nonneg_of_cases`（`R := ℤ`、`a := |·|`）の特殊化として得る。 -/
theorem int_absolute_value_is_nonnegative_of_necSuf (x : ℤ) : 0 ≤ |x| :=
  NecSuf.abs_nonneg_of_cases (fun y => |y|)
    (fun y h => (int_abs_of_nonneg_and_of_not_nonneg y).1 h)
    (fun y h => (int_abs_of_nonneg_and_of_not_nonneg y).2 h)
    (fun y => le_total 0 y) add_neg_cancel (fun _ t h => add_le_add_left h t) zero_add x

end Ising2D
