/-
人手証明「開境界正方形と部分正方形の比較による密度の挟み込み（Λ_ℚ 版。q は 1 以下）」
（`claim_open_square_subsquare_comparison_density_le_one`）の具体版。

`1 ≤ a < L`、`0 < q ≤ 1` について、
  `((a+L)/L²)·ι(log q) + (a²/L²)·Ψ^op_a(q)
     ≤_{Λ_ℚ} Ψ^op_L(q)
     ≤_{Λ_ℚ} ((L²−a²)/L²)·ι(ℓ_2) + (2(L²−a²)/L²)·ι(log(1+q)) + (a²/L²)·Ψ^op_a(q)`。
  人手証明の段                                                このファイル
  準備の第一: 値の正値性・a² ≠ 0・L² ≠ 0                        `[NeZero a] [NeZero L]`（値の正値性は Λ の鎖の側で使う）
  準備の第二: (1/L²)·ι(log Z^op_{a,a}(q)) = (a²/L²)·Ψ^op_a(q)   scaled_subsquareBlockDensity_eq（三段）
  準備の第三: 下からの評価の側の元の像（六段）                  scaled_subsquareLowerForm_eq
  準備の第四: 上からの評価の側の元の像（六段）                  scaled_subsquareUpperForm_eq
  本体（左右の不等式を 3 段の鎖 2 本）                          rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one
