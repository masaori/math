/-
必要十分版の「共通有限和の二評価と非零因子の消去」を、正方格子の高温展開へ特殊化する。
-/
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.NecSuf.FisherZero.HighTemperaturePolynomial

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- 必要十分版から得る `2^(L²) Z_L = H_L`。 -/
theorem highTemperaturePolynomial_identity_from_necSuf (L : ℕ) [NeZero L] :
    2 ^ (L ^ 2) * partitionPolynomial L = highTemperaturePolynomial L := by
  have hpow : (2 : Polynomial ℤ) ^ (2 * L ^ 2) =
      2 ^ (L ^ 2) * 2 ^ (L ^ 2) := by
    rw [← pow_add]
    congr
    omega
  have hleft := highTemperatureCommonSum_eq_partition L
  rw [hpow, mul_assoc] at hleft
  exact Ising2DLambda.NecSuf.FisherZero.common_sum_two_evaluations_necSuf
    (2 ^ (L ^ 2) : Polynomial ℤ)
    (partitionPolynomial L)
    (highTemperaturePolynomial L)
    (highTemperatureCommonSum L)
    (pow_ne_zero _ (Polynomial.C_ne_zero.mpr (by norm_num : (2 : ℤ) ≠ 0)))
    hleft
    (highTemperatureCommonSum_eq_highTemperature L)

end Ising2DLambda.FisherZero
