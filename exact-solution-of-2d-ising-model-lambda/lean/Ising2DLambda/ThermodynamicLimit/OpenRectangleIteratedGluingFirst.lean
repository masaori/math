/-
章「熱力学極限」の「開境界長方形を第一座標方向へ反復接合した値の評価」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_rectangle_iterated_gluing_first` である。

  人手証明の段                                     このファイル
  k = 1 の底: t^{(1-1)b} (Z^op)^1 = Z^op           帰納法の base（等号の鎖）
  kb = b + (k-1)b と冪の指数法則・積の結合則        hkb / pow_add / pow_succ / mul_assoc
  帰納法の仮定と正数の乗法                         mul_le_mul_of_nonneg_left / _right + ih
  接合不等式（一辺 ka と a の二長方形へ適用）      openPartitionValue_glueFirst_bounds_of_le_one /
                                                   _of_one_le（c := a、a := k·a）
  (k+1)a = ka + a                                  Nat.succ_mul

住処: この章で宣言済みの ℝ 脱出の中にある。使うのは順序体の性質・自然数冪・
有限積だけであり、実対数・完備性・極限は使わない（人手証明の realEscape どおり）。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

variable (a b : ℕ)

/-- `claim_open_rectangle_iterated_gluing_first` の `0 < t ≤ 1` の場合:
`t^{(k-1)b} (Z^op_{a,b}(t))^k ≤ Z^op_{ka,b}(t) ≤ (Z^op_{a,b}(t))^k`。 -/
theorem openPartitionValue_iteratedGlueFirst_bounds_of_le_one
    (ha : 0 < a) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    ∀ k : ℕ, 1 ≤ k →
      t ^ ((k - 1) * b) * openPartitionValue a b t ^ k ≤
          openPartitionValue (k * a) b t ∧
        openPartitionValue (k * a) b t ≤ openPartitionValue a b t ^ k := by
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>
      -- 人手証明の k = 1 の底: 左右の評価はいずれも等号で成り立つ。
      constructor
      · exact le_of_eq (by
          calc t ^ ((1 - 1) * b) * openPartitionValue a b t ^ 1
              = t ^ (0 * b) * openPartitionValue a b t ^ 1 := by rw [Nat.sub_self]
            _ = t ^ 0 * openPartitionValue a b t ^ 1 := by rw [Nat.zero_mul]
            _ = 1 * openPartitionValue a b t ^ 1 := by rw [pow_zero]
            _ = openPartitionValue a b t ^ 1 := one_mul _
            _ = openPartitionValue a b t := pow_one _
            _ = openPartitionValue (1 * a) b t := by rw [Nat.one_mul])
      · exact le_of_eq (by
          calc openPartitionValue (1 * a) b t
              = openPartitionValue a b t := by rw [Nat.one_mul]
            _ = openPartitionValue a b t ^ 1 := (pow_one _).symm)
  | succ k hk ih =>
      -- 接合不等式を一辺が ka と a の二長方形へ適用する。
      have hka : 0 < k * a := Nat.mul_pos hk ha
      have hglue := openPartitionValue_glueFirst_bounds_of_le_one (k * a) b a hka ha ht0 ht1
      have hz0 : (0 : ℝ) ≤ openPartitionValue a b t := (openPartitionValue_pos a b ht0).le
      -- 人手証明の「kb = b + (k-1)b」（k ≥ 1 で成り立つ）。
      have hkb : k * b = b + (k - 1) * b := by
        conv_lhs => rw [← Nat.sub_add_cancel hk]
        rw [Nat.add_mul, Nat.one_mul]
        exact Nat.add_comm _ _
      constructor
      · -- 下からの評価（人手証明の calc と同じ順）。
        calc t ^ ((k + 1 - 1) * b) * openPartitionValue a b t ^ (k + 1)
            = t ^ (k * b) * openPartitionValue a b t ^ (k + 1) := by
              rw [Nat.add_sub_cancel]
          _ = t ^ (b + (k - 1) * b) * openPartitionValue a b t ^ (k + 1) := by rw [hkb]
          _ = t ^ b * t ^ ((k - 1) * b) * openPartitionValue a b t ^ (k + 1) := by
              rw [pow_add]
          _ = t ^ b * t ^ ((k - 1) * b) *
                (openPartitionValue a b t ^ k * openPartitionValue a b t) := by
              rw [pow_succ]
          _ = t ^ b * (t ^ ((k - 1) * b) * openPartitionValue a b t ^ k *
                openPartitionValue a b t) := by
              rw [mul_assoc, ← mul_assoc (t ^ ((k - 1) * b))]
          _ ≤ t ^ b * (openPartitionValue (k * a) b t * openPartitionValue a b t) := by
              apply mul_le_mul_of_nonneg_left _ (pow_pos_by_induction ht0 b).le
              exact mul_le_mul_of_nonneg_right ih.1 hz0
          _ ≤ openPartitionValue (k * a + a) b t := hglue.1
          _ = openPartitionValue ((k + 1) * a) b t := by rw [Nat.succ_mul]
      · -- 上からの評価。
        calc openPartitionValue ((k + 1) * a) b t
            = openPartitionValue (k * a + a) b t := by rw [Nat.succ_mul]
          _ ≤ openPartitionValue (k * a) b t * openPartitionValue a b t := hglue.2
          _ ≤ openPartitionValue a b t ^ k * openPartitionValue a b t :=
              mul_le_mul_of_nonneg_right ih.2 hz0
          _ = openPartitionValue a b t ^ (k + 1) := (pow_succ _ _).symm

/-- `claim_open_rectangle_iterated_gluing_first` の `1 ≤ t` の場合:
`(Z^op_{a,b}(t))^k ≤ Z^op_{ka,b}(t) ≤ t^{(k-1)b} (Z^op_{a,b}(t))^k`。 -/
theorem openPartitionValue_iteratedGlueFirst_bounds_of_one_le
    (ha : 0 < a) {t : ℝ} (ht : 1 ≤ t) :
    ∀ k : ℕ, 1 ≤ k →
      openPartitionValue a b t ^ k ≤ openPartitionValue (k * a) b t ∧
        openPartitionValue (k * a) b t ≤
          t ^ ((k - 1) * b) * openPartitionValue a b t ^ k := by
  have ht0 : (0 : ℝ) < t := lt_of_lt_of_le zero_lt_one ht
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>
      constructor
      · exact le_of_eq (by
          calc openPartitionValue a b t ^ 1
              = openPartitionValue a b t := pow_one _
            _ = openPartitionValue (1 * a) b t := by rw [Nat.one_mul])
      · exact le_of_eq (by
          calc openPartitionValue (1 * a) b t
              = openPartitionValue a b t := by rw [Nat.one_mul]
            _ = openPartitionValue a b t ^ 1 := (pow_one _).symm
            _ = 1 * openPartitionValue a b t ^ 1 := (one_mul _).symm
            _ = t ^ 0 * openPartitionValue a b t ^ 1 := by rw [pow_zero]
            _ = t ^ (0 * b) * openPartitionValue a b t ^ 1 := by rw [Nat.zero_mul]
            _ = t ^ ((1 - 1) * b) * openPartitionValue a b t ^ 1 := by rw [Nat.sub_self])
  | succ k hk ih =>
      have hka : 0 < k * a := Nat.mul_pos hk ha
      have hglue := openPartitionValue_glueFirst_bounds_of_one_le (k * a) b a hka ha ht
      have hz0 : (0 : ℝ) ≤ openPartitionValue a b t := (openPartitionValue_pos a b ht0).le
      have hkb : k * b = b + (k - 1) * b := by
        conv_lhs => rw [← Nat.sub_add_cancel hk]
        rw [Nat.add_mul, Nat.one_mul]
        exact Nat.add_comm _ _
      constructor
      · -- 下からの評価。
        calc openPartitionValue a b t ^ (k + 1)
            = openPartitionValue a b t ^ k * openPartitionValue a b t := pow_succ _ _
          _ ≤ openPartitionValue (k * a) b t * openPartitionValue a b t :=
              mul_le_mul_of_nonneg_right ih.1 hz0
          _ ≤ openPartitionValue (k * a + a) b t := hglue.1
          _ = openPartitionValue ((k + 1) * a) b t := by rw [Nat.succ_mul]
      · -- 上からの評価（人手証明の calc と同じ順）。
        calc openPartitionValue ((k + 1) * a) b t
            = openPartitionValue (k * a + a) b t := by rw [Nat.succ_mul]
          _ ≤ t ^ b * (openPartitionValue (k * a) b t * openPartitionValue a b t) :=
              hglue.2
          _ ≤ t ^ b * (t ^ ((k - 1) * b) * openPartitionValue a b t ^ k *
                openPartitionValue a b t) := by
              apply mul_le_mul_of_nonneg_left _ (pow_pos_by_induction ht0 b).le
              exact mul_le_mul_of_nonneg_right ih.2 hz0
          _ = t ^ b * t ^ ((k - 1) * b) *
                (openPartitionValue a b t ^ k * openPartitionValue a b t) := by
              rw [mul_assoc, mul_assoc]
          _ = t ^ b * t ^ ((k - 1) * b) * openPartitionValue a b t ^ (k + 1) := by
              rw [pow_succ]
          _ = t ^ (b + (k - 1) * b) * openPartitionValue a b t ^ (k + 1) := by
              rw [pow_add t b ((k - 1) * b)]
          _ = t ^ (k * b) * openPartitionValue a b t ^ (k + 1) := by rw [hkb]
          _ = t ^ ((k + 1 - 1) * b) * openPartitionValue a b t ^ (k + 1) := by
              rw [Nat.add_sub_cancel]

end Ising2DLambda.ThermodynamicLimit
