/-
章「複素行列環」の、一つの因子だけを残した族・前の因子を残した族と、一つの因子だけを残したクロネッカー積の番号順の積の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  def_single_site_family_of_matrices                            singleSiteFamily（f^{[j]}）
  def_initial_part_family_of_matrices                           initialPartFamily（f^{[≤p]}）
  claim_ordered_product_of_single_site_kronecker_products       singleSiteKroneckerProduct（x_j）・
                                                                initialPart_mul_singleSite（証明の準備）・
                                                                partialOrderedProduct_singleSiteKroneckerProducts（Π_p の帰納法）・
                                                                orderedProduct_singleSiteKroneckerProducts

番号付けた行列の族 f_1,…,f_M は `ℕ → Mat (Idx 2)` で表し、1,…,M の外の値は使わない。I_2 := 1_{Mat_{1,2}} は `Mat.one`。
B := Mat_{P_M}(ℂ) は ℂ-代数 `matricesComplexAlgebra (isFiniteSet_powerSet M)` で、B の中の番号順の積は
`ComplexAlgebra.partialOrderedProduct`（Π_p）・`ComplexAlgebra.restrictedOrderedProduct`（族を {1,…,p} に制限した積）である。
本文の帰納法の段 p（p - 1 で成り立つとする）は、Lean では段 p + 1（p で成り立つとする）と書く。

本文の前提 M ∈ ℤ_{≥1}、j ∈ {1,…,M}、p ∈ {0,…,M} は、証明が使わない（M = 0 でも、p > M でも同じ式で成り立つ）ので仮定に置かない。

本文が引くほかのブロックは、次の宣言を引く。
  def_ordered_product_in_algebra                                     ComplexAlgebra.partialOrderedProduct
  def_ordered_product_of_restricted_family                           ComplexAlgebra.restrictedOrderedProduct
  claim_partial_product_is_ordered_product_of_restricted_family      ComplexAlgebra.orderedProduct_of_restricted_family
  claim_kronecker_product_of_identity_matrices_is_identity_matrix    kroneckerProduct_one
  claim_product_of_kronecker_products_is_kronecker_product_of_products
                                                                     mul_kroneckerProduct
  claim_kronecker_products_of_factorwise_equal_families_are_equal    kroneckerProduct_congr
  claim_identity_matrix_is_right_unit_of_matrix_product              mat_mul_one
  claim_identity_matrix_is_left_unit_of_matrix_product               mat_one_mul

必要十分版は `NecSuf/ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/SingleSiteKroneckerProducts.lean`、
導出版は `FirstSiteHighestDigitNumberingFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_single_site_family_of_matrices`：f^{[j]}_t := f_j（t = j）、I_2（t ≠ j）。 -/
noncomputable def singleSiteFamily (f : ℕ → Mat (Idx 2)) (j : ℕ) (t : ℕ) : Mat (Idx 2) :=
  if t = j then f j else Mat.one

