/-
章「同型の証明」のうち、生成作用素の行列の定義とその成分・反交換関係の部分の具体版が、必要十分版の
K := ℂ、n := -1_ℂ への特殊化として得られることを示す導出版。具体版のファイルはどれも必要十分版を引かない。
このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。

  具体版                                              必要十分版の特殊化
  creationMatrix・annihilationMatrix                  creationMatrix_eq_necSuf・annihilationMatrix_eq_necSuf
                                                      （成分の if の値 ς を `sign_eq_necSuf` で移す）
  entry_mul_creationMatrix                            entry_mul_creationMatrix_of_necSuf
  entry_creationMatrix_mul                            entry_creationMatrix_mul_of_necSuf
  entry_creationMatrix_mul_creationMatrix             entry_creationMatrix_mul_creationMatrix_of_necSuf
  creationMatrices_anticommute                        creationMatrices_anticommute_of_necSuf
  entry_annihilationMatrix_mul_annihilationMatrix     entry_annihilationMatrix_mul_annihilationMatrix_of_necSuf
  annihilationMatrices_anticommute                    annihilationMatrices_anticommute_of_necSuf
  entry_creationMatrix_mul_annihilationMatrix         entry_creationMatrix_mul_annihilationMatrix_of_necSuf
  entry_annihilationMatrix_mul_creationMatrix         entry_annihilationMatrix_mul_creationMatrix_of_necSuf
  creationMatrix_annihilationMatrix_anticommute       creationMatrix_annihilationMatrix_anticommute_of_necSuf

ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、a · 1 = a の `mul_one`、a · 0 = 0 の `mul_zero`、
0 · a = 0 の `zero_mul`、1 + (-1) = 0 の `add_neg_cancel`、(-1) + 1 = 1 + (-1) の `add_comm`、`signLaws_complex` である。
ς の値どうしの交換は、必要十分版が `complexValuedMapsLaws` の乗法の結合法則と 1 · a = a から作るので渡さない。
行列の積は `Mat.mul_eq_necSuf` で移す。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.Anticommutation
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSignFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.MatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.Anticommutation

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義の対応 -/

/-- 具体版の c_i は、必要十分版の c_i の n := -1_ℂ の場合と同じ。 -/
theorem creationMatrix_eq_necSuf (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) :
    creationMatrix M i hi = NecSuf.Isomorphism.creationMatrix (-1 : ℂ) M i hi := by
  funext p
  unfold creationMatrix NecSuf.Isomorphism.creationMatrix
  rw [sign_eq_necSuf]

/-- 具体版の c_i^T は、必要十分版の c_i^T の n := -1_ℂ の場合と同じ。 -/
theorem annihilationMatrix_eq_necSuf (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) :
    annihilationMatrix M i hi = NecSuf.Isomorphism.annihilationMatrix (-1 : ℂ) M i hi := by
  funext p
  show Mat.entry (creationMatrix M i hi) p.2 p.1
    = NecSuf.ComplexMatrixAlgebra.Mat.entry (NecSuf.Isomorphism.creationMatrix (-1 : ℂ) M i hi) p.2 p.1
  rw [creationMatrix_eq_necSuf]
  rfl

/-! ### 主張 -/

