/-
具体版（正の有理点）の二方向合成が必要十分版 `two_direction_pow_bounds_necSuf` の特殊化であることを示す。
必要十分版は実数版と共有する（可換半環と順序だけを使い、体にも接ぐ向きにも依らない）。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTiling

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

theorem openPartitionValueRat_squareBlockTiling_bounds_of_le_one_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k ≤
        openPartitionValueRat (k * a) (k * a) q ∧
      openPartitionValueRat (k * a) (k * a) q ≤ (openPartitionValueRat a a q ^ k) ^ k := by
  have hfirst := openPartitionValueRat_iteratedGlueFirst_bounds_of_le_one a a ha hq0 hq1 k hk
  have hsecond := openPartitionValueRat_iteratedGlueSecond_bounds_of_le_one
    (k * a) a ha hq0 hq1 k hk
  simpa [one_mul] using
    (NecSuf.ThermodynamicLimit.two_direction_pow_bounds_necSuf
      (openPartitionValueRat a a q) (openPartitionValueRat (k * a) a q)
      (openPartitionValueRat (k * a) (k * a) q)
      (q ^ ((k - 1) * a)) 1 (q ^ ((k - 1) * (k * a))) 1 k
      (openPartitionValueRat_pos a a hq0).le (openPartitionValueRat_pos (k * a) a hq0).le
      (pow_pos_by_induction hq0 _).le (pow_pos_by_induction hq0 _).le zero_le_one
      (by simpa [one_mul] using hfirst) (by simpa [one_mul] using hsecond))

theorem openPartitionValueRat_squareBlockTiling_bounds_of_one_le_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq : 1 ≤ q) :
    (openPartitionValueRat a a q ^ k) ^ k ≤ openPartitionValueRat (k * a) (k * a) q ∧
      openPartitionValueRat (k * a) (k * a) q ≤
        q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k := by
  have hq0 : 0 < q := lt_of_lt_of_le zero_lt_one hq
  have hfirst := openPartitionValueRat_iteratedGlueFirst_bounds_of_one_le a a ha hq k hk
  have hsecond := openPartitionValueRat_iteratedGlueSecond_bounds_of_one_le
    (k * a) a ha hq k hk
  simpa [one_mul] using
    (NecSuf.ThermodynamicLimit.two_direction_pow_bounds_necSuf
      (openPartitionValueRat a a q) (openPartitionValueRat (k * a) a q)
      (openPartitionValueRat (k * a) (k * a) q)
      1 (q ^ ((k - 1) * a)) 1 (q ^ ((k - 1) * (k * a))) k
      (openPartitionValueRat_pos a a hq0).le (openPartitionValueRat_pos (k * a) a hq0).le
      zero_le_one zero_le_one (pow_pos_by_induction hq0 _).le
      (by simpa [one_mul] using hfirst) (by simpa [one_mul] using hsecond))

end Ising2DLambda.ThermodynamicLimit
