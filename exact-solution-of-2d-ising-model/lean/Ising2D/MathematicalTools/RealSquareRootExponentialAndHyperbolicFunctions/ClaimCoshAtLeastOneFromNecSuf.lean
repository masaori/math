/-
# `cosh x ≥ 1` を、必要十分版の特殊化として得る

具体版 `ClaimCoshAtLeastOne.lean` の主張 `cosh_at_least_one` を、必要十分版
`Ising2D/NecSuf/OnePlusTwiceNonnegativeIsAtLeastOne.lean` の `NecSuf.one_add_two_mul_sq_ge_one'` を
`S := ℝ`、`h := cosh x`、`t := sinh(x/2)` に特殊化して得る。
人手のラベルは `cosh_at_least_one`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAtLeastOne
import Ising2D.NecSuf.OnePlusTwiceNonnegativeIsAtLeastOne

namespace Ising2D

/-- `cosh_at_least_one` を `NecSuf.one_add_two_mul_sq_ge_one'` の特殊化として得る。仮定 `hh` は
`cosh_eq_one_add_two_sinh_half_sq`（`cosh_half_angle_formula`）で与える。 -/
theorem cosh_at_least_one_of_necSuf (x : ℝ) : Real.cosh x ≥ 1 :=
  NecSuf.one_add_two_mul_sq_ge_one' (Real.cosh x) (Real.sinh (x / 2)) (cosh_eq_one_add_two_sinh_half_sq x)

end Ising2D
