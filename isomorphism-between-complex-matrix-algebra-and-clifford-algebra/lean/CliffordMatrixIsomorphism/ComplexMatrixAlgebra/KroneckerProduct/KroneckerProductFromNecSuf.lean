/-
章「複素行列環」の、クロネッカー積と両側から挟む写像の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、
必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                    必要十分版の特殊化
  selectedFactor・kroneckerFactor           …_eq_necSuf（同じ式。rfl）
  kroneckerProduct                          kroneckerProduct_eq_necSuf（番号順の積を `orderedProduct_eq_necSuf` で移す）
  conjugation                               conjugation_eq_necSuf（積を `Mat.mul_eq_necSuf` で移す）
  各主張（部分集合全体の上の和の準備（一）（二）と帰納法の主張、両側から挟む写像の四つの条件を含む）
                                            …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、`mul_one`、`mul_zero`、
`zero_mul`、`mul_assoc`、分配法則 `mul_add`・`add_mul` と、λ・λ' の交換・0 と 1 の交換（`mul_comm` から）である。
0 + a = a は必要十分版が `complexValuedMapsLaws` から作るので渡さない。
o_{M,T}(k)・{1,2}・P_M・2 進の番号付けは ℂ を含まず、両版に同じ形で別に置いてある。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.Conjugation
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.MatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.Conjugation

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-! ### 定義の対応 -/

theorem selectedFactor_eq_necSuf (x y : ℕ → ℂ) (R : Set ℕ) :
    selectedFactor x y R = NecSuf.ComplexMatrixAlgebra.selectedFactor x y R := rfl

/-- 本文 `def_kronecker_product_indexed_by_power_set` の因子の族は、必要十分版の因子の族と同じ式。 -/
theorem kroneckerFactor_eq_necSuf {M : ℕ} (A : ℕ → Mat (Idx 2)) (S T : PowerSet M) :
    kroneckerFactor A S T = NecSuf.ComplexMatrixAlgebra.kroneckerFactor A S T := rfl

/-- 本文 `def_kronecker_product_indexed_by_power_set` のクロネッカー積は、必要十分版のクロネッカー積と一致する。 -/
theorem kroneckerProduct_eq_necSuf (M : ℕ) (A : ℕ → Mat (Idx 2)) :
    kroneckerProduct M A = NecSuf.ComplexMatrixAlgebra.kroneckerProduct M A :=
  funext fun p => orderedProduct_eq_necSuf M (kroneckerFactor A p.1 p.2)

