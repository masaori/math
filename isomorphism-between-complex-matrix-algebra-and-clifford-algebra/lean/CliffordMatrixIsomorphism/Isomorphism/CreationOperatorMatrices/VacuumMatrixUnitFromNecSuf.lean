/-
章「同型の証明」の、空集合の位置の行列単位についての三つの主張の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化として
得られることを示す導出版。具体版のファイルは必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張
`…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。

  具体版                                                              必要十分版の特殊化
  notMemIndicator・vacuumIndicator                                    notMemIndicator_eq_necSuf・vacuumIndicator_eq_necSuf（rfl）
  annihilationTimesCreation・selectedCreation・
  reversedSelectedAnnihilation                                        …_eq_necSuf（行列の積は `Mat.mul_eq_necSuf`、c_i・c_i^T は
                                                                      `creationMatrix_eq_necSuf`・`annihilationMatrix_eq_necSuf` で移す）
  orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit        …_of_necSuf
  orderedProduct_selectedCreation_mul_vacuumMatrixUnit                …_of_necSuf
  vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation    …_of_necSuf

番号順の積は `orderedProduct_eq_necSuf` で必要十分版の番号順の積へ移し、代数は `matricesComplexAlgebra_toNecSuf` で
必要十分版の `matricesAlgebra complexValuedMapsLaws mul_comm mul_zero` へ移す。
ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、a · 0 = 0 の `mul_zero`、
a · 1 = a の `mul_one`、0 · a = 0 の `zero_mul`、`signLaws_complex` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.VacuumMatrixUnit
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatricesFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnitsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.VacuumMatrixUnit

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

theorem notMemIndicator_eq_necSuf {M : ℕ} (i : ℕ) (U : PowerSet M) :
    notMemIndicator i U = (NecSuf.Isomorphism.notMemIndicator i U : ℂ) := rfl

theorem vacuumIndicator_eq_necSuf {M : ℕ} (m : ℕ) (S U : PowerSet M) :
    vacuumIndicator m S U = (NecSuf.Isomorphism.vacuumIndicator m S U : ℂ) := rfl

/-- 具体版の x_i は、必要十分版の x_i の K := ℂ、n := -1_ℂ の場合と同じ。 -/
theorem annihilationTimesCreation_eq_necSuf (M : ℕ) :
    annihilationTimesCreation M
      = NecSuf.Isomorphism.annihilationTimesCreation complexValuedMapsLaws (-1 : ℂ) M := by
  funext i
  by_cases hi : 1 ≤ i ∧ i ≤ M
  · rw [annihilationTimesCreation_of_mem hi,
      NecSuf.Isomorphism.annihilationTimesCreation_of_mem complexValuedMapsLaws (-1 : ℂ) hi,
      Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf]
  · show (if hi : 1 ≤ i ∧ i ≤ M then _ else Mat.one)
      = (if hi : 1 ≤ i ∧ i ≤ M then _ else NecSuf.ComplexMatrixAlgebra.Mat.one)
    rw [dif_neg hi, dif_neg hi]
    rfl

/-- 具体版の y_t は、必要十分版の y_t の n := -1_ℂ の場合と同じ。 -/
theorem selectedCreation_eq_necSuf (M : ℕ) (S : PowerSet M) :
    selectedCreation M S = NecSuf.Isomorphism.selectedCreation (-1 : ℂ) M S := by
  funext t
  by_cases h : t ∈ S.1
  · rw [selectedCreation_of_mem (S.2 t h) h,
      NecSuf.Isomorphism.selectedCreation_of_mem (-1 : ℂ) (S.2 t h) h, creationMatrix_eq_necSuf]
  · rw [selectedCreation_of_not_mem h, NecSuf.Isomorphism.selectedCreation_of_not_mem (-1 : ℂ) h]
    rfl

/-- 具体版の ž_k は、必要十分版の ž_k の n := -1_ℂ の場合と同じ。 -/
theorem reversedSelectedAnnihilation_eq_necSuf (M : ℕ) (T : PowerSet M) :
    reversedSelectedAnnihilation M T = NecSuf.Isomorphism.reversedSelectedAnnihilation (-1 : ℂ) M T := by
  funext k
  by_cases h : M + 1 - k ∈ T.1
  · rw [reversedSelectedAnnihilation_of_mem (T.2 _ h) h,
      NecSuf.Isomorphism.reversedSelectedAnnihilation_of_mem (-1 : ℂ) (T.2 _ h) h,
      annihilationMatrix_eq_necSuf]
  · rw [reversedSelectedAnnihilation_of_not_mem h,
      NecSuf.Isomorphism.reversedSelectedAnnihilation_of_not_mem (-1 : ℂ) h]
    rfl

/-! ### 主張 -/

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` を必要十分版から得る。 -/
theorem orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit_of_necSuf (M : ℕ) :
    ComplexAlgebra.orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (annihilationTimesCreation M)
      = matrixUnit (emptyIndexSet M) (emptyIndexSet M) := by
  rw [ComplexAlgebra.orderedProduct_eq_necSuf, matricesComplexAlgebra_toNecSuf, annihilationTimesCreation_eq_necSuf,
    matrixUnit_eq_necSuf]
  exact NecSuf.Isomorphism.orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit complexValuedMapsLaws
    mul_comm mul_zero mul_one zero_mul (-1 : ℂ) signLaws_complex M

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` を必要十分版から得る。 -/
theorem orderedProduct_selectedCreation_mul_vacuumMatrixUnit_of_necSuf (M : ℕ) (S : PowerSet M) :
    Mat.mul (isFiniteSet_powerSet M)
        (ComplexAlgebra.orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (selectedCreation M S))
        (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
      = matrixUnit S (emptyIndexSet M) := by
  rw [Mat.mul_eq_necSuf, ComplexAlgebra.orderedProduct_eq_necSuf, matricesComplexAlgebra_toNecSuf,
    selectedCreation_eq_necSuf, matrixUnit_eq_necSuf, matrixUnit_eq_necSuf]
  exact NecSuf.Isomorphism.orderedProduct_selectedCreation_mul_vacuumMatrixUnit complexValuedMapsLaws
    mul_comm mul_zero zero_mul (-1 : ℂ) M S

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` を
必要十分版から得る。 -/
theorem vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation_of_necSuf (M : ℕ)
    (T : PowerSet M) :
    Mat.mul (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
        (ComplexAlgebra.orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (reversedSelectedAnnihilation M T))
      = matrixUnit (emptyIndexSet M) T := by
  rw [Mat.mul_eq_necSuf, ComplexAlgebra.orderedProduct_eq_necSuf, matricesComplexAlgebra_toNecSuf,
    reversedSelectedAnnihilation_eq_necSuf, matrixUnit_eq_necSuf, matrixUnit_eq_necSuf]
  exact NecSuf.Isomorphism.vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation
    complexValuedMapsLaws mul_comm mul_zero (-1 : ℂ) M T

end CliffordMatrixIsomorphism.Isomorphism
