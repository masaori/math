/-
章「複素行列環」の、番号 1 を最上位の桁にする番号付けによる付け替え・番号で添字づけたクロネッカー積・一つの因子だけを残したクロネッカー積の
番号順の積の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、
必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                                    必要十分版の特殊化
  firstSiteHighestReindexMatrix・
  firstSiteHighestInverseReindexMatrix・
  numberedKroneckerFactor・singleSiteFamily・initialPartFamily …_eq_necSuf（同じ式。rfl）
  numberedKroneckerProduct・singleSiteKroneckerProduct      …_eq_necSuf（番号順の積・クロネッカー積の一致を通して移す）
  各主張                                                    …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、a · 0 = 0 の `mul_zero` と、
0 と 1 の交換（`mul_comm` から）である。番号で添字づけたクロネッカー積の二つの主張には、ℂ の性質を一つも渡さない。
ϱ_M・r_M・𝓘_M・ō_M・pos_M・整数の番号順の和・num_M は ℂ を含まないので、両版が同じものを使う（導出版を置かない）。
B の中の番号順の積は、具体版の ℂ-代数を必要十分版の代数として読んだもの（`toNecSuf`）が必要十分版の `matricesAlgebra` と
一致すること（`matricesComplexAlgebra_toNecSuf`）を通して移す。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.NumberedKroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.SingleSiteKroneckerProducts
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProductFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.NumberedKroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.SingleSiteKroneckerProducts

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

/-- 本文 `def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit` の ν_{r_M} は、必要十分版の ν_{r_M} と同じ式。 -/
theorem firstSiteHighestReindexMatrix_eq_necSuf (M : ℕ) (F : Mat (PowerSet M)) :
    firstSiteHighestReindexMatrix M F = NecSuf.ComplexMatrixAlgebra.firstSiteHighestReindexMatrix M F := rfl

/-- 本文 `def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit` の μ_{r_M} は、
必要十分版の μ_{r_M} と同じ式。 -/
theorem firstSiteHighestInverseReindexMatrix_eq_necSuf (M : ℕ) (G : Mat (Idx (twoPower M))) :
    firstSiteHighestInverseReindexMatrix M G = NecSuf.ComplexMatrixAlgebra.firstSiteHighestInverseReindexMatrix M G :=
  rfl

/-- 本文 `def_kronecker_product_indexed_by_numbers` の因子の族は、必要十分版の因子の族と同じ式。 -/
theorem numberedKroneckerFactor_eq_necSuf {M : ℕ} (A : ℕ → Mat (Idx 2)) (I J : OneTwoTuple M) :
    numberedKroneckerFactor A I J = NecSuf.ComplexMatrixAlgebra.numberedKroneckerFactor A I J := rfl

/-- 本文 `def_kronecker_product_indexed_by_numbers` の ⊠̂ は、必要十分版の ⊠̂ と一致する。 -/
theorem numberedKroneckerProduct_eq_necSuf (M : ℕ) (A : ℕ → Mat (Idx 2)) :
    numberedKroneckerProduct M A = NecSuf.ComplexMatrixAlgebra.numberedKroneckerProduct M A :=
  funext fun _ => orderedProduct_eq_necSuf M _

/-- 本文 `def_single_site_family_of_matrices` の f^{[j]} は、必要十分版の f^{[j]} と同じ式。 -/
theorem singleSiteFamily_eq_necSuf (f : ℕ → Mat (Idx 2)) (j : ℕ) :
    singleSiteFamily f j = NecSuf.ComplexMatrixAlgebra.singleSiteFamily f j := rfl

/-- 本文 `def_initial_part_family_of_matrices` の f^{[≤p]} は、必要十分版の f^{[≤p]} と同じ式。 -/
theorem initialPartFamily_eq_necSuf (f : ℕ → Mat (Idx 2)) (p : ℕ) :
    initialPartFamily f p = NecSuf.ComplexMatrixAlgebra.initialPartFamily f p := rfl

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の x_j は、必要十分版の x_j と一致する。 -/
theorem singleSiteKroneckerProduct_eq_necSuf (M : ℕ) (f : ℕ → Mat (Idx 2)) :
    singleSiteKroneckerProduct M f = NecSuf.ComplexMatrixAlgebra.singleSiteKroneckerProduct M f :=
  funext fun j => kroneckerProduct_eq_necSuf M (singleSiteFamily f j)

/-! ### 主張 -/

/-- 本文 `def_kronecker_product_indexed_by_numbers` の定義の式を必要十分版から得る。 -/
theorem numberedKroneckerProduct_entry_of_necSuf (M : ℕ) (A : ℕ → Mat (Idx 2)) (I J : OneTwoTuple M) :
    Mat.entry (numberedKroneckerProduct M A) (tupleNumberIdx M I) (tupleNumberIdx M J)
      = orderedProduct M (numberedKroneckerFactor A I J) := by
  rw [numberedKroneckerProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.numberedKroneckerProduct_entry M A I J

/-- 本文 `claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit` を必要十分版から得る。 -/
theorem firstSiteHighestReindexMatrix_kroneckerProduct_of_necSuf (M : ℕ) (A : ℕ → Mat (Idx 2)) :
    firstSiteHighestReindexMatrix M (kroneckerProduct M A) = numberedKroneckerProduct M A := by
  rw [kroneckerProduct_eq_necSuf, numberedKroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.firstSiteHighestReindexMatrix_kroneckerProduct M A

/-- 本文 `claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal` を必要十分版から得る。 -/
theorem numberedKroneckerProduct_congr_of_necSuf (M : ℕ) (A A' : ℕ → Mat (Idx 2))
    (h : ∀ t : ℕ, 1 ≤ t → t ≤ M → A t = A' t) :
    numberedKroneckerProduct M A = numberedKroneckerProduct M A' := by
  rw [numberedKroneckerProduct_eq_necSuf, numberedKroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.numberedKroneckerProduct_congr M A A' h

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の証明の準備を必要十分版から得る。 -/
theorem initialPart_mul_singleSite_of_necSuf (f : ℕ → Mat (Idx 2)) (p t : ℕ) :
    Mat.mul isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
      = initialPartFamily f (p + 1) t := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.initialPart_mul_singleSite complexValuedMapsLaws (fun a => mul_comm 0 a)
    (fun a => mul_comm 1 a) f p t

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の帰納法の主張を必要十分版から得る。 -/
theorem partialOrderedProduct_singleSiteKroneckerProducts_of_necSuf (M : ℕ) (f : ℕ → Mat (Idx 2)) (p : ℕ) :
    ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p = kroneckerProduct M (initialPartFamily f p) := by
  rw [ComplexAlgebra.partialOrderedProduct_eq_necSuf, matricesComplexAlgebra_toNecSuf,
    singleSiteKroneckerProduct_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.partialOrderedProduct_singleSiteKroneckerProducts complexValuedMapsLaws
    mul_comm mul_zero M f p

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` を必要十分版から得る。 -/
theorem orderedProduct_singleSiteKroneckerProducts_of_necSuf (M : ℕ) (f : ℕ → Mat (Idx 2)) (p : ℕ) :
    ComplexAlgebra.restrictedOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p
      = kroneckerProduct M (initialPartFamily f p) := by
  rw [ComplexAlgebra.restrictedOrderedProduct_eq_necSuf, matricesComplexAlgebra_toNecSuf,
    singleSiteKroneckerProduct_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.orderedProduct_singleSiteKroneckerProducts complexValuedMapsLaws
    mul_comm mul_zero M f p

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
