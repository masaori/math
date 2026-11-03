/-
# 相異なるサイトに置いた Pauli 行列は可換（具体版を必要十分版から導く）

具体版 `DefinitionTransferMatrixSymbols.lean` の `siteOp_mul_comm`（人手 `distinct_site_pauli_matrices_commute`）を、必要十分版
`Ising2D/NecSuf/SitewiseCommute.lean` の `update_mul_comm_of_ne` の `P := siteProd M`、`R := Mat(2, ℂ)` の特殊化として得る。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.NecSuf.SitewiseCommute

namespace Ising2D

/-- `distinct_site_pauli_matrices_commute` を `NecSuf.update_mul_comm_of_ne`（`P := siteProd M`）の特殊化として得る。 -/
theorem siteOp_mul_comm_of_necSuf {M : ℕ} {k l : Fin M} (hkl : k ≠ l) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A * siteOp l B = siteOp l B * siteOp k A :=
  NecSuf.update_mul_comm_of_ne (siteProd M) (siteProd_mul M) hkl A B

end Ising2D
