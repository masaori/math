/- 具体版の二方向合成が必要十分版の特殊化であることを示す。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTiling
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTiling

namespace Ising2DLambda.ThermodynamicLimit

theorem openPartitionValue_squareBlockTiling_bounds_of_le_one_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k ≤
        openPartitionValue (k * a) (k * a) t ∧
      openPartitionValue (k * a) (k * a) t ≤ (openPartitionValue a a t ^ k) ^ k := by
  have hfirst := openPartitionValue_iteratedGlueFirst_bounds_of_le_one a a ha ht0 ht1 k hk
  have hsecond := openPartitionValue_iteratedGlueSecond_bounds_of_le_one
    (k * a) a ha ht0 ht1 k hk
  simpa [one_mul] using
    (NecSuf.ThermodynamicLimit.two_direction_pow_bounds_necSuf
      (openPartitionValue a a t) (openPartitionValue (k * a) a t)
      (openPartitionValue (k * a) (k * a) t)
      (t ^ ((k - 1) * a)) 1 (t ^ ((k - 1) * (k * a))) 1 k
      (openPartitionValue_pos a a ht0).le (openPartitionValue_pos (k * a) a ht0).le
      (pow_pos_by_induction ht0 _).le (pow_pos_by_induction ht0 _).le zero_le_one
      (by simpa [one_mul] using hfirst) (by simpa [one_mul] using hsecond))

theorem openPartitionValue_squareBlockTiling_bounds_of_one_le_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {t : ℝ} (ht : 1 ≤ t) :
    (openPartitionValue a a t ^ k) ^ k ≤ openPartitionValue (k * a) (k * a) t ∧
      openPartitionValue (k * a) (k * a) t ≤
        t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  have hfirst := openPartitionValue_iteratedGlueFirst_bounds_of_one_le a a ha ht k hk
  have hsecond := openPartitionValue_iteratedGlueSecond_bounds_of_one_le
    (k * a) a ha ht k hk
  simpa [one_mul] using
    (NecSuf.ThermodynamicLimit.two_direction_pow_bounds_necSuf
      (openPartitionValue a a t) (openPartitionValue (k * a) a t)
      (openPartitionValue (k * a) (k * a) t)
      1 (t ^ ((k - 1) * a)) 1 (t ^ ((k - 1) * (k * a))) k
      (openPartitionValue_pos a a ht0).le (openPartitionValue_pos (k * a) a ht0).le
      zero_le_one zero_le_one (pow_pos_by_induction ht0 _).le
      (by simpa [one_mul] using hfirst) (by simpa [one_mul] using hsecond))

end Ising2DLambda.ThermodynamicLimit
