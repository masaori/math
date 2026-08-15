/- 必要十分版（`sum_pow_le_uniform_bound_necSuf`。ℝ 版と共有。係数の住処は順序付き加法モノイドかつモノイドで
あればよく、有理数体であることは本質でない）を配位・破れボンド数・有理数体へ特殊化し、配位数を代入する。 -/
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBoundRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial FreeEntropy

theorem partitionPolynomial_eval_rat_le_upperBound_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) :
    Polynomial.aeval q (partitionPolynomial L) ≤
      ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
  have hqBase : q ≤ 1 + q := by linarith
  have hOneBase : 1 ≤ 1 + q := by linarith
  have habstract :=
    NecSuf.ThermodynamicLimit.sum_pow_le_uniform_bound_necSuf
      (base := q) (upperBase := 1 + q)
      (exponent := brokenBondCount L) (cap := 2 * L ^ 2)
      (fun k => pow_le_pow_of_pos_of_le_by_induction_rat hq hqBase k)
      (fun σ => pow_le_pow_of_one_le_of_exp_le_by_induction_rat hOneBase (brokenBondCount_le L σ))
  rw [eval_partitionPolynomial L q]
  calc
    ∑ σ : Config L, q ^ brokenBondCount L σ
        ≤ ∑ _σ : Config L, (1 + q) ^ (2 * L ^ 2) := habstract
    _ = ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
      rw [sum_const, card_univ, card_config, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
