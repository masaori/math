/-
# 実数の絶対値の二乗と、二つの実数の和の二乗の評価を、必要十分版の特殊化として得る

具体版 `ClaimSquareOfRealAbsoluteValueAndOfRealSum.lean` の主張を、必要十分版
`Ising2D/NecSuf/SquareOfAbsoluteValueAndOfSum.lean` を `R := ℝ` に特殊化して得る。人手のラベルは
`square_of_real_absolute_value`, `square_of_real_sum_is_at_most_twice_sum_of_squares`。
人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum
import Ising2D.NecSuf.SquareOfAbsoluteValueAndOfSum
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- `square_of_real_absolute_value` を `NecSuf.sq_abs'`（`R := ℝ`）の特殊化として得る。 -/
theorem square_of_real_absolute_value_of_necSuf (q : ℝ) : |q| ^ 2 = q ^ 2 :=
  NecSuf.sq_abs' q

/-- `square_of_real_sum_is_at_most_twice_sum_of_squares` を `NecSuf.add_sq_le_two_mul_add'`（`R := ℝ`）の特殊化として得る。 -/
theorem square_of_real_sum_is_at_most_twice_sum_of_squares_of_necSuf (a b : ℝ) :
    (a + b) ^ 2 ≤ 2 * a ^ 2 + 2 * b ^ 2 :=
  NecSuf.add_sq_le_two_mul_add' a b

end Ising2D
