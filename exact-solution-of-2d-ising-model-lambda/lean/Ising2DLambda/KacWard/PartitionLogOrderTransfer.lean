/-
「分配多項式の両側評価を対数順序群の鎖へ移す」（`claim_partition_log_order_bounds`）のうち、
有理数での両側評価 `M^abs_L(q)/4 ≤ Z_L(q) ≤ 2 M^abs_L(q)` から `Λ` の鎖を得る段の具体版。

  人手証明                                                    このファイル・引く具体版
  `M^abs_L(q) := max_{(a,b)∈𝒮} |Q^{a,b}_L(q)|`                  `signedEvenSubgraphAbsMax`
  `Z_L(q) > 0`（`claim_value_at_rational_is_positive`）           `FreeEntropy.partitionPolynomial_eval_pos`
  `Φ_L(q) = log Z_L(q)`（`def_finite_free_entropy`）              `freeEntropy_eq_logRat_partitionValue`
  下界の鎖
    `M^abs_L(q) ≤ 4 Z_L(q)`（`M^abs_L(q)/4 ≤ Z_L(q)`）            ℚ の正の数倍
    `log M^abs_L(q) ≤_Λ log(4 Z_L(q))`（`claim_rational_log_order_iff`）
                                                                `FreeEntropy.logRat_le_iff`
    `= log 4 + log Z_L(q)`（`claim_log_additive`）                `FreeEntropy.logRat_mul`
    `= 2ℓ₂ + log Z_L(q)`（`claim_log_power`、`ℓ₂ = log 2`）        `FreeEntropy.logRat_pow`
    `= 2ℓ₂ + Φ_L(q)`（`def_finite_free_entropy`）
    両辺に `-2ℓ₂` を加える（`claim_log_order_group_add_monotone`） `FreeEntropy.logOrderLE_add_right`
  上界の鎖
    `Φ_L(q) = log Z_L(q) ≤_Λ log(2 M^abs_L(q))`（`claim_rational_log_order_iff`）
    `= log 2 + log M^abs_L(q)`（`claim_log_additive`）
    `= log M^abs_L(q) + ℓ₂`（`Λ` の加法の交換律）

人手証明の前半（`q² + 2q − 1 ≠ 0`、その符号による二場合、各場合で低温側・高温側の両側評価を引いて
`M^abs_L(q)/4 ≤ Z_L(q) ≤ 2 M^abs_L(q)` と `M^abs_L(q) > 0` を得ること）は、この段の仮定 `hM`・`hlow`・`hup`
として受け、二つの両側評価の具体版を引いて合成する段で与える。
`ℓ₂` は本文の記法どおり `log 2`（`logRat 2`）と書く。必要十分版の定理・定義は使わない。
住処は ℚ と Λ。実数体・複素数体・実対数は現れない。
-/
import Ising2DLambda.KacWard.LowTemperaturePartitionBounds
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.FreeEntropy.LogOrderGroupAddMonotone
import Ising2DLambda.FreeEntropy.Additivity

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.FreeEntropy

/-- `M^abs_L(q) := max_{(a,b)∈𝒮} |Q^{a,b}_L(q)| ∈ ℚ`。 -/
noncomputable def signedEvenSubgraphAbsMax (L : ℕ) [NeZero L] (q : ℚ) : ℚ :=
  Finset.univ.sup' spinStructure_univ_nonempty (fun s => |signedEvenSubgraphValue L q s|)

/-- `Z_L(q)` を係数の写像 `ℤ → ℚ` と評価で書いた値は、`ℤ`-代数としての評価に等しい。 -/
theorem partitionValue_eq_aeval (L : ℕ) [NeZero L] (q : ℚ) :
    partitionValue L q = Polynomial.aeval q (partitionPolynomial L) := by
  rw [partitionValue, Polynomial.aeval_def, Polynomial.eval₂_eq_eval_map, algebraMap_int_eq]

