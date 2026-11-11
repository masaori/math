/-
# 正の実数の平方根は正（具体版を必要十分版から導く）

具体版 `ClaimSqrtOfPositiveRealIsPositive.lean` の `sqrt_of_positive_real_is_positive` の主張を、必要十分版
`Ising2D/NecSuf/PositiveSquareRootIsPositive.lean` の `NecSuf.pos_of_nonneg_of_sq_eq_pos` の
`R := ℝ`、`y := √x` への特殊化として得る。人手のラベルは `sqrt_of_positive_real_is_positive`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSqrtOfPositiveRealIsPositive
import Ising2D.NecSuf.PositiveSquareRootIsPositive

namespace Ising2D

/-- `sqrt_of_positive_real_is_positive` を `NecSuf.pos_of_nonneg_of_sq_eq_pos`（`R := ℝ`、`y := √x`）の特殊化として得る。
`0·0 = 0` は ℝ で `0·x = 0` の `x → 0`、`y ≥ 0`・`y^2 = x` は `definition_of_sqrt_r_positive`（`Real.sqrt_nonneg`・`Real.sq_sqrt`）が与える。 -/
theorem sqrt_of_positive_real_is_positive_of_necSuf (x : ℝ) (hx : 0 < x) : 0 < Real.sqrt x :=
  NecSuf.pos_of_nonneg_of_sq_eq_pos (zero_mul 0) (Real.sqrt_nonneg x) (Real.sq_sqrt (le_of_lt hx)) hx

end Ising2D
