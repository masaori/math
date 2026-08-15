/- 第二座標方向の具体版の反復接合評価（正の有理点）が必要十分版の特殊化であることを示す。
必要十分版 `iterated_glue_pow_bounds_necSuf` は接ぐ向きに依らず（一段の上下評価と底の一致
だけを仮定する）、実数版と共有する（半環と順序だけを仮定し、有理数体・実数体は本質でない）ので、
第一座標方向・実数版と同じ定理をそのまま使う。
`P` を「k 枚接いだ長方形の値 k ↦ Z^op_{a,kb}(q)」、`z` を一枚の値、一段の上下評価を
第二座標方向の一回の接合不等式（`0<q≤1` では low = q^a・high = 1、`1≤q` では
low = 1・high = q^a）へそれぞれ代入する。`q^{(k-1)a} = (q^a)^{k-1}` は冪の指数法則、
`1^{k-1} = 1` で接合面因子の無い側が復元される。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingSecondRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleIteratedGluingFirst

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

/-- `0 < q ≤ 1` の場合の導出。 -/
theorem openPartitionValueRat_iteratedGlueSecond_bounds_of_le_one_from_necSuf
    (a b : ℕ) (hb : 0 < b) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∀ k : ℕ, 1 ≤ k →
      q ^ ((k - 1) * a) * openPartitionValueRat a b q ^ k ≤
          openPartitionValueRat a (k * b) q ∧
        openPartitionValueRat a (k * b) q ≤ openPartitionValueRat a b q ^ k := by
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValueRat a (n * b) q) (openPartitionValueRat a b q)
    (q ^ a) 1
    (openPartitionValueRat_pos a b hq0).le (pow_pos_by_induction hq0 a).le zero_le_one
    (by rw [Nat.one_mul])
    (fun m hm => by
      show q ^ a * (openPartitionValueRat a (m * b) q * openPartitionValueRat a b q) ≤
        openPartitionValueRat a ((m + 1) * b) q
      rw [Nat.succ_mul]
      exact (openPartitionValueRat_glueSecond_bounds_of_le_one a (m * b) b
        (Nat.mul_pos hm hb) hb hq0 hq1).1)
    (fun m hm => by
      show openPartitionValueRat a ((m + 1) * b) q ≤
        1 * (openPartitionValueRat a (m * b) q * openPartitionValueRat a b q)
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValueRat_glueSecond_bounds_of_le_one a (m * b) b
        (Nat.mul_pos hm hb) hb hq0 hq1).2)
    k hk
  constructor
  · calc q ^ ((k - 1) * a) * openPartitionValueRat a b q ^ k
        = (q ^ a) ^ (k - 1) * openPartitionValueRat a b q ^ k := by
          rw [Nat.mul_comm (k - 1) a, pow_mul]
      _ ≤ openPartitionValueRat a (k * b) q := h.1
  · calc openPartitionValueRat a (k * b) q
        ≤ (1 : ℚ) ^ (k - 1) * openPartitionValueRat a b q ^ k := h.2
      _ = 1 * openPartitionValueRat a b q ^ k := by rw [one_pow]
      _ = openPartitionValueRat a b q ^ k := one_mul _

/-- `1 ≤ q` の場合の導出。 -/
theorem openPartitionValueRat_iteratedGlueSecond_bounds_of_one_le_from_necSuf
    (a b : ℕ) (hb : 0 < b) {q : ℚ} (hq : 1 ≤ q) :
    ∀ k : ℕ, 1 ≤ k →
      openPartitionValueRat a b q ^ k ≤ openPartitionValueRat a (k * b) q ∧
        openPartitionValueRat a (k * b) q ≤
          q ^ ((k - 1) * a) * openPartitionValueRat a b q ^ k := by
  have hq0 : (0 : ℚ) < q := lt_of_lt_of_le zero_lt_one hq
  intro k hk
  have h := NecSuf.ThermodynamicLimit.iterated_glue_pow_bounds_necSuf
    (fun n => openPartitionValueRat a (n * b) q) (openPartitionValueRat a b q)
    1 (q ^ a)
    (openPartitionValueRat_pos a b hq0).le zero_le_one (pow_pos_by_induction hq0 a).le
    (by rw [Nat.one_mul])
    (fun m hm => by
      show (1 : ℚ) * (openPartitionValueRat a (m * b) q * openPartitionValueRat a b q) ≤
        openPartitionValueRat a ((m + 1) * b) q
      rw [one_mul, Nat.succ_mul]
      exact (openPartitionValueRat_glueSecond_bounds_of_one_le a (m * b) b
        (Nat.mul_pos hm hb) hb hq).1)
    (fun m hm => by
      show openPartitionValueRat a ((m + 1) * b) q ≤
        q ^ a * (openPartitionValueRat a (m * b) q * openPartitionValueRat a b q)
      rw [Nat.succ_mul]
      exact (openPartitionValueRat_glueSecond_bounds_of_one_le a (m * b) b
        (Nat.mul_pos hm hb) hb hq).2)
    k hk
  constructor
  · calc openPartitionValueRat a b q ^ k
        = 1 * openPartitionValueRat a b q ^ k := (one_mul _).symm
      _ = (1 : ℚ) ^ (k - 1) * openPartitionValueRat a b q ^ k := by rw [one_pow]
      _ ≤ openPartitionValueRat a (k * b) q := h.1
  · calc openPartitionValueRat a (k * b) q
        ≤ (q ^ a) ^ (k - 1) * openPartitionValueRat a b q ^ k := h.2
      _ = q ^ ((k - 1) * a) * openPartitionValueRat a b q ^ k := by
          rw [← pow_mul, Nat.mul_comm a (k - 1)]

end Ising2DLambda.ThermodynamicLimit
