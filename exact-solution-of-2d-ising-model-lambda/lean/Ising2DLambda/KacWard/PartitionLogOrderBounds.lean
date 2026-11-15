/-
「分配多項式の両側評価を対数順序群の鎖へ移す」（`claim_partition_log_order_bounds`）の具体版。
`0 < q < 1` なら `log M^abs_L(q) − 2ℓ₂ ≤_Λ Φ_L(q) ≤_Λ log M^abs_L(q) + ℓ₂`。

  人手証明                                                    このファイル・引く具体版
  `q² + 2q − 1 ≠ 0`: 零なら `(q+1)² = 2`（`claim_no_rational_square_two` に反する）
                                                              `FisherZero.noRationalSquareTwo`
  有理数の全順序で符号による二場合に分ける                     `lt_or_gt_of_ne`
  `q² + 2q − 1 < 0`: 四つの値は正（`claim_signed_even_subgraph_rational_sign`）なので
    `M^abs_L(q) = M_L(q)`                                      `absMax_eq_max_of_pos`
    `claim_low_temperature_partition_bounds` から `M^abs_L(q)/4 ≤ Z_L(q) ≤ 2 M^abs_L(q)`
                                                              `lowTemperaturePartitionBounds`
  `q² + 2q − 1 > 0`: `claim_high_temperature_partition_bounds` が同じ不等式を与える
                                                              `highTemperaturePartitionBounds`
  `Z_L(q) > 0`（`claim_value_at_rational_is_positive`）と上界から `M^abs_L(q) > 0`
                                                              `partitionValue_pos`
  有理数の両側評価から `Λ` の鎖                                `partitionLogOrderTransfer`

必要十分版の定理・定義は使わない。住処は ℚ と Λ（四つの値の符号の判定だけ実閉部分体 R ⊂ Qbar を通る）。
実数体・複素数体・実対数は現れない。
-/
import Ising2DLambda.KacWard.PartitionLogOrderTransfer
import Ising2DLambda.KacWard.HighTemperaturePartitionBounds
import Ising2DLambda.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.FreeEntropy

/-- `q² + 2q − 1 ≠ 0`（零なら `(q+1)·(q+1) = 2`）。 -/
theorem selfDualQuadratic_ne_zero (q : ℚ) : q ^ 2 + 2 * q - 1 ≠ 0 := by
  intro h
  -- `(q+1)² = q² + 2q + 1 = 2`
  have h2 : (q + 1) * (q + 1) = 2 := by linear_combination h
  exact Ising2DLambda.FisherZero.noRationalSquareTwo (q + 1) h2

/-- 四つの値が正なら `M^abs_L(q) = M_L(q)`。 -/
theorem absMax_eq_max_of_pos (L : ℕ) [NeZero L] (q : ℚ)
    (hpos : ∀ s : SpinStructure, 0 < signedEvenSubgraphValue L q s) :
    signedEvenSubgraphAbsMax L q = signedEvenSubgraphMax L q := by
  rw [signedEvenSubgraphAbsMax, signedEvenSubgraphMax]
  congr 1
  funext s
  exact abs_of_pos (hpos s)

/-- 有理数での両側評価 `M^abs_L(q)/4 ≤ Z_L(q) ≤ 2 M^abs_L(q)`（符号による二場合を合わせたもの）。 -/
theorem partitionRationalBounds (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    signedEvenSubgraphAbsMax L q / 4 ≤ partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q := by
  rcases lt_or_gt_of_ne (selfDualQuadratic_ne_zero q) with hc | hc
  · -- 低温側: 四つの値は正なので `M^abs_L(q) = M_L(q)`
    have hpos : ∀ s : SpinStructure, 0 < signedEvenSubgraphValue L q s := fun s =>
      (signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc
    have heq := absMax_eq_max_of_pos L q hpos
    obtain ⟨hlow, hup⟩ := lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc
    rw [← heq] at hlow hup
    -- `M^abs_L(q) > 0`（最大は正の値の一つ）
    have hM : 0 < signedEvenSubgraphAbsMax L q := by
      rw [heq]
      exact lt_of_lt_of_le (hpos (false, false))
        (Finset.le_sup' (signedEvenSubgraphValue L q) (Finset.mem_univ _))
    -- `M^abs_L(q)/4 ≤ M^abs_L(q)/2 ≤ Z_L(q)`
    exact ⟨by linarith, hup⟩
  · -- 高温側
    exact highTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc

/-- 具体版: `0 < q < 1` なら `log M^abs_L(q) − 2ℓ₂ ≤_Λ Φ_L(q) ≤_Λ log M^abs_L(q) + ℓ₂`。 -/
theorem partitionLogOrderBounds (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2) := by
  obtain ⟨hlow, hup⟩ := partitionRationalBounds (L := L) data z hz4 q hq0 hq1
  -- `Z_L(q) > 0` と上界 `Z_L(q) ≤ 2 M^abs_L(q)` から `M^abs_L(q) > 0`
  have hZ : 0 < partitionValue L q := partitionValue_pos L hq0
  have hM : 0 < signedEvenSubgraphAbsMax L q := by linarith
  exact partitionLogOrderTransfer q hq0 hM hlow hup

end Ising2DLambda.KacWard
