/-
章「複素行列環」の、行列の集合の線型空間・積の性質・代数の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、
必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                 必要十分版の特殊化
  Mat・Mat.add・Mat.smul・Mat.zero・Mat.one
                                         …_eq_necSuf（同じ式。rfl）
  Mat.mul                                Mat.mul_eq_necSuf（成分の和を `sumOverFiniteSet_eq_necSuf` で移す。
                                         ℂ^vec は必要十分版の `coefficientsVec complexValuedMapsLaws` と rfl で一致）
  matricesVectorSpace                    matricesVectorSpace_of_necSuf と、具体版との一致（rfl）・matricesVectorSpace_toNecSuf
  matricesComplexAlgebra                 matricesComplexAlgebra_of_necSuf と、具体版との一致 matricesComplexAlgebra_eq_of_necSuf
                                         （積の欄だけが定義によらず Mat.mul_eq_necSuf で一致する）
  各主張                                 …_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、a · 0 = 0 の `mul_zero` である。
右の単位元の主張には、0 と 1 がどの元とも交換すること（`mul_comm` を 0 と 1 に当てたもの）を渡す。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.TensorProductFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-! ### 定義の対応 -/

theorem mat_eq_necSuf (X : Type u) : Mat X = NecSuf.ComplexMatrixAlgebra.Mat ℂ X := rfl

/-- 本文 `def_matrices_indexed_by_finite_set` の加法は、必要十分版の加法と同じ式。 -/
theorem Mat.add_eq_necSuf (A B : Mat X) : Mat.add A B = NecSuf.ComplexMatrixAlgebra.Mat.add A B := rfl

/-- 本文 `def_matrices_indexed_by_finite_set` のスカラー倍は、必要十分版のスカラー倍と同じ式。 -/
theorem Mat.smul_eq_necSuf (l : ℂ) (A : Mat X) :
    Mat.smul l A = NecSuf.ComplexMatrixAlgebra.Mat.smul l A := rfl

/-- 本文 `def_matrices_indexed_by_finite_set` の零行列は、必要十分版の零行列と同じ式。 -/
theorem Mat.zero_eq_necSuf : (Mat.zero : Mat X) = NecSuf.ComplexMatrixAlgebra.Mat.zero := rfl

/-- 本文 `def_matrices_indexed_by_finite_set` の単位行列は、必要十分版の単位行列と同じ式。 -/
theorem Mat.one_eq_necSuf [DecidableEq X] : (Mat.one : Mat X) = NecSuf.ComplexMatrixAlgebra.Mat.one := rfl

