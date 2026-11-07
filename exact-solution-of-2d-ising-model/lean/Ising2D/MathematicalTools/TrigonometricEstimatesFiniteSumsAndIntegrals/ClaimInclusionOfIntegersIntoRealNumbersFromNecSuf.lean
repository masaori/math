/-
# `ι(1) = 1`・非負の整数の和・定数の有限和・2 の冪（具体版を必要十分版から導く）

具体版 `ClaimInclusionOfIntegersIntoRealNumbers.lean` の 5 つの主張を、必要十分版
`Ising2D/NecSuf/NaturalNumberCastIntoSemiring.lean` の `R := ℝ`（`power_of_two_in_integers_is_at_least_one` は `R := ℕ`）の特殊化として得る。
人手のラベルは `inclusion_zz_to_rr_of_one`、`inclusion_zz_to_rr_preserves_sum_of_nonnegatives`、
`finite_sum_of_constant_real_number`、`power_of_two_in_integers_is_at_least_one`、`inclusion_zz_to_rr_of_power_of_two`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers
import Ising2D.NecSuf.NaturalNumberCastIntoSemiring

namespace Ising2D

/-- `inclusion_zz_to_rr_of_one` を `NecSuf.cast_one'` の `R := ℝ` として得る。 -/
theorem inclusion_zz_to_rr_of_one_of_necSuf : ((1 : ℕ) : ℝ) = 1 :=
  NecSuf.cast_one' (R := ℝ)

/-- `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` を `NecSuf.cast_add'` の `R := ℝ` として得る。 -/
theorem inclusion_zz_to_rr_preserves_sum_of_nonnegatives_of_necSuf (a b : ℕ) :
    ((a + b : ℕ) : ℝ) = (a : ℝ) + (b : ℝ) :=
  NecSuf.cast_add' (R := ℝ) a b

/-- `finite_sum_of_constant_real_number_succ` を `NecSuf.sum_const_fin_succ'` の `R := ℝ` として得る。 -/
theorem finite_sum_of_constant_real_number_succ_of_necSuf (m : ℕ) (r : ℝ) :
    ∑ _j : Fin (m + 1), r = ((m + 1 : ℕ) : ℝ) * r :=
  NecSuf.sum_const_fin_succ' m r

/-- `inclusion_zz_to_rr_of_power_of_two` を `NecSuf.cast_two_pow'` の `R := ℝ` として得る。 -/
theorem inclusion_zz_to_rr_of_power_of_two_of_necSuf (M : ℕ) : ((2 ^ M : ℕ) : ℝ) = (2 : ℝ) ^ M :=
  NecSuf.cast_two_pow' (R := ℝ) M

/-- `power_of_two_in_integers_is_at_least_one` を `NecSuf.one_le_two_pow'` の `R := ℕ` として得る。 -/
theorem power_of_two_in_integers_is_at_least_one_of_necSuf (M : ℕ) : 1 ≤ 2 ^ M :=
  NecSuf.one_le_two_pow' (R := ℕ) M

end Ising2D
