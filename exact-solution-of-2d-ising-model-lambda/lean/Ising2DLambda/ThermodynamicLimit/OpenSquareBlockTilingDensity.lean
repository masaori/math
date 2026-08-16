/-
人手証明「開境界正方形のブロック敷き詰め評価の密度の挟み込み（Λ_ℚ 版）」
（`claim_open_square_block_tiling_density`）の具体版。

`a, k ≥ 1`、`q ∈ ℚ_{>0}` について、
  `0 < q ≤ 1`: `(2(k-1)/(ka))·ι(log q) + Ψ^op_a(q) ≤_{Λ_ℚ} Ψ^op_{ka}(q) ≤_{Λ_ℚ} Ψ^op_a(q)`
  `1 ≤ q`:     その反転。
準備の第一: `Z^op_{a,a}(q), Z^op_{ka,ka}(q) ∈ ℚ_{>0}` と `(ka)² ≠ 0`（`NeZero (k*a)` は `[NeZero a] [NeZero k]` から）。
準備の第二（上からの評価の側。`scaled_blockTilingUpperForm_eq`）:
  (1/(ka)²)·ι(k²·log Z^op_{a,a}(q))
    = (1/(ka)²)·(k²·ι(log Z^op_{a,a}(q)))            （`toRational_intSmul` を逆向きに）
    = ((1/(ka)²)·k²)·ι(log Z^op_{a,a}(q))            （有理数倍の結合則 `smul_smul`）
    = (1/a²)·ι(log Z^op_{a,a}(q))                    （ℚ の約分 k²/(k²a²) = 1/a²）
    = Ψ^op_a(q)                                      （定義 `openScaledFreeEntropy`）
準備の第三（下からの評価の側。`scaled_blockTilingLowerForm_eq`）:
  (1/(ka)²)·ι(2k(k-1)a·log q + k²·log Z^op_{a,a}(q))
    = (1/(ka)²)·(ι(2k(k-1)a·log q) + ι(k²·log Z^op_{a,a}(q)))   （`toRational_add`）
    = (1/(ka)²)·ι(2k(k-1)a·log q) + (1/(ka)²)·ι(k²·log Z^op_{a,a}(q))   （有理数倍の分配則 `smul_add`）
    = (1/(ka)²)·(2k(k-1)a·ι(log q)) + …                （`toRational_intSmul` を逆向きに）
    = ((1/(ka)²)·2k(k-1)a)·ι(log q) + …                （`smul_smul`）
    = (2(k-1)/(ka))·ι(log q) + …                       （ℚ の約分 2k(k-1)a/(k²a²) = 2(k-1)/(ka)）
    = (2(k-1)/(ka))·ι(log q) + Ψ^op_a(q)               （準備の第二）
本体（二場合とも左右の不等式を 3 段の鎖 2 本ずつ）:
  準備の等式 → `rationalLogOrderLE_scaled_toRational_iff (k*a)` の ← で
  `claim_open_square_block_tiling_log` の Λ の比較を移す → 定義 `openScaledFreeEntropy`。
