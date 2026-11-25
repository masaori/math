/-
# `cosh`・`sinh` の加法定理を、必要十分版の特殊化として得る

具体版 `ClaimCoshAdditionAndHalfAngle.lean` の `cosh_add_formula`・`cosh_sub_formula`・`sinh_add_formula`・`sinh_sub_formula` を、
必要十分版 `Ising2D/NecSuf/SymmetrizedAdditionFormulas.lean` の `NecSuf.symmetrized_add_formula'`・`symmetrized_sub_formula'`・
`antisymmetrized_add_formula'`・`antisymmetrized_sub_formula'` を `G, K := ℝ`、
`hneg := real_negation_of_sum_is_sum_of_negations`、`hsub := sub_eq_add_neg`、`f := exp`、`hf := Real.exp_add`、
`c := cosh`、`s := sinh`、`hc := cosh_eq_mul_invOf_two`、`hs := sinh_eq_mul_invOf_two`（`Real.cosh_eq`・`Real.sinh_eq` の `/2` を `·⅟2` へ読み替えたもの。
`ClaimCoshSinhBasicPropertiesFromNecSuf.lean`）に特殊化して得る。
人手のラベルは `cosh_addition_formula`・`sinh_addition_formula`。人手証明と 1 対 1 に対応する形は具体版のほうである。

同じファイルで、`sinh_eq_two_sinh_half_mul_cosh_half`（人手 `sinh_double_angle_formula`）を、必要十分版
`Ising2D/NecSuf/DoubleAngleFormula.lean` の `NecSuf.double_angle_formula'` を `A, R := ℝ`、`y := x / 2`、
`s := sinh`、`c := cosh`、`hh := (add_halves x).symm`、`hadd := sinh_add_formula (x / 2) (x / 2)`、`hcomm := mul_comm _ _`、
`hdbl := (two_mul _).symm`、`hassoc := (mul_assoc 2 _ _).symm` に特殊化して得る。

同じファイルで、`sinh_le_mul_cosh_of_nonneg`（人手 `sinh_at_most_argument_times_cosh`）を、必要十分版
`Ising2D/NecSuf/HyperbolicBounds.lean` の `NecSuf.sinh_le_mul_cosh` の特殊化として得る（主張は同じ型）。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle
import Ising2D.NecSuf.SymmetrizedAdditionFormulas
import Ising2D.NecSuf.DoubleAngleFormula
import Ising2D.NecSuf.HyperbolicBounds
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicPropertiesFromNecSuf

namespace Ising2D

/-- `cosh_add_formula` を `NecSuf.symmetrized_add_formula'` の特殊化として得る。 -/
theorem cosh_add_formula_of_necSuf (x y : ℝ) :
    Real.cosh (x + y) = Real.cosh x * Real.cosh y + Real.sinh x * Real.sinh y :=
  NecSuf.symmetrized_add_formula' real_negation_of_sum_is_sum_of_negations Real.exp Real.exp_add
    Real.cosh Real.sinh cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two x y

/-- `cosh_sub_formula` を `NecSuf.symmetrized_sub_formula'` の特殊化として得る。 -/
theorem cosh_sub_formula_of_necSuf (x y : ℝ) :
    Real.cosh (x - y) = Real.cosh x * Real.cosh y - Real.sinh x * Real.sinh y :=
  NecSuf.symmetrized_sub_formula' real_negation_of_sum_is_sum_of_negations sub_eq_add_neg Real.exp Real.exp_add
    Real.cosh Real.sinh cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two x y

/-- `sinh_add_formula` を `NecSuf.antisymmetrized_add_formula'` の特殊化として得る。 -/
theorem sinh_add_formula_of_necSuf (x y : ℝ) :
    Real.sinh (x + y) = Real.sinh x * Real.cosh y + Real.cosh x * Real.sinh y :=
  NecSuf.antisymmetrized_add_formula' real_negation_of_sum_is_sum_of_negations Real.exp Real.exp_add
    Real.cosh Real.sinh cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two x y

/-- `sinh_sub_formula` を `NecSuf.antisymmetrized_sub_formula'` の特殊化として得る。 -/
theorem sinh_sub_formula_of_necSuf (x y : ℝ) :
    Real.sinh (x - y) = Real.sinh x * Real.cosh y - Real.cosh x * Real.sinh y :=
  NecSuf.antisymmetrized_sub_formula' real_negation_of_sum_is_sum_of_negations sub_eq_add_neg Real.exp Real.exp_add
    Real.cosh Real.sinh cosh_eq_mul_invOf_two sinh_eq_mul_invOf_two x y

/-- `sinh_eq_two_sinh_half_mul_cosh_half` を `NecSuf.double_angle_formula'` の特殊化として得る。 -/
theorem sinh_eq_two_sinh_half_mul_cosh_half_of_necSuf (x : ℝ) :
    Real.sinh x = 2 * Real.sinh (x / 2) * Real.cosh (x / 2) :=
  NecSuf.double_angle_formula' Real.sinh Real.cosh x (x / 2) (add_halves x).symm
    (sinh_add_formula (x / 2) (x / 2)) (mul_comm _ _) (two_mul _).symm (mul_assoc 2 _ _).symm

/-- `sinh_le_mul_cosh_of_nonneg` を `NecSuf.sinh_le_mul_cosh` の特殊化として得る。 -/
theorem sinh_le_mul_cosh_of_nonneg_of_necSuf {t : ℝ} (ht : 0 ≤ t) : Real.sinh t ≤ t * Real.cosh t :=
  NecSuf.sinh_le_mul_cosh ht

end Ising2D
