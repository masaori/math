/-
# 実数の包含の有限積・成分が実数の行列のクロネッカー積（具体版を必要十分版から導く）

具体版 `finite_product_of_real_inclusions_is_real`・`siteProd_hasRealEntries` の主張を、必要十分版
`Ising2D/NecSuf/KroneckerOfRealEntryMatrices.lean` の `prod_mem_of_mul_closed`・`kroneckerProdOf_entries_mem` の
係数 `R := ℂ`、性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）、因子の添字 `α = β := Fin 2` の特殊化として得る。
積で閉じること `hmul` は具体版の `real_inclusion_preserves_product`（`real_inclusion_mul`）が与える。
人手のラベルは `finite_product_of_real_inclusions_is_real`・`kronecker_of_real_entry_matrices_has_real_entries`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerOfRealEntryMatricesHasRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerTransposeFromNecSuf
import Ising2D.NecSuf.KroneckerOfRealEntryMatrices

namespace Ising2D

/-- `ℝ` の像に入ることは積で閉じる（`real_inclusion_preserves_product`）。 -/
theorem real_image_mul_closed (a b : ℂ) :
    (∃ r : ℝ, a = (r : ℂ)) → (∃ r : ℝ, b = (r : ℂ)) → ∃ r : ℝ, a * b = (r : ℂ) := by
  rintro ⟨s, rfl⟩ ⟨t, rfl⟩
  exact ⟨s * t, real_inclusion_mul s t⟩

/-- `finite_product_of_real_inclusions_is_real` を `NecSuf.prod_mem_of_mul_closed` の特殊化として得る。 -/
theorem finite_product_of_real_inclusions_is_real_of_necSuf (m : ℕ) (z : Fin (m + 1) → ℂ)
    (hz : ∀ j, ∃ r : ℝ, z j = (r : ℂ)) : ∃ r : ℝ, ∏ j, z j = (r : ℂ) :=
  NecSuf.prod_mem_of_mul_closed (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_mul_closed m z hz

/-- `siteProd_hasRealEntries` を `NecSuf.kroneckerProdOf_entries_mem` の特殊化として得る。 -/
theorem siteProd_hasRealEntries_of_necSuf {n : ℕ} (x : Fin (n + 1) → Matrix (Fin 2) (Fin 2) ℂ)
    (hx : ∀ k, MatrixHasRealEntries (x k)) : MatrixHasRealEntries (siteProd (n + 1) x) := by
  rw [siteProd_eq_kroneckerProdOf]
  exact NecSuf.kroneckerProdOf_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_mul_closed x hx

end Ising2D
