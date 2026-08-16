/-
章「熱力学極限」の「開境界正方形と部分正方形の比較の対数化（Λ の鎖。q は 1 以下）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_square_subsquare_comparison_log_le_one` である。

  人手証明の段                                                このファイル
  準備の第一: 値と両端の値の正値性                             hZa / hZL / hlow / hup
  準備の第二: log 2 = ℓ_2                                     `logRat_two`（`FreeEntropy.AtOne`）
  準備の第三（前半）: 下端の値の対数を開く二段                 logRat_subsquareLowerValue_eq
  準備の第三（後半）: 上端の値の対数を開く四段                 logRat_subsquareUpperValue_eq
  本体（対数の順序移送で挟む 4 段の鎖）                        logOrderLE_openSquareSubsquareLog_bounds_of_le_one

住処: Λ（`LogOrderGroup`）。比較は `logRat_le_iff` を通した ℚ の比較であり、実数体は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.FreeEntropy.AtOne
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

/-- 準備の第三（前半）: 下端の値の対数を Λ の中で開く二段
`log(q^m·Z) = m·log q + log Z`（`Z > 0`）。 -/
theorem logRat_subsquareLowerValue_eq (m : ℕ) {q Z : ℚ} (hq0 : 0 < q) (hZ : 0 < Z) :
    logRat (q ^ m * Z) = m • logRat q + logRat Z := by
  calc
    logRat (q ^ m * Z)
        -- 対数の加法性（claim_log_additive）
        = logRat (q ^ m) + logRat Z := logRat_mul (pow_pos_by_induction hq0 _) hZ
    -- 対数の冪（claim_log_power を k := m で）
    _ = m • logRat q + logRat Z := by rw [logRat_pow hq0]

/-- 準備の第三（後半）: 上端の値の対数を開く四段
`log(2^n·(1+q)^{2n}·Z) = n·ℓ_2 + 2n·log(1+q) + log Z`（`Z > 0`）。 -/
theorem logRat_subsquareUpperValue_eq (n : ℕ) {q Z : ℚ} (hq0 : 0 < q) (hZ : 0 < Z) :
    logRat (((2 ^ n : ℕ) : ℚ) * (1 + q) ^ (2 * n) * Z) =
      n • generator ⟨2, Nat.prime_two⟩ + (2 * n) • logRat (1 + q) + logRat Z := by
  have h1q : 0 < 1 + q := by linarith
  have h2 : (0 : ℚ) < 2 := by norm_num
  have hB : 0 < ((2 ^ n : ℕ) : ℚ) * (1 + q) ^ (2 * n) := mul_pos (by positivity) (pow_pos h1q _)
  calc
    logRat (((2 ^ n : ℕ) : ℚ) * (1 + q) ^ (2 * n) * Z)
        -- 対数の加法性（claim_log_additive）
        = logRat (((2 ^ n : ℕ) : ℚ) * (1 + q) ^ (2 * n)) + logRat Z := logRat_mul hB hZ
    _ = logRat ((2 : ℚ) ^ n * (1 + q) ^ (2 * n)) + logRat Z := by push_cast; rfl
    -- 対数の加法性（claim_log_additive）
    _ = logRat ((2 : ℚ) ^ n) + logRat ((1 + q) ^ (2 * n)) + logRat Z := by
          rw [logRat_mul (pow_pos h2 _) (pow_pos h1q _)]
    -- 対数の冪（claim_log_power を k := n と k := 2n で二項へ同時適用）
    _ = n • logRat 2 + (2 * n) • logRat (1 + q) + logRat Z := by
          rw [logRat_pow h2, logRat_pow h1q]
    -- 準備の第二: log 2 = ℓ_2
    _ = n • generator ⟨2, Nat.prime_two⟩ + (2 * n) • logRat (1 + q) + logRat Z := by
          rw [logRat_two]

/-- `claim_open_square_subsquare_comparison_log_le_one`:
`(a+L)·log q + log Z^op_{a,a}(q) ≤_Λ log Z^op_{L,L}(q)
 ≤_Λ (L²−a²)·ℓ_2 + 2(L²−a²)·log(1+q) + log Z^op_{a,a}(q)`。 -/
theorem logOrderLE_openSquareSubsquareLog_bounds_of_le_one
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE ((a + L) • logRat q + logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat L L q)) ∧
      logOrderLE (logRat (openPartitionValueRat L L q))
        ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
          (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q)) := by
  have h1q : 0 < 1 + q := by linarith
  -- 準備の第一: 値と両端の値の正値性
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZL : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq0
  have hlow : 0 < q ^ (a + L) * openPartitionValueRat a a q :=
    mul_pos (pow_pos_by_induction hq0 _) hZa
  have hup : 0 < ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * (L ^ 2 - a ^ 2)) *
      openPartitionValueRat a a q :=
    mul_pos (mul_pos (by positivity) (pow_pos h1q _)) hZa
  -- 値の比較（claim_open_square_subsquare_comparison_rational_le_one）
  have hbounds := openPartitionValueRat_square_subsquare_bounds_of_le_one a L ha haL hq0 hq1
  constructor
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第三（前半）
    have h := (logRat_le_iff hlow hZL).mp hbounds.1
    rwa [logRat_subsquareLowerValue_eq (a + L) hq0 hZa] at h
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第三（後半）
    have h := (logRat_le_iff hZL hup).mp hbounds.2
    rwa [logRat_subsquareUpperValue_eq (L ^ 2 - a ^ 2) hq0 hZa] at h

end Ising2DLambda.ThermodynamicLimit
