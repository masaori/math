/-
# `(2_ℂ z) 2_ℂ^{-1} = z`（具体版を必要十分版から導く）

具体版 `ClaimTwiceTimesInverseOfTwoIsOriginalInCC.lean` の主張を、必要十分版
`Ising2D/NecSuf/TwiceTimesInverseOfTwo.lean` の `M := ℂ`・`t := 2_ℂ`・`s := 2_ℂ^{-1}` の特殊化として得る。
人手のラベルは `twice_times_inverse_of_two_is_original_in_cc`。
仮定 `hc` は `ℂ` の積の可換律（`mul_comm`）、`hinv` は `complex_two_ne_zero_by_re` と `mul_inv_cancel₀`（人手の
`multiplicative_group_of_cc` の逆元）、`hone` は `mul_one`（人手の `complex_numbers_form_a_field` の積の単位元）で与える。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimTwiceTimesInverseOfTwoIsOriginalInCC
import Ising2D.NecSuf.TwiceTimesInverseOfTwo

namespace Ising2D

/-- `complex_two_mul_mul_inv_two` を `NecSuf.mul_mul_right_inverse_of_commute'`（`M := ℂ`）の特殊化として得る。 -/
theorem complex_two_mul_mul_inv_two_of_necSuf (z : ℂ) : (2 * z) * 2⁻¹ = z :=
  NecSuf.mul_mul_right_inverse_of_commute' mul_one 2 2⁻¹ z (mul_comm 2 z)
    (mul_inv_cancel₀ complex_two_ne_zero_by_re)

end Ising2D
