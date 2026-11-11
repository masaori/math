/-
# `z(-w) = -(zw)`・`(-z)w = -(zw)`・`(-x) + x = 0_ℂ`（具体版を必要十分版から導く）

具体版 `ClaimNegationInProductAndNegationPlusSelfInCC.lean` の主張を、必要十分版
`Ising2D/NecSuf/NegationInProductAndNegationPlusSelf.lean` の係数 `R := ℂ` の特殊化として得る。
人手のラベルは `complex_times_negation_is_negation_of_product_in_cc`・`negation_times_complex_is_negation_of_product_in_cc`・
`negation_plus_self_is_zero_in_cc`。
仮定 `hneg` は `ClaimMatrixDoubleNegationFromNecSuf.lean` の `complex_neg_eq_neg_one_mul`、`hleft` は
`ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf.lean` の `complex_one_mul` で、`hcomm`・`hsum`・`hzero` はこのファイルで与える。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimNegationInProductAndNegationPlusSelfInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf
import Ising2D.NecSuf.NegationInProductAndNegationPlusSelf

namespace Ising2D

/-- 必要十分版の仮定 `hcomm` を `ℂ` で与える（人手の `complex_numbers_form_a_field` の積の可換律）。 -/
theorem complex_mul_neg_one_comm (x : ℂ) : x * (-1) = (-1) * x := mul_comm x (-1)

/-- 必要十分版の仮定 `hsum` を `ℂ` で与える（具体版 `neg_add_self_complex` の 4〜7 段目と同じ成分の鎖）。 -/
theorem complex_neg_one_add_one : (-1 : ℂ) + 1 = 0 :=
  calc (-1 : ℂ) + 1
      = (⟨-1, 0⟩ : ℂ) + ⟨1, 0⟩ := by congr 1 <;> apply Complex.ext <;> simp   -- `inclusion_rr_to_cc`
    _ = (⟨-1 + 1, 0 + 0⟩ : ℂ) := rfl                                        -- `definition_of_cc` の和
    _ = (⟨0, 0⟩ : ℂ) := by norm_num                                         -- `ℝ` の四則
    _ = 0 := rfl                                                            -- `inclusion_rr_to_cc` を右辺から左辺へ

/-- 必要十分版の仮定 `hzero` を `ℂ` で与える（人手の `complex_zero_times_is_zero`）。 -/
theorem complex_zero_mul (x : ℂ) : 0 * x = 0 := zero_mul x

/-- `mul_neg_eq_neg_mul_complex` を `NecSuf.mul_neg_eq_neg_mul_of_neg_one'`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_neg_eq_neg_mul_complex_of_necSuf (z w : ℂ) : z * (-w) = -(z * w) :=
  NecSuf.mul_neg_eq_neg_mul_of_neg_one' complex_neg_eq_neg_one_mul complex_mul_neg_one_comm z w

/-- `neg_mul_eq_neg_mul_complex` を `NecSuf.neg_mul_eq_neg_mul_of_neg_one'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_mul_eq_neg_mul_complex_of_necSuf (z w : ℂ) : (-z) * w = -(z * w) :=
  NecSuf.neg_mul_eq_neg_mul_of_neg_one' complex_neg_eq_neg_one_mul z w

/-- `neg_add_self_complex` を `NecSuf.neg_add_self_of_neg_one'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_add_self_complex_of_necSuf (x : ℂ) : (-x) + x = 0 :=
  NecSuf.neg_add_self_of_neg_one' complex_neg_eq_neg_one_mul complex_one_mul complex_neg_one_add_one complex_zero_mul x

end Ising2D
