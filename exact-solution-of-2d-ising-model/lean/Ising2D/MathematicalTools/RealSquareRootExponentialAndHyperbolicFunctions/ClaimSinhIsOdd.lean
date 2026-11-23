/-
# `sinh` は奇関数（**具体版**）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_claim_sinh_is_odd`（ラベル `sinh_is_odd`）

人手の 11 行の鎖と `sinh_is_odd` の `calc` は 1 対 1 である。`def_cosh_sinh` は Lean で定義し直しておらず、
mathlib の `Real.sinh` の等式 `Real.sinh_eq`（`sinh x = (exp x − exp(−x))/2`）が人手の定義の式そのものとしてその役を担う。
`def_real_difference`（`y − z := y + (−z)`）は mathlib の `sub_eq_add_neg`、`def_real_quotient`（`y/z := y z^{-1}`）は具体版 `real_div_eq_mul_inv`（`DefinitionRealQuotient.lean`）、
`set_and_algebra_notation` の加法の交換律は `add_comm` が、それぞれ定義の式・公理の役を担う。
mathlib の `Real.sinh_neg`・`neg_sub`・`neg_div` は使わない（人手の鎖をそのまま書くため）。
人手の `def_real_quotient` の前提 `2 ≠ 0` の根拠 `real_two_is_nonzero` は、`real_div_eq_mul_inv` の仮定（商の定義域）へ渡す。
必要十分版は `Ising2D/NecSuf/AntisymmetrizedDifferenceIsOdd.lean` の `NecSuf.antisymmetrized_difference_is_odd'`、
具体版をその特殊化として得る導出は `ClaimSinhIsOddFromNecSuf.lean`。
-/
import Mathlib.Analysis.Complex.Trigonometric
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealDoubleNegation
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfSumIsSumOfNegations
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesIsNegationOfProduct
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwoIsNonzero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealQuotient

namespace Ising2D

/-- **人手 `sinh_is_odd`**: `x ∈ ℝ` について `sinh(−x) = −sinh x`。 -/
theorem sinh_is_odd (x : ℝ) : Real.sinh (-x) = -Real.sinh x :=
  calc Real.sinh (-x)
      = (Real.exp (-x) - Real.exp (-(-x))) / 2 := Real.sinh_eq (-x)
                                                        -- `sinh` の定義（`def_cosh_sinh`）
    _ = (Real.exp (-x) - Real.exp x) / 2 := by rw [real_double_negation x]
                                                        -- `real_double_negation`（`a → x`）
    _ = (Real.exp (-x) + (-Real.exp x)) / 2 := by rw [sub_eq_add_neg (Real.exp (-x)) (Real.exp x)]
                                                        -- `def_real_difference`（`y → exp(−x)`, `z → exp(x)`）
    _ = ((-Real.exp x) + Real.exp (-x)) / 2 := by rw [add_comm (Real.exp (-x)) (-Real.exp x)]
                                                        -- `ℝ` の加法の交換律（`p → exp(−x)`, `q → −exp(x)`）（`set_and_algebra_notation`）
    _ = ((-Real.exp x) + (-(-Real.exp (-x)))) / 2 := by rw [real_double_negation (Real.exp (-x))]
                                                        -- `real_double_negation`（`a → exp(−x)`）を右辺から左辺へ
    _ = (-(Real.exp x + (-Real.exp (-x)))) / 2 := by
          rw [real_negation_of_sum_is_sum_of_negations (Real.exp x) (-Real.exp (-x))]
                                                        -- `real_negation_of_sum_is_sum_of_negations`（`x → exp(x)`, `y → −exp(−x)`）を右辺から左辺へ
    _ = (-(Real.exp x - Real.exp (-x))) / 2 := by rw [← sub_eq_add_neg (Real.exp x) (Real.exp (-x))]
                                                        -- `def_real_difference`（`y → exp(x)`, `z → exp(−x)`）を右辺から左辺へ
    _ = (-(Real.exp x - Real.exp (-x))) * 2⁻¹ := real_div_eq_mul_inv _ 2 real_two_is_nonzero
                                                        -- `def_real_quotient`（`y → −(exp(x) − exp(−x))`, `z → 2`）。`2 ≠ 0` は `real_two_is_nonzero`
    _ = -((Real.exp x - Real.exp (-x)) * 2⁻¹) :=
          real_negation_times_is_negation_of_product (Real.exp x - Real.exp (-x)) 2⁻¹
                                                        -- `real_negation_times_is_negation_of_product`（`x → exp(x) − exp(−x)`, `t → 2^{-1}`）
    _ = -((Real.exp x - Real.exp (-x)) / 2) := by rw [← real_div_eq_mul_inv (Real.exp x - Real.exp (-x)) 2 real_two_is_nonzero]
                                                        -- `def_real_quotient`（`y → exp(x) − exp(−x)`, `z → 2`）を右辺から左辺へ（`2 ≠ 0` は `real_two_is_nonzero`）
    _ = -Real.sinh x := by rw [← Real.sinh_eq x]        -- `sinh` の定義を右辺から左辺へ（`def_cosh_sinh`）

end Ising2D
