/-
# 実数を 2 で割った商に 2 を掛けるともとの実数に戻る（具体版を必要十分版から導く）

具体版 `ClaimRealTwiceQuotientByTwoIsOriginal.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulDivCancelOfRightInverse.lean` の `R := ℝ`、`t := 2` の特殊化として得る。
商の定義の仮定には `def_real_quotient` を読む `div_eq_mul_inv` を、`b` と `2⁻¹` の可換性には `mul_comm` を、
結合則には `mul_assoc` を、右逆元には `mul_inv_cancel₀ real_two_is_nonzero` を、左単位元には `one_mul` を渡す。
人手のラベルは `real_twice_quotient_by_two_is_original`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwiceQuotientByTwoIsOriginal
import Ising2D.NecSuf.MulDivCancelOfRightInverse

namespace Ising2D

/-- `real_twice_quotient_by_two_is_original` を `NecSuf.mul_div_cancel_of_right_inverse'`（`R := ℝ`、`t := 2`）の
特殊化として得る。 -/
theorem real_twice_quotient_by_two_is_original_of_necSuf (b : ℝ) : 2 * (b / 2) = b :=
  NecSuf.mul_div_cancel_of_right_inverse' b (2 : ℝ) div_eq_mul_inv (mul_comm b 2⁻¹)
    (fun x y z => mul_assoc x y z) (mul_inv_cancel₀ real_two_is_nonzero) one_mul

end Ising2D
