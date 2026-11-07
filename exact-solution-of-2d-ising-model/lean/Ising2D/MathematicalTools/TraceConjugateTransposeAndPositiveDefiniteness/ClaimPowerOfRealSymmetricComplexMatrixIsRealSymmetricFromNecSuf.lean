/-
# 実対称な複素行列の冪は実対称（必要十分版から導く）

具体版 `Ising2D.power_of_real_symmetric_complex_matrix_is_real_symmetric`（人手 `power_of_real_symmetric_complex_matrix_is_real_symmetric`）と
同じ主張が、必要十分版 `Ising2D.NecSuf.pow_entries_mem_and_transpose_eq'`（`Ising2D/NecSuf/PowerOfSymmetricMatrixWithClosedEntries.lean`）を、
係数 `R → ℂ`、性質 `S → ℝ の像に入る`（`0 = (0)_ℂ`、`1 = (1)_ℂ`、積と和で閉じることは `real_image_mul_closed`・`real_image_add_closed`）、
添字 `ι → Conf M` に取った特殊化として得られることの記録である。具体版の証明には使わない。
-/
import Ising2D.NecSuf.PowerOfSymmetricMatrixWithClosedEntries
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetric
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerOfRealEntryMatricesFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-- `power_of_real_symmetric_complex_matrix_is_real_symmetric` を `NecSuf.pow_entries_mem_and_transpose_eq'` の特殊化として得る。 -/
theorem power_of_real_symmetric_complex_matrix_is_real_symmetric_of_necSuf (A : TensorPow M)
    (hA : MatrixIsRealSymmetric A) (p : ℕ) : MatrixIsRealSymmetric (A ^ p) :=
  NecSuf.pow_entries_mem_and_transpose_eq' (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ))
    ⟨0, Complex.ofReal_zero.symm⟩ ⟨1, Complex.ofReal_one.symm⟩
    real_image_mul_closed real_image_add_closed A hA.1 hA.2 p

end Ising2D
