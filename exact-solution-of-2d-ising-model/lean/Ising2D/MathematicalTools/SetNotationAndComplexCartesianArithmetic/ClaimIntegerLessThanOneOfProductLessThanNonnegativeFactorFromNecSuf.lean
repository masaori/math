/-
# 0 以上の整数 c について x·c < c なら x < 1（具体版を必要十分版から導く）

具体版 `ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactor.lean` の主張を、必要十分版
`Ising2D/NecSuf/LtOneOfMulLtSelfOfCases.lean` の `R := ℤ` の特殊化として得る。
人手のラベルは `int_less_than_one_of_product_less_than_nonnegative_factor`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactor
import Ising2D.NecSuf.LtOneOfMulLtSelfOfCases

namespace Ising2D

/-- `int_less_than_one_of_product_less_than_nonnegative_factor` を `NecSuf.lt_one_of_mul_lt_self_of_cases`（`R := ℤ`）の特殊化として得る。 -/
theorem int_less_than_one_of_product_less_than_nonnegative_factor_of_necSuf (x c : ℤ) (hc : 0 ≤ c)
    (hxc : x * c < c) : x < 1 :=
  NecSuf.lt_one_of_mul_lt_self_of_cases x c (le_total x 0)
    (fun y hy => by
      rcases eq_or_lt_of_le hy with h | h
      · exact Or.inl h.symm
      · exact Or.inr ⟨y - 1, by omega, by omega⟩)
    (le_refl 0) (fun _ _ _ h1 h2 => le_trans h1 h2) (fun h1 h2 => le_antisymm h1 h2)
    (fun _ _ t h => add_le_add_left h t)
    (fun _ _ h1 h2 => mul_nonneg h1 h2)
    int_lt_iff_add_one_le
    zero_add add_neg_cancel neg_add_cancel add_assoc add_comm one_mul add_mul
    int_zero_at_most_one zero_ne_one hc hxc

end Ising2D
