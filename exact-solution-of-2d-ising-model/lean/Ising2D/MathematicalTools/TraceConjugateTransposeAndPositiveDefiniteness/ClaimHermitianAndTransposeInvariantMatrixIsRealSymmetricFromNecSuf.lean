/-
# エルミートかつ転置で不変な複素行列は実対称（具体版を必要十分版から導く）

具体版 `hermitian_and_transpose_invariant_matrix_is_real_symmetric` の主張を、必要十分版
`Ising2D/NecSuf/StarFixedEntriesOfHermitianSymmetric.lean` の `star_fixed_entries_of_hermitian_symmetric` の係数 `R := ℂ`、
性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）の特殊化として得る。
共役で動かない元が `S` に入ること `hS` は、具体版の補題 `exists_real_of_star_eq`（人手の 2 つ目の鎖からの段）である。
人手のラベルは `hermitian_and_transpose_invariant_matrix_is_real_symmetric`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetric
import Ising2D.NecSuf.StarFixedEntriesOfHermitianSymmetric

namespace Ising2D

open Matrix

/-- `hermitian_and_transpose_invariant_matrix_is_real_symmetric` を
`NecSuf.star_fixed_entries_of_hermitian_symmetric` の特殊化として得る。 -/
theorem hermitian_and_transpose_invariant_matrix_is_real_symmetric_of_necSuf {n : Type*} (A : Matrix n n ℂ)
    (hH : Aᴴ = A) (hT : Aᵀ = A) : MatrixIsRealSymmetric A :=
  NecSuf.star_fixed_entries_of_hermitian_symmetric (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ))
    exists_real_of_star_eq A hH hT

end Ising2D
