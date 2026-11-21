/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、番号で添字づけたサイトごとの Pauli 行列、
Z^{(2^M)}_m・Y^{(2^M)}_m と、Z_m・Y_m を ν_{r_M} で付け替えるとそれになることの具体版が、必要十分版の K := ℂ、i := imaginaryUnit への
特殊化として得られることを示す導出版。

  具体版                                                     必要十分版の特殊化
  pauliOf・sitePauliFamily・sitePauli・
  numberedJordanWignerFactor                                 …_eq_necSuf（番号で添字づけたクロネッカー積を `numberedKroneckerProduct_eq_necSuf` で移す）
  numberedJordanWignerZ・numberedJordanWignerY               …_eq_necSuf（B̂ の中の番号順の積を `orderedProduct_eq_necSuf` と
                                                             `matricesComplexAlgebra_toNecSuf` で移す）
  各主張                                                     …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、a · 0 = 0 の `mul_zero` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IndexedByNumbers
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugationFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.FirstSiteHighestDigitNumberingFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.IndexedByNumbers

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

/-- 具体版の {x, y, z} の元を、必要十分版の同じ名前の元へ送る（二つの版に同じ形で別に置いた帰納型の間の写像）。 -/
def PauliLabel.toNecSuf : PauliLabel → NecSuf.Isomorphism.PauliLabel
  | .x => .x
  | .y => .y
  | .z => .z

/-- 具体版の {y, z} の元を、必要十分版の同じ名前の元へ送る。 -/
def JordanWignerLabel.toNecSuf : JordanWignerLabel → NecSuf.Isomorphism.JordanWignerLabel
  | .y => .y
  | .z => .z

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の σ^{a} は、必要十分版の σ^{a} の i := imaginaryUnit の場合と同じ。 -/
theorem pauliOf_eq_necSuf (a : PauliLabel) : pauliOf a = NecSuf.Isomorphism.pauliOf imaginaryUnit a.toNecSuf := by
  cases a <;> rfl

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の右辺の族は、必要十分版の族の i := imaginaryUnit の場合と同じ。 -/
theorem sitePauliFamily_eq_necSuf (a : PauliLabel) (k : ℕ) :
    sitePauliFamily a k = NecSuf.Isomorphism.sitePauliFamily imaginaryUnit a.toNecSuf k := by
  funext t
  cases a <;> rfl

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の σ^{a}_{k} は、必要十分版の σ^{a}_{k} の i := imaginaryUnit の場合と一致する。 -/
theorem sitePauli_eq_necSuf (M : ℕ) (a : PauliLabel) (k : ℕ) :
    sitePauli M a k = NecSuf.Isomorphism.sitePauli imaginaryUnit M a.toNecSuf k := by
  rw [sitePauli, numberedKroneckerProduct_eq_necSuf, sitePauliFamily_eq_necSuf]
  rfl

/-- 本文 `def_factors_of_jordan_wigner_matrices_indexed_by_numbers` の F^{(b)}_{m,j} は、必要十分版の F^{(b)}_{m,j} の
i := imaginaryUnit の場合と一致する。 -/
theorem numberedJordanWignerFactor_eq_necSuf (M : ℕ) (b : JordanWignerLabel) (m : ℕ) :
    numberedJordanWignerFactor M b m = NecSuf.Isomorphism.numberedJordanWignerFactor imaginaryUnit M b.toNecSuf m := by
  funext j
  by_cases hjm : j < m
  · rw [numberedJordanWignerFactor, NecSuf.Isomorphism.numberedJordanWignerFactor, if_pos hjm, if_pos hjm,
      sitePauli_eq_necSuf]
    all_goals rfl
  · rw [numberedJordanWignerFactor, NecSuf.Isomorphism.numberedJordanWignerFactor, if_neg hjm, if_neg hjm,
      sitePauli_eq_necSuf]
    all_goals (cases b <;> rfl)

/-- 本文 `def_jordan_wigner_z_matrix_indexed_by_numbers` の Z^{(2^M)}_m は、必要十分版の Z^{(2^M)}_m と一致する。 -/
theorem numberedJordanWignerZ_eq_necSuf (M m : ℕ) :
    numberedJordanWignerZ M m
      = NecSuf.Isomorphism.numberedJordanWignerZ complexValuedMapsLaws mul_comm mul_zero imaginaryUnit M m := by
  rw [numberedJordanWignerZ, ComplexAlgebra.orderedProduct_eq_necSuf, numberedMatrixAlgebra,
    matricesComplexAlgebra_toNecSuf, numberedJordanWignerFactor_eq_necSuf]
  rfl

/-- 本文 `def_jordan_wigner_y_matrix_indexed_by_numbers` の Y^{(2^M)}_m は、必要十分版の Y^{(2^M)}_m の i := imaginaryUnit の場合と一致する。 -/
theorem numberedJordanWignerY_eq_necSuf (M m : ℕ) :
    numberedJordanWignerY M m
      = NecSuf.Isomorphism.numberedJordanWignerY complexValuedMapsLaws mul_comm mul_zero imaginaryUnit M m := by
  rw [numberedJordanWignerY, ComplexAlgebra.orderedProduct_eq_necSuf, numberedMatrixAlgebra,
    matricesComplexAlgebra_toNecSuf, numberedJordanWignerFactor_eq_necSuf]
  rfl

/-! ### 主張 -/

/-- 本文 `claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers` を必要十分版から得る。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerZ_of_necSuf (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerZ M m) = numberedJordanWignerZ M m := by
  rw [jordanWignerZ_eq_necSuf, numberedJordanWignerZ_eq_necSuf, firstSiteHighestReindexMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.firstSiteHighestReindexMatrix_jordanWignerZ complexValuedMapsLaws mul_comm mul_zero
    imaginaryUnit M m

/-- 本文 `claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers` を必要十分版から得る。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerY_of_necSuf (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerY M m) = numberedJordanWignerY M m := by
  rw [jordanWignerY_eq_necSuf, numberedJordanWignerY_eq_necSuf, firstSiteHighestReindexMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.firstSiteHighestReindexMatrix_jordanWignerY complexValuedMapsLaws mul_comm mul_zero
    imaginaryUnit M m

end CliffordMatrixIsomorphism.Isomorphism
