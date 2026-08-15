/- 具体版の境界評価が必要十分版の特殊化であることを示す。
添字を開境界配位、全単射を配位の読み替え r_L、指数を破れボンド数、二項分解を
破れボンド数の分解 b = b^op + s^bd、境界因子の評価を自然数冪の順序の評価へ
それぞれ代入する。 -/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonInequality
import Ising2DLambda.NecSuf.ThermodynamicLimit.PeriodicOpenComparisonInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

/-- `0 < t ≤ 1` の場合の導出。 -/
theorem partitionValue_periodicOpen_bounds_of_le_one_from_necSuf
    (L : ℕ) [NeZero L] {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ (2 * L) * openPartitionValue L L t ≤
        Polynomial.aeval t (partitionPolynomial L) ∧
      Polynomial.aeval t (partitionPolynomial L) ≤ openPartitionValue L L t := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_reindex_bounds_necSuf
    (periodicOpenConfigEquiv L) t
    (openBrokenBondCount L L) (brokenBondCount L) (periodicBoundaryBrokenCount L)
    (fun τ => brokenBondCount_openConfigToPeriodic L τ)
    (t ^ (2 * L)) 1 ht0.le
    (fun τ => pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
      (periodicBoundaryBrokenCount_le L τ))
    (fun τ => pow_le_one_by_induction ht0.le ht1 _)
  rw [one_mul] at h
  rw [eval_partitionPolynomial_real, openPartitionValue_eq_sum]
  exact h

/-- `1 ≤ t` の場合の導出。 -/
theorem partitionValue_periodicOpen_bounds_of_one_le_from_necSuf
    (L : ℕ) [NeZero L] {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue L L t ≤ Polynomial.aeval t (partitionPolynomial L) ∧
      Polynomial.aeval t (partitionPolynomial L) ≤
        t ^ (2 * L) * openPartitionValue L L t := by
  have ht0 : (0 : ℝ) ≤ t := le_trans zero_le_one ht
  have h := NecSuf.ThermodynamicLimit.sum_pow_reindex_bounds_necSuf
    (periodicOpenConfigEquiv L) t
    (openBrokenBondCount L L) (brokenBondCount L) (periodicBoundaryBrokenCount L)
    (fun τ => brokenBondCount_openConfigToPeriodic L τ)
    1 (t ^ (2 * L)) ht0
    (fun τ => one_le_pow_by_induction ht _)
    (fun τ => pow_le_pow_of_one_le_of_exp_le_by_induction ht
      (periodicBoundaryBrokenCount_le L τ))
  rw [one_mul] at h
  rw [eval_partitionPolynomial_real, openPartitionValue_eq_sum]
  exact h

end Ising2DLambda.ThermodynamicLimit
