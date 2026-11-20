/-
# `sinh` は奇関数を、必要十分版の特殊化として得る

具体版 `ClaimSinhIsOdd.lean` の主張 `sinh_is_odd` を、必要十分版 `Ising2D/NecSuf/AntisymmetrizedDifferenceIsOdd.lean` の
`NecSuf.antisymmetrized_difference_is_odd'` を `G, R, S := ℝ`、`hsub := sub_eq_add_neg`、`hcomm := add_comm`、
`hnegadd := real_negation_of_sum_is_sum_of_negations`、`f := exp`、`d := (· / 2)`、`m := (· * 2⁻¹)`、`hdm := div_eq_mul_inv · 2`、
`hm := real_negation_times_is_negation_of_product · 2⁻¹`、`h := sinh` に特殊化して得る。
人手のラベルは `sinh_is_odd`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimSinhIsOdd
import Ising2D.NecSuf.AntisymmetrizedDifferenceIsOdd

namespace Ising2D

/-- `sinh_is_odd` を `NecSuf.antisymmetrized_difference_is_odd'` の特殊化として得る。
仮定 `hsub` は `def_real_difference` の役の `sub_eq_add_neg`、`hcomm` は加法の交換律 `add_comm`、`hnegadd` は
`real_negation_of_sum_is_sum_of_negations`、`hdm` は `def_real_quotient` の役の `div_eq_mul_inv`、`hm` は
`real_negation_times_is_negation_of_product`（`t → 2^{-1}`）、`hh` は `Real.sinh_eq`（`def_cosh_sinh`）で与える。 -/
theorem sinh_is_odd_of_necSuf (x : ℝ) : Real.sinh (-x) = -Real.sinh x :=
  NecSuf.antisymmetrized_difference_is_odd' sub_eq_add_neg add_comm real_negation_of_sum_is_sum_of_negations
    Real.exp (fun s => s / 2) (fun s => s * 2⁻¹) (fun r => div_eq_mul_inv r 2)
    (fun r => real_negation_times_is_negation_of_product r 2⁻¹) Real.sinh Real.sinh_eq x

end Ising2D
