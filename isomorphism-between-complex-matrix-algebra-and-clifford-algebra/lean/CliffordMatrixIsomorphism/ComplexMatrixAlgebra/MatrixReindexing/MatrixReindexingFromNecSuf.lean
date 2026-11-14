/-
章「複素行列環」の、番号付けによる行列の添字の付け替えと 2 進の番号付けによる行列環の同型の具体版が、
必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、
必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                         必要十分版の特殊化
  reindexMatrix・inverseReindexMatrix            …_eq_necSuf（同じ式。rfl）
  binaryReindexMatrix・binaryInverseReindexMatrix …_eq_necSuf（同じ式。rfl）
  各主張                                         …_of_necSuf

準同型であることは、具体版の ℂ-代数を必要十分版の代数として読んだもの（`toNecSuf`）が必要十分版の `matricesAlgebra` と一致すること
（`matricesComplexAlgebra_toNecSuf`）を通して移す。乗法を保つことは、積の一致 `Mat.mul_eq_necSuf` を通して移す。
ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ^X を線型空間にする八つ）、乗法の交換法則 `mul_comm`、a · 0 = 0 の `mul_zero` である。
付け替えの四つの等式と、二つの付け替えが互いの逆であることには、ℂ の性質を一つも渡さない。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixReindexing.BinaryNumberingIsomorphism
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.MatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixReindexing.BinaryNumberingIsomorphism

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {X : Type u}

/-! ### 定義の対応 -/

theorem reindexMatrix_eq_necSuf {n : ℕ} (e : Idx n → X) (F : Mat X) :
    reindexMatrix e F = NecSuf.ComplexMatrixAlgebra.reindexMatrix e F := rfl

/-- 本文 `def_reindexing_of_matrices_by_inverse_numbering` の μ_e は、必要十分版の μ_e と同じ式。 -/
theorem inverseReindexMatrix_eq_necSuf {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat (Idx n)) :
    inverseReindexMatrix he G = NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix he G := rfl

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M} は、必要十分版の ν_{e_M} と同じ式。 -/
theorem binaryReindexMatrix_eq_necSuf (M : ℕ) (F : Mat (PowerSet M)) :
    binaryReindexMatrix M F = NecSuf.ComplexMatrixAlgebra.binaryReindexMatrix M F := rfl

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の μ_{e_M} は、必要十分版の μ_{e_M} と同じ式。 -/
theorem binaryInverseReindexMatrix_eq_necSuf (M : ℕ) (G : Mat (Idx (twoPower M))) :
    binaryInverseReindexMatrix M G = NecSuf.ComplexMatrixAlgebra.binaryInverseReindexMatrix M G := rfl

/-! ### ν_e は ℂ-代数の準同型である -/