/-- 本文 `claim_entry_of_matrix_times_creation_operator_matrix` を必要十分版から得る。 -/
theorem entry_mul_creationMatrix_of_necSuf {M j : ℕ} (hj : 1 ≤ j ∧ j ≤ M) (A : Mat (PowerSet M))
    (S U : PowerSet M) :
    (j ∉ U.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) A (creationMatrix M j hj)) S U
        = Mat.entry A S (unionSingleton U j hj) * sign (countBelow U j))
      ∧ (j ∈ U.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) A (creationMatrix M j hj)) S U = 0) := by
  rw [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.entry_mul_creationMatrix complexValuedMapsLaws mul_one mul_zero zero_mul
    (-1 : ℂ) hj A S U

/-- 本文 `claim_entry_of_creation_operator_matrix_times_matrix` を必要十分版から得る。 -/
theorem entry_creationMatrix_mul_of_necSuf {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (A : Mat (PowerSet M))
    (S U : PowerSet M) :
    (i ∈ S.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) A) S U
        = sign (countBelow (removeIndex S i) i) * Mat.entry A (removeIndex S i) U)
      ∧ (i ∉ S.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) A) S U = 0) := by
  rw [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.entry_creationMatrix_mul complexValuedMapsLaws mul_zero zero_mul
    (-1 : ℂ) hi A S U

/-- 本文 `claim_creation_operator_matrices_anticommute` の（⋆）を必要十分版から得る。 -/
theorem entry_creationMatrix_mul_creationMatrix_of_necSuf {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    (creationCond hk hl S U →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = sign (countBelow (unionSingleton U l hl) k) * sign (countBelow U l))
      ∧ (¬creationCond hk hl S U →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = 0) := by
  simp only [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.entry_creationMatrix_mul_creationMatrix complexValuedMapsLaws mul_one mul_zero
    zero_mul (-1 : ℂ) hk hl S U

/-- 本文 `claim_creation_operator_matrices_anticommute` を必要十分版から得る。 -/
theorem creationMatrices_anticommute_of_necSuf {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M j hj) (creationMatrix M i hi))
      = Mat.zero := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, creationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.creationMatrices_anticommute complexValuedMapsLaws mul_one mul_zero zero_mul
    (-1 : ℂ) (add_neg_cancel (1 : ℂ)) (add_comm (-1 : ℂ) 1) hi hj

/-- 本文 `claim_annihilation_operator_matrices_anticommute` の（⋆）を必要十分版から得る。 -/
theorem entry_annihilationMatrix_mul_annihilationMatrix_of_necSuf {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M k hk) (annihilationMatrix M l hl)) S U
      = Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M l hl) (creationMatrix M k hk)) U S := by
  simp only [Mat.mul_eq_necSuf, annihilationMatrix_eq_necSuf, creationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.entry_annihilationMatrix_mul_annihilationMatrix complexValuedMapsLaws mul_zero
    zero_mul (-1 : ℂ) hk hl S U

/-- 本文 `claim_annihilation_operator_matrices_anticommute` を必要十分版から得る。 -/
theorem annihilationMatrices_anticommute_of_necSuf {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (annihilationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (annihilationMatrix M i hi))
      = Mat.zero := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf, annihilationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.annihilationMatrices_anticommute complexValuedMapsLaws mul_one mul_zero zero_mul
    (-1 : ℂ) (add_neg_cancel (1 : ℂ)) (add_comm (-1 : ℂ) 1) hi hj

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（⋆_1）を必要十分版から得る。 -/
theorem entry_creationMatrix_mul_annihilationMatrix_of_necSuf {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = sign (countBelow (removeIndex S i) i) * sign (countBelow (removeIndex S i) j))
      ∧ (¬(i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = 0) := by
  simp only [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.entry_creationMatrix_mul_annihilationMatrix complexValuedMapsLaws mul_zero zero_mul
    (-1 : ℂ) hi hj S U

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（⋆_2）を必要十分版から得る。 -/
theorem entry_annihilationMatrix_mul_creationMatrix_of_necSuf {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = sign (countBelow S j) * sign (countBelow U i))
      ∧ (¬(i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = 0) := by
  simp only [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf, sign_eq_necSuf]
  exact NecSuf.Isomorphism.entry_annihilationMatrix_mul_creationMatrix complexValuedMapsLaws mul_one mul_zero
    zero_mul (-1 : ℂ) hi hj S U

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` を必要十分版から得る。 -/
theorem creationMatrix_annihilationMatrix_anticommute_of_necSuf {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi))
      = Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M)) Mat.one := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf, creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.creationMatrix_annihilationMatrix_anticommute complexValuedMapsLaws mul_one
    mul_zero zero_mul (-1 : ℂ) signLaws_complex hi hj

end CliffordMatrixIsomorphism.Isomorphism
