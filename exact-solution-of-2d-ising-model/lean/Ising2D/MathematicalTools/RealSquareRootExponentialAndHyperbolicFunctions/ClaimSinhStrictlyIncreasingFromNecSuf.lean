/-
# `sinh` の狭義単調性を、必要十分版の特殊化として得る

具体版 `ClaimSinhStrictlyIncreasing.lean` の `sinh_strictly_increasing`（人手 `sinh_strictly_increasing`）を、
必要十分版 `Ising2D/NecSuf/OddPartStrictlyIncreasing.lean` の `NecSuf.oddPart_strictly_increasing'` を
`G, R := ℝ`、`e := exp`、`s := sinh`、`k := 1/2`、`hk := one_half_pos`、`hmono := Real.exp_lt_exp.mpr`、
`hs := sinh_eq_mul_one_half`（`Real.sinh_eq` の `/2` を `·(1/2)` へ読み替えたもの）に特殊化して得る。
人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimSinhStrictlyIncreasing
import Ising2D.NecSuf.OddPartStrictlyIncreasing

namespace Ising2D

/-- `sinh x = (exp x − exp(−x))·(1/2)`（`Real.sinh_eq` の `/2` を `·(1/2)` へ読み替える）。 -/
theorem sinh_eq_mul_one_half (x : ℝ) : Real.sinh x = (Real.exp x - Real.exp (-x)) * (1 / 2) := by
  rw [Real.sinh_eq x, mul_one_div]

/-- `sinh_strictly_increasing` を `NecSuf.oddPart_strictly_increasing'` の特殊化として得る。 -/
theorem sinh_strictly_increasing_of_necSuf {x y : ℝ} (h : x < y) : Real.sinh x < Real.sinh y :=
  NecSuf.oddPart_strictly_increasing' Real.exp Real.sinh (1 / 2) one_half_pos
    (fun _ _ hab => Real.exp_lt_exp.mpr hab) sinh_eq_mul_one_half h

end Ising2D
