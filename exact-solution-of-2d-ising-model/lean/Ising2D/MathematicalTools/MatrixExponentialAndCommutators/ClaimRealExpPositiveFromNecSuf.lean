/-
# 実数の exp は正（具体版を必要十分版から導く）

具体版 `ClaimRealExpPositive.lean` の主張を、必要十分版 `Ising2D/NecSuf/PositivityOfAdditiveToMultiplicativeMap.lean` の
定義域 `G := ℝ`、値域 `R := ℝ`、写像 `f := Real.exp`、`y := x/2` の特殊化として得る。人手のラベルは `real_exp_positive`。
-/
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpPositive
import Ising2D.NecSuf.PositivityOfAdditiveToMultiplicativeMap

namespace Ising2D

/-- `real_exp_positive` を `NecSuf.map_pos`（`f := Real.exp`、半分は `x/2`）の特殊化として得る。 -/
theorem real_exp_positive_of_necSuf (x : ℝ) : Real.exp x > 0 :=
  NecSuf.map_pos Real.exp Real.exp_add Real.exp_zero (fun x => ⟨x / 2, add_halves x⟩) x

end Ising2D
