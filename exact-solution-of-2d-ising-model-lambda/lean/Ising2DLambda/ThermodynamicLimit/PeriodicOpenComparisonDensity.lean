/-
人手証明「周期境界と開境界の密度の比較（Λ_ℚ 版。q は 1 以下）」
（`claim_periodic_open_boundary_comparison_density_le_one`）の具体版。

`L ≥ 1`、`0 < q ≤ 1` について、
  `Ψ^op_L(q) + (2/L)·ι(log q) ≤_{Λ_ℚ} Ψ_L(q) ≤_{Λ_ℚ} Ψ^op_L(q)`。
  人手証明の段                                                このファイル
  準備の第一: L² ≠ 0（値の正値性は Λ の鎖の側で使う）           `[NeZero L]`
  準備の第二: (1/L²)·ι(2L·log q + log Z^op_{L,L}(q))
              = Ψ^op_L(q) + (2/L)·ι(log q)（七段）              scaled_periodicOpenLowerForm_eq
  本体（左右の不等式を 3 段の鎖 2 本）                          rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one
準備の等式 → `rationalLogOrderLE_scaled_toRational_iff L` の ← で
`claim_periodic_open_boundary_comparison_log_le_one` の Λ の比較を移す → 定義 `scaledFreeEntropy`・`openScaledFreeEntropy`。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensity
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: `(1/L²)·ι(2L·log q + log Z^op_{L,L}(q)) = Ψ^op_L(q) + (2/L)·ι(log q)`。 -/
theorem scaled_periodicOpenLowerForm_eq (L : ℕ) [NeZero L] (q : ℚ) :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((2 * L) • logRat q + logRat (openPartitionValueRat L L q)) =
      openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) := by
  have hL : (L : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne L)
  calc
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((2 * L) • logRat q + logRat (openPartitionValueRat L L q))
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            (toRational ((2 * L) • logRat q) + toRational (logRat (openPartitionValueRat L L q))) := by
          rw [toRational_add]                                    -- ι は加法を保つ
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((2 * L) • logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q)) := by
          rw [smul_add]                                          -- 有理数倍の分配則
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • ((((2 * L : ℕ) : ℤ) : ℚ) • toRational (logRat q)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q)) := by
          have e : toRational ((2 * L) • logRat q) =
              (((2 * L : ℕ) : ℤ) : ℚ) • toRational (logRat q) := by
            rw [← natCast_zsmul, ← toRational_intSmul]           -- n·ι(ν) = ι(nν) を逆向きに
          rw [e]
    _ = (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((2 * L : ℕ) : ℤ) : ℚ)) • toRational (logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q)) := by
          rw [smul_smul]                                         -- 有理数倍の結合則
    _ = ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q)) := by
          congr 2
          push_cast
          field_simp                                             -- ℚ の約分 (1/L²)·2L = 2/L
    _ = ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) + openScaledFreeEntropy L q := rfl
                                                                 -- 定義（def_open_square_free_entropy_density）
    _ = openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) :=
          add_comm _ _                                           -- Λ_ℚ の加法の可換性

/-- `claim_periodic_open_boundary_comparison_density_le_one`:
`Ψ^op_L(q) + (2/L)·ι(log q) ≤_{Λ_ℚ} Ψ_L(q) ≤_{Λ_ℚ} Ψ^op_L(q)`（`0 < q ≤ 1`）。 -/
theorem rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one
    (L : ℕ) [NeZero L] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q))
        (scaledFreeEntropy L q) ∧
      rationalLogOrderLE (scaledFreeEntropy L q) (openScaledFreeEntropy L q) := by
  -- Λ の鎖（claim_periodic_open_boundary_comparison_log_le_one）
  have hbounds := logOrderLE_periodicOpenLog_bounds_of_le_one L hq0 hq1
  constructor
  · -- 準備の第二 → 順序の移送（claim_scaled_embedding_order_transfer の ←）→ 定義
    have h := (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr hbounds.1
    rw [scaled_periodicOpenLowerForm_eq L q] at h
    exact h
  · -- 定義 → 順序の移送 → 定義
    exact (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr hbounds.2

end Ising2DLambda.ThermodynamicLimit
