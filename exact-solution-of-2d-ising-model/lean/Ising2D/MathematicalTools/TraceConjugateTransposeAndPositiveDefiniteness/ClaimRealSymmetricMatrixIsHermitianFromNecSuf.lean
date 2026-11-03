/-
# 実対称な複素行列はエルミート（具体版を必要十分版から導く）

具体版 `real_symmetric_isHermitian` の主張を、必要十分版
`Ising2D/NecSuf/HermitianOfStarFixedSymmetricEntries.lean` の `hermitian_of_star_fixed_symmetric_entries` の係数 `R := ℂ`、
性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）の特殊化として得る。
共役で動かないこと `hS` は、人手 `complex_conjugate_of_real_inclusion`（具体版 `complex_conjugate_of_real_inclusion`）である。
人手のラベルは `real_symmetric_matrix_is_hermitian`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian
import Ising2D.NecSuf.HermitianOfStarFixedSymmetricEntries

namespace Ising2D

/-- `real_symmetric_isHermitian` を `NecSuf.hermitian_of_star_fixed_symmetric_entries` の特殊化として得る。 -/
theorem real_symmetric_isHermitian_of_necSuf {n : Type*} (A : Matrix n n ℂ) (hA : MatrixIsRealSymmetric A) :
    A.IsHermitian :=
  NecSuf.hermitian_of_star_fixed_symmetric_entries (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ))
    (by rintro w ⟨r, rfl⟩; exact complex_conjugate_of_real_inclusion r) A hA.1 hA.2

end Ising2D
