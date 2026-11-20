/-
# −1 か 1 の実数は、自分自身との積が 1（具体版を必要十分版から導く）

具体版 `ClaimRealPlusOrMinusOneTimesItselfIsOne.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulSelfEqOneOfEqOneOrEqNegOne.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `real_plus_or_minus_one_times_itself_is_one`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealPlusOrMinusOneTimesItselfIsOne
import Ising2D.NecSuf.MulSelfEqOneOfEqOneOrEqNegOne

namespace Ising2D

/-- `real_plus_or_minus_one_times_itself_is_one` を `NecSuf.mul_self_eq_one_of_eq_one_or_eq_neg_one`
（`R := ℝ`、`1·a = a` は `one_mul`）の特殊化として得る。 -/
theorem real_plus_or_minus_one_times_itself_is_one_of_necSuf (σ : ℝ) (hσ : σ = 1 ∨ σ = -1) : σ * σ = 1 :=
  NecSuf.mul_self_eq_one_of_eq_one_or_eq_neg_one (fun c : ℝ => one_mul c) σ hσ

end Ising2D
