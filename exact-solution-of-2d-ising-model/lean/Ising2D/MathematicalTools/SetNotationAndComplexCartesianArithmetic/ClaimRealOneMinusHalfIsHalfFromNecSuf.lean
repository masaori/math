/-
# 実数で 1 から 1/2 を引くと 1/2 になる（具体版を必要十分版から導く）

具体版 `ClaimRealOneMinusHalfIsHalf.lean` の主張を、必要十分版
`Ising2D/NecSuf/OneSubHalfEqHalf.lean` の `R := ℝ`、`t := 2` の特殊化として得る。
`t·t⁻¹ = 1` の仮定には、具体版と同じく `real_two_is_nonzero` から `mul_inv_cancel₀` で得たものを、
`t = 1 + 1` には `def_real_two` の具体版 `real_two_eq_one_add_one` を渡す。
人手のラベルは `real_one_minus_half_is_half`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealOneMinusHalfIsHalf
import Ising2D.NecSuf.OneSubHalfEqHalf

namespace Ising2D

/-- `real_one_minus_half_is_half` を `NecSuf.one_sub_half_eq_half'`（`R := ℝ`、`t := 2`）の特殊化として得る。 -/
theorem real_one_minus_half_is_half_of_necSuf : (1 : ℝ) - 1 / 2 = 1 / 2 :=
  NecSuf.one_sub_half_eq_half' (2 : ℝ) sub_eq_add_neg (mul_inv_cancel₀ real_two_is_nonzero)
    real_two_eq_one_add_one add_mul div_eq_mul_inv add_assoc add_neg_cancel add_zero

end Ising2D
