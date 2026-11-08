/-
# 正の実数の二乗の一意性（具体版を必要十分版から導く）

具体版 `ClaimPositiveRealSquareInjective.lean` の `factor_difference_of_squares_eq_zero`・`positive_real_square_injective` の主張を、
必要十分版 `Ising2D/NecSuf/PositiveSquareInjective.lean` の `NecSuf.factor_difference_of_squares_eq_zero'`・
`NecSuf.positive_square_injective'` の `R := ℝ` の特殊化として得る。`b a = a b` は ℝ の乗法の交換法則 `mul_comm b a` で与える。
人手のラベルは `positive_real_square_injective`。
-/
import Ising2D.NecSuf.PositiveSquareInjective
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- `factor_difference_of_squares_eq_zero` を `NecSuf.factor_difference_of_squares_eq_zero'`（`R := ℝ`）の特殊化として得る。 -/
theorem factor_difference_of_squares_eq_zero_of_necSuf {a b : ℝ} (h : a ^ 2 = b ^ 2) :
    (a - b) * (a + b) = 0 :=
  NecSuf.factor_difference_of_squares_eq_zero' (mul_comm b a) h

/-- `positive_real_square_injective` を `NecSuf.positive_square_injective'`（`R := ℝ`）の特殊化として得る。 -/
theorem positive_real_square_injective_of_necSuf {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a ^ 2 = b ^ 2 ↔ a = b :=
  NecSuf.positive_square_injective' (mul_comm b a) ha hb

end Ising2D
