/-
章「熱力学極限」の「開境界長方形を第一座標方向へ反復接合した値の評価（正の有理点）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_rectangle_iterated_gluing_first_rational` である。

  人手証明の段                                     このファイル
  k = 1 の底: q^{(1-1)b} (Z^op)^1 = Z^op           帰納法の base（等号の鎖）
  kb = b + (k-1)b と冪の指数法則・積の結合則        hkb / pow_add / pow_succ / mul_assoc
  帰納法の仮定と正数の乗法                         mul_le_mul_of_nonneg_left / _right + ih
  接合不等式（一辺 ka と a の二長方形へ適用）      openPartitionValueRat_glueFirst_bounds_of_le_one /
                                                   _of_one_le（c := a、a := k·a）
  (k+1)a = ka + a                                  Nat.succ_mul

住処: Q。使うのは有理数体の順序体の性質・自然数冪・有限積だけであり、実数体は現れない
（実数版 `OpenRectangleIteratedGluingFirst.lean` の帰納法を ℚ で書き直したもの。
一回の接合不等式は `OpenRectangleGluingInequalityRational.lean` の ℚ 版を引く）。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityRational

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

variable (a b : ℕ)

/-- `claim_open_rectangle_iterated_gluing_first_rational` の `0 < q ≤ 1` の場合:
`q^{(k-1)b} (Z^op_{a,b}(q))^k ≤ Z^op_{ka,b}(q) ≤ (Z^op_{a,b}(q))^k`。 -/
theorem openPartitionValueRat_iteratedGlueFirst_bounds_of_le_one
    (ha : 0 < a) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∀ k : ℕ, 1 ≤ k →
      q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ k ≤
          openPartitionValueRat (k * a) b q ∧
        openPartitionValueRat (k * a) b q ≤ openPartitionValueRat a b q ^ k := by
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>
      -- 人手証明の k = 1 の底: 左右の評価はいずれも等号で成り立つ。
      constructor
      · exact le_of_eq (by
          calc q ^ ((1 - 1) * b) * openPartitionValueRat a b q ^ 1
              = q ^ (0 * b) * openPartitionValueRat a b q ^ 1 := by rw [Nat.sub_self]
            _ = q ^ 0 * openPartitionValueRat a b q ^ 1 := by rw [Nat.zero_mul]
            _ = 1 * openPartitionValueRat a b q ^ 1 := by rw [pow_zero]
            _ = openPartitionValueRat a b q ^ 1 := one_mul _
            _ = openPartitionValueRat a b q := pow_one _
            _ = openPartitionValueRat (1 * a) b q := by rw [Nat.one_mul])
      · exact le_of_eq (by
          calc openPartitionValueRat (1 * a) b q
              = openPartitionValueRat a b q := by rw [Nat.one_mul]
            _ = openPartitionValueRat a b q ^ 1 := (pow_one _).symm)
  | succ k hk ih =>
      -- 接合不等式を一辺が ka と a の二長方形へ適用する。
      have hka : 0 < k * a := Nat.mul_pos hk ha
      have hglue := openPartitionValueRat_glueFirst_bounds_of_le_one (k * a) b a hka ha hq0 hq1
      have hz0 : (0 : ℚ) ≤ openPartitionValueRat a b q := (openPartitionValueRat_pos a b hq0).le
      -- 人手証明の「kb = b + (k-1)b」（k ≥ 1 で成り立つ）。
      have hkb : k * b = b + (k - 1) * b := by
        conv_lhs => rw [← Nat.sub_add_cancel hk]
        rw [Nat.add_mul, Nat.one_mul]
        exact Nat.add_comm _ _
      constructor
      · -- 下からの評価（人手証明の calc と同じ順）。
        calc q ^ ((k + 1 - 1) * b) * openPartitionValueRat a b q ^ (k + 1)
            = q ^ (k * b) * openPartitionValueRat a b q ^ (k + 1) := by
              rw [Nat.add_sub_cancel]
          _ = q ^ (b + (k - 1) * b) * openPartitionValueRat a b q ^ (k + 1) := by rw [hkb]
          _ = q ^ b * q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ (k + 1) := by
              rw [pow_add]
          _ = q ^ b * q ^ ((k - 1) * b) *
                (openPartitionValueRat a b q ^ k * openPartitionValueRat a b q) := by
              rw [pow_succ]
          _ = q ^ b * (q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ k *
                openPartitionValueRat a b q) := by
              rw [mul_assoc, ← mul_assoc (q ^ ((k - 1) * b))]
          _ ≤ q ^ b * (openPartitionValueRat (k * a) b q * openPartitionValueRat a b q) := by
              apply mul_le_mul_of_nonneg_left _ (pow_pos_by_induction hq0 b).le
              exact mul_le_mul_of_nonneg_right ih.1 hz0
          _ ≤ openPartitionValueRat (k * a + a) b q := hglue.1
          _ = openPartitionValueRat ((k + 1) * a) b q := by rw [Nat.succ_mul]
      · -- 上からの評価。
        calc openPartitionValueRat ((k + 1) * a) b q
            = openPartitionValueRat (k * a + a) b q := by rw [Nat.succ_mul]
          _ ≤ openPartitionValueRat (k * a) b q * openPartitionValueRat a b q := hglue.2
          _ ≤ openPartitionValueRat a b q ^ k * openPartitionValueRat a b q :=
              mul_le_mul_of_nonneg_right ih.2 hz0
          _ = openPartitionValueRat a b q ^ (k + 1) := (pow_succ _ _).symm

/-- `claim_open_rectangle_iterated_gluing_first_rational` の `1 ≤ q` の場合:
`(Z^op_{a,b}(q))^k ≤ Z^op_{ka,b}(q) ≤ q^{(k-1)b} (Z^op_{a,b}(q))^k`。 -/
theorem openPartitionValueRat_iteratedGlueFirst_bounds_of_one_le
    (ha : 0 < a) {q : ℚ} (hq : 1 ≤ q) :
    ∀ k : ℕ, 1 ≤ k →
      openPartitionValueRat a b q ^ k ≤ openPartitionValueRat (k * a) b q ∧
        openPartitionValueRat (k * a) b q ≤
          q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ k := by
  have hq0 : (0 : ℚ) < q := lt_of_lt_of_le zero_lt_one hq
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>
      constructor
      · exact le_of_eq (by
          calc openPartitionValueRat a b q ^ 1
              = openPartitionValueRat a b q := pow_one _
            _ = openPartitionValueRat (1 * a) b q := by rw [Nat.one_mul])
      · exact le_of_eq (by
          calc openPartitionValueRat (1 * a) b q
              = openPartitionValueRat a b q := by rw [Nat.one_mul]
            _ = openPartitionValueRat a b q ^ 1 := (pow_one _).symm
            _ = 1 * openPartitionValueRat a b q ^ 1 := (one_mul _).symm
            _ = q ^ 0 * openPartitionValueRat a b q ^ 1 := by rw [pow_zero]
            _ = q ^ (0 * b) * openPartitionValueRat a b q ^ 1 := by rw [Nat.zero_mul]
            _ = q ^ ((1 - 1) * b) * openPartitionValueRat a b q ^ 1 := by rw [Nat.sub_self])
  | succ k hk ih =>
      have hka : 0 < k * a := Nat.mul_pos hk ha
      have hglue := openPartitionValueRat_glueFirst_bounds_of_one_le (k * a) b a hka ha hq
      have hz0 : (0 : ℚ) ≤ openPartitionValueRat a b q := (openPartitionValueRat_pos a b hq0).le
      have hkb : k * b = b + (k - 1) * b := by
        conv_lhs => rw [← Nat.sub_add_cancel hk]
        rw [Nat.add_mul, Nat.one_mul]
        exact Nat.add_comm _ _
      constructor
      · -- 下からの評価。
        calc openPartitionValueRat a b q ^ (k + 1)
            = openPartitionValueRat a b q ^ k * openPartitionValueRat a b q := pow_succ _ _
          _ ≤ openPartitionValueRat (k * a) b q * openPartitionValueRat a b q :=
              mul_le_mul_of_nonneg_right ih.1 hz0
          _ ≤ openPartitionValueRat (k * a + a) b q := hglue.1
          _ = openPartitionValueRat ((k + 1) * a) b q := by rw [Nat.succ_mul]
      · -- 上からの評価（人手証明の calc と同じ順）。
        calc openPartitionValueRat ((k + 1) * a) b q
            = openPartitionValueRat (k * a + a) b q := by rw [Nat.succ_mul]
          _ ≤ q ^ b * (openPartitionValueRat (k * a) b q * openPartitionValueRat a b q) :=
              hglue.2
          _ ≤ q ^ b * (q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ k *
                openPartitionValueRat a b q) := by
              apply mul_le_mul_of_nonneg_left _ (pow_pos_by_induction hq0 b).le
              exact mul_le_mul_of_nonneg_right ih.2 hz0
          _ = q ^ b * q ^ ((k - 1) * b) *
                (openPartitionValueRat a b q ^ k * openPartitionValueRat a b q) := by
              rw [mul_assoc, mul_assoc]
          _ = q ^ b * q ^ ((k - 1) * b) * openPartitionValueRat a b q ^ (k + 1) := by
              rw [pow_succ]
          _ = q ^ (b + (k - 1) * b) * openPartitionValueRat a b q ^ (k + 1) := by
              rw [pow_add q b ((k - 1) * b)]
          _ = q ^ (k * b) * openPartitionValueRat a b q ^ (k + 1) := by rw [hkb]
          _ = q ^ ((k + 1 - 1) * b) * openPartitionValueRat a b q ^ (k + 1) := by
              rw [Nat.add_sub_cancel]

end Ising2DLambda.ThermodynamicLimit
