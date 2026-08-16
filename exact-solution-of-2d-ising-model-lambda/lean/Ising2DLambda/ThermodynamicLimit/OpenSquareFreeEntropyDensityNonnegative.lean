/-
人手証明「開境界正方形の自由エントロピー密度は非負である」
（`claim_open_square_free_entropy_density_nonnegative`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `0 ≤_{Λ_ℚ} Ψ^op_L(q)`。
準備の第一: `Z^op_{L,L}(q) ∈ ℚ_{>0}`（`openPartitionValueRat_pos`）、
            `1 ≤ Z^op_{L,L}(q)`（`one_le_openPartitionValueRat` を `a := L`、`b := L` で）。
準備の第二: `log 1 = 0`（`logRat_one`。`claim_log_power` の `k = 0`）。
準備の第三: `(1/L^2)·ι(0) = 0`（周期境界と同じ五段の鎖 `scaled_toRational_zero` を共有）。
Λ の鎖:   `0 = log 1 ≤_Λ log Z^op_{L,L}(q)`（`logRat_le_iff` の → を `q := 1`、`q' := Z^op_{L,L}(q)` で読む）。
Λ_ℚ の鎖: `0 = (1/L^2)·ι(0) ≤_{Λ_ℚ} (1/L^2)·ι(log Z^op_{L,L}(q)) = Ψ^op_L(q)`
          （`rationalLogOrderLE_scaled_toRational_iff` の ← を `λ := 0`、`μ := log Z^op_{L,L}(q)` で読む）。
周期境界の `FiniteFreeEntropyDensityNonnegative.lean` と同じ手順で、`freeEntropy L q` の代わりに
`logRat (openPartitionValueRat L L q)` を置いたものである。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.FiniteFreeEntropyDensityNonnegative
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensity
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueGeOneRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- Λ の鎖: `0 = log 1 ≤_Λ log Z^op_{L,L}(q)`。 -/
theorem logOrderLE_zero_logRat_openPartitionValueRat (L : ℕ) {q : ℚ} (hq : 0 < q) :
    logOrderLE 0 (logRat (openPartitionValueRat L L q)) := by
  -- 準備の第一
  have hZpos : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq
  have hZone : 1 ≤ openPartitionValueRat L L q := one_le_openPartitionValueRat L L hq
  -- log 1 ≤_Λ log Z^op_{L,L}(q)（対数は順序を保つ。1 ≤ Z^op_{L,L}(q) を移す）
  have h : logOrderLE (logRat 1) (logRat (openPartitionValueRat L L q)) :=
    (logRat_le_iff one_pos hZpos).mp hZone
  -- 0 = log 1（準備の第二）
  rw [logRat_one] at h
  exact h

/-- `claim_open_square_free_entropy_density_nonnegative`。`0 ≤_{Λ_ℚ} Ψ^op_L(q)`。 -/
theorem rationalLogOrderLE_zero_openScaledFreeEntropy (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    rationalLogOrderLE 0 (openScaledFreeEntropy L q) := by
  -- (1/L^2)·ι(0) ≤_{Λ_ℚ} (1/L^2)·ι(log Z^op_{L,L}(q))（順序の移送の ← を λ := 0、μ := log Z^op で読む）
  have h : rationalLogOrderLE (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (0 : LogOrderGroup))
      (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q))) :=
    (rationalLogOrderLE_scaled_toRational_iff L 0 (logRat (openPartitionValueRat L L q))).mpr
      (logOrderLE_zero_logRat_openPartitionValueRat L hq)
  -- 0 = (1/L^2)·ι(0)（準備の第三）、(1/L^2)·ι(log Z^op_{L,L}(q)) = Ψ^op_L(q)（定義）
  rw [scaled_toRational_zero] at h
  exact h

end Ising2DLambda.ThermodynamicLimit
