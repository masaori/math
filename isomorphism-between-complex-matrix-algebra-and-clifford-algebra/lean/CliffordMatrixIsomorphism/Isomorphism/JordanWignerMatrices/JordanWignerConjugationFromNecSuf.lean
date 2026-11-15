/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Z_m・Y_m・U・U' と、生成作用素・消滅作用素の行列を
U と U' で挟んだ行列の具体版が、必要十分版の K := ℂ、n := -1_ℂ、i := imaginaryUnit、h := inverseOfTwo への特殊化として
得られることを示す導出版。

  具体版                                                     必要十分版の特殊化
  jordanWignerZ・jordanWignerY・kroneckerPowerOfExchange・kroneckerPowerOfHalfExchange
                                                             …_eq_necSuf（クロネッカー積を `kroneckerProduct_eq_necSuf` で移す）
  各主張                                                     …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`、`mul_comm`、`mul_zero`、`add_neg_cancel`、`neg_mul`、`neg_neg`、
(1 + 1) · h = 1 の `mul_inverseOfTwo`、-1 = n（`rfl`）である。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugation
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.CreationMatricesAsKroneckerProductsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.JordanWignerConjugation

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

/-- 本文 `def_jordan_wigner_z_matrix` の Z_m は、必要十分版の Z_m と一致する。 -/
theorem jordanWignerZ_eq_necSuf (M m : ℕ) : jordanWignerZ M m = NecSuf.Isomorphism.jordanWignerZ M m :=
  kroneckerProduct_eq_necSuf M _

/-- 本文 `def_jordan_wigner_y_matrix` の Y_m は、必要十分版の Y_m の i := imaginaryUnit の場合と一致する。 -/
theorem jordanWignerY_eq_necSuf (M m : ℕ) : jordanWignerY M m = NecSuf.Isomorphism.jordanWignerY imaginaryUnit M m :=
  kroneckerProduct_eq_necSuf M _

/-- 本文 `def_kronecker_power_of_matrix_exchanging_pauli_z_and_x` の U は、必要十分版の U と一致する。 -/
theorem kroneckerPowerOfExchange_eq_necSuf (M : ℕ) :
    kroneckerPowerOfExchange M = NecSuf.Isomorphism.kroneckerPowerOfExchange M :=
  kroneckerProduct_eq_necSuf M _

/-- 本文 `def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x` の U' は、必要十分版の U' の
h := inverseOfTwo の場合と一致する。 -/
theorem kroneckerPowerOfHalfExchange_eq_necSuf (M : ℕ) :
    kroneckerPowerOfHalfExchange M = NecSuf.Isomorphism.kroneckerPowerOfHalfExchange inverseOfTwo M :=
  kroneckerProduct_eq_necSuf M _

/-! ### 主張 -/

/-- 本文 `claim_kronecker_power_of_k_times_that_of_its_half_is_identity` を必要十分版から得る。 -/
theorem kroneckerPowerOfExchange_mul_half_of_necSuf (M : ℕ) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M) = Mat.one := by
  rw [Mat.mul_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf, kroneckerPowerOfHalfExchange_eq_necSuf]
  exact NecSuf.Isomorphism.kroneckerPowerOfExchange_mul_half complexValuedMapsLaws mul_comm mul_zero add_neg_cancel
    neg_mul neg_neg inverseOfTwo mul_inverseOfTwo M

/-- 本文 `claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity` を必要十分版から得る。 -/
theorem kroneckerPowerOfHalfExchange_mul_of_necSuf (M : ℕ) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfHalfExchange M) (kroneckerPowerOfExchange M) = Mat.one := by
  rw [Mat.mul_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf, kroneckerPowerOfHalfExchange_eq_necSuf]
  exact NecSuf.Isomorphism.kroneckerPowerOfHalfExchange_mul complexValuedMapsLaws mul_comm mul_zero add_neg_cancel
    neg_mul neg_neg inverseOfTwo mul_inverseOfTwo M

/-- 本文 `claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix` を必要十分版から得る。 -/
theorem conjugation_creation_add_annihilation_of_necSuf (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M)
      (Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm)) = jordanWignerZ M m := by
  rw [conjugation_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf, kroneckerPowerOfHalfExchange_eq_necSuf,
    creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf, jordanWignerZ_eq_necSuf]
  exact NecSuf.Isomorphism.conjugation_creation_add_annihilation complexValuedMapsLaws mul_comm mul_zero add_neg_cancel
    neg_mul neg_neg inverseOfTwo mul_inverseOfTwo (-1) rfl M m hm

/-- 本文 `claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix` を
必要十分版から得る。 -/
theorem conjugation_imaginary_combination_of_necSuf (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M)
      (Mat.add (Mat.smul (-imaginaryUnit) (creationMatrix M m hm)) (Mat.smul imaginaryUnit (annihilationMatrix M m hm)))
      = jordanWignerY M m := by
  rw [conjugation_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf, kroneckerPowerOfHalfExchange_eq_necSuf,
    creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf, jordanWignerY_eq_necSuf]
  exact NecSuf.Isomorphism.conjugation_imaginary_combination complexValuedMapsLaws mul_comm mul_zero add_neg_cancel
    neg_mul neg_neg inverseOfTwo mul_inverseOfTwo (-1) rfl imaginaryUnit M m hm

end CliffordMatrixIsomorphism.Isomorphism
