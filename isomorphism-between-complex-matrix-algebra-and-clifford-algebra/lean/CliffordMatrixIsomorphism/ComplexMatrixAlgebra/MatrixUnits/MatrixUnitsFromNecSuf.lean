/-
章「複素行列環」の、行列単位とその積の規則、成分を取り出す写像、単位行列と行列の行列単位による分解の具体版が、
必要十分版の K := ℂ への特殊化として得られることを示す導出版。具体版のファイルは必要十分版を引かない。
このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                      必要十分版の特殊化
  MatrixUnits.kroneckerDelta_swap             MatrixUnits.kroneckerDelta_swap_of_necSuf
  matrixUnit・entryMap                        matrixUnit_eq_necSuf・entryMap_eq_necSuf（同じ式。rfl）
  matrixUnit_mul_matrixUnit                   matrixUnit_mul_matrixUnit_of_necSuf
  entryMap_isComplexLinearMap                 entryMap_isComplexLinearMap_of_necSuf
  sum_matrixUnit_diagonal_eq_one              sum_matrixUnit_diagonal_eq_one_of_necSuf
  eq_double_sum_entry_smul_matrixUnit         eq_double_sum_entry_smul_matrixUnit_of_necSuf

Mat_X(ℂ) の中の和は `sumOverFiniteSet_eq_necSuf` で必要十分版の和へ移す。そのとき和をとる線型空間
`(matricesVectorSpace X).toNecSuf` は必要十分版の `matricesVectorSpace complexValuedMapsLaws X` と、ℂ^vec の
`complexNumbersVectorSpace.toNecSuf` は `coefficientsVec complexValuedMapsLaws` と、どちらも定義により一致する。
ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）と、0 と 1 がどの元とも交換すること（`mul_comm` から）である。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.MatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-! ### 定義の対応 -/

theorem matrixUnit_eq_necSuf [DecidableEq X] (x y : X) :
    matrixUnit x y = (NecSuf.ComplexMatrixAlgebra.matrixUnit x y : NecSuf.ComplexMatrixAlgebra.Mat ℂ X) := rfl

/-- 本文 `claim_matrix_entry_map_is_linear_map` の ent_{p,q} は、必要十分版の ent_{p,q} と同じ。 -/
theorem entryMap_eq_necSuf (p q : X) :
    entryMap p q = (NecSuf.ComplexMatrixAlgebra.entryMap p q : NecSuf.ComplexMatrixAlgebra.Mat ℂ X → ℂ) := rfl

/-- ℂ では 0 がどの元とも交換する。 -/
theorem MatrixUnits.complex_zero_mul_comm (a : ℂ) : 0 * a = a * 0 := mul_comm 0 a

/-- ℂ では 1 がどの元とも交換する。 -/
theorem MatrixUnits.complex_one_mul_comm (a : ℂ) : 1 * a = a * 1 := mul_comm 1 a

/-! ### 主張 -/

theorem MatrixUnits.kroneckerDelta_swap_of_necSuf [DecidableEq X] (i j : X) :
    kroneckerDelta i j = kroneckerDelta j i :=
  NecSuf.ComplexMatrixAlgebra.MatrixUnits.kroneckerDelta_swap (K := ℂ) i j

/-- 本文 `claim_product_of_matrix_units` を必要十分版から得る。 -/
theorem matrixUnit_mul_matrixUnit_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (x y z w : X) :
    Mat.mul hX (matrixUnit x y) (matrixUnit z w) = Mat.smul (kroneckerDelta y z) (matrixUnit x w) := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.matrixUnit_mul_matrixUnit complexValuedMapsLaws
    MatrixUnits.complex_zero_mul_comm MatrixUnits.complex_one_mul_comm hX x y z w

/-- 本文 `claim_matrix_entry_map_is_linear_map` を必要十分版から得る。 -/
theorem entryMap_isComplexLinearMap_of_necSuf (X : Type u) (p q : X) :
    IsComplexLinearMap (matricesVectorSpace X) complexNumbersVectorSpace (entryMap p q) :=
  (isComplexLinearMap_iff_necSuf _ _ _).2
    (NecSuf.ComplexMatrixAlgebra.entryMap_isLinearMap complexValuedMapsLaws X p q)

/-- 本文 `claim_decomposition_of_identity_matrix_into_matrix_units` を必要十分版から得る。 -/
theorem sum_matrixUnit_diagonal_eq_one_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] :
    sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1) (fun x => matrixUnit x x) = Mat.one := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.sum_matrixUnit_diagonal_eq_one complexValuedMapsLaws hX

/-- 本文 `claim_matrix_is_double_sum_of_entries_times_matrix_units` を必要十分版から得る。 -/
theorem eq_double_sum_entry_smul_matrixUnit_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (F : Mat X) :
    F = sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1)
      (fun x => sumOverFiniteSet (matricesVectorSpace X) hX (fun y => Mat.entry F x y)
        (fun y => matrixUnit x y)) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.eq_double_sum_entry_smul_matrixUnit complexValuedMapsLaws
    MatrixUnits.complex_zero_mul_comm MatrixUnits.complex_one_mul_comm hX F

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