/-- 本文 `def_matrices_indexed_by_finite_set` の積は、必要十分版の積の K := ℂ の場合と一致する。 -/
theorem Mat.mul_eq_necSuf (hX : IsFiniteSet X) (A B : Mat X) :
    Mat.mul hX A B = NecSuf.ComplexMatrixAlgebra.Mat.mul complexValuedMapsLaws hX A B :=
  funext fun p => sumOverFiniteSet_eq_necSuf complexNumbersVectorSpace hX
    (fun z => Mat.entry A p.1 z) (fun z => Mat.entry B z p.2)

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_vector_space` を、必要十分版に ℂ の性質を渡して得たもの。 -/
def matricesVectorSpace_of_necSuf (X : Type u) : ComplexVectorSpace (Mat X) :=
  let N := NecSuf.ComplexMatrixAlgebra.matricesVectorSpace complexValuedMapsLaws X
  { add := N.add
    smul := N.smul
    zero := N.zero
    add_assoc := N.add_assoc
    add_comm := N.add_comm
    add_zero := N.add_zero
    exists_add_inverse := N.exists_add_inverse
    smul_assoc := N.smul_assoc
    one_smul := N.one_smul
    smul_add := N.smul_add
    add_smul := N.add_smul }

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_vector_space` の具体版の組は、必要十分版から作った組と同じ。 -/
theorem matricesVectorSpace_eq_of_necSuf (X : Type u) :
    matricesVectorSpace X = matricesVectorSpace_of_necSuf X := rfl

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_vector_space` の具体版の組を必要十分版の組として読むと、必要十分版の組と同じ。 -/
theorem matricesVectorSpace_toNecSuf (X : Type u) :
    (matricesVectorSpace X).toNecSuf
      = NecSuf.ComplexMatrixAlgebra.matricesVectorSpace complexValuedMapsLaws X := rfl

/-! ### 主張 -/

/-- 本文 `claim_matrix_product_is_associative` を必要十分版から得る。 -/
theorem mat_mul_assoc_of_necSuf (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX (Mat.mul hX A B) C = Mat.mul hX A (Mat.mul hX B C) := by
  rw [Mat.mul_eq_necSuf hX A B, Mat.mul_eq_necSuf hX B C, Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mat_mul_assoc complexValuedMapsLaws mul_comm mul_zero hX A B C

/-- 本文 `claim_matrix_product_distributes_over_sum_in_right_factor` を必要十分版から得る。 -/
theorem mat_mul_add_of_necSuf (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX A (Mat.add B C) = Mat.add (Mat.mul hX A B) (Mat.mul hX A C) := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf hX A B, Mat.mul_eq_necSuf hX A C]
  exact NecSuf.ComplexMatrixAlgebra.mat_mul_add complexValuedMapsLaws hX A B C

/-- 本文 `claim_matrix_product_distributes_over_sum_in_left_factor` を必要十分版から得る。 -/
theorem mat_add_mul_of_necSuf (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX (Mat.add A B) C = Mat.add (Mat.mul hX A C) (Mat.mul hX B C) := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf hX A C, Mat.mul_eq_necSuf hX B C]
  exact NecSuf.ComplexMatrixAlgebra.mat_add_mul complexValuedMapsLaws hX A B C

/-- 本文 `claim_identity_matrix_is_left_unit_of_matrix_product` を必要十分版から得る。 -/
theorem mat_one_mul_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (A : Mat X) :
    Mat.mul hX Mat.one A = A := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mat_one_mul complexValuedMapsLaws hX A

/-- 本文 `claim_identity_matrix_is_right_unit_of_matrix_product` を必要十分版から得る。 -/
theorem mat_mul_one_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] (A : Mat X) :
    Mat.mul hX A Mat.one = A := by
  rw [Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mat_mul_one complexValuedMapsLaws (fun a => mul_comm 0 a) (fun a => mul_comm 1 a)
    hX A

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor` を必要十分版から得る。 -/
theorem mat_smul_mul_left_of_necSuf (hX : IsFiniteSet X) (l : ℂ) (A B : Mat X) :
    Mat.smul l (Mat.mul hX A B) = Mat.mul hX (Mat.smul l A) B := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mat_smul_mul_left complexValuedMapsLaws mul_zero hX l A B

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor` を必要十分版から得る。 -/
theorem mat_smul_mul_right_of_necSuf (hX : IsFiniteSet X) (l : ℂ) (A B : Mat X) :
    Mat.smul l (Mat.mul hX A B) = Mat.mul hX A (Mat.smul l B) := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.mat_smul_mul_right complexValuedMapsLaws mul_comm mul_zero hX l A B

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
noncomputable def matricesComplexAlgebra_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] :
    ComplexAlgebra (Mat X) :=
  let N := NecSuf.ComplexMatrixAlgebra.matricesAlgebra complexValuedMapsLaws mul_comm mul_zero hX
  { toUnitalRing := N.toUnitalRing
    smul := N.smul
    smul_assoc := N.smul_assoc
    one_smul := N.one_smul
    smul_add := N.smul_add
    add_smul := N.add_smul
    smul_mul_left := N.smul_mul_left
    smul_mul_right := N.smul_mul_right }

/-- 具体版の ℂ-代数は、必要十分版から作った ℂ-代数と同じ組である（積の欄は `Mat.mul_eq_necSuf` で一致し、
ほかの欄は定義による）。 -/
theorem matricesComplexAlgebra_eq_of_necSuf (hX : IsFiniteSet X) [DecidableEq X] :
    matricesComplexAlgebra hX = matricesComplexAlgebra_of_necSuf hX := by
  have hmul : Mat.mul hX = NecSuf.ComplexMatrixAlgebra.Mat.mul complexValuedMapsLaws hX :=
    funext fun A => funext fun B => Mat.mul_eq_necSuf hX A B
  unfold matricesComplexAlgebra matricesComplexAlgebra_of_necSuf
  -- 欄ごとに比べ、積の欄の等式 Mat.mul hX = …（congr が残す唯一の等式）を仮定 hmul で閉じる
  congr

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra` の具体版の組を必要十分版の代数として読むと、必要十分版の組と同じ。 -/
theorem matricesComplexAlgebra_toNecSuf (hX : IsFiniteSet X) [DecidableEq X] :
    (matricesComplexAlgebra hX).toNecSuf
      = NecSuf.ComplexMatrixAlgebra.matricesAlgebra complexValuedMapsLaws mul_comm mul_zero hX := by
  rw [matricesComplexAlgebra_eq_of_necSuf hX]
  rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
