/-
# 実数の狭義の順序は右から同じ数を足しても保たれる（具体版を必要十分版から導く）

具体版 `ClaimRealLessThanPreservedByAddingOnRight.lean` の主張を、必要十分版
`Ising2D/NecSuf/AddLtAddRightOfLeCompat.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_less_than_preserved_by_adding_on_right`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Ising2D.NecSuf.AddLtAddRightOfLeCompat

namespace Ising2D

/-- `real_less_than_preserved_by_adding_on_right` を `NecSuf.add_lt_add_right_of_le_compat`（`R := ℝ`）の特殊化として得る。 -/
theorem real_less_than_preserved_by_adding_on_right_of_necSuf (x y c : ℝ) (h : x < y) : x + c < y + c :=
  NecSuf.add_lt_add_right_of_le_compat real_lt_iff_le_and_ne (fun _ _ t hle => add_le_add_left hle t)
    add_zero add_neg_cancel add_assoc x y c h

end Ising2D
