/- 必要十分版（`sum_pow_le_uniform_bound_necSuf`。周期境界・ℝ 版と共有。係数の住処は順序付き加法モノイド
かつモノイドであればよく、有理数体であることも開境界であることも本質でない）を開境界の配位・破れボンド数・
有理数体へ特殊化し、配位数を代入する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueUpperBoundRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset

theorem openPartitionValueRat_le_upperBound_from_necSuf (a b : ℕ) {q : ℚ} (hq : 0 < q) :
    openPartitionValueRat a b q ≤ ((2 ^ (a * b) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * b)) := by
  have hqBase : q ≤ 1 + q := by linarith
  have hOneBase : 1 ≤ 1 + q := by linarith
  have habstract :=
    NecSuf.ThermodynamicLimit.sum_pow_le_uniform_bound_necSuf
      (base := q) (upperBase := 1 + q)
      (exponent := openBrokenBondCount a b) (cap := 2 * (a * b))
      (fun k => pow_le_pow_of_pos_of_le_by_induction_rat hq hqBase k)
      (fun σ => pow_le_pow_of_one_le_of_exp_le_by_induction_rat hOneBase
        (openBrokenBondCount_le_two_mul a b σ))
  rw [openPartitionValueRat_eq_sum]
  calc
    ∑ σ : OpenConfig a b, q ^ openBrokenBondCount a b σ
        ≤ ∑ _σ : OpenConfig a b, (1 + q) ^ (2 * (a * b)) := habstract
    _ = ((2 ^ (a * b) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * b)) := by
      rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
