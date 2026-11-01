/-
# `exp(tσ^x) = cosh(t)I + sinh(t)σ^x` を必要十分版の系として導く

正本: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
（ラベル **`two_by_two_transfer_identity`** の中間目標「`exp(tσ^x)` の閉じた形」）

人手と 1 対 1 に対応する主張は `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh`
（`PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentity.lean`）である。ここでは同じ主張を、必要十分版
`Ising2D.NecSuf.exp_series_sum_of_sq_eq_one`（`NecSuf/ExpOfInvolution.lean`）を
`𝔸 = Mat(2, ℂ)`、`A = σ^x`、`E = exp(tσ^x)` に特殊化して得る。
必要十分版の仮定 `A^2 = 1` は `pauliX_sq`、`hE`（指数級数の部分和の極限が `E`）は `exp_smul_pauliX_hasSum` が与える。
-/
import Ising2D.NecSuf.ExpOfInvolution
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimTwoByTwoTransferIdentity

namespace Ising2D

open NormedSpace

/-- `exp_smul_pauliX_eq_cosh_add_sinh` を必要十分版の特殊化として導いたもの。 -/
theorem exp_smul_pauliX_eq_cosh_add_sinh_of_necSuf (t : ℂ) :
    exp (t • pauliX) = Complex.cosh t • (1 : Matrix (Fin 2) (Fin 2) ℂ)
      + Complex.sinh t • pauliX :=
  NecSuf.exp_series_sum_of_sq_eq_one pauliX_sq t (exp_smul_pauliX_hasSum t).tendsto_sum_nat

end Ising2D
