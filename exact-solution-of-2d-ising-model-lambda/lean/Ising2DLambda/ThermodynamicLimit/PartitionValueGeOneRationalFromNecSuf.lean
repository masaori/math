/- 必要十分版を具体的な配位・破れボンド数・有理数体へ特殊化する。
添字型は `Config L`、指数は `brokenBondCount L`、選ぶ項は `allPlusConfig L`
（`allPlusConfig_brokenBondCount_eq_zero`）、係数の住処は `ℚ`。 -/
import Ising2DLambda.ThermodynamicLimit.PartitionValueGeOneRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueGeOneRational

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial FreeEntropy

theorem one_le_partitionPolynomial_eval_rat_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) : 1 ≤ Polynomial.aeval q (partitionPolynomial L) := by
  rw [eval_partitionPolynomial L q]
  exact NecSuf.ThermodynamicLimit.one_le_sum_pow_of_exponent_zero_necSuf
    (allPlusConfig L) (brokenBondCount L) (allPlusConfig_brokenBondCount_eq_zero L) hq

end Ising2DLambda.ThermodynamicLimit
