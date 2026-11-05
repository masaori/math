/-
# 転置で不変な行列の exp は転置で不変（具体版を必要十分版から導く）

具体版 `ClaimExpOfSymmetricIsSymmetric.lean` の主張を、必要十分版 `Ising2D/NecSuf/SeriesOfSymmetricIsSymmetric.lean` の
係数 `α := ℂ`、添字 `Conf M`、係数の列 `c m := (m!)^{-1}`（`K := ℂ`）、極限 `L := exp(S)` の特殊化として得る。
人手のラベルは `exp_of_symmetric_is_symmetric`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfSymmetricIsSymmetric
import Ising2D.NecSuf.SeriesOfSymmetricIsSymmetric

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

variable {M : ℕ}

/-- `identity_transpose_tensorPow` を `NecSuf.one_transpose_matrix'` の特殊化として得る。 -/
theorem identity_transpose_tensorPow_of_necSuf : (1 : TensorPow M)ᵀ = 1 :=
  NecSuf.one_transpose_matrix'

/-- `tensorPow_mul_pow_comm` を `NecSuf.mul_pow_comm_self'`（`Monoid` を `TensorPow M` に）の特殊化として得る。 -/
theorem tensorPow_mul_pow_comm_of_necSuf (S : TensorPow M) (m : ℕ) : S * S ^ m = S ^ m * S :=
  NecSuf.mul_pow_comm_self' S m

/-- `tensorPow_pow_transpose_of_transpose_eq` を `NecSuf.pow_transpose_of_transpose_eq'` の特殊化として得る。 -/
theorem tensorPow_pow_transpose_of_transpose_eq_of_necSuf (S : TensorPow M) (hS : Sᵀ = S) (m : ℕ) :
    (S ^ m)ᵀ = S ^ m :=
  NecSuf.pow_transpose_of_transpose_eq' S hS m

/-- `expPartialSum_transpose` を `NecSuf.partialSum_transpose'`（`c m := (m!)^{-1}`）の特殊化として得る。 -/
theorem expPartialSum_transpose_of_necSuf (S : TensorPow M) (hS : Sᵀ = S) (N : ℕ) :
    (expPartialSum S N)ᵀ = expPartialSum S N :=
  NecSuf.partialSum_transpose' (fun m => ((m.factorial : ℂ))⁻¹) S hS N

/-- `matExp_transpose_of_transpose_eq` を `NecSuf.limit_transpose_of_transpose_eq'`（`c m := (m!)^{-1}`, `L := exp(S)`）の
特殊化として得る。部分和が `exp(S)` へ収束することは `matExp_hasSum` から渡す。 -/
theorem matExp_transpose_of_transpose_eq_of_necSuf (S : TensorPow M) (hS : Sᵀ = S) :
    (matExp S)ᵀ = matExp S :=
  NecSuf.limit_transpose_of_transpose_eq' (fun m => ((m.factorial : ℂ))⁻¹) S hS (matExp S)
    (tendsto_iff_norm_sub_tendsto_zero.1
      (((matExp_hasSum S).tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)))

end Ising2D
