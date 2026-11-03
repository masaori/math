/-
# 成分がすべて実数の行列の実数倍（具体版を必要十分版から導く）

具体版 `real_smul_hasRealEntries` の主張を、必要十分版 `Ising2D/NecSuf/ScalarMultipleOfClosedEntries.lean` の
`smul_entries_mem` の係数 `R := ℂ`、性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）、掛ける数 `c_ℂ` の特殊化として得る。
積で閉じること `hmul` は具体版の `real_inclusion_preserves_product`（`real_inclusion_mul`）が与える
`real_image_mul_closed`（`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`）である。
人手のラベルは `real_scalar_multiple_of_real_entry_matrix_has_real_entries`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerOfRealEntryMatricesFromNecSuf
import Ising2D.NecSuf.ScalarMultipleOfClosedEntries

namespace Ising2D

/-- `real_smul_hasRealEntries` を `NecSuf.smul_entries_mem` の特殊化として得る。 -/
theorem real_smul_hasRealEntries_of_necSuf {α β : Type*} (c : ℝ) (B : Matrix α β ℂ)
    (hB : MatrixHasRealEntries B) : MatrixHasRealEntries ((c : ℂ) • B) :=
  NecSuf.smul_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_mul_closed (c : ℂ) ⟨c, rfl⟩ B hB

end Ising2D
