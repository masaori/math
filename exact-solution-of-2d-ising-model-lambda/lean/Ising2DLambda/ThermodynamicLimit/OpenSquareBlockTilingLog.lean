/-
章「熱力学極限」の「開境界正方形のブロック敷き詰め評価の対数化（Λ の鎖）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_square_block_tiling_log` である。

  人手証明の段                                              このファイル
  準備の第一: 値と両側の評価の値の正値性                     hZa / hZka / hinner / hlow / hup
  準備の第二: 下からの評価の側の値の対数を開く六段           logRat_blockTilingLowerValue_eq
  準備の第三: 上からの評価の側の値の対数を開く三段           logRat_blockTilingUpperValue_eq
  本体 0<q≤1（対数の順序移送で挟む）                         logOrderLE_openSquareBlockTilingLog_bounds_of_le_one
  本体 1≤q（向きを反転した同じ鎖）                           logOrderLE_openSquareBlockTilingLog_bounds_of_one_le

住処: Λ（`LogOrderGroup`）。比較は `logRat_le_iff` を通した ℚ の比較であり、実数体は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

/-- 準備の第二: 下からの評価の側の値の対数を Λ の中で開く六段
`log(q^{(k-1)(ka)}·(q^{(k-1)a}·Z^op_{a,a}(q)^k)^k) = 2k(k-1)a·log q + k²·log Z^op_{a,a}(q)`。 -/
theorem logRat_blockTilingLowerValue_eq (a k : ℕ) {q : ℚ} (hq0 : 0 < q) :
    logRat (q ^ ((k - 1) * (k * a)) *
        (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k) =
      (2 * (k * ((k - 1) * a))) • logRat q +
        (k * k) • logRat (openPartitionValueRat a a q) := by
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hinner : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)
  -- 整数の計算 (k-1)(ka) + k(k-1)a = 2k(k-1)a（k-1 はひとつの自然数として扱う）
  have hcoef : (k - 1) * (k * a) + k * ((k - 1) * a) = 2 * (k * ((k - 1) * a)) := by
    generalize k - 1 = m
    ring
  calc
    logRat (q ^ ((k - 1) * (k * a)) *
        (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k)
        -- 対数の加法性（claim_log_additive）
        = logRat (q ^ ((k - 1) * (k * a))) +
            logRat ((q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k) :=
          logRat_mul (pow_pos_by_induction hq0 _) (pow_pos_by_induction hinner _)
    -- 対数の冪（claim_log_power を二項へ同時適用）
    _ = ((k - 1) * (k * a)) • logRat q +
          k • logRat (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) := by
          rw [logRat_pow hq0, logRat_pow hinner]
    -- 対数の加法性（claim_log_additive）
    _ = ((k - 1) * (k * a)) • logRat q +
          k • (logRat (q ^ ((k - 1) * a)) + logRat (openPartitionValueRat a a q ^ k)) := by
          rw [logRat_mul (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)]
    -- 対数の冪（claim_log_power を二項へ同時適用）
    _ = ((k - 1) * (k * a)) • logRat q +
          k • (((k - 1) * a) • logRat q + k • logRat (openPartitionValueRat a a q)) := by
          rw [logRat_pow hq0, logRat_pow hZa]
    -- 整数倍の分配則と結合則（def_log_order_group。素数ごとの ℤ の積）
    _ = ((k - 1) * (k * a)) • logRat q +
          ((k * ((k - 1) * a)) • logRat q +
            (k * k) • logRat (openPartitionValueRat a a q)) := by
          rw [smul_add, smul_smul, smul_smul]
    -- 同じ元の整数倍の和 nλ + mλ = (n+m)λ
    _ = ((k - 1) * (k * a) + k * ((k - 1) * a)) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q) := by
          rw [add_smul, add_assoc]
    -- 整数の計算（準備の hcoef）
    _ = (2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q) := by
          rw [hcoef]

/-- 準備の第三: 上からの評価の側の値の対数を Λ の中で開く三段
`log((Z^op_{a,a}(q)^k)^k) = k²·log Z^op_{a,a}(q)`。 -/
theorem logRat_blockTilingUpperValue_eq (a k : ℕ) {q : ℚ} (hq0 : 0 < q) :
    logRat ((openPartitionValueRat a a q ^ k) ^ k) =
      (k * k) • logRat (openPartitionValueRat a a q) := by
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  -- claim_log_power ×2 と整数倍の結合則
  rw [logRat_pow (pow_pos_by_induction hZa k), logRat_pow hZa, smul_smul]

/-- `claim_open_square_block_tiling_log` の `0 < q ≤ 1` の場合:
`2k(k-1)a·log q + k²·log Z^op_{a,a}(q) ≤_Λ log Z^op_{ka,ka}(q) ≤_Λ k²·log Z^op_{a,a}(q)`。 -/
theorem logOrderLE_openSquareBlockTilingLog_bounds_of_le_one
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat (k * a) (k * a) q)) ∧
      logOrderLE (logRat (openPartitionValueRat (k * a) (k * a) q))
        ((k * k) • logRat (openPartitionValueRat a a q)) := by
  -- 準備の第一: 値と両側の評価の値の正値性
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZka : 0 < openPartitionValueRat (k * a) (k * a) q :=
    openPartitionValueRat_pos (k * a) (k * a) hq0
  have hinner : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)
  have hlow : 0 < q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hinner _)
  have hup : 0 < (openPartitionValueRat a a q ^ k) ^ k :=
    pow_pos_by_induction (pow_pos_by_induction hZa _) _
  -- ブロック敷き詰め評価（claim_open_square_block_tiling_rational の 0<q≤1 の場合）
  have hbounds := openPartitionValueRat_squareBlockTiling_bounds_of_le_one a k ha hk hq0 hq1
  constructor
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第二
    have h := (logRat_le_iff hlow hZka).mp hbounds.1
    rwa [logRat_blockTilingLowerValue_eq a k hq0] at h
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第三
    have h := (logRat_le_iff hZka hup).mp hbounds.2
    rwa [logRat_blockTilingUpperValue_eq a k hq0] at h

/-- `claim_open_square_block_tiling_log` の `1 ≤ q` の場合:
`k²·log Z^op_{a,a}(q) ≤_Λ log Z^op_{ka,ka}(q) ≤_Λ 2k(k-1)a·log q + k²·log Z^op_{a,a}(q)`。 -/
theorem logOrderLE_openSquareBlockTilingLog_bounds_of_one_le
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE ((k * k) • logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat (k * a) (k * a) q)) ∧
      logOrderLE (logRat (openPartitionValueRat (k * a) (k * a) q))
        ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  -- 準備の第一: 値と両側の評価の値の正値性
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZka : 0 < openPartitionValueRat (k * a) (k * a) q :=
    openPartitionValueRat_pos (k * a) (k * a) hq0
  have hinner : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)
  have hlow : 0 < q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hinner _)
  have hup : 0 < (openPartitionValueRat a a q ^ k) ^ k :=
    pow_pos_by_induction (pow_pos_by_induction hZa _) _
  -- ブロック敷き詰め評価（claim_open_square_block_tiling_rational の 1≤q の場合）
  have hbounds := openPartitionValueRat_squareBlockTiling_bounds_of_one_le a k ha hk hq
  constructor
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第三
    have h := (logRat_le_iff hup hZka).mp hbounds.1
    rwa [logRat_blockTilingUpperValue_eq a k hq0] at h
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第二
    have h := (logRat_le_iff hZka hlow).mp hbounds.2
    rwa [logRat_blockTilingLowerValue_eq a k hq0] at h

end Ising2DLambda.ThermodynamicLimit