/-- 本文 `def_initial_part_family_of_matrices`：f^{[≤p]}_t := f_t（t ≤ p）、I_2（t > p）。 -/
noncomputable def initialPartFamily (f : ℕ → Mat (Idx 2)) (p : ℕ) (t : ℕ) : Mat (Idx 2) :=
  if t ≤ p then f t else Mat.one

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の x_j := ⊠_{t=1}^{M} f^{[j]}_t ∈ B。 -/
noncomputable def singleSiteKroneckerProduct (M : ℕ) (f : ℕ → Mat (Idx 2)) (j : ℕ) : Mat (PowerSet M) :=
  kroneckerProduct M (singleSiteFamily f j)

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の証明の準備（Lean では p を p + 1 と読む）：
すべての t ∈ {1,…,M} について f^{[≤p]}_t ·_{Mat_{1,2}} f^{[p+1]}_t = f^{[≤p+1]}_t。 -/
theorem initialPart_mul_singleSite (f : ℕ → Mat (Idx 2)) (p t : ℕ) :
    Mat.mul isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
      = initialPartFamily f (p + 1) t := by
  by_cases htp : t < p + 1
  · -- t < p + 1 のとき：f^{[≤p]}_t = f_t、f^{[p+1]}_t = I_2
    have h1 : initialPartFamily f p t = f t := if_pos (by omega)
    have h2 : singleSiteFamily f (p + 1) t = Mat.one := if_neg (by omega)
    calc Mat.mul isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
        -- def_initial_part_family_of_matrices（t ≤ p）、def_single_site_family_of_matrices（t ≠ p + 1）
        = Mat.mul isFiniteSet_two (f t) Mat.one := by rw [h1, h2]
      -- claim_identity_matrix_is_right_unit_of_matrix_product
      _ = f t := mat_mul_one isFiniteSet_two (f t)
      -- def_initial_part_family_of_matrices（t ≤ p + 1）
      _ = initialPartFamily f (p + 1) t := (if_pos (by omega)).symm
  · by_cases htp' : t = p + 1
    · -- t = p + 1 のとき
      subst htp'
      have h1 : initialPartFamily f p (p + 1) = Mat.one := if_neg (by omega)
      have h2 : singleSiteFamily f (p + 1) (p + 1) = f (p + 1) := if_pos rfl
      calc Mat.mul isFiniteSet_two (initialPartFamily f p (p + 1)) (singleSiteFamily f (p + 1) (p + 1))
          -- def_initial_part_family_of_matrices（p + 1 > p）、def_single_site_family_of_matrices（t = p + 1）
          = Mat.mul isFiniteSet_two Mat.one (f (p + 1)) := by rw [h1, h2]
        -- claim_identity_matrix_is_left_unit_of_matrix_product
        _ = f (p + 1) := mat_one_mul isFiniteSet_two (f (p + 1))
        -- def_initial_part_family_of_matrices（p + 1 ≤ p + 1）
        _ = initialPartFamily f (p + 1) (p + 1) := (if_pos le_rfl).symm
    · -- t > p + 1 のとき
      have h1 : initialPartFamily f p t = Mat.one := if_neg (by omega)
      have h2 : singleSiteFamily f (p + 1) t = Mat.one := if_neg htp'
      calc Mat.mul isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
          -- def_initial_part_family_of_matrices（t > p）、def_single_site_family_of_matrices（t ≠ p + 1）
          = Mat.mul isFiniteSet_two (Mat.one : Mat (Idx 2)) Mat.one := by rw [h1, h2]
        -- claim_identity_matrix_is_left_unit_of_matrix_product
        _ = Mat.one := mat_one_mul isFiniteSet_two Mat.one
        -- def_initial_part_family_of_matrices（t > p + 1）
        _ = initialPartFamily f (p + 1) t := (if_neg (by omega)).symm

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の帰納法の主張：Π_p = ⊠_{t=1}^{M} f^{[≤p]}_t。
Π_p は族 x_1, x_2, … について def_ordered_product_in_algebra で帰納的に定めた B の元。 -/
theorem partialOrderedProduct_singleSiteKroneckerProducts (M : ℕ) (f : ℕ → Mat (Idx 2)) :
    ∀ p : ℕ, ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p = kroneckerProduct M (initialPartFamily f p)
  | 0 => calc
      ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) 0
          -- def_ordered_product_in_algebra
          = (Mat.one : Mat (PowerSet M)) := rfl
      -- claim_kronecker_product_of_identity_matrices_is_identity_matrix
      _ = kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2))) := (kroneckerProduct_one M).symm
      -- claim_kronecker_products_of_factorwise_equal_families_are_equal。すべての t ≥ 1 で I_2 = f^{[≤0]}_t
      _ = kroneckerProduct M (initialPartFamily f 0) :=
          kroneckerProduct_congr M _ _ fun t ht1 _ => (if_neg (by omega)).symm
  | p + 1 => calc
      ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) (p + 1)
          -- def_ordered_product_in_algebra
          = Mat.mul (isFiniteSet_powerSet M)
              (ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
                (singleSiteKroneckerProduct M f) p)
              (singleSiteKroneckerProduct M f (p + 1)) := rfl
      -- 帰納法の仮定
      _ = Mat.mul (isFiniteSet_powerSet M) (kroneckerProduct M (initialPartFamily f p))
            (singleSiteKroneckerProduct M f (p + 1)) := by
          rw [partialOrderedProduct_singleSiteKroneckerProducts M f p]
      -- x_{p+1} の置き方
      _ = Mat.mul (isFiniteSet_powerSet M) (kroneckerProduct M (initialPartFamily f p))
            (kroneckerProduct M (singleSiteFamily f (p + 1))) := rfl
      -- claim_product_of_kronecker_products_is_kronecker_product_of_products
      _ = kroneckerProduct M (fun t => Mat.mul isFiniteSet_two (initialPartFamily f p t)
            (singleSiteFamily f (p + 1) t)) := mul_kroneckerProduct M _ _
      -- claim_kronecker_products_of_factorwise_equal_families_are_equal。因子が等しいことは上の準備
      _ = kroneckerProduct M (initialPartFamily f (p + 1)) :=
          kroneckerProduct_congr M _ _ fun t _ _ => initialPart_mul_singleSite f p t

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products`：
族 x_j := ⊠_{t=1}^{M} f^{[j]}_t を {1,…,p} に制限した番号順の積は ⊠_{t=1}^{M} f^{[≤p]}_t に等しい。 -/
theorem orderedProduct_singleSiteKroneckerProducts (M : ℕ) (f : ℕ → Mat (Idx 2)) (p : ℕ) :
    ComplexAlgebra.restrictedOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p
      = kroneckerProduct M (initialPartFamily f p) := calc
  ComplexAlgebra.restrictedOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
      (singleSiteKroneckerProduct M f) p
      -- claim_partial_product_is_ordered_product_of_restricted_family：左辺は Π_p に等しい
      = ComplexAlgebra.partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) p :=
        ComplexAlgebra.orderedProduct_of_restricted_family _ _ _ p fun _ _ _ => rfl
  -- Π_p についての帰納法
  _ = kroneckerProduct M (initialPartFamily f p) := partialOrderedProduct_singleSiteKroneckerProducts M f p

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