準備の等式 → `rationalLogOrderLE_scaled_toRational_iff L` の ← で
`claim_open_square_subsquare_comparison_log_le_one` の Λ の比較を移す → 定義 `openScaledFreeEntropy`。
`L² − a²` は自然数の引き算のまま扱う（`a < L` なので切り捨ては起きない）。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensity
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: `(1/L²)·ι(log Z^op_{a,a}(q)) = (a²/L²)·Ψ^op_a(q)`。 -/
theorem scaled_subsquareBlockDensity_eq (a L : ℕ) [NeZero a] [NeZero L] (q : ℚ) :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) =
      (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := by
  have ha : (a : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne a)
  calc
    ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q))
        = ((((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) * ((1 : ℚ) / ((a : ℚ) ^ 2))) •
            toRational (logRat (openPartitionValueRat a a q)) := by
          congr 1
          field_simp                                             -- ℚ の約分 (a²/L²)·(1/a²) = 1/L² を逆向きに
    _ = (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) •
          (((1 : ℚ) / ((a : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q))) :=
          (smul_smul _ _ _).symm                                 -- 有理数倍の結合則
    _ = (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := rfl   -- 定義を L := a で

/-- 準備の第三: `(1/L²)·ι((a+L)·log q + log Z^op_{a,a}(q)) = ((a+L)/L²)·ι(log q) + (a²/L²)·Ψ^op_a(q)`。 -/
theorem scaled_subsquareLowerForm_eq (a L : ℕ) [NeZero a] [NeZero L] (q : ℚ) :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((a + L) • logRat q + logRat (openPartitionValueRat a a q)) =
      (((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
        (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := by
  calc
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((a + L) • logRat q + logRat (openPartitionValueRat a a q))
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            (toRational ((a + L) • logRat q) + toRational (logRat (openPartitionValueRat a a q))) := by
          rw [toRational_add]                                    -- ι は加法を保つ
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((a + L) • logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          rw [smul_add]                                          -- 有理数倍の分配則
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • ((((a + L : ℕ) : ℤ) : ℚ) • toRational (logRat q)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          have e : toRational ((a + L) • logRat q) =
              (((a + L : ℕ) : ℤ) : ℚ) • toRational (logRat q) := by
            rw [← natCast_zsmul, ← toRational_intSmul]           -- n·ι(ν) = ι(nν) を逆向きに
          rw [e]
    _ = (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((a + L : ℕ) : ℤ) : ℚ)) • toRational (logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          rw [smul_smul]                                         -- 有理数倍の結合則
    _ = (((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          congr 2
          push_cast
          ring                                                   -- ℚ の積 (1/L²)·(a+L) = (a+L)/L²
    _ = (((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := by
          rw [scaled_subsquareBlockDensity_eq]                   -- 準備の第二

/-- 準備の第四: `(1/L²)·ι(n·ℓ_2 + 2n·log(1+q) + log Z^op_{a,a}(q))
  = (n/L²)·ι(ℓ_2) + (2n/L²)·ι(log(1+q)) + (a²/L²)·Ψ^op_a(q)`（`n := L² − a²`）。 -/
theorem scaled_subsquareUpperForm_eq (a L : ℕ) [NeZero a] [NeZero L] (q : ℚ) :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
          (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q)) =
      (((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
        (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
        (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := by
  calc
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
          (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q))
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            (toRational ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩) +
              toRational ((2 * (L ^ 2 - a ^ 2)) • logRat (1 + q)) +
              toRational (logRat (openPartitionValueRat a a q))) := by
          rw [toRational_add, toRational_add]                    -- ι は加法を保つ（二回）
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((2 * (L ^ 2 - a ^ 2)) • logRat (1 + q)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          rw [smul_add, smul_add]                                -- 有理数倍の分配則（二回）
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            ((((L ^ 2 - a ^ 2 : ℕ) : ℤ) : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            ((((2 * (L ^ 2 - a ^ 2) : ℕ) : ℤ) : ℚ) • toRational (logRat (1 + q))) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          have e1 : toRational ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩) =
              (((L ^ 2 - a ^ 2 : ℕ) : ℤ) : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩) := by
            rw [← natCast_zsmul, ← toRational_intSmul]           -- n·ι(ν) = ι(nν) を逆向きに
          have e2 : toRational ((2 * (L ^ 2 - a ^ 2)) • logRat (1 + q)) =
              (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℤ) : ℚ) • toRational (logRat (1 + q)) := by
            rw [← natCast_zsmul, ← toRational_intSmul]           -- 同上（二項へ同時）
          rw [e1, e2]
    _ = (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((L ^ 2 - a ^ 2 : ℕ) : ℤ) : ℚ)) •
            toRational (generator ⟨2, Nat.prime_two⟩) +
          (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℤ) : ℚ)) •
            toRational (logRat (1 + q)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          rw [smul_smul, smul_smul]                              -- 有理数倍の結合則（二項へ同時）
    _ = (((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat a a q)) := by
          congr 2
          · congr 1
            push_cast
            ring                                                 -- ℚ の積 (1/L²)·n = n/L²
          · congr 1
            push_cast
            ring                                                 -- ℚ の積 (1/L²)·2n = 2n/L²
    _ = (((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q := by
          rw [scaled_subsquareBlockDensity_eq]                   -- 準備の第二

/-- `claim_open_square_subsquare_comparison_density_le_one`:
`((a+L)/L²)·ι(log q) + (a²/L²)·Ψ^op_a(q) ≤_{Λ_ℚ} Ψ^op_L(q)
 ≤_{Λ_ℚ} ((L²−a²)/L²)·ι(ℓ_2) + (2(L²−a²)/L²)·ι(log(1+q)) + (a²/L²)·Ψ^op_a(q)`。 -/
theorem rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        ((((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q)
        (openScaledFreeEntropy L q) ∧
      rationalLogOrderLE (openScaledFreeEntropy L q)
        ((((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q) := by
  -- Λ の鎖（claim_open_square_subsquare_comparison_log_le_one）
  have hbounds := logOrderLE_openSquareSubsquareLog_bounds_of_le_one a L
    (Nat.pos_of_ne_zero (NeZero.ne a)) haL hq0 hq1
  constructor
  · -- 準備の第三 → 順序の移送（claim_scaled_embedding_order_transfer の ←）→ 定義
    have h := (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr hbounds.1
    rw [scaled_subsquareLowerForm_eq a L q] at h
    exact h
  · -- 定義 → 順序の移送 → 準備の第四
    have h := (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr hbounds.2
    rw [scaled_subsquareUpperForm_eq a L q] at h
    exact h

end Ising2DLambda.ThermodynamicLimit
