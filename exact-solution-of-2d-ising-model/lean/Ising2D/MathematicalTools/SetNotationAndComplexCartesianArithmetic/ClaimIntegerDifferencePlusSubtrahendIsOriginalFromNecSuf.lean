/-
# 整数の差に引いた数を足すともとに戻る（具体版を必要十分版から導く）

具体版 `ClaimIntegerDifferencePlusSubtrahendIsOriginal.lean` の主張を、必要十分版
`Ising2D/NecSuf/SubAddCancelOfAddGroup.lean` の `R := ℤ` の特殊化として得る。
人手のラベルは `int_difference_plus_subtrahend_is_original`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerDifferencePlusSubtrahendIsOriginal
import Ising2D.NecSuf.SubAddCancelOfAddGroup

namespace Ising2D

/-- `int_difference_plus_subtrahend_is_original` を `NecSuf.sub_add_cancel_of_addGroup`（`R := ℤ`）の特殊化として得る。 -/
theorem int_difference_plus_subtrahend_is_original_of_necSuf (x y : ℤ) : (x - y) + y = x :=
  NecSuf.sub_add_cancel_of_addGroup x y

end Ising2D
