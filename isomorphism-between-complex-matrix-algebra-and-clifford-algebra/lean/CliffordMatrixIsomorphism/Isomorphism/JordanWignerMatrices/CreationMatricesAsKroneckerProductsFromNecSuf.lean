/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、生成作用素・消滅作用素の行列をクロネッカー積で書く
三つの主張の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化として得られることを示す導出版。

  具体版                                         必要十分版の特殊化
  creationFactor・annihilationFactor             …_eq_necSuf（同じ式。rfl）
  各主張                                         …_of_necSuf

ℂ から渡す性質は、`mul_one`・`mul_zero`・`zero_mul`・`mul_assoc`、-1 の交換と 0・1 の交換（`mul_comm` から）、
-1 = n（n := -1_ℂ なので `rfl`）である。番号順の積・ς・c_m・c_m^T・クロネッカー積は既存の `…_eq_necSuf` で移す。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.CreationMatricesAsKroneckerProducts
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.PauliMatricesFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.CreationMatricesAsKroneckerProducts
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatricesFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSignFromNecSuf

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の族 A_k は、必要十分版の族と同じ。 -/
theorem creationFactor_eq_necSuf (m : ℕ) :
    creationFactor m = (NecSuf.Isomorphism.creationFactor m : ℕ → NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の族 A'_k は、必要十分版の族と同じ。 -/
theorem annihilationFactor_eq_necSuf (m : ℕ) :
    annihilationFactor m
      = (NecSuf.Isomorphism.annihilationFactor m : ℕ → NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

/-! ### 主張 -/

/-- 本文 `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count` を必要十分版から得る。 -/
theorem partialOrderedProduct_pauliZ_diagonal_eq_sign_of_necSuf {M : ℕ} (T : PowerSet M) (i : ℕ) (hi1 : 1 ≤ i)
    (α : ℕ → ℂ)
    (hα : ∀ k : ℕ, 1 ≤ k → k ≤ i - 1 → α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k)) :
    partialOrderedProduct α (i - 1) = sign (countBelow T i) := by
  rw [partialOrderedProduct_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.partialOrderedProduct_pauliZ_diagonal_eq_sign mul_one (fun a => mul_comm a (-1)) (-1) rfl
    T i hi1 α hα

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` を必要十分版から得る。 -/
theorem creationMatrix_eq_kroneckerProduct_of_necSuf (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    creationMatrix M m hm = kroneckerProduct M (creationFactor m) := by
  rw [creationMatrix_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.Isomorphism.creationMatrix_eq_kroneckerProduct mul_one mul_zero zero_mul mul_assoc
    (fun a => mul_comm a (-1)) (-1) rfl M m hm

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` を必要十分版から得る。 -/
theorem annihilationMatrix_eq_kroneckerProduct_of_necSuf (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    annihilationMatrix M m hm = kroneckerProduct M (annihilationFactor m) := by
  rw [annihilationMatrix_eq_necSuf, kroneckerProduct_eq_necSuf]
  exact NecSuf.Isomorphism.annihilationMatrix_eq_kroneckerProduct mul_one mul_zero zero_mul mul_assoc
    (fun a => mul_comm a (-1)) (fun a => mul_comm 0 a) (fun a => mul_comm 1 a) (-1) rfl M m hm

end CliffordMatrixIsomorphism.Isomorphism
