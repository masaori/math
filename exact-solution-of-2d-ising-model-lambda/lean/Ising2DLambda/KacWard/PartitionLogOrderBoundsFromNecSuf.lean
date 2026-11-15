import Ising2DLambda.KacWard.PartitionLogOrderBounds
import Ising2DLambda.NecSuf.KacWard.PartitionLogOrderBounds

/-!
具体版 `partitionLogOrderBounds`（`claim_partition_log_order_bounds`）を必要十分版から得る導出版。

`K = ℚ`、`G = Λ`、`le = ≤_Λ`、`lg = log`、`ι = 𝒮`、`f = Q^{·}_L(q)`、`Z = Z_L(q)` に特殊化する。
`2` の平方根が無いことは `noRationalSquareTwo`、低温側の三つの仮定は
`signedEvenSubgraphPolynomial_rational_sign` と `lowTemperaturePartitionBounds`、
高温側は `highTemperaturePartitionBounds`、`Z_L(q) > 0` は `partitionValue_pos` から取る。
`Φ_L(q) = log Z_L(q)` は `freeEntropy_eq_logRat_partitionValue` で書き換える。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.FreeEntropy

theorem partitionLogOrderBounds_from_necSuf (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2) := by
  rw [freeEntropy_eq_logRat_partitionValue]
  exact Ising2DLambda.NecSuf.KacWard.partition_log_order_bounds_necSuf
    spinStructure_univ_nonempty Ising2DLambda.FisherZero.noRationalSquareTwo
    logOrderLE logRat (fun ha hb h => (logRat_le_iff ha hb).1 h)
    (fun ha hb => logRat_mul ha hb) (fun h n => logOrderLE_add_right h n)
    q (partitionValue L q) (signedEvenSubgraphValue L q) (partitionValue_pos L hq0)
    (fun hc s => (signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc)
    (fun hc => (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).1)
    (fun hc => (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).2)
    (fun hc => highTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc)

end Ising2DLambda.KacWard