/-- 本文 `def_conjugation_of_matrices` の κ_{U,U'} は、必要十分版の κ_{U,U'} と一致する。 -/
theorem conjugation_eq_necSuf (hX : IsFiniteSet X) (U U' : Mat X) :
    conjugation hX U U' = NecSuf.ComplexMatrixAlgebra.conjugation complexValuedMapsLaws hX.toNecSuf U U' :=
  funext fun F => by
    unfold conjugation NecSuf.ComplexMatrixAlgebra.conjugation
    rw [Mat.mul_eq_necSuf hX U F, Mat.mul_eq_necSuf]

/-! ### 主張 -/

theorem partialOrderedProduct_selectedFactor_congr_of_necSuf (x y : ℕ → ℂ) (R R' : Set ℕ) :
    ∀ m' : ℕ, (∀ i : ℕ, 1 ≤ i → i ≤ m' → selectedFactor x y R i = selectedFactor x y R' i) →
      partialOrderedProduct (selectedFactor x y R) m' = partialOrderedProduct (selectedFactor x y R') m' :=
  fun m' h => by
    rw [partialOrderedProduct_eq_necSuf (selectedFactor x y R) m',
      partialOrderedProduct_eq_necSuf (selectedFactor x y R') m']
    exact NecSuf.ComplexMatrixAlgebra.partialOrderedProduct_selectedFactor_congr x y R R' m' h

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の準備（二）を必要十分版から得る。 -/
theorem linearCombination_mul_right_of_necSuf (n : ℕ) (r : ℂ) (p : ℕ → ℂ) :
    linearCombination complexNumbersVectorSpace n (fun _ => 1) (fun k => p k * r)
      = linearCombination complexNumbersVectorSpace n (fun _ => 1) p * r := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.linearCombination_mul_right complexValuedMapsLaws mul_comm mul_one mul_zero
    n r p

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の帰納法の主張を必要十分版から得る。 -/
theorem sumOverBinaryNumbering_selected_of_necSuf (x y : ℕ → ℂ) :
    ∀ m : ℕ, linearCombination complexNumbersVectorSpace (twoPower m) (fun _ => 1)
        (numberedFamily (binaryNumbering m)
          (fun R => partialOrderedProduct (selectedFactor x y R.1) m) complexNumbersVectorSpace.zero)
      = partialOrderedProduct (fun k => y k + x k) m :=
  fun m => by
    simp only [linearCombination_eq_necSuf, partialOrderedProduct_eq_necSuf]
    exact NecSuf.ComplexMatrixAlgebra.sumOverBinaryNumbering_selected complexValuedMapsLaws mul_comm mul_one
      mul_zero x y m

/-- 本文 `claim_entry_of_product_of_matrices_indexed_by_two_element_set` を必要十分版から得る。 -/
theorem entry_mul_two_of_necSuf (A B : Mat (Idx 2)) (a b : Idx 2) :
    Mat.entry (Mat.mul isFiniteSet_two A B) a b
      = Mat.entry A a idxOne * Mat.entry B idxOne b + Mat.entry A a idxTwo * Mat.entry B idxTwo b := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.entry_mul_two complexValuedMapsLaws A B a b

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` を必要十分版から得る。 -/
theorem sumOverPowerSet_selected_of_necSuf (M : ℕ) (x y : ℕ → ℂ) :
    sumOverFiniteSet complexNumbersVectorSpace (isFiniteSet_powerSet M) (fun _ => 1)
        (fun R => orderedProduct M (selectedFactor x y R.1))
      = orderedProduct M (fun k => y k + x k) := by
  rw [sumOverFiniteSet_eq_necSuf]
  simp only [orderedProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.sumOverPowerSet_selected complexValuedMapsLaws mul_comm mul_one mul_zero
    M x y

/-- 本文 `claim_product_of_kronecker_products_is_kronecker_product_of_products` を必要十分版から得る。 -/
theorem mul_kroneckerProduct_of_necSuf (M : ℕ) (A B : ℕ → Mat (Idx 2)) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerProduct M A) (kroneckerProduct M B)
      = kroneckerProduct M (fun k => Mat.mul isFiniteSet_two (A k) (B k)) := by
  simp only [Mat.mul_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mul_kroneckerProduct complexValuedMapsLaws mul_comm mul_one mul_zero
    M A B

/-- 本文 `claim_kronecker_product_of_identity_matrices_is_identity_matrix` を必要十分版から得る。 -/
theorem kroneckerProduct_one_of_necSuf (M : ℕ) :
    kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2))) = (Mat.one : Mat (PowerSet M)) := by
  rw [kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.kroneckerProduct_one mul_one mul_assoc (fun a => mul_comm a 0) zero_mul M

/-- 本文 `claim_kronecker_product_is_linear_in_one_factor` を必要十分版から得る。 -/
theorem kroneckerProduct_linear_in_one_factor_of_necSuf (M r : ℕ) (hr1 : 1 ≤ r) (hrM : r ≤ M) (l l' : ℂ)
    (A A' A'' : ℕ → Mat (Idx 2))
    (hne : ∀ k : ℕ, 1 ≤ k → k ≤ M → k ≠ r → A k = A' k ∧ A k = A'' k)
    (hr : A'' r = Mat.add (Mat.smul l (A r)) (Mat.smul l' (A' r))) :
    kroneckerProduct M A''
      = Mat.add (Mat.smul l (kroneckerProduct M A)) (Mat.smul l' (kroneckerProduct M A')) := by
  rw [kroneckerProduct_eq_necSuf, kroneckerProduct_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.kroneckerProduct_linear_in_one_factor mul_add add_mul mul_assoc M r hr1 hrM
    l l' (fun a => mul_comm a l) (fun a => mul_comm a l') A A' A'' hne hr

/-- 本文 `claim_kronecker_products_of_factorwise_equal_families_are_equal` を必要十分版から得る。 -/
theorem kroneckerProduct_congr_of_necSuf (M : ℕ) (A A' : ℕ → Mat (Idx 2))
    (h : ∀ t : ℕ, 1 ≤ t → t ≤ M → A t = A' t) : kroneckerProduct M A = kroneckerProduct M A' := by
  rw [kroneckerProduct_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.kroneckerProduct_congr M A A' h

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の加法を保つことを必要十分版から得る。 -/
theorem conjugation_map_add_of_necSuf (hX : IsFiniteSet X) (U U' F G : Mat X) :
    conjugation hX U U' (Mat.add F G) = Mat.add (conjugation hX U U' F) (conjugation hX U U' G) := by
  rw [conjugation_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.conjugation_map_add complexValuedMapsLaws hX.toNecSuf U U' F G

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の乗法を保つことを必要十分版から得る。 -/
theorem conjugation_map_mul_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hU'U : Mat.mul hX U' U = Mat.one) (F G : Mat X) :
    Mat.mul hX (conjugation hX U U' F) (conjugation hX U U' G) = conjugation hX U U' (Mat.mul hX F G) := by
  rw [conjugation_eq_necSuf]
  rw [Mat.mul_eq_necSuf] at hU'U
  simp only [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.conjugation_map_mul complexValuedMapsLaws mul_comm mul_zero hX.toNecSuf U U' hU'U F G

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の乗法の単位元を保つことを必要十分版から得る。 -/
theorem conjugation_map_one_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hUU' : Mat.mul hX U U' = Mat.one) : conjugation hX U U' Mat.one = Mat.one := by
  rw [conjugation_eq_necSuf]
  rw [Mat.mul_eq_necSuf] at hUU'
  exact NecSuf.ComplexMatrixAlgebra.conjugation_map_one complexValuedMapsLaws (fun a => mul_comm 0 a)
    (fun a => mul_comm 1 a) hX.toNecSuf U U' hUU'

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` のスカラー倍を保つことを必要十分版から得る。 -/
theorem conjugation_map_smul_of_necSuf (hX : IsFiniteSet X) (U U' : Mat X) (l : ℂ) (F : Mat X) :
    conjugation hX U U' (Mat.smul l F) = Mat.smul l (conjugation hX U U' F) := by
  rw [conjugation_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.conjugation_map_smul complexValuedMapsLaws mul_comm mul_zero hX.toNecSuf U U' l F

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem conjugation_isComplexAlgebraHomomorphism_of_necSuf (hX : IsFiniteSet X) [DecidableEq X]
    (U U' : Mat X) (hUU' : Mat.mul hX U U' = Mat.one) (hU'U : Mat.mul hX U' U = Mat.one) :
    ComplexAlgebra.IsComplexAlgebraHomomorphism (matricesComplexAlgebra hX) (matricesComplexAlgebra hX)
      (conjugation hX U U') := by
  rw [ComplexAlgebra.isComplexAlgebraHomomorphism_iff_necSuf, matricesComplexAlgebra_toNecSuf,
    conjugation_eq_necSuf]
  rw [Mat.mul_eq_necSuf] at hUU' hU'U
  exact NecSuf.ComplexMatrixAlgebra.conjugation_isAlgebraHomomorphism complexValuedMapsLaws mul_comm mul_zero
    hX.toNecSuf U U' hUU' hU'U

/-- 本文 `claim_conjugations_by_mutually_inverse_matrices_compose_to_identity` を必要十分版から得る。 -/
theorem conjugation_conjugation_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hU'U : Mat.mul hX U' U = Mat.one) (F : Mat X) :
    conjugation hX U' U (conjugation hX U U' F) = F := by
  rw [conjugation_eq_necSuf, conjugation_eq_necSuf]
  rw [Mat.mul_eq_necSuf] at hU'U
  exact NecSuf.ComplexMatrixAlgebra.conjugation_conjugation complexValuedMapsLaws mul_comm mul_zero hX.toNecSuf U U'
    hU'U F

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
