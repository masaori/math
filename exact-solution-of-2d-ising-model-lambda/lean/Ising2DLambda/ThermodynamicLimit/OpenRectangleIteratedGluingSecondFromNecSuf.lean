/- 第二座標方向の具体版の反復接合評価が必要十分版の特殊化であることを示す。
必要十分版 `iterated_glue_pow_bounds_necSuf` は接ぐ向きに依らない（一段の上下評価と底の一致
だけを仮定する）ので、第一座標方向と同じ定理をそのまま使う。
`P` を「k 枚接いだ長方形の値 k ↦ Z^op_{a,kb}(t)」、`z` を一枚の値、一段の上下評価を
第二座標方向の一回の接合不等式（`0<t≤1` では low = t^a・high = 1、`1≤t` では
low = 1・high = t^a）へそれぞれ代入する。`t^{(k-1)a} = (t^a)^{k-1}` は冪の指数法則、
`1^{k-1} = 1` で接合面因子の無い側が復元される。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingSecond
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleIteratedGluingFirst

namespace Ising2DLambda.ThermodynamicLimit

/-- `0 < t ≤ 1` の場合の導出。 -/
theorem openPartitionValue_iteratedGlueSecond_bounds_of_le_one_from_necSuf
    (a b : ℕ) (hb : 0 < b) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    ∀ k : ℕ, 1 ≤ k →
      t ^ ((k - 1) * a) * openPartitionValue a b t ^ k ≤
          openPartitionValue a (k * b) t ∧
        openPartitionValue a (k * b) t ≤ openPartitionValue a b t ^ k := by
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValue a (n * b) t) (openPartitionValue a b t)
    (t ^ a) 1
    (openPartitionValue_pos a b ht0).le (pow_pos_by_induction ht0 a).le zero_le_one
    (by rw [Nat.one_mul])
    (fun m hm => by
      show t ^ a * (openPartitionValue a (m * b) t * openPartitionValue a b t) ≤
        openPartitionValue a ((m + 1) * b) t
      rw [Nat.succ_mul]
      exact (openPartitionValue_glueSecond_bounds_of_le_one a (m * b) b
        (Nat.mul_pos hm hb) hb ht0 ht1).1)
    (fun m hm => by
      show openPartitionValue a ((m + 1) * b) t ≤
        1 * (openPartitionValue a (m * b) t * openPartitionValue a b t)
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValue_glueSecond_bounds_of_le_one a (m * b) b
        (Nat.mul_pos hm hb) hb ht0 ht1).2)
    k hk
  constructor
  · calc t ^ ((k - 1) * a) * openPartitionValue a b t ^ k
        = (t ^ a) ^ (k - 1) * openPartitionValue a b t ^ k := by
          rw [Nat.mul_comm (k - 1) a, pow_mul]
      _ ≤ openPartitionValue a (k * b) t := h.1
  · calc openPartitionValue a (k * b) t
        ≤ (1 : ℝ) ^ (k - 1) * openPartitionValue a b t ^ k := h.2
      _ = 1 * openPartitionValue a b t ^ k := by rw [one_pow]
      _ = openPartitionValue a b t ^ k := one_mul _

/-- `1 ≤ t` の場合の導出。 -/
theorem openPartitionValue_iteratedGlueSecond_bounds_of_one_le_from_necSuf
    (a b : ℕ) (hb : 0 < b) {t : ℝ} (ht : 1 ≤ t) :
    ∀ k : ℕ, 1 ≤ k →
      openPartitionValue a b t ^ k ≤ openPartitionValue a (k * b) t ∧
        openPartitionValue a (k * b) t ≤
          t ^ ((k - 1) * a) * openPartitionValue a b t ^ k := by
  have ht0 : (0 : ℝ) < t := lt_of_lt_of_le zero_lt_one ht
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValue a (n * b) t) (openPartitionValue a b t)
    1 (t ^ a)
    (openPartitionValue_pos a b ht0).le zero_le_one (pow_pos_by_induction ht0 a).le
    (by rw [Nat.one_mul])
    (fun m hm => by
      show (1 : ℝ) * (openPartitionValue a (m * b) t * openPartitionValue a b t) ≤
        openPartitionValue a ((m + 1) * b) t
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValue_glueSecond_bounds_of_one_le a (m * b) b
        (Nat.mul_pos hm hb) hb ht).1)
    (fun m hm => by
      show openPartitionValue a ((m + 1) * b) t ≤
        t ^ a * (openPartitionValue a (m * b) t * openPartitionValue a b t)
      rw [Nat.succ_mul]
      exact (openPartitionValue_glueSecond_bounds_of_one_le a (m * b) b
        (Nat.mul_pos hm hb) hb ht).2)
    k hk
  constructor
  · calc openPartitionValue a b t ^ k
        = 1 * openPartitionValue a b t ^ k := (one_mul _).symm
      _ = (1 : ℝ) ^ (k - 1) * openPartitionValue a b t ^ k := by rw [one_pow]
      _ ≤ openPartitionValue a (k * b) t := h.1
  · calc openPartitionValue a (k * b) t
        ≤ (t ^ a) ^ (k - 1) * openPartitionValue a b t ^ k := h.2
      _ = t ^ ((k - 1) * a) * openPartitionValue a b t ^ k := by
          rw [← pow_mul, Nat.mul_comm a (k - 1)]

end Ising2DLambda.ThermodynamicLimit
