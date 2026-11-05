/-
# 成分がすべて実数の行列の積（具体版を必要十分版から導く）

具体版 `matrix_mul_hasRealEntries` の主張を、必要十分版 `Ising2D/NecSuf/ProductOfClosedEntries.lean` の `mul_entries_mem` の
係数 `R := ℂ`、性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）の特殊化として得る。
積で閉じること `hmul` は `real_image_mul_closed`（`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`。人手の
`real_inclusion_preserves_product`）、和で閉じること `hadd` は `real_image_add_closed`（`ClaimSumsOfRealEntryMatricesFromNecSuf.lean`）である。
人手のラベルは `product_of_real_entry_matrices_has_real_entries`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimSumsOfRealEntryMatricesFromNecSuf
import Ising2D.NecSuf.ProductOfClosedEntries

namespace Ising2D

/-- `matrix_mul_hasRealEntries` を `NecSuf.mul_entries_mem` の特殊化として得る。 -/
theorem matrix_mul_hasRealEntries_of_necSuf {α β γ : Type*} [Fintype β] [Nonempty β]
    (A : Matrix α β ℂ) (B : Matrix β γ ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A * B) :=
  NecSuf.mul_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_mul_closed real_image_add_closed
    A B hA hB

end Ising2D
