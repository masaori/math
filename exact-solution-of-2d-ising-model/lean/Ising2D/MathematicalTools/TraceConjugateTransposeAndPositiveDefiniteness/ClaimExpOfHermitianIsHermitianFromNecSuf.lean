/-
# エルミート行列の exp はエルミート（具体版を必要十分版から導く）

具体版 `ClaimExpOfHermitianIsHermitian.lean` の主張を、必要十分版 `Ising2D/NecSuf/SeriesOfHermitianIsHermitian.lean` の
係数 `α := ℂ`、添字 `Conf M`、係数の列 `c m := (m!)^{-1}`、極限 `L := exp(S)` の特殊化として得る。
人手のラベルは `exp_of_hermitian_is_hermitian`。
共役の仮定には、具体版と同じく人手の `complex_conjugate_of_sum`（`hsum`・`hsumRange`）・`complex_conjugate_of_product`（`hmul`）・
`complex_conjugate_of_difference`（`hsub`）・`abs_of_complex_conjugate`（`hnorm`）に当たる mathlib の `star_sum`・`star_mul'`・`star_sub`・`norm_star` と、
人手 `complex_conjugate_of_real_inclusion` の具体版（`h0`・`h1`、係数の `hc` は `star_inv_factorial`）を渡す。
部分和と極限の段の `h0` は必要十分版の中で `hsumRange` から作るので、そこでは渡さない。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfHermitianIsHermitian
import Ising2D.NecSuf.SeriesOfHermitianIsHermitian

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

variable {M : ℕ}

/-- `star_identity_entry_tensorPow` を `NecSuf.star_ite_one_zero'` の特殊化として得る。 -/
theorem star_identity_entry_tensorPow_of_necSuf (l k : Conf M) :
    star (if l = k then (1 : ℂ) else 0) = if l = k then (1 : ℂ) else 0 :=
  NecSuf.star_ite_one_zero' (complex_conjugate_of_real_inclusion 0) (complex_conjugate_of_real_inclusion 1) _

/-- `identity_conjTranspose_tensorPow` を `NecSuf.one_conjTranspose_matrix'` の特殊化として得る。 -/
theorem identity_conjTranspose_tensorPow_of_necSuf : (1 : TensorPow M)ᴴ = 1 :=
  NecSuf.one_conjTranspose_matrix' (complex_conjugate_of_real_inclusion 0) (complex_conjugate_of_real_inclusion 1)

/-- `tensorPow_pow_conjTranspose_of_conjTranspose_eq` を `NecSuf.pow_conjTranspose_of_conjTranspose_eq'` の特殊化として得る。 -/
theorem tensorPow_pow_conjTranspose_of_conjTranspose_eq_of_necSuf (S : TensorPow M) (hS : Sᴴ = S) (m : ℕ) :
    (S ^ m)ᴴ = S ^ m :=
  NecSuf.pow_conjTranspose_of_conjTranspose_eq' (fun f => star_sum _ f) star_mul'
    (complex_conjugate_of_real_inclusion 0) (complex_conjugate_of_real_inclusion 1) S hS m

/-- `expPartialSum_conjTranspose` を `NecSuf.partialSum_conjTranspose'`（`c m := (m!)^{-1}`）の特殊化として得る。 -/
theorem expPartialSum_conjTranspose_of_necSuf (S : TensorPow M) (hS : Sᴴ = S) (N : ℕ) :
    (expPartialSum S N)ᴴ = expPartialSum S N :=
  NecSuf.partialSum_conjTranspose' (fun f => star_sum _ f) (fun _ f => star_sum _ f) star_mul'
    (complex_conjugate_of_real_inclusion 1)
    (fun m => ((m.factorial : ℂ))⁻¹) star_inv_factorial S hS N

/-- `matExp_conjTranspose_of_conjTranspose_eq` を `NecSuf.limit_conjTranspose_of_conjTranspose_eq'`（`c m := (m!)^{-1}`, `L := exp(S)`）の
特殊化として得る。部分和が `exp(S)` へ収束することは `matExp_hasSum` から渡す。 -/
theorem matExp_conjTranspose_of_conjTranspose_eq_of_necSuf (S : TensorPow M) (hS : Sᴴ = S) :
    (matExp S)ᴴ = matExp S :=
  NecSuf.limit_conjTranspose_of_conjTranspose_eq' (fun f => star_sum _ f) (fun _ f => star_sum _ f) star_mul'
    (complex_conjugate_of_real_inclusion 1) norm_star star_sub
    (fun m => ((m.factorial : ℂ))⁻¹) star_inv_factorial S hS (matExp S)
    (tendsto_iff_norm_sub_tendsto_zero.1
      (((matExp_hasSum S).tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)))

end Ising2D
