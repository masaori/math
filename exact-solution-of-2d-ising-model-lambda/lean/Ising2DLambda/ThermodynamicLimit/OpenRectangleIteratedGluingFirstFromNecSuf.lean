/- 具体版の反復接合評価が必要十分版の特殊化であることを示す。
`P` を「k 枚接いだ長方形の値 k ↦ Z^op_{ka,b}(t)」、`z` を一枚の値、一段の上下評価を
一回の接合不等式（`0<t≤1` では low = t^b・high = 1、`1≤t` では low = 1・high = t^b）へ
それぞれ代入する。`t^{(k-1)b} = (t^b)^{k-1}` は冪の指数法則、`1^{k-1} = 1` で
接合面因子の無い側が復元される。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingFirst
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleIteratedGluingFirst

namespace Ising2DLambda.ThermodynamicLimit

/-- `0 < t ≤ 1` の場合の導出。 -/
theorem openPartitionValue_iteratedGlueFirst_bounds_of_le_one_from_necSuf
    (a b : ℕ) (ha : 0 < a) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    ∀ k : ℕ, 1 ≤ k →
      t ^ ((k - 1) * b) * openPartitionValue a b t ^ k ≤
          openPartitionValue (k * a) b t ∧
        openPartitionValue (k * a) b t ≤ openPartitionValue a b t ^ k := by
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValue (n * a) b t) (openPartitionValue a b t)
    (t ^ b) 1
    (openPartitionValue_pos a b ht0).le (pow_pos_by_induction ht0 b).le zero_le_one
    (by rw [Nat.one_mul])
    (fun m hm => by
      show t ^ b * (openPartitionValue (m * a) b t * openPartitionValue a b t) ≤
        openPartitionValue ((m + 1) * a) b t
      rw [Nat.succ_mul]
      exact (openPartitionValue_glueFirst_bounds_of_le_one (m * a) b a
        (Nat.mul_pos hm ha) ha ht0 ht1).1)
    (fun m hm => by
      show openPartitionValue ((m + 1) * a) b t ≤
        1 * (openPartitionValue (m * a) b t * openPartitionValue a b t)
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValue_glueFirst_bounds_of_le_one (m * a) b a
        (Nat.mul_pos hm ha) ha ht0 ht1).2)
    k hk
  constructor
  · calc t ^ ((k - 1) * b) * openPartitionValue a b t ^ k
        = (t ^ b) ^ (k - 1) * openPartitionValue a b t ^ k := by
          rw [Nat.mul_comm (k - 1) b, pow_mul]
      _ ≤ openPartitionValue (k * a) b t := h.1
  · calc openPartitionValue (k * a) b t
        ≤ (1 : ℝ) ^ (k - 1) * openPartitionValue a b t ^ k := h.2
      _ = 1 * openPartitionValue a b t ^ k := by rw [one_pow]
      _ = openPartitionValue a b t ^ k := one_mul _

/-- `1 ≤ t` の場合の導出。 -/
theorem openPartitionValue_iteratedGlueFirst_bounds_of_one_le_from_necSuf
    (a b : ℕ) (ha : 0 < a) {t : ℝ} (ht : 1 ≤ t) :
    ∀ k : ℕ, 1 ≤ k →
      openPartitionValue a b t ^ k ≤ openPartitionValue (k * a) b t ∧
        openPartitionValue (k * a) b t ≤
          t ^ ((k - 1) * b) * openPartitionValue a b t ^ k := by
  have ht0 : (0 : ℝ) < t := lt_of_lt_of_le zero_lt_one ht
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValue (n * a) b t) (openPartitionValue a b t)
    1 (t ^ b)
    (openPartitionValue_pos a b ht0).le zero_le_one (pow_pos_by_induction ht0 b).le
    (by rw [Nat.one_mul])
    (fun m hm => by
      show (1 : ℝ) * (openPartitionValue (m * a) b t * openPartitionValue a b t) ≤
        openPartitionValue ((m + 1) * a) b t
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValue_glueFirst_bounds_of_one_le (m * a) b a
        (Nat.mul_pos hm ha) ha ht).1)
    (fun m hm => by
      show openPartitionValue ((m + 1) * a) b t ≤
        t ^ b * (openPartitionValue (m * a) b t * openPartitionValue a b t)
      rw [Nat.succ_mul]
      exact (openPartitionValue_glueFirst_bounds_of_one_le (m * a) b a
        (Nat.mul_pos hm ha) ha ht).2)
    k hk
  constructor
  · calc openPartitionValue a b t ^ k
        = 1 * openPartitionValue a b t ^ k := (one_mul _).symm
      _ = (1 : ℝ) ^ (k - 1) * openPartitionValue a b t ^ k := by rw [one_pow]
      _ ≤ openPartitionValue (k * a) b t := h.1
  · calc openPartitionValue (k * a) b t
        ≤ (t ^ b) ^ (k - 1) * openPartitionValue a b t ^ k := h.2
      _ = t ^ ((k - 1) * b) * openPartitionValue a b t ^ k := by
          rw [← pow_mul, Nat.mul_comm b (k - 1)]

end Ising2DLambda.ThermodynamicLimit
