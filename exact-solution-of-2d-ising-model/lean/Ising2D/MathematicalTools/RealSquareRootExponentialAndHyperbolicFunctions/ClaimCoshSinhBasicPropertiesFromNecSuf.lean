/-
# `cosh`・`sinh` の基本性質 (1)・(3)（具体版を必要十分版から導く）

具体版 `ClaimCoshSinhBasicProperties.lean` の主張を、必要十分版 `Ising2D/NecSuf/HyperbolicBasicPropertiesFromMonotoneMap.lean` の
定義域 `G := ℝ`、値域 `R := ℝ`、写像 `e := Real.exp`、`c := Real.cosh`、`s := Real.sinh` の特殊化として得る。
`c`・`s` の定義の仮定には mathlib の `Real.cosh_eq`・`Real.sinh_eq`（`/2` を `·⅟2` へ読み替える `cosh_eq_mul_invOf_two`・
`sinh_eq_mul_invOf_two`）、`e` の正値性には具体版 `real_exp_positive`、狭義単調性には mathlib の `Real.exp_lt_exp` を当てる。
人手のラベルは `cosh_sinh_basic_properties`。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicProperties
import Ising2D.NecSuf.HyperbolicBasicPropertiesFromMonotoneMap

namespace Ising2D

/-- `cosh x = (exp(x) + exp(−x))·⅟2`（`Real.cosh_eq` の `/2` を `·⅟2` へ読み替える）。 -/
theorem cosh_eq_mul_invOf_two (x : ℝ) : Real.cosh x = (Real.exp x + Real.exp (-x)) * ⅟2 := by
  rw [Real.cosh_eq, invOf_eq_inv, div_eq_mul_inv]

/-- `sinh x = (exp(x) − exp(−x))·⅟2`（`Real.sinh_eq` の `/2` を `·⅟2` へ読み替える）。 -/
theorem sinh_eq_mul_invOf_two (x : ℝ) : Real.sinh x = (Real.exp x - Real.exp (-x)) * ⅟2 := by
  rw [Real.sinh_eq, invOf_eq_inv, div_eq_mul_inv]

/-- `cosh_sinh_basic_properties` (1) を `NecSuf.evenPart_oddPart_properties'` の特殊化として得る。 -/
theorem cosh_sinh_basic_properties_1_of_necSuf (x : ℝ) :
    (Real.cosh x - Real.sinh x = Real.exp (-x) ∧ Real.exp (-x) > 0) ∧
    (Real.cosh x + Real.sinh x = Real.exp x ∧ Real.exp x > 0) ∧
    Real.cosh x > 0 ∧ Real.cosh x > Real.sinh x :=
  NecSuf.evenPart_oddPart_properties' Real.exp Real.cosh Real.sinh real_exp_positive
    cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two x

/-- `cosh_sinh_basic_properties` (3) を `NecSuf.evenPart_gt_oddPart_pos'` の特殊化として得る。 -/
theorem cosh_sinh_basic_properties_3_of_necSuf {x : ℝ} (hx : x > 0) :
    Real.cosh x > Real.sinh x ∧ Real.sinh x > 0 :=
  NecSuf.evenPart_gt_oddPart_pos' Real.exp Real.cosh Real.sinh real_exp_positive
    (fun _ _ h => Real.exp_lt_exp.mpr h) cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two hx

end Ising2D
