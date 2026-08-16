/- 具体版の境界評価（正の有理点）が必要十分版の特殊化であることを示す。
添字を開境界配位、全単射を配位の読み替え r_L、指数を破れボンド数、二項分解を
破れボンド数の分解 b = b^op + s^bd、境界因子の評価を自然数冪の順序の評価へ
それぞれ代入する。必要十分版 `sum_pow_reindex_bounds_necSuf` は実数版と共有する
（可換半環と順序だけを仮定しており、有理数体・実数体は本質でない）。 -/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonInequalityRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.PeriodicOpenComparisonInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

/-- `0 < q ≤ 1` の場合の導出。 -/
theorem partitionValueRat_periodicOpen_bounds_of_le_one_from_necSuf
    (L : ℕ) [NeZero L] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ (2 * L) * openPartitionValueRat L L q ≤
        Polynomial.aeval q (partitionPolynomial L) ∧
      Polynomial.aeval q (partitionPolynomial L) ≤ openPartitionValueRat L L q := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_reindex_bounds_necSuf
    (periodicOpenConfigEquiv L) q
    (openBrokenBondCount L L) (brokenBondCount L) (periodicBoundaryBrokenCount L)
    (fun τ => brokenBondCount_openConfigToPeriodic L τ)
    (q ^ (2 * L)) 1 hq0.le
    (fun τ => pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
      (periodicBoundaryBrokenCount_le L τ))
    (fun τ => pow_le_one_by_induction_rat hq0.le hq1 _)
  rw [one_mul] at h
  rw [FreeEntropy.eval_partitionPolynomial, openPartitionValueRat_eq_sum]
  exact h

/-- `1 ≤ q` の場合の導出。 -/
theorem partitionValueRat_periodicOpen_bounds_of_one_le_from_necSuf
    (L : ℕ) [NeZero L] {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat L L q ≤ Polynomial.aeval q (partitionPolynomial L) ∧
      Polynomial.aeval q (partitionPolynomial L) ≤
        q ^ (2 * L) * openPartitionValueRat L L q := by
  have hq0 : (0 : ℚ) ≤ q := le_trans zero_le_one hq
  have h := NecSuf.ThermodynamicLimit.sum_pow_reindex_bounds_necSuf
    (periodicOpenConfigEquiv L) q
    (openBrokenBondCount L L) (brokenBondCount L) (periodicBoundaryBrokenCount L)
    (fun τ => brokenBondCount_openConfigToPeriodic L τ)
    1 (q ^ (2 * L)) hq0
    (fun τ => one_le_pow_by_induction_rat hq _)
    (fun τ => pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
      (periodicBoundaryBrokenCount_le L τ))
  rw [one_mul] at h
  rw [FreeEntropy.eval_partitionPolynomial, openPartitionValueRat_eq_sum]
  exact h

end Ising2DLambda.ThermodynamicLimit
