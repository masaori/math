/-
# 対称形の転送行列の射影子移動を必要十分版の特殊化として導く

正本: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
（ラベル **`symmetrized_transfer_matrix_on_sectors`** の最後の段）

人手と 1 対 1 に対応する具体版は `PhysicalSymTransferBridge.lean` の
`symmetrized_transfer_matrix_on_sectors` の、本文の最後の 15 行の鎖に当たる `calc` である。ここでは同じ段
`BV_2BP^{(+)} = CV_2CP^{(+)}` を、必要十分版 `NecSuf.sandwich_mul_proj_eq`（任意の半群）を
`Mat(2^{M_col}, ℂ)` と `P = P^{(+)}` へ特殊化して導く。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.NecSuf.Projector

namespace Ising2D

variable {M : ℕ}

/-- `symmetrized_transfer_matrix_on_sectors` の最後の段の必要十分版 `NecSuf.sandwich_mul_proj_eq` からの導出。 -/
theorem sandwich_mul_epsProjPlus_eq_of_necSuf {B C V : TensorPow M}
    (hBP : B * epsProjPlus M = C * epsProjPlus M) (hCP : Commute C (epsProjPlus M))
    (hVP : Commute V (epsProjPlus M)) :
    B * V * B * epsProjPlus M = C * V * C * epsProjPlus M :=
  NecSuf.sandwich_mul_proj_eq hBP hCP hVP

end Ising2D
