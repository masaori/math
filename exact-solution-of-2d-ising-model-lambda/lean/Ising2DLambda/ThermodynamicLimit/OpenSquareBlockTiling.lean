/-
「開境界正方形のブロック敷き詰め評価」の具体版。人手証明と同じく、第一座標方向の
反復接合評価を k 乗してから、第二座標方向の反復接合評価へ代入する。

住処は ℝ。使うのは順序体の性質・自然数冪・有限積だけであり、実対数・完備性・極限は
使わない（人手証明の realEscape どおり）。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingFirst
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingSecond

namespace Ising2DLambda.ThermodynamicLimit

/-- `0 < t ≤ 1` の場合の二方向の反復接合評価。 -/
theorem openPartitionValue_squareBlockTiling_bounds_of_le_one
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k ≤
        openPartitionValue (k * a) (k * a) t ∧
      openPartitionValue (k * a) (k * a) t ≤
        (openPartitionValue a a t ^ k) ^ k := by
  have hfirst := openPartitionValue_iteratedGlueFirst_bounds_of_le_one a a ha ht0 ht1 k hk
  have hsecond := openPartitionValue_iteratedGlueSecond_bounds_of_le_one
    (k * a) a ha ht0 ht1 k hk
  have hlower0 : 0 < t ^ ((k - 1) * a) * openPartitionValue a a t ^ k := by
    exact mul_pos (pow_pos_by_induction ht0 _) (pow_pos_by_induction (openPartitionValue_pos a a ht0) _)
  have hupper0 : 0 < openPartitionValue a a t ^ k :=
    pow_pos_by_induction (openPartitionValue_pos a a ht0) _
  have hlowerPow := pow_le_pow_of_pos_of_le_by_induction hlower0 hfirst.1 k
  have hupperPow := pow_le_pow_of_pos_of_le_by_induction (openPartitionValue_pos (k * a) a ht0)
    hfirst.2 k
  constructor
  · calc t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k
        ≤ t ^ ((k - 1) * (k * a)) * openPartitionValue (k * a) a t ^ k :=
          mul_le_mul_of_nonneg_left hlowerPow (pow_pos_by_induction ht0 _).le
      _ ≤ openPartitionValue (k * a) (k * a) t := hsecond.1
  · calc openPartitionValue (k * a) (k * a) t
        ≤ openPartitionValue (k * a) a t ^ k := hsecond.2
      _ ≤ (openPartitionValue a a t ^ k) ^ k := hupperPow

/-- `1 ≤ t` の場合の二方向の反復接合評価。 -/
theorem openPartitionValue_squareBlockTiling_bounds_of_one_le
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {t : ℝ} (ht : 1 ≤ t) :
    (openPartitionValue a a t ^ k) ^ k ≤ openPartitionValue (k * a) (k * a) t ∧
      openPartitionValue (k * a) (k * a) t ≤
        t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  have hfirst := openPartitionValue_iteratedGlueFirst_bounds_of_one_le a a ha ht k hk
  have hsecond := openPartitionValue_iteratedGlueSecond_bounds_of_one_le
    (k * a) a ha ht k hk
  have hbase0 : 0 < openPartitionValue a a t ^ k :=
    pow_pos_by_induction (openPartitionValue_pos a a ht0) _
  have hstrip0 : 0 < openPartitionValue (k * a) a t := openPartitionValue_pos _ _ ht0
  have hlowerPow := pow_le_pow_of_pos_of_le_by_induction hbase0 hfirst.1 k
  have hupperPow := pow_le_pow_of_pos_of_le_by_induction hstrip0 hfirst.2 k
  constructor
  · calc (openPartitionValue a a t ^ k) ^ k
        ≤ openPartitionValue (k * a) a t ^ k := hlowerPow
      _ ≤ openPartitionValue (k * a) (k * a) t := hsecond.1
  · calc openPartitionValue (k * a) (k * a) t
        ≤ t ^ ((k - 1) * (k * a)) * openPartitionValue (k * a) a t ^ k := hsecond.2
      _ ≤ t ^ ((k - 1) * (k * a)) *
          (t ^ ((k - 1) * a) * openPartitionValue a a t ^ k) ^ k :=
          mul_le_mul_of_nonneg_left hupperPow (pow_pos_by_induction ht0 _).le

end Ising2DLambda.ThermodynamicLimit