theorem reindexMatrix_add_of_necSuf {n : ℕ} (e : Idx n → X) (F G : Mat X) :
    reindexMatrix e (Mat.add F G) = Mat.add (reindexMatrix e F) (reindexMatrix e G) :=
  NecSuf.ComplexMatrixAlgebra.reindexMatrix_add e F G

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の乗法を保つ等式を必要十分版から得る。 -/
theorem reindexMatrix_mul_of_necSuf (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) (F G : Mat X) :
    reindexMatrix e (Mat.mul hX F G)
      = Mat.mul (isFiniteSet_idx n) (reindexMatrix e F) (reindexMatrix e G) := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.reindexMatrix_mul complexValuedMapsLaws hX he F G

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の単位元を保つ等式を必要十分版から得る。 -/
theorem reindexMatrix_one_of_necSuf [DecidableEq X] {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) :
    reindexMatrix e (Mat.one : Mat X) = (Mat.one : Mat (Idx n)) :=
  NecSuf.ComplexMatrixAlgebra.reindexMatrix_one he

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` のスカラー倍を保つ等式を必要十分版から得る。 -/
theorem reindexMatrix_smul_of_necSuf {n : ℕ} (e : Idx n → X) (l : ℂ) (F : Mat X) :
    reindexMatrix e (Mat.smul l F) = Mat.smul l (reindexMatrix e F) :=
  NecSuf.ComplexMatrixAlgebra.reindexMatrix_smul e l F

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem reindexMatrix_isComplexAlgebraHomomorphism_of_necSuf (hX : IsFiniteSet X) [DecidableEq X]
    {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra hX)
      (matricesComplexAlgebra (isFiniteSet_idx n)) (reindexMatrix e) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, matricesComplexAlgebra_toNecSuf,
    matricesComplexAlgebra_toNecSuf]
  exact NecSuf.ComplexMatrixAlgebra.reindexMatrix_isAlgebraHomomorphism complexValuedMapsLaws mul_comm
    mul_zero hX he

/-! ### ν_e と μ_e は互いの逆である -/

theorem inverseReindexMatrix_reindexMatrix_of_necSuf {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) (F : Mat X) : inverseReindexMatrix he (reindexMatrix e F) = F :=
  NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_reindexMatrix he F

/-- 本文 `claim_reindexing_after_inverse_reindexing_of_matrices_is_identity` を必要十分版から得る。 -/
theorem reindexMatrix_inverseReindexMatrix_of_necSuf {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) (G : Mat (Idx n)) : reindexMatrix e (inverseReindexMatrix he G) = G :=
  NecSuf.ComplexMatrixAlgebra.reindexMatrix_inverseReindexMatrix he G

/-! ### μ_e は ℂ-代数の準同型である -/

theorem inverseReindexMatrix_add_of_necSuf {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G H : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.add G H)
      = Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H) :=
  NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_add he G H

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の乗法を保つ等式を必要十分版から得る。 -/
theorem inverseReindexMatrix_mul_of_necSuf (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) (G H : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.mul (isFiniteSet_idx n) G H)
      = Mat.mul hX (inverseReindexMatrix he G) (inverseReindexMatrix he H) := by
  rw [Mat.mul_eq_necSuf, Mat.mul_eq_necSuf]
  exact NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_mul complexValuedMapsLaws hX he G H

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の単位元を保つ等式を必要十分版から得る。 -/
theorem inverseReindexMatrix_one_of_necSuf [DecidableEq X] {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) :
    inverseReindexMatrix he (Mat.one : Mat (Idx n)) = (Mat.one : Mat X) :=
  NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_one he

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` のスカラー倍を保つ等式を必要十分版から得る。 -/
theorem inverseReindexMatrix_smul_of_necSuf {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (l : ℂ) (G : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.smul l G) = Mat.smul l (inverseReindexMatrix he G) :=
  NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_smul he l G

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem inverseReindexMatrix_isComplexAlgebraHomomorphism_of_necSuf (hX : IsFiniteSet X)
    [DecidableEq X] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_idx n))
      (matricesComplexAlgebra hX) (inverseReindexMatrix he) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, matricesComplexAlgebra_toNecSuf,
    matricesComplexAlgebra_toNecSuf]
  exact NecSuf.ComplexMatrixAlgebra.inverseReindexMatrix_isAlgebraHomomorphism complexValuedMapsLaws
    mul_comm mul_zero hX he

/-! ### 2 進の番号付けによる行列環の同型 -/

theorem binaryReindex_isomorphism_of_necSuf (M : ℕ) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (matricesComplexAlgebra (isFiniteSet_idx (twoPower M))) (binaryReindexMatrix M)
      ∧ IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_idx (twoPower M)))
        (matricesComplexAlgebra (isFiniteSet_powerSet M)) (binaryInverseReindexMatrix M)
      ∧ (∀ F : Mat (PowerSet M), binaryInverseReindexMatrix M (binaryReindexMatrix M F) = F)
      ∧ (∀ G : Mat (Idx (twoPower M)), binaryReindexMatrix M (binaryInverseReindexMatrix M G) = G) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, isComplexAlgebraHomomorphism_iff_necSuf,
    matricesComplexAlgebra_toNecSuf, matricesComplexAlgebra_toNecSuf]
  exact NecSuf.ComplexMatrixAlgebra.binaryReindex_isomorphism complexValuedMapsLaws mul_comm mul_zero M

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M} が単射であることを必要十分版から得る。 -/
theorem binaryReindexMatrix_injective_of_necSuf (M : ℕ) (F F' : Mat (PowerSet M))
    (h : binaryReindexMatrix M F = binaryReindexMatrix M F') : F = F' :=
  NecSuf.ComplexMatrixAlgebra.binaryReindexMatrix_injective M F F' h

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M} が全射であることを必要十分版から得る。 -/
theorem binaryReindexMatrix_surjective_of_necSuf (M : ℕ) (G : Mat (Idx (twoPower M))) :
    ∃ F : Mat (PowerSet M), binaryReindexMatrix M F = G :=
  NecSuf.ComplexMatrixAlgebra.binaryReindexMatrix_surjective M G

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M}(F) = G を満たすただ一つの F は μ_{e_M}(G) であることを必要十分版から得る。 -/
theorem binaryReindexMatrix_eq_iff_of_necSuf (M : ℕ) (F : Mat (PowerSet M))
    (G : Mat (Idx (twoPower M))) :
    binaryReindexMatrix M F = G ↔ F = binaryInverseReindexMatrix M G :=
  NecSuf.ComplexMatrixAlgebra.binaryReindexMatrix_eq_iff M F G

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
