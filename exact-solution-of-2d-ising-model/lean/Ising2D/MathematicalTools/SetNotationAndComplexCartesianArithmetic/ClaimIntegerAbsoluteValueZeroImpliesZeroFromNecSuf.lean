/-
# 絶対値が 0 の整数は 0（具体版を必要十分版から導く）

具体版 `ClaimIntegerAbsoluteValueZeroImpliesZero.lean` の主張を、必要十分版
`Ising2D/NecSuf/EqZeroOfAbsCasesEqZero.lean` の `R := ℤ`、`a := |·|` の特殊化として得る。
人手のラベルは `int_absolute_value_zero_implies_zero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueZeroImpliesZero
import Ising2D.NecSuf.EqZeroOfAbsCasesEqZero

namespace Ising2D

/-- `int_absolute_value_zero_implies_zero` を `NecSuf.eq_zero_of_abs_cases_eq_zero`（`R := ℤ`、`a := |·|`）の特殊化として得る。 -/
theorem int_absolute_value_zero_implies_zero_of_necSuf (x : ℤ) (h : |x| = 0) : x = 0 :=
  NecSuf.eq_zero_of_abs_cases_eq_zero (fun y => |y|)
    (fun y hy => (int_abs_of_nonneg_and_of_not_nonneg y).1 hy)
    (fun y hy => (int_abs_of_nonneg_and_of_not_nonneg y).2 hy)
    add_zero add_neg_cancel x h

end Ising2D
