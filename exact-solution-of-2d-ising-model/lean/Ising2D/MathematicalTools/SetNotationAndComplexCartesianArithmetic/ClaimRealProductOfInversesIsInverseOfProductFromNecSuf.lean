/-
# 0 でない実数の逆元どうしの積は積の逆元（具体版を必要十分版から導く）

具体版 `ClaimRealProductOfInversesIsInverseOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulOfRightInversesEqRightInverseOfMul.lean` の `R := ℝ`、`a' := a⁻¹`、`b' := b⁻¹`、`c := (a·b)⁻¹` の
特殊化として得る。`(a·b)·(a·b)⁻¹ = 1` の `a·b ≠ 0` には、具体版と同じく `real_product_of_nonzero_is_nonzero` を渡す。
人手のラベルは `real_product_of_inverses_is_inverse_of_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfInversesIsInverseOfProduct
import Ising2D.NecSuf.MulOfRightInversesEqRightInverseOfMul

namespace Ising2D

/-- `real_product_of_inverses_is_inverse_of_product` を `NecSuf.mul_of_rightInverses_eq_rightInverse_of_mul`
（`R := ℝ`、`a' := a⁻¹`、`b' := b⁻¹`、`c := (a·b)⁻¹`）の特殊化として得る。 -/
theorem real_product_of_inverses_is_inverse_of_product_of_necSuf (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    a⁻¹ * b⁻¹ = (a * b)⁻¹ :=
  NecSuf.mul_of_rightInverses_eq_rightInverse_of_mul one_mul mul_one mul_assoc mul_comm
    (mul_inv_cancel₀ ha) (mul_inv_cancel₀ hb)
    (mul_inv_cancel₀ (real_product_of_nonzero_is_nonzero a b ha hb))

end Ising2D
