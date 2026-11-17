/-
# 実数の狭義の順序は非対称（具体版を必要十分版から導く）

具体版 `ClaimRealLessThanIsAsymmetric.lean` の主張を、必要十分版
`Ising2D/NecSuf/NotLtOfLtOfAntisymm.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_less_than_is_asymmetric`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanIsAsymmetric
import Ising2D.NecSuf.NotLtOfLtOfAntisymm

namespace Ising2D

/-- `real_less_than_is_asymmetric` を `NecSuf.not_lt_of_lt_of_antisymm`（`R := ℝ`）の特殊化として得る。 -/
theorem real_less_than_is_asymmetric_of_necSuf (a b : ℝ) (hab : a < b) : ¬ b < a :=
  NecSuf.not_lt_of_lt_of_antisymm (fun _ _ h => h.le) (fun _ _ h => h.ne)
    (fun _ _ h₁ h₂ => le_antisymm h₁ h₂) a b hab

end Ising2D