`k - 1` は自然数のまま扱い、係数は `2·((k-1 : ℕ) : ℚ) / (k·a)` の形にする。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensity
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: `(1/(ka)²)·ι(k²·log Z^op_{a,a}(q)) = Ψ^op_a(q)`。 -/
theorem scaled_blockTilingUpperForm_eq (a k : ℕ) [NeZero a] [NeZero k] (q : ℚ) :
    ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
        toRational ((k * k) • logRat (openPartitionValueRat a a q)) =
      openScaledFreeEntropy a q := by
  have ha : (a : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne a)
  have hk : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne k)
  calc
    ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
        toRational ((k * k) • logRat (openPartitionValueRat a a q))
        = ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            ((((k * k : ℕ) : ℤ) : ℚ) • toRational (logRat (openPartitionValueRat a a q))) := by
          rw [← natCast_zsmul, ← toRational_intSmul]           -- n·ι(ν) = ι(nν) を逆向きに
    _ = (((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) * (((k * k : ℕ) : ℤ) : ℚ)) •
          toRational (logRat (openPartitionValueRat a a q)) :=
          smul_smul _ _ _                                        -- 有理数倍の結合則
    _ = ((1 : ℚ) / ((a : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          congr 1
          push_cast
          field_simp                                             -- ℚ の約分 k²/(k²a²) = 1/a²
    _ = openScaledFreeEntropy a q := rfl                         -- 定義

/-- 準備の第三: `(1/(ka)²)·ι(2k(k-1)a·log q + k²·log Z^op_{a,a}(q)) = (2(k-1)/(ka))·ι(log q) + Ψ^op_a(q)`。 -/
theorem scaled_blockTilingLowerForm_eq (a k : ℕ) [NeZero a] [NeZero k] (q : ℚ) :
    ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
        toRational ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q)) =
      ((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
        openScaledFreeEntropy a q := by
  have ha : (a : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne a)
  have hk : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne k)
  calc
    ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
        toRational ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q))
        = ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            (toRational ((2 * (k * ((k - 1) * a))) • logRat q) +
              toRational ((k * k) • logRat (openPartitionValueRat a a q))) := by
          rw [toRational_add]                                    -- ι は加法を保つ
    _ = ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) • toRational ((2 * (k * ((k - 1) * a))) • logRat q) +
          ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            toRational ((k * k) • logRat (openPartitionValueRat a a q)) := by
          rw [smul_add]                                          -- 有理数倍の分配則
    _ = ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            ((((2 * (k * ((k - 1) * a)) : ℕ) : ℤ) : ℚ) • toRational (logRat q)) +
          ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            toRational ((k * k) • logRat (openPartitionValueRat a a q)) := by
          have e : toRational ((2 * (k * ((k - 1) * a))) • logRat q) =
              (((2 * (k * ((k - 1) * a)) : ℕ) : ℤ) : ℚ) • toRational (logRat q) := by
            rw [← natCast_zsmul, ← toRational_intSmul]           -- n·ι(ν) = ι(nν) を逆向きに
          rw [e]
    _ = (((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) * (((2 * (k * ((k - 1) * a)) : ℕ) : ℤ) : ℚ)) •
            toRational (logRat q) +
          ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            toRational ((k * k) • logRat (openPartitionValueRat a a q)) := by
          rw [smul_smul]                                         -- 有理数倍の結合則
    _ = ((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) •
            toRational ((k * k) • logRat (openPartitionValueRat a a q)) := by
          congr 2
          push_cast
          field_simp                                             -- ℚ の約分 2k(k-1)a/(k²a²) = 2(k-1)/(ka)
    _ = ((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          openScaledFreeEntropy a q := by
          rw [scaled_blockTilingUpperForm_eq]                    -- 準備の第二

/-- `claim_open_square_block_tiling_density` の `0 < q ≤ 1` の場合:
`(2(k-1)/(ka))·ι(log q) + Ψ^op_a(q) ≤_{Λ_ℚ} Ψ^op_{ka}(q) ≤_{Λ_ℚ} Ψ^op_a(q)`。 -/
theorem rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          openScaledFreeEntropy a q)
        (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q) (openScaledFreeEntropy a q) := by
  -- Λ の鎖（claim_open_square_block_tiling_log の 0<q≤1 の場合）
  have hbounds := logOrderLE_openSquareBlockTilingLog_bounds_of_le_one a k
    (Nat.pos_of_ne_zero (NeZero.ne a)) (Nat.one_le_iff_ne_zero.mpr (NeZero.ne k)) hq0 hq1
  constructor
  · -- 準備の第三 → 順序の移送（claim_scaled_embedding_order_transfer の ←）→ 定義
    have h := (rationalLogOrderLE_scaled_toRational_iff (k * a) _ _).mpr hbounds.1
    rw [scaled_blockTilingLowerForm_eq a k q] at h
    exact h
  · -- 定義 → 順序の移送 → 準備の第二
    have h := (rationalLogOrderLE_scaled_toRational_iff (k * a) _ _).mpr hbounds.2
    rw [scaled_blockTilingUpperForm_eq a k q] at h
    exact h

/-- `claim_open_square_block_tiling_density` の `1 ≤ q` の場合:
`Ψ^op_a(q) ≤_{Λ_ℚ} Ψ^op_{ka}(q) ≤_{Λ_ℚ} (2(k-1)/(ka))·ι(log q) + Ψ^op_a(q)`。 -/
theorem rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_one_le
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq : 1 ≤ q) :
    rationalLogOrderLE (openScaledFreeEntropy a q) (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q)
        (((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          openScaledFreeEntropy a q) := by
  -- Λ の鎖（claim_open_square_block_tiling_log の 1≤q の場合）
  have hbounds := logOrderLE_openSquareBlockTilingLog_bounds_of_one_le a k
    (Nat.pos_of_ne_zero (NeZero.ne a)) (Nat.one_le_iff_ne_zero.mpr (NeZero.ne k)) hq
  constructor
  · -- 準備の第二 → 順序の移送 → 定義
    have h := (rationalLogOrderLE_scaled_toRational_iff (k * a) _ _).mpr hbounds.1
    rw [scaled_blockTilingUpperForm_eq a k q] at h
    exact h
  · -- 定義 → 順序の移送 → 準備の第三
    have h := (rationalLogOrderLE_scaled_toRational_iff (k * a) _ _).mpr hbounds.2
    rw [scaled_blockTilingLowerForm_eq a k q] at h
    exact h

end Ising2DLambda.ThermodynamicLimit
