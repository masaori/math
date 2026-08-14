/- 具体版の分配多項式の上界が必要十分版の特殊化であることを示す。 -/
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

/-- 必要十分版を配位・破れボンド数・実数へ特殊化し、配位数を代入する。 -/
theorem partitionPolynomial_eval_real_le_upperBound_from_necSuf
    (L : PositiveNatural) [NeZero L.1] (t : StrictlyPositiveReal) :
    Polynomial.aeval t.1 (partitionPolynomial L.1) ≤
      ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
  have htBase : t.1 ≤ 1 + t.1 := by linarith
  have hOneBase : 1 ≤ 1 + t.1 := by nlinarith [t.2]
  have habstract :=
    NecSuf.ThermodynamicLimit.sum_pow_le_uniform_bound_necSuf
      (base := t.1) (upperBase := 1 + t.1)
      (exponent := brokenBondCount L.1) (cap := 2 * L.1 ^ 2)
      (fun k => pow_le_pow_of_pos_of_le_by_induction t.2 htBase k)
      (fun σ => pow_le_pow_of_one_le_of_exp_le_by_induction hOneBase (brokenBondCount_le L.1 σ))
  rw [eval_partitionPolynomial_real L.1 t.1]
  calc
    ∑ σ : Config L.1, t.1 ^ brokenBondCount L.1 σ
        ≤ ∑ _σ : Config L.1, (1 + t.1) ^ (2 * L.1 ^ 2) := habstract
    _ = ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
      rw [sum_const, card_univ, card_config, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
