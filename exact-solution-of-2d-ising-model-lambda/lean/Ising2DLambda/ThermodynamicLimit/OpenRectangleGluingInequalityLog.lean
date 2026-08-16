/-
章「熱力学極限」の「開境界長方形の接合不等式の対数化（Λ の鎖）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_rectangle_gluing_inequality_log` である。

  人手証明の段                                              このファイル
  準備の第一: 値と両端の値の正値性                           hZab / hZcb / hZ / hlow / hup
  準備の第二（前半）: 下端の値の対数を開く三段               logRat_gluingLowerValue_eq
  準備の第二（後半）: 上端の値の対数を開く一段               logRat_gluingUpperValue_eq
  第一の座標の向き 0<q≤1（対数の順序移送で挟む）             logOrderLE_openRectangleGlueFirstLog_bounds_of_le_one
  第一の座標の向き 1≤q（向きを反転した同じ鎖）               logOrderLE_openRectangleGlueFirstLog_bounds_of_one_le
  第二の座標の向き（b→a、Z_{c,b}→Z_{a,c}、Z_{a+c,b}→Z_{a,b+c}） logOrderLE_openRectangleGlueSecondLog_bounds_of_le_one / _of_one_le

住処: Λ（`LogOrderGroup`）。比較は `logRat_le_iff` を通した ℚ の比較であり、実数体は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

/-- 準備の第二（前半）: 下端の値の対数を Λ の中で開く三段
`log(q^n·(Z₁·Z₂)) = n·log q + log Z₁ + log Z₂`（`Z₁, Z₂ > 0`）。 -/
theorem logRat_gluingLowerValue_eq (n : ℕ) {q Z₁ Z₂ : ℚ}
    (hq0 : 0 < q) (h1 : 0 < Z₁) (h2 : 0 < Z₂) :
    logRat (q ^ n * (Z₁ * Z₂)) = n • logRat q + logRat Z₁ + logRat Z₂ := by
  calc
    logRat (q ^ n * (Z₁ * Z₂))
        -- 対数の加法性（claim_log_additive）
        = logRat (q ^ n) + logRat (Z₁ * Z₂) :=
          logRat_mul (pow_pos_by_induction hq0 _) (mul_pos h1 h2)
    -- 対数の冪（claim_log_power を k := n で）
    _ = n • logRat q + logRat (Z₁ * Z₂) := by rw [logRat_pow hq0]
    -- 対数の加法性（claim_log_additive）
    _ = n • logRat q + logRat Z₁ + logRat Z₂ := by rw [logRat_mul h1 h2, add_assoc]

/-- 準備の第二（後半）: 上端の値の対数を開く一段 `log(Z₁·Z₂) = log Z₁ + log Z₂`。 -/
theorem logRat_gluingUpperValue_eq {Z₁ Z₂ : ℚ} (h1 : 0 < Z₁) (h2 : 0 < Z₂) :
    logRat (Z₁ * Z₂) = logRat Z₁ + logRat Z₂ :=
  logRat_mul h1 h2

/-- `claim_open_rectangle_gluing_inequality_log` 第一の座標の向き・`0 < q ≤ 1`:
`b·log q + log Z^op_{a,b}(q) + log Z^op_{c,b}(q) ≤_Λ log Z^op_{a+c,b}(q)
 ≤_Λ log Z^op_{a,b}(q) + log Z^op_{c,b}(q)`。 -/
theorem logOrderLE_openRectangleGlueFirstLog_bounds_of_le_one
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        (b • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat c b q))
        (logRat (openPartitionValueRat (a + c) b q)) ∧
      logOrderLE (logRat (openPartitionValueRat (a + c) b q))
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q)) := by
  -- 準備の第一: 値と両端の値の正値性
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZcb : 0 < openPartitionValueRat c b q := openPartitionValueRat_pos c b hq0
  have hZ : 0 < openPartitionValueRat (a + c) b q := openPartitionValueRat_pos (a + c) b hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat c b q := mul_pos hZab hZcb
  have hlow : 0 < q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  -- 接合不等式（claim_open_rectangle_gluing_inequality_rational の第一の座標の向き・0<q≤1）
  have hbounds := openPartitionValueRat_glueFirst_bounds_of_le_one (a := a) (b := b) (c := c)
    ha hc hq0 hq1
  constructor
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第二（前半）
    have h := (logRat_le_iff hlow hZ).mp hbounds.1
    rwa [logRat_gluingLowerValue_eq b hq0 hZab hZcb] at h
  · -- 対数の順序移送（claim_rational_log_order_iff）と準備の第二（後半）
    have h := (logRat_le_iff hZ hup).mp hbounds.2
    rwa [logRat_gluingUpperValue_eq hZab hZcb] at h

/-- `claim_open_rectangle_gluing_inequality_log` 第一の座標の向き・`1 ≤ q`（向きを反転した同じ鎖）。 -/
theorem logOrderLE_openRectangleGlueFirstLog_bounds_of_one_le
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q))
        (logRat (openPartitionValueRat (a + c) b q)) ∧
      logOrderLE (logRat (openPartitionValueRat (a + c) b q))
        (b • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat c b q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZcb : 0 < openPartitionValueRat c b q := openPartitionValueRat_pos c b hq0
  have hZ : 0 < openPartitionValueRat (a + c) b q := openPartitionValueRat_pos (a + c) b hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat c b q := mul_pos hZab hZcb
  have hlow : 0 < q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueFirst_bounds_of_one_le (a := a) (b := b) (c := c)
    ha hc hq
  constructor
  · have h := (logRat_le_iff hup hZ).mp hbounds.1
    rwa [logRat_gluingUpperValue_eq hZab hZcb] at h
  · have h := (logRat_le_iff hZ hlow).mp hbounds.2
    rwa [logRat_gluingLowerValue_eq b hq0 hZab hZcb] at h

/-- 第二の座標の向き・`0 < q ≤ 1`:
`a·log q + log Z^op_{a,b}(q) + log Z^op_{a,c}(q) ≤_Λ log Z^op_{a,b+c}(q)
 ≤_Λ log Z^op_{a,b}(q) + log Z^op_{a,c}(q)`。 -/
theorem logOrderLE_openRectangleGlueSecondLog_bounds_of_le_one
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        (a • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat a c q))
        (logRat (openPartitionValueRat a (b + c) q)) ∧
      logOrderLE (logRat (openPartitionValueRat a (b + c) q))
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q)) := by
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZac : 0 < openPartitionValueRat a c q := openPartitionValueRat_pos a c hq0
  have hZ : 0 < openPartitionValueRat a (b + c) q := openPartitionValueRat_pos a (b + c) hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat a c q := mul_pos hZab hZac
  have hlow : 0 < q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueSecond_bounds_of_le_one (a := a) (b := b) (c := c)
    hb hc hq0 hq1
  constructor
  · have h := (logRat_le_iff hlow hZ).mp hbounds.1
    rwa [logRat_gluingLowerValue_eq a hq0 hZab hZac] at h
  · have h := (logRat_le_iff hZ hup).mp hbounds.2
    rwa [logRat_gluingUpperValue_eq hZab hZac] at h

/-- 第二の座標の向き・`1 ≤ q`（向きを反転した同じ鎖）。 -/
theorem logOrderLE_openRectangleGlueSecondLog_bounds_of_one_le
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q))
        (logRat (openPartitionValueRat a (b + c) q)) ∧
      logOrderLE (logRat (openPartitionValueRat a (b + c) q))
        (a • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat a c q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZac : 0 < openPartitionValueRat a c q := openPartitionValueRat_pos a c hq0
  have hZ : 0 < openPartitionValueRat a (b + c) q := openPartitionValueRat_pos a (b + c) hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat a c q := mul_pos hZab hZac
  have hlow : 0 < q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueSecond_bounds_of_one_le (a := a) (b := b) (c := c)
    hb hc hq
  constructor
  · have h := (logRat_le_iff hup hZ).mp hbounds.1
    rwa [logRat_gluingUpperValue_eq hZab hZac] at h
  · have h := (logRat_le_iff hZ hlow).mp hbounds.2
    rwa [logRat_gluingLowerValue_eq a hq0 hZab hZac] at h

end Ising2DLambda.ThermodynamicLimit
