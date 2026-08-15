/-
「開境界長方形を第一座標方向へ反復接合した値の評価」の必要十分版。

格子・配位・破れボンド数・実数を除き、具体版の証明が実際に使っている次だけを残す:
- 反復回数についての帰納法（`Nat.le_induction`）
- k = 1 の底での値の一致（接合前の一枚の値そのもの）
- 一回の接合の一段の上下評価（接合面因子 `low` / `high` を掛けた形）
- 非負元の乗法の単調性と冪の指数法則

証明手順は具体版と同じ: 底は等号の鎖、帰納段は「因子の冪を一段ほどき、
帰納法の仮定へ非負元を掛け、一段の評価でつなぐ」。

仮定が要る理由（削ると通らない）:
- `Monoid K` + `Semiring K` 相当の積と冪: 冪の指数法則 `pow_succ` / `pow_succ'` と
  積の結合則 `mul_assoc` に要る。**積の可換性は使わないので `CommSemiring` は課さない**
  （一回の接合の必要十分版 `sum_pow_glue_bounds_necSuf` は `mul_comm` を使うが、
  反復の帰納法は因子の順序を保ったまま進むので可換性が落ちる）。
- `PartialOrder K` + `IsOrderedRing K`: 非負元を左右から掛けても順序が保たれること
  （`mul_le_mul_of_nonneg_left` / `_right`）に要る。全順序（三分律）は使わないので課さない。
- `0 ≤ z`・`0 ≤ low`・`0 ≤ high`: 帰納法の仮定へ掛ける因子の非負性そのもの。
-/
import Mathlib.Algebra.Order.Ring.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 一段の上下評価 `low * (P k * z) ≤ P (k+1) ≤ high * (P k * z)` と底 `P 1 = z` から、
反復回数 `k` についての帰納法で `low^{k-1} z^k ≤ P k ≤ high^{k-1} z^k` を得る
（具体版と同じ手順）。 -/
theorem iterated_glue_pow_bounds_necSuf
    {K : Type*} [Semiring K] [PartialOrder K] [IsOrderedRing K]
    (P : ℕ → K) (z low high : K)
    (hz0 : 0 ≤ z) (hlow0 : 0 ≤ low) (hhigh0 : 0 ≤ high)
    (hbase : P 1 = z)
    (hlow : ∀ k : ℕ, 1 ≤ k → low * (P k * z) ≤ P (k + 1))
    (hhigh : ∀ k : ℕ, 1 ≤ k → P (k + 1) ≤ high * (P k * z)) :
    ∀ k : ℕ, 1 ≤ k →
      low ^ (k - 1) * z ^ k ≤ P k ∧ P k ≤ high ^ (k - 1) * z ^ k := by
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>
      -- 底は等号の鎖（具体版の k = 1 の底にあたる）。
      constructor
      · exact le_of_eq (by
          calc low ^ (1 - 1) * z ^ 1
              = low ^ 0 * z ^ 1 := by rw [Nat.sub_self]
            _ = 1 * z ^ 1 := by rw [pow_zero]
            _ = z ^ 1 := one_mul _
            _ = z := pow_one _
            _ = P 1 := hbase.symm)
      · exact le_of_eq (by
          calc P 1
              = z := hbase
            _ = z ^ 1 := (pow_one _).symm
            _ = 1 * z ^ 1 := (one_mul _).symm
            _ = high ^ 0 * z ^ 1 := by rw [pow_zero]
            _ = high ^ (1 - 1) * z ^ 1 := by rw [Nat.sub_self])
  | succ k hk ih =>
      -- 因子の冪を一段ほどく等式（具体版の「kb = b + (k-1)b」にあたる）。
      have hpow : ∀ x : K, x ^ (k + 1 - 1) = x * x ^ (k - 1) := by
        intro x
        rw [Nat.add_sub_cancel]
        conv_lhs => rw [← Nat.sub_add_cancel hk]
        rw [pow_succ']
      constructor
      · calc low ^ (k + 1 - 1) * z ^ (k + 1)
            = low * low ^ (k - 1) * z ^ (k + 1) := by rw [hpow]
          _ = low * low ^ (k - 1) * (z ^ k * z) := by rw [pow_succ]
          _ = low * (low ^ (k - 1) * z ^ k * z) := by
              rw [mul_assoc, ← mul_assoc (low ^ (k - 1))]
          _ ≤ low * (P k * z) := by
              apply mul_le_mul_of_nonneg_left _ hlow0
              exact mul_le_mul_of_nonneg_right ih.1 hz0
          _ ≤ P (k + 1) := hlow k hk
      · calc P (k + 1)
            ≤ high * (P k * z) := hhigh k hk
          _ ≤ high * (high ^ (k - 1) * z ^ k * z) := by
              apply mul_le_mul_of_nonneg_left _ hhigh0
              exact mul_le_mul_of_nonneg_right ih.2 hz0
          _ = high * high ^ (k - 1) * (z ^ k * z) := by
              rw [mul_assoc, mul_assoc]
          _ = high * high ^ (k - 1) * z ^ (k + 1) := by rw [pow_succ]
          _ = high ^ (k + 1 - 1) * z ^ (k + 1) := by rw [hpow]

end Ising2DLambda.NecSuf.ThermodynamicLimit
