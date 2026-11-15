import Ising2DLambda.KacWard.PartitionLogOrderTransfer
import Ising2DLambda.NecSuf.KacWard.PartitionLogOrderTransfer

/-!
具体版 `partitionLogOrderTransfer`（`claim_partition_log_order_bounds` の、Λ の鎖へ移す段）を、
必要十分版から得る導出版。

`K = ℚ`、`G = Λ`、`le = ≤_Λ`、`lg = log`、`M = M^abs_L(q)`、`Z = Z_L(q)` に特殊化する。
`lg` が正の元の上で順序を保つことは `logRat_le_iff` の右向き、積の法則は `logRat_mul`、
加法の単調性は `logOrderLE_add_right`、`Z_L(q) > 0` は `partitionValue_pos` から取る。
`Φ_L(q) = log Z_L(q)` は `freeEntropy_eq_logRat_partitionValue` で書き換える。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.FreeEntropy

theorem partitionLogOrderTransfer_from_necSuf {L : ℕ} [NeZero L] (q : ℚ) (hq0 : 0 < q)
    (hM : 0 < signedEvenSubgraphAbsMax L q)
    (hlow : signedEvenSubgraphAbsMax L q / 4 ≤ partitionValue L q)
    (hup : partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q) :
    logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2) := by
  rw [freeEntropy_eq_logRat_partitionValue]
  exact Ising2DLambda.NecSuf.KacWard.log_order_transfer_of_two_sided_bounds_necSuf
    logOrderLE logRat (fun ha hb h => (logRat_le_iff ha hb).1 h)
    (fun ha hb => logRat_mul ha hb) (fun h n => logOrderLE_add_right h n)
    (signedEvenSubgraphAbsMax L q) (partitionValue L q) hM (partitionValue_pos L hq0) hlow hup

end Ising2DLambda.KacWard
