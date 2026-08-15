/-
人手証明「有限系の自由エントロピー密度は非負である」（`claim_finite_free_entropy_density_nonnegative`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `0 ≤_{Λ_ℚ} Ψ_L(q)`。
準備の第一: `Z_L(q) ∈ ℚ_{>0}`（`partitionPolynomial_eval_pos`）、`1 ≤ Z_L(q)`（`one_le_partitionPolynomial_eval_rat`）。
準備の第二: `log 1 = 0`（`logRat_one`。`claim_log_power` の `k = 0`）。
準備の第三: `(1/L^2)·ι(0) = 0`（各素数での五段の鎖 `scaled_toRational_zero`）。
Λ の鎖:   `0 = log 1 ≤_Λ log Z_L(q) = Φ_L(q)`（`logRat_le_iff` の → を `q := 1`、`q' := Z_L(q)` で読む）。
Λ_ℚ の鎖: `0 = (1/L^2)·ι(0) ≤_{Λ_ℚ} (1/L^2)·ι(Φ_L(q)) = Ψ_L(q)`
          （`rationalLogOrderLE_scaled_toRational_iff` の ← を `λ := 0`、`μ := Φ_L(q)` で読む）。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.PartitionValueGeOneRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy PartitionPolynomial

/-- 準備の第三: `(1/L^2)·ι(0) = 0`。写像の等号は各素数での値の等号（五段の鎖）。 -/
theorem scaled_toRational_zero (L : ℕ) [NeZero L] :
    ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (0 : LogOrderGroup) = (0 : RationalLogOrderGroup) := by
  ext p
  calc
    (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (0 : LogOrderGroup)) p
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) * toRational (0 : LogOrderGroup) p :=
          Finsupp.smul_apply _ _ _                              -- 有理数倍の定義
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) * (((0 : LogOrderGroup) p : ℤ) : ℚ) := by
          rw [toRational_apply]                                 -- ι の定義
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) * ((0 : ℤ) : ℚ) := by
          rw [Finsupp.zero_apply]                               -- Λ の単位元は零写像
    _ = 0 := by rw [Int.cast_zero, mul_zero]                    -- ℚ の積。0 倍は 0
    _ = (0 : RationalLogOrderGroup) p := Finsupp.zero_apply.symm  -- Λ_ℚ の単位元は零写像

/-- Λ の鎖: `0 = log 1 ≤_Λ log Z_L(q) = Φ_L(q)`。 -/
theorem logOrderLE_zero_freeEntropy (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    logOrderLE 0 (freeEntropy L q) := by
  -- 準備の第一
  have hZpos : 0 < Polynomial.aeval q (partitionPolynomial L) := partitionPolynomial_eval_pos L hq
  have hZone : 1 ≤ Polynomial.aeval q (partitionPolynomial L) :=
    one_le_partitionPolynomial_eval_rat L hq
  -- log 1 ≤_Λ log Z_L(q)（対数は順序を保つ。1 ≤ Z_L(q) を移す）
  have h : logOrderLE (logRat 1) (logRat (Polynomial.aeval q (partitionPolynomial L))) :=
    (logRat_le_iff one_pos hZpos).mp hZone
  -- 0 = log 1（準備の第二）、log Z_L(q) = Φ_L(q)（定義）
  rw [logRat_one] at h
  exact h

/-- `claim_finite_free_entropy_density_nonnegative`。`0 ≤_{Λ_ℚ} Ψ_L(q)`。 -/
theorem rationalLogOrderLE_zero_scaledFreeEntropy (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    rationalLogOrderLE 0 (scaledFreeEntropy L q) := by
  -- (1/L^2)·ι(0) ≤_{Λ_ℚ} (1/L^2)·ι(Φ_L(q))（順序の移送の ← を λ := 0、μ := Φ_L(q) で読む）
  have h : rationalLogOrderLE (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (0 : LogOrderGroup))
      (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (freeEntropy L q)) :=
    (rationalLogOrderLE_scaled_toRational_iff L 0 (freeEntropy L q)).mpr
      (logOrderLE_zero_freeEntropy L hq)
  -- 0 = (1/L^2)·ι(0)（準備の第三）、(1/L^2)·ι(Φ_L(q)) = Ψ_L(q)（定義）
  rw [scaled_toRational_zero] at h
  exact h

end Ising2DLambda.ThermodynamicLimit
