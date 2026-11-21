/-
章「複素行列環」の、一つの因子だけを残した族・前の因子を残した族と、一つの因子だけを残したクロネッカー積の番号順の積の必要十分版。
具体版 `ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/SingleSiteKroneckerProducts.lean` と同じ def と calc の行で、
係数 ℂ を型の変数 K に替えて書く。B := Mat_{P_M}(K) は K-代数 `matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)`。

  本文のラベル                                                  このファイル                                         使う K の性質
  def_single_site_family_of_matrices                            singleSiteFamily                                     なし（0 と 1 の記号だけ）
  def_initial_part_family_of_matrices                           initialPartFamily                                    なし（0 と 1 の記号だけ）
  claim_ordered_product_of_single_site_kronecker_products       singleSiteKroneckerProduct                           なし（乗法・0・1 の記号だけ）
                                                                initialPart_mul_singleSite（証明の準備）             L・0 と 1 がどの元とも交換すること
                                                                partialOrderedProduct_singleSiteKroneckerProducts・  L・乗法の交換法則・a · 0 = 0
                                                                orderedProduct_singleSiteKroneckerProducts

L : `ValuedMapsLaws K` は行列の積 `Mat.mul L hX` を定めるのに要る。

削れなかった仮定:
- 乗法の交換法則と a · 0 = 0（主張の本体）: 番号順の積 Π_p は K-代数 B の中の積（def_ordered_product_in_algebra）なので、
  行列の集合を K-代数にする `matricesAlgebra` が要する二つを仮定に持つ（`NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Algebra.lean`）。
  行の中では、交換法則を二つの積の主張（`mul_kroneckerProduct`。部分集合全体の上の和の主張と、二つの番号順の積の積の主張が要る）と、
  単位行列のクロネッカー積の主張（`kroneckerProduct_one`。a · 0 = 0 · a と、交換法則と a · 0 = 0 から出る 0 · a = 0）に渡す。
  a · 1 = a は、交換法則と L の 1 · a = a から出す（`hmul1_of_comm`）ので仮定に置かない。
- 証明の準備（f^{[≤p]}_t · f^{[p+1]}_t = f^{[≤p+1]}_t）が使うのは、単位行列を右から掛けても変わらないことの仮定
  （0 と 1 がどの元とも交換すること）と L だけで、乗法の交換法則全体は要らない。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet isFiniteSet_two)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K]

