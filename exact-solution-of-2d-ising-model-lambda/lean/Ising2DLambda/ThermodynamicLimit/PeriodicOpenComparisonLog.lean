/-
章「熱力学極限」の「周期境界と開境界の境界評価の対数化（Λ の鎖。q は 1 以下）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_periodic_open_boundary_comparison_log_le_one` である。

  人手証明の段                                                このファイル
  準備の第一: 周期境界の値・開境界の値・下端の値の正値性        hZ / hZop / hlow
  準備の第二: 下端の値の対数を開く二段                         logRat_periodicOpenLowerValue_eq
  本体（対数の順序移送で挟む 3 段の鎖）                        logOrderLE_periodicOpenLog_bounds_of_le_one

住処: Λ（`LogOrderGroup`）。比較は `logRat_le_iff` を通した ℚ の比較であり、実数体は現れない。
上端は `log Z^op_{L,L}(q)` そのもので、開く操作は要らない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.FreeEntropy.Basic
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonInequalityRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: 下端の値の対数を Λ の中で開く二段
`log(q^{2L}·Z) = 2L·log q + log Z`（`Z > 0`）。 -/
theorem logRat_periodicOpenLowerValue_eq (L : ℕ) {q Z : ℚ} (hq0 : 0 < q) (hZ : 0 < Z) :
    logRat (q ^ (2 * L) * Z) = (2 * L) • logRat q + logRat Z := by
  calc
    logRat (q ^ (2 * L) * Z)
        -- 対数の加法性（claim_log_additive）
        = logRat (q ^ (2 * L)) + logRat Z := logRat_mul (pow_pos hq0 _) hZ
    -- 対数の冪（claim_log_power を k := 2L で）
    _ = (2 * L) • logRat q + logRat Z := by rw [logRat_pow hq0]

/-- `claim_periodic_open_boundary_comparison_log_le_one`:
`2L·log q + log Z^op_{L,L}(q) ≤_Λ Φ_L(q) ≤_Λ log Z^op_{L,L}(q)`（`0 < q ≤ 1`）。 -/
theorem logOrderLE_periodicOpenLog_bounds_of_le_one
    (L : ℕ) [NeZero L] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE ((2 * L) • logRat q + logRat (openPartitionValueRat L L q))
        (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (openPartitionValueRat L L q)) := by
  -- 準備の第一: 値の正値性
  have hZ : 0 < Polynomial.aeval q (PartitionPolynomial.partitionPolynomial L) :=
    partitionPolynomial_eval_pos L hq0
  have hZop : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq0
  have hlow : 0 < q ^ (2 * L) * openPartitionValueRat L L q := mul_pos (pow_pos hq0 _) hZop
  -- 値の比較（claim_periodic_open_boundary_comparison_rational）
  have hbounds := partitionValueRat_periodicOpen_bounds_of_le_one L hq0 hq1
  unfold freeEntropy
  constructor
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第二
    have h := (logRat_le_iff hlow hZ).mp hbounds.1
    rwa [logRat_periodicOpenLowerValue_eq L hq0 hZop] at h
  · -- 対数の順序移送（claim_rational_log_order_iff）
    exact (logRat_le_iff hZ hZop).mp hbounds.2

end Ising2DLambda.ThermodynamicLimit
