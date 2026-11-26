/-
# 因子が対角ならクロネッカー積の非対角成分は 0（具体版を必要十分版から導く）

具体版 `ClaimSigmaZDiagonalAction.lean` の `siteProd_diagonal` の非対角成分の段を、必要十分版
`Ising2D/NecSuf/SiteDiagonal.lean` の `NecSuf.prod_entry_eq_zero_of_ne` の
`ι := Fin M`、`κ i := Fin 2`、`R := ℂ`、`d i := Matrix.diagonal (d i)` の特殊化として得る。
人手のラベルは `site_sigma_z_is_diagonal`（正本: `structured-latex/content/partition_function_transfer_matrix_representation.ts`）。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimSigmaZDiagonalAction
import Ising2D.NecSuf.SiteDiagonal

namespace Ising2D

variable {M : ℕ}

/-- `siteProd_diagonal` の非対角成分（`s ≠ t` なら `0_ℂ`）を `NecSuf.prod_entry_eq_zero_of_ne` の特殊化として得る。 -/
theorem siteProd_diagonal_apply_of_ne_of_necSuf (d : Fin M → Fin 2 → ℂ) (s t : Conf M)
    (h : s ≠ t) :
    siteProd M (fun i => Matrix.diagonal (d i)) s t = 0 := by
  rw [siteProd_apply]
  exact NecSuf.prod_entry_eq_zero_of_ne
    (fun i => (Matrix.diagonal (d i) : Matrix (Fin 2) (Fin 2) ℂ))
    (fun _ _ _ hab => Matrix.diagonal_apply_ne _ hab) s t h

end Ising2D
