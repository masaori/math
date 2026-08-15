/-
人手証明「有限系の自由エントロピー密度の上からの評価」（`claim_finite_free_entropy_density_upper_bound`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `Ψ_L(q) ≤_{Λ_ℚ} ι(ℓ_2) + 2·ι(log(1+q))`。
準備の第一: `Z_L(q) ∈ ℚ_{>0}`（`partitionPolynomial_eval_pos`）、`Z_L(q) ≤ 2^{L²}(1+q)^{2L²}`
            （`partitionPolynomial_eval_rat_le_upperBound`）。
準備の第二: `log 2 = ℓ_2`（`logRat_two`。各素数での鎖は `AtOne.lean` にある）。
準備の第三: `n·ι(ν) = ι(nν)`（`toRational_intSmul`）。
Λ の鎖（`logRat_upperBound_eq` と `logOrderLE_freeEntropy_upperBound`）:
  Φ_L(q) = log Z_L(q)                                   （定義）
         ≤_Λ log(2^{L²}·(1+q)^{2L²})                    （`logRat_le_iff` の →。準備の第一を移す）
         = log 2^{L²} + log (1+q)^{2L²}                 （`logRat_mul`）
         = L²·log 2 + 2L²·log(1+q)                      （`logRat_pow` を二項へ）
         = L²·ℓ_2 + 2L²·log(1+q)                        （準備の第二）
Λ_ℚ の鎖（`scaled_toRational_upperBound_eq` と `rationalLogOrderLE_scaledFreeEntropy_upperBound`）:
  Ψ_L(q) = (1/L²)·ι(Φ_L(q))                             （定義）
         ≤_{Λ_ℚ} (1/L²)·ι(L²ℓ_2 + 2L² log(1+q))          （`rationalLogOrderLE_scaled_toRational_iff` の ←）
         = (1/L²)·(ι(L²ℓ_2) + ι(2L² log(1+q)))          （`toRational_add`）
         = (1/L²)·ι(L²ℓ_2) + (1/L²)·ι(2L² log(1+q))     （有理数倍の分配則 `smul_add`）
         = (1/L²)·(L²·ι(ℓ_2)) + (1/L²)·(2L²·ι(log(1+q)))（準備の第三を二項へ）
         = ((1/L²)·L²)·ι(ℓ_2) + ((1/L²)·2L²)·ι(log(1+q))（有理数倍の結合則 `smul_smul`）
         = 1·ι(ℓ_2) + 2·ι(log(1+q))                     （ℚ の約分）
         = ι(ℓ_2) + 2·ι(log(1+q))                       （`one_smul`）
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.FreeEntropy.AtOne
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBoundRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy PartitionPolynomial

/-- 上界の対数を二項へ開く（Λ の鎖の第三〜五段）:
`log(2^{L²}·(1+q)^{2L²}) = L²·ℓ_2 + 2L²·log(1+q)`。 -/
theorem logRat_upperBound_eq (L : ℕ) {q : ℚ} (hq : 0 < q) :
    logRat (((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2)) =
      (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q) := by
  have h1q : 0 < 1 + q := by linarith
  have h2 : (0 : ℚ) < 2 := by norm_num
  calc
    logRat (((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2))
        = logRat ((2 : ℚ) ^ (L ^ 2) * (1 + q) ^ (2 * L ^ 2)) := by push_cast; rfl
    _ = logRat ((2 : ℚ) ^ (L ^ 2)) + logRat ((1 + q) ^ (2 * L ^ 2)) :=
          logRat_mul (pow_pos h2 _) (pow_pos h1q _)              -- 加法性
    _ = (L ^ 2) • logRat 2 + (2 * L ^ 2) • logRat (1 + q) := by
          rw [logRat_pow h2, logRat_pow h1q]                     -- 冪（二項へ同時適用）
    _ = (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q) := by
          rw [logRat_two]                                        -- 準備の第二

/-- Λ の鎖: `Φ_L(q) ≤_Λ L²·ℓ_2 + 2L²·log(1+q)`。 -/
theorem logOrderLE_freeEntropy_upperBound (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    logOrderLE (freeEntropy L q)
      ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q)) := by
  have h1q : 0 < 1 + q := by linarith
  -- 準備の第一
  have hZpos : 0 < Polynomial.aeval q (partitionPolynomial L) := partitionPolynomial_eval_pos L hq
  have hBpos : 0 < ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) :=
    mul_pos (by positivity) (pow_pos h1q _)
  have hZle := partitionPolynomial_eval_rat_le_upperBound L hq
  -- log Z_L(q) ≤_Λ log(2^{L²}(1+q)^{2L²})（対数は順序を保つ）
  have h := (logRat_le_iff hZpos hBpos).mp hZle
  -- 上界の対数を二項へ開く
  rw [logRat_upperBound_eq L hq] at h
  exact h

/-- Λ_ℚ の鎖の第三〜八段:
`(1/L²)·ι(L²ℓ_2 + 2L² log(1+q)) = ι(ℓ_2) + 2·ι(log(1+q))`。 -/
theorem scaled_toRational_upperBound_eq (L : ℕ) [NeZero L] (q : ℚ) :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q)) =
      toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) := by
  have hL : ((L : ℚ) ^ 2) ≠ 0 := pow_ne_zero 2 (Nat.cast_ne_zero.mpr (NeZero.ne L))
  calc
    ((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q))
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) •
            (toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩) +
              toRational ((2 * L ^ 2) • logRat (1 + q))) := by
          rw [toRational_add]                                    -- ι は加法を保つ
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational ((2 * L ^ 2) • logRat (1 + q)) := by
          rw [smul_add]                                          -- 有理数倍の分配則
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) • ((((L ^ 2 : ℕ) : ℤ) : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩)) +
          ((1 : ℚ) / ((L : ℚ) ^ 2)) • ((((2 * L ^ 2 : ℕ) : ℤ) : ℚ) • toRational (logRat (1 + q))) := by
          rw [toRational_intSmul, toRational_intSmul, natCast_zsmul, natCast_zsmul]  -- 準備の第三（二項へ）
    _ = (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((L ^ 2 : ℕ) : ℤ) : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((1 : ℚ) / ((L : ℚ) ^ 2)) * (((2 * L ^ 2 : ℕ) : ℤ) : ℚ)) • toRational (logRat (1 + q)) := by
          rw [smul_smul, smul_smul]                              -- 有理数倍の結合則
    _ = (1 : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (2 : ℚ) • toRational (logRat (1 + q)) := by
          have hL0 : (L : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (NeZero.ne L)
          congr 2 <;> push_cast <;> field_simp                   -- ℚ の約分
    _ = toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) := by
          rw [one_smul]                                          -- 1·λ = λ

/-- `claim_finite_free_entropy_density_upper_bound`。`Ψ_L(q) ≤_{Λ_ℚ} ι(ℓ_2) + 2·ι(log(1+q))`。 -/
theorem rationalLogOrderLE_scaledFreeEntropy_upperBound (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    rationalLogOrderLE (scaledFreeEntropy L q)
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  -- (1/L²)·ι(Φ_L(q)) ≤_{Λ_ℚ} (1/L²)·ι(L²ℓ_2 + 2L² log(1+q))（順序の移送の ←）
  have h : rationalLogOrderLE (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (freeEntropy L q))
      (((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q))) :=
    (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr (logOrderLE_freeEntropy_upperBound L hq)
  -- 右辺を ι(ℓ_2) + 2·ι(log(1+q)) へ
  rw [scaled_toRational_upperBound_eq] at h
  exact h

end Ising2DLambda.ThermodynamicLimit
