/-
# 0 でない実数どうしの積は 0 でない（具体版を必要十分版から導く）

具体版 `ClaimRealProductOfNonzeroIsNonzero.lean` の主張を、必要十分版
`Ising2D/NecSuf/MulNeZeroOfLeftInverse.lean` の `R := ℝ`、`c := a⁻¹` の特殊化として得る。
`y·0 = 0` の仮定には、具体版と同じく `real_times_zero_is_zero` を渡す。
人手のラベルは `real_product_of_nonzero_is_nonzero`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfNonzeroIsNonzero
import Ising2D.NecSuf.MulNeZeroOfLeftInverse

namespace Ising2D

/-- `real_product_of_nonzero_is_nonzero` を `NecSuf.mul_ne_zero_of_leftInverse`（`R := ℝ`、`c := a⁻¹`）の特殊化として得る。 -/
theorem real_product_of_nonzero_is_nonzero_of_necSuf (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    a * b ≠ 0 :=
  NecSuf.mul_ne_zero_of_leftInverse one_mul mul_assoc real_times_zero_is_zero
    (inv_mul_cancel₀ ha) hb

end Ising2D
