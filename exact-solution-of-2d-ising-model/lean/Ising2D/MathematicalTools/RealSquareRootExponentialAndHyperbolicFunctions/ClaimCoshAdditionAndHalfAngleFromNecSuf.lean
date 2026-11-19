/-
# `cosh`・`sinh` の加法定理を、必要十分版の特殊化として得る

具体版 `ClaimCoshAdditionAndHalfAngle.lean` の `cosh_add_formula`・`cosh_sub_formula`・`sinh_add_formula`・`sinh_sub_formula` を、
必要十分版 `Ising2D/NecSuf/SymmetrizedAdditionFormulas.lean` の `NecSuf.symmetrized_add_formula'`・`symmetrized_sub_formula'`・
`antisymmetrized_add_formula'`・`antisymmetrized_sub_formula'` を `G, K := ℝ`、
`hneg := real_negation_of_sum_is_sum_of_negations`、`hsub := sub_eq_add_neg`、`f := exp`、`hf := Real.exp_add`、
`c := cosh`、`s := sinh`、`hc := cosh_eq_mul_invOf_two`、`hs := sinh_eq_mul_invOf_two`（`Real.cosh_eq`・`Real.sinh_eq` の `/2` を `·⅟2` へ読み替えたもの。
`ClaimCoshSinhBasicPropertiesFromNecSuf.lean`）に特殊化して得る。
人手のラベルは `cosh_addition_formula`・`sinh_addition_formula`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle
import Ising2D.NecSuf.SymmetrizedAdditionFormulas
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

end Ising2D
