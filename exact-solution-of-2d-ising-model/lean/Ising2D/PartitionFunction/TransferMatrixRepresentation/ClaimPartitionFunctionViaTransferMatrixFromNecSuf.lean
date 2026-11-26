/-
# 転送行列の積の冪のトレースの展開を必要十分版の系として導く

正本: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
（ラベル **`partition_function_via_transfer_matrix`** の中間目標「行列の冪の成分」と「トレースの展開」）

人手と 1 対 1 に対応する証明は `Ising2D.partition_function_via_transfer_matrix`
（`PartitionFunction/TransferMatrixRepresentation/ClaimPartitionFunctionViaTransferMatrix.lean`）の中の `hpow`・`htrace` である。
ここでは `htrace` と同じ等式を、必要十分版 `Ising2D.NecSuf.trace_pow_succ`（`NecSuf/TracePathSum.lean`。任意の可換半環上の
有限添字の行列）を `R = ℂ`、添字 `Conf M`、`A = V_1V_2` に特殊化して得る。人手の行方向の周期規約に当たる巡回後者は、
具体版の `nextSite` と必要十分版の `NecSuf.cycSucc` が同じ定義である（`nextSite_eq_cycSucc`）。
-/
import Ising2D.NecSuf.TracePathSum
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimPartitionFunctionViaTransferMatrix

namespace Ising2D

variable {M : ℕ}

/-- 具体版の巡回後者 `nextSite` は必要十分版の巡回後者 `NecSuf.cycSucc` と同じ定義である。 -/
theorem nextSite_eq_cycSucc {n : ℕ} : (nextSite : Fin n → Fin n) = NecSuf.cycSucc := rfl

/-- `partition_function_via_transfer_matrix` の中間目標「トレースの展開」を、必要十分版 `NecSuf.trace_pow_succ` の特殊化として得たもの。 -/
theorem trace_V1_mul_V2_pow_succ_of_necSuf (K1 K2 : ℝ) (n : ℕ) :
    ((V1 M K1 * V2 M K2) ^ (n + 1)).trace
      = ∑ s : Fin (n + 1) → Conf M, ∏ k : Fin (n + 1),
          (V1 M K1 * V2 M K2) (s k) (s (nextSite k)) := by
  rw [nextSite_eq_cycSucc]
  exact NecSuf.trace_pow_succ _ n

end Ising2D
