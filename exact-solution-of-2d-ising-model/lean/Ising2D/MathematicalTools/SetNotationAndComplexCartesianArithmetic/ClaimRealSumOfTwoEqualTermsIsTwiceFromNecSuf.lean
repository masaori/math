/-
# 同じ実数を二つ足すと 2 倍になる（具体版を必要十分版から導く）

具体版 `ClaimRealSumOfTwoEqualTermsIsTwice.lean` の主張を、必要十分版
`Ising2D/NecSuf/AddSelfEqTwoMul.lean` の `R := ℝ`、`t := 2` の特殊化として得る。
左単位元の仮定には `one_mul` を、右からの分配則には `add_mul` を、`1 + 1 = t` には `def_real_two` を読む
`one_add_one_eq_two` を渡す。人手のラベルは `real_sum_of_two_equal_terms_is_twice`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealSumOfTwoEqualTermsIsTwice
import Ising2D.NecSuf.AddSelfEqTwoMul

namespace Ising2D

/-- `real_sum_of_two_equal_terms_is_twice` を `NecSuf.add_self_eq_two_mul'`（`R := ℝ`、`t := 2`）の特殊化として得る。 -/
theorem real_sum_of_two_equal_terms_is_twice_of_necSuf (a : ℝ) : a + a = 2 * a :=
  NecSuf.add_self_eq_two_mul' a (2 : ℝ) one_mul add_mul one_add_one_eq_two

end Ising2D
