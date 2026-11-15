/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、{1,2} で添字づけた行列とその間の等式の具体版が、
必要十分版の K := ℂ、i := imaginaryUnit、h := inverseOfTwo への特殊化として得られることを示す導出版。
具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                              必要十分版の特殊化
  matrixOfEntries・pauliX・pauliY・pauliZ・exchangeMatrix・halfExchangeMatrix・offDiagonalSum・imaginaryOffDiagonalCombination
                                                      …_eq_necSuf（同じ式。rfl）
  各主張                                              …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`、`mul_zero`・`mul_one`・`zero_mul`・`add_zero`・`zero_add`、`add_neg_cancel`（a + (-a) = 0）、
`neg_mul`・`mul_neg`、`neg_neg`、(1 + 1) · h = 1 の `mul_inverseOfTwo` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.PauliMatrices
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.PauliMatrices
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProductFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnitsFromNecSuf

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

theorem matrixOfEntries_eq_necSuf (a11 a12 a21 a22 : ℂ) :
    matrixOfEntries a11 a12 a21 a22 = NecSuf.Isomorphism.matrixOfEntries a11 a12 a21 a22 := rfl

/-- 本文 `def_pauli_matrix_x` の σx は、必要十分版の σx と同じ。 -/
theorem pauliX_eq_necSuf : pauliX = (NecSuf.Isomorphism.pauliX : NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

/-- 本文 `def_pauli_matrix_y` の σy は、必要十分版の σy の i := imaginaryUnit の場合と同じ。 -/
theorem pauliY_eq_necSuf : pauliY = NecSuf.Isomorphism.pauliY imaginaryUnit := rfl

/-- 本文 `def_pauli_matrix_z` の σz は、必要十分版の σz と同じ。 -/
theorem pauliZ_eq_necSuf : pauliZ = (NecSuf.Isomorphism.pauliZ : NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

/-- 本文 `def_matrix_exchanging_pauli_z_and_x` の K は、必要十分版の K と同じ。 -/
theorem exchangeMatrix_eq_necSuf :
    exchangeMatrix = (NecSuf.Isomorphism.exchangeMatrix : NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

/-- 本文 `def_half_of_matrix_exchanging_pauli_z_and_x` の K' は、必要十分版の K' の h := inverseOfTwo の場合と同じ。 -/
theorem halfExchangeMatrix_eq_necSuf : halfExchangeMatrix = NecSuf.Isomorphism.halfExchangeMatrix inverseOfTwo := rfl

theorem offDiagonalSum_eq_necSuf :
    offDiagonalSum = (NecSuf.Isomorphism.offDiagonalSum : NecSuf.ComplexMatrixAlgebra.Mat ℂ (Idx 2)) := rfl

theorem imaginaryOffDiagonalCombination_eq_necSuf :
    imaginaryOffDiagonalCombination = NecSuf.Isomorphism.imaginaryOffDiagonalCombination imaginaryUnit := rfl

/-! ### 主張 -/

/-- 本文 `claim_entries_of_combination_of_off_diagonal_matrix_units` を必要十分版から得る。 -/
theorem entries_offDiagonalCombination_of_necSuf (l l' : ℂ) :
    let D := Mat.add (Mat.smul l (matrixUnit idxTwo idxOne)) (Mat.smul l' (matrixUnit idxOne idxTwo))
    Mat.entry D idxOne idxOne = 0 ∧ Mat.entry D idxOne idxTwo = l'
      ∧ Mat.entry D idxTwo idxOne = l ∧ Mat.entry D idxTwo idxTwo = 0 :=
  NecSuf.Isomorphism.entries_offDiagonalCombination mul_zero mul_one _root_.add_zero _root_.zero_add l l'

/-- 本文 `claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity` を必要十分版から得る。 -/
theorem exchangeMatrix_mul_halfExchangeMatrix_of_necSuf :
    Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix = Mat.one := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.Isomorphism.exchangeMatrix_mul_halfExchangeMatrix complexValuedMapsLaws inverseOfTwo mul_inverseOfTwo
    add_neg_cancel neg_mul neg_neg

/-- 本文 `claim_half_times_matrix_exchanging_pauli_matrices_is_identity` を必要十分版から得る。 -/
theorem halfExchangeMatrix_mul_exchangeMatrix_of_necSuf :
    Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix = Mat.one := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.Isomorphism.halfExchangeMatrix_mul_exchangeMatrix complexValuedMapsLaws inverseOfTwo mul_inverseOfTwo
    mul_one add_neg_cancel neg_mul mul_neg neg_neg

/-- 本文 `claim_matrix_k_turns_pauli_z_into_pauli_x` を必要十分版から得る。 -/
theorem exchangeMatrix_mul_pauliZ_of_necSuf :
    Mat.mul isFiniteSet_two exchangeMatrix pauliZ = Mat.mul isFiniteSet_two pauliX exchangeMatrix := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.Isomorphism.exchangeMatrix_mul_pauliZ complexValuedMapsLaws mul_zero mul_one zero_mul neg_mul neg_neg

/-- 本文 `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z` を必要十分版から得る。 -/
theorem exchangeMatrix_mul_offDiagonalSum_of_necSuf :
    Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum = Mat.mul isFiniteSet_two pauliZ exchangeMatrix := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.Isomorphism.exchangeMatrix_mul_offDiagonalSum complexValuedMapsLaws mul_zero mul_one zero_mul neg_mul
    neg_neg

/-- 本文 `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y` を必要十分版から得る。 -/
theorem exchangeMatrix_mul_imaginaryOffDiagonalCombination_of_necSuf :
    Mat.mul isFiniteSet_two exchangeMatrix imaginaryOffDiagonalCombination
      = Mat.mul isFiniteSet_two pauliY exchangeMatrix := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.Isomorphism.exchangeMatrix_mul_imaginaryOffDiagonalCombination complexValuedMapsLaws mul_zero mul_one
    zero_mul neg_mul mul_neg neg_neg imaginaryUnit

end CliffordMatrixIsomorphism.Isomorphism