/-- `def_finite_free_entropy`: `Φ_L(q) = log Z_L(q)`。 -/
theorem freeEntropy_eq_logRat_partitionValue (L : ℕ) [NeZero L] (q : ℚ) :
    freeEntropy L q = logRat (partitionValue L q) := by
  rw [freeEntropy, partitionValue_eq_aeval]

/-- `claim_value_at_rational_is_positive`: `0 < q` なら `Z_L(q) > 0`。 -/
theorem partitionValue_pos (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) : 0 < partitionValue L q := by
  rw [partitionValue_eq_aeval]
  exact partitionPolynomial_eval_pos L hq

/-- `claim_log_power` を `2² = 4` に当てたもの: `log 4 = 2ℓ₂`。 -/
theorem logRat_four : logRat 4 = 2 • logRat 2 := by
  have h4 : (4 : ℚ) = 2 ^ 2 := by norm_num
  rw [h4, logRat_pow (by norm_num : (0 : ℚ) < 2) 2]

/-- 具体版: `M^abs_L(q) > 0` と `M^abs_L(q)/4 ≤ Z_L(q) ≤ 2 M^abs_L(q)` から
`log M^abs_L(q) − 2ℓ₂ ≤_Λ Φ_L(q) ≤_Λ log M^abs_L(q) + ℓ₂`。 -/
theorem partitionLogOrderTransfer {L : ℕ} [NeZero L] (q : ℚ) (hq0 : 0 < q)
    (hM : 0 < signedEvenSubgraphAbsMax L q)
    (hlow : signedEvenSubgraphAbsMax L q / 4 ≤ partitionValue L q)
    (hup : partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q) :
    logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2) := by
  -- `Z_L(q) > 0`
  have hZ : 0 < partitionValue L q := partitionValue_pos L hq0
  constructor
  · -- 下界の鎖
    -- `M^abs_L(q) ≤ 4 Z_L(q)`（ℚ の正の数倍）
    have h1 : signedEvenSubgraphAbsMax L q ≤ 4 * partitionValue L q := by linarith
    -- `log M^abs_L(q) ≤_Λ log(4 Z_L(q))`
    have h2 : logOrderLE (logRat (signedEvenSubgraphAbsMax L q))
        (logRat (4 * partitionValue L q)) :=
      (logRat_le_iff hM (by positivity)).1 h1
    -- `log(4 Z_L(q)) = log 4 + log Z_L(q) = 2ℓ₂ + log Z_L(q) = 2ℓ₂ + Φ_L(q)`
    have h3 : logRat (4 * partitionValue L q) = 2 • logRat 2 + freeEntropy L q := by
      rw [logRat_mul (by norm_num) hZ, logRat_four, freeEntropy_eq_logRat_partitionValue]
    rw [h3] at h2
    -- 両辺に `-2ℓ₂ ∈ Λ` を加える
    have h4 := logOrderLE_add_right h2 (-(2 • logRat 2))
    have e1 : logRat (signedEvenSubgraphAbsMax L q) + -(2 • logRat 2)
        = logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2 := by abel
    have e2 : 2 • logRat 2 + freeEntropy L q + -(2 • logRat 2) = freeEntropy L q := by abel
    rw [e1, e2] at h4
    exact h4
  · -- 上界の鎖
    -- `Φ_L(q) = log Z_L(q) ≤_Λ log(2 M^abs_L(q))`
    have h2 : logOrderLE (logRat (partitionValue L q))
        (logRat (2 * signedEvenSubgraphAbsMax L q)) :=
      (logRat_le_iff hZ (by positivity)).1 hup
    -- `log(2 M^abs_L(q)) = log 2 + log M^abs_L(q)`
    rw [← freeEntropy_eq_logRat_partitionValue, logRat_mul (by norm_num) hM] at h2
    -- `Λ` の加法の交換律
    rw [add_comm (logRat 2)] at h2
    exact h2

end Ising2DLambda.KacWard
