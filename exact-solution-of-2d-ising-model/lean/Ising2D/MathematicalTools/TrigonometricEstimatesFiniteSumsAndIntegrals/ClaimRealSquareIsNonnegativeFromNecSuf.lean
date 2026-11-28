/-
# 実数の二乗は 0 以上（具体版を必要十分版から導く）

具体版 `ClaimRealSquareIsNonnegative.lean` の主張を、必要十分版
`Ising2D/NecSuf/SqNonnegOfCases.lean` の `R := ℝ`、`s := (·)^2` の特殊化として得る。
人手のラベルは `real_square_is_nonnegative`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealSquareIsNonnegative
import Ising2D.NecSuf.SqNonnegOfCases

namespace Ising2D

/-- `real_square_is_nonnegative` を `NecSuf.sq_nonneg_of_cases`（`R := ℝ`、`s := (·)^2`）の特殊化として得る。 -/
theorem real_square_is_nonnegative_of_necSuf (r : ℝ) : 0 ≤ r ^ 2 :=
  NecSuf.sq_nonneg_of_cases (fun y : ℝ => y ^ 2) square_of_real_number_is_product
    (fun y => le_total 0 y) add_neg_cancel (fun _ t h => add_le_add_left h t) zero_add
    (fun y h => mul_nonneg h h) (fun y => real_negation_times_negation_is_product y y) r

end Ising2D