/-- 乗法の交換法則と 1 · a = a から a · 1 = a。 -/
theorem hmul1_of_comm (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (a : K) : a * 1 = a := by
  rw [hcomm a 1, L.one_mul a]

omit [Add K] [One K] in
/-- 乗法の交換法則と a · 0 = 0 から 0 · a = 0。 -/
theorem hzero_mul_of_comm (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (a : K) : 0 * a = 0 := by
  rw [hcomm 0 a, hmul0 a]

/-- 本文 `def_single_site_family_of_matrices` の必要十分版：f^{[j]}_t := f_j（t = j）、I_2（t ≠ j）。 -/
noncomputable def singleSiteFamily (f : ℕ → Mat K (Idx 2)) (j : ℕ) (t : ℕ) : Mat K (Idx 2) :=
  if t = j then f j else Mat.one

/-- 本文 `def_initial_part_family_of_matrices` の必要十分版：f^{[≤p]}_t := f_t（t ≤ p）、I_2（t > p）。 -/
noncomputable def initialPartFamily (f : ℕ → Mat K (Idx 2)) (p : ℕ) (t : ℕ) : Mat K (Idx 2) :=
  if t ≤ p then f t else Mat.one

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の x_j := ⊠_{t=1}^{M} f^{[j]}_t ∈ B。 -/
noncomputable def singleSiteKroneckerProduct (M : ℕ) (f : ℕ → Mat K (Idx 2)) (j : ℕ) : Mat K (PowerSet M) :=
  kroneckerProduct M (singleSiteFamily f j)

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の証明の準備（Lean では p を p + 1 と読む）：
すべての t ∈ {1,…,M} について f^{[≤p]}_t ·_{Mat_{1,2}} f^{[p+1]}_t = f^{[≤p+1]}_t。 -/
theorem initialPart_mul_singleSite (L : ValuedMapsLaws K)
    (hzero_comm : ∀ a : K, 0 * a = a * 0) (hone_comm : ∀ a : K, 1 * a = a * 1) (f : ℕ → Mat K (Idx 2)) (p t : ℕ) :
    Mat.mul L isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
      = initialPartFamily f (p + 1) t := by
  by_cases htp : t < p + 1
  · -- t < p + 1 のとき：f^{[≤p]}_t = f_t、f^{[p+1]}_t = I_2
    have h1 : initialPartFamily f p t = f t := if_pos (by omega)
    have h2 : singleSiteFamily f (p + 1) t = Mat.one := if_neg (by omega)
    calc Mat.mul L isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
        -- def_initial_part_family_of_matrices（t ≤ p）、def_single_site_family_of_matrices（t ≠ p + 1）
        = Mat.mul L isFiniteSet_two (f t) Mat.one := by rw [h1, h2]
      -- claim_identity_matrix_is_right_unit_of_matrix_product
      _ = f t := mat_mul_one L hzero_comm hone_comm isFiniteSet_two (f t)
      -- def_initial_part_family_of_matrices（t ≤ p + 1）
      _ = initialPartFamily f (p + 1) t := (if_pos (by omega)).symm
  · by_cases htp' : t = p + 1
    · -- t = p + 1 のとき
      subst htp'
      have h1 : initialPartFamily f p (p + 1) = Mat.one := if_neg (by omega)
      have h2 : singleSiteFamily f (p + 1) (p + 1) = f (p + 1) := if_pos rfl
      calc Mat.mul L isFiniteSet_two (initialPartFamily f p (p + 1)) (singleSiteFamily f (p + 1) (p + 1))
          -- def_initial_part_family_of_matrices（p + 1 > p）、def_single_site_family_of_matrices（t = p + 1）
          = Mat.mul L isFiniteSet_two Mat.one (f (p + 1)) := by rw [h1, h2]
        -- claim_identity_matrix_is_left_unit_of_matrix_product
        _ = f (p + 1) := mat_one_mul L isFiniteSet_two (f (p + 1))
        -- def_initial_part_family_of_matrices（p + 1 ≤ p + 1）
        _ = initialPartFamily f (p + 1) (p + 1) := (if_pos le_rfl).symm
    · -- t > p + 1 のとき
      have h1 : initialPartFamily f p t = Mat.one := if_neg (by omega)
      have h2 : singleSiteFamily f (p + 1) t = Mat.one := if_neg htp'
      calc Mat.mul L isFiniteSet_two (initialPartFamily f p t) (singleSiteFamily f (p + 1) t)
          -- def_initial_part_family_of_matrices（t > p）、def_single_site_family_of_matrices（t ≠ p + 1）
          = Mat.mul L isFiniteSet_two (Mat.one : Mat K (Idx 2)) Mat.one := by rw [h1, h2]
        -- claim_identity_matrix_is_left_unit_of_matrix_product
        _ = Mat.one := mat_one_mul L isFiniteSet_two Mat.one
        -- def_initial_part_family_of_matrices（t > p + 1）
        _ = initialPartFamily f (p + 1) t := (if_neg (by omega)).symm

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の帰納法の主張：Π_p = ⊠_{t=1}^{M} f^{[≤p]}_t。
Π_p は族 x_1, x_2, … について def_ordered_product_in_algebra で帰納的に定めた B の元。 -/
theorem partialOrderedProduct_singleSiteKroneckerProducts (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (M : ℕ) (f : ℕ → Mat K (Idx 2)) :
    ∀ p : ℕ, AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p = kroneckerProduct M (initialPartFamily f p)
  | 0 => calc
      AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) 0
          -- def_ordered_product_in_algebra
          = (Mat.one : Mat K (PowerSet M)) := rfl
      -- claim_kronecker_product_of_identity_matrices_is_identity_matrix
      _ = kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2))) := (kroneckerProduct_one (hmul1_of_comm L hcomm) L.mul_assoc (fun a => hcomm a 0)
            (hzero_mul_of_comm hcomm hmul0) M).symm
      -- claim_kronecker_products_of_factorwise_equal_families_are_equal。すべての t ≥ 1 で I_2 = f^{[≤0]}_t
      _ = kroneckerProduct M (initialPartFamily f 0) :=
          kroneckerProduct_congr M _ _ fun t ht1 _ => (if_neg (by omega)).symm
  | p + 1 => calc
      AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) (p + 1)
          -- def_ordered_product_in_algebra
          = Mat.mul L (isFiniteSet_powerSet M)
              (AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
                (singleSiteKroneckerProduct M f) p)
              (singleSiteKroneckerProduct M f (p + 1)) := rfl
      -- 帰納法の仮定
      _ = Mat.mul L (isFiniteSet_powerSet M) (kroneckerProduct M (initialPartFamily f p))
            (singleSiteKroneckerProduct M f (p + 1)) := by
          rw [partialOrderedProduct_singleSiteKroneckerProducts L hcomm hmul0 M f p]
      -- x_{p+1} の置き方
      _ = Mat.mul L (isFiniteSet_powerSet M) (kroneckerProduct M (initialPartFamily f p))
            (kroneckerProduct M (singleSiteFamily f (p + 1))) := rfl
      -- claim_product_of_kronecker_products_is_kronecker_product_of_products
      _ = kroneckerProduct M (fun t => Mat.mul L isFiniteSet_two (initialPartFamily f p t)
            (singleSiteFamily f (p + 1) t)) := mul_kroneckerProduct L hcomm (hmul1_of_comm L hcomm) hmul0 M _ _
      -- claim_kronecker_products_of_factorwise_equal_families_are_equal。因子が等しいことは上の準備
      _ = kroneckerProduct M (initialPartFamily f (p + 1)) :=
          kroneckerProduct_congr M _ _ fun t _ _ => initialPart_mul_singleSite L (fun a => hcomm 0 a) (fun a => hcomm 1 a) f p t

/-- 本文 `claim_ordered_product_of_single_site_kronecker_products` の必要十分版：
族 x_j := ⊠_{t=1}^{M} f^{[j]}_t を {1,…,p} に制限した番号順の積は ⊠_{t=1}^{M} f^{[≤p]}_t に等しい。 -/
theorem orderedProduct_singleSiteKroneckerProducts (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (M : ℕ) (f : ℕ → Mat K (Idx 2)) (p : ℕ) :
    AlgebraOver.restrictedOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
        (singleSiteKroneckerProduct M f) p
      = kroneckerProduct M (initialPartFamily f p) := calc
  AlgebraOver.restrictedOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
      (singleSiteKroneckerProduct M f) p
      -- claim_partial_product_is_ordered_product_of_restricted_family：左辺は Π_p に等しい
      = AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
          (singleSiteKroneckerProduct M f) p :=
        AlgebraOver.orderedProduct_of_restricted_family _ _ _ p fun _ _ _ => rfl
  -- Π_p についての帰納法
  _ = kroneckerProduct M (initialPartFamily f p) := partialOrderedProduct_singleSiteKroneckerProducts L hcomm hmul0 M f p

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
