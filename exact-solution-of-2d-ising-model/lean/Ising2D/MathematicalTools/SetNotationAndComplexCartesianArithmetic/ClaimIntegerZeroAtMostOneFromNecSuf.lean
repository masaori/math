/-
# 整数の 0 は 1 以下（具体版を必要十分版から導く）

具体版 `ClaimIntegerZeroAtMostOne.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroLeOneOfCases.lean` の `R := ℤ` の特殊化として得る。
人手のラベルは `int_zero_at_most_one`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroAtMostOne
import Ising2D.NecSuf.ZeroLeOneOfCases

namespace Ising2D

/-- `int_zero_at_most_one` を `NecSuf.zero_le_one_of_cases`（`R := ℤ`）の特殊化として得る。 -/
theorem int_zero_at_most_one_of_necSuf : (0 : ℤ) ≤ 1 :=
  NecSuf.zero_le_one_of_cases (le_total 0 1)
    (fun _ _ t h => add_le_add_left h t)
    (fun _ _ h1 h2 => mul_nonneg h1 h2)
    int_negation_times_is_negation_of_product
    one_mul zero_add add_zero add_neg_cancel neg_add_cancel add_assoc

end Ising2D
