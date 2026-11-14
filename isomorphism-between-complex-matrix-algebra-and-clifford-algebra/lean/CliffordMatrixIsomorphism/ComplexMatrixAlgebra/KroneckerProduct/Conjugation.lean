/-
章「複素行列環」の、二つの行列で両側から挟む写像と、その二つの主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                              このファイル
  def_conjugation_of_matrices                                               conjugation（κ_{U,U'}）
  claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism    conjugation_map_add・conjugation_map_mul・
                                                                            conjugation_map_one・conjugation_map_smul（四つの条件）・
                                                                            conjugation_isComplexAlgebraHomomorphism
  claim_conjugations_by_mutually_inverse_matrices_compose_to_identity       conjugation_conjugation

B := Mat_X(ℂ) の演算は `Mat.add`・`Mat.mul hX`・`Mat.smul`・`Mat.one` で、ℂ-代数 B は `matricesComplexAlgebra hX`。
本文が「結合」と略記する行は `mat_mul_assoc` を一回当てる行、
claim_matrix_product_distributes_over_sum_in_right_factor・…_left_factor は `mat_mul_add`・`mat_add_mul`、
claim_identity_matrix_is_left_unit_of_matrix_product・…_right_unit_… は `mat_one_mul`・`mat_mul_one`、
claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor・…_left_factor は
`mat_smul_mul_right`・`mat_smul_mul_left` を引く。
本文は乗法を保つことを κ(F) ·_B κ(G) から κ(F ·_B G) へ書くので、`conjugation_map_mul` はその向きで示し、
準同型の欄（φ(F · G) = φ(F) · φ(G)）にはその逆向きを入れる。

必要十分版は `NecSuf/ComplexMatrixAlgebra/KroneckerProduct/Conjugation.lean`、導出版は `KroneckerProductFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-- 本文 `def_conjugation_of_matrices`：κ_{U,U'}(F) := (U ·_{Mat_X} F) ·_{Mat_X} U'。 -/
noncomputable def conjugation (hX : IsFiniteSet X) (U U' : Mat X) (F : Mat X) : Mat X :=
  Mat.mul hX (Mat.mul hX U F) U'

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の加法を保つこと。 -/
theorem conjugation_map_add (hX : IsFiniteSet X) (U U' F G : Mat X) :
    conjugation hX U U' (Mat.add F G) = Mat.add (conjugation hX U U' F) (conjugation hX U U' G) := calc
  conjugation hX U U' (Mat.add F G) = Mat.mul hX (Mat.mul hX U (Mat.add F G)) U' := rfl
  _ = Mat.mul hX (Mat.add (Mat.mul hX U F) (Mat.mul hX U G)) U' := by rw [mat_mul_add hX U F G]
  _ = Mat.add (Mat.mul hX (Mat.mul hX U F) U') (Mat.mul hX (Mat.mul hX U G) U') :=
      mat_add_mul hX (Mat.mul hX U F) (Mat.mul hX U G) U'
  _ = Mat.add (conjugation hX U U' F) (conjugation hX U U' G) := rfl

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の乗法を保つこと（U' · U = 1 を使う）。 -/
theorem conjugation_map_mul (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hU'U : Mat.mul hX U' U = Mat.one) (F G : Mat X) :
    Mat.mul hX (conjugation hX U U' F) (conjugation hX U U' G) = conjugation hX U U' (Mat.mul hX F G) := calc
  Mat.mul hX (conjugation hX U U' F) (conjugation hX U U' G)
      = Mat.mul hX (Mat.mul hX (Mat.mul hX U F) U') (Mat.mul hX (Mat.mul hX U G) U') := rfl
  _ = Mat.mul hX (Mat.mul hX U F) (Mat.mul hX U' (Mat.mul hX (Mat.mul hX U G) U')) :=
      mat_mul_assoc hX (Mat.mul hX U F) U' (Mat.mul hX (Mat.mul hX U G) U')
  _ = Mat.mul hX (Mat.mul hX U F) (Mat.mul hX (Mat.mul hX U' (Mat.mul hX U G)) U') := by
      rw [mat_mul_assoc hX U' (Mat.mul hX U G) U']
  _ = Mat.mul hX (Mat.mul hX U F) (Mat.mul hX (Mat.mul hX (Mat.mul hX U' U) G) U') := by
      rw [mat_mul_assoc hX U' U G]
  _ = Mat.mul hX (Mat.mul hX U F) (Mat.mul hX (Mat.mul hX Mat.one G) U') := by rw [hU'U]
  _ = Mat.mul hX (Mat.mul hX U F) (Mat.mul hX G U') := by rw [mat_one_mul hX G]
  _ = Mat.mul hX (Mat.mul hX (Mat.mul hX U F) G) U' := (mat_mul_assoc hX (Mat.mul hX U F) G U').symm
  _ = Mat.mul hX (Mat.mul hX U (Mat.mul hX F G)) U' := by rw [mat_mul_assoc hX U F G]
  _ = conjugation hX U U' (Mat.mul hX F G) := rfl

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の乗法の単位元を保つこと（U · U' = 1 を使う）。 -/
theorem conjugation_map_one (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hUU' : Mat.mul hX U U' = Mat.one) : conjugation hX U U' Mat.one = Mat.one := calc
  conjugation hX U U' Mat.one = Mat.mul hX (Mat.mul hX U Mat.one) U' := rfl
  _ = Mat.mul hX U U' := by rw [mat_mul_one hX U]
  _ = Mat.one := hUU'

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` のスカラー倍を保つこと。 -/
theorem conjugation_map_smul (hX : IsFiniteSet X) (U U' : Mat X) (l : ℂ) (F : Mat X) :
    conjugation hX U U' (Mat.smul l F) = Mat.smul l (conjugation hX U U' F) := calc
  conjugation hX U U' (Mat.smul l F) = Mat.mul hX (Mat.mul hX U (Mat.smul l F)) U' := rfl
  _ = Mat.mul hX (Mat.smul l (Mat.mul hX U F)) U' := by rw [mat_smul_mul_right hX l U F]
  _ = Mat.smul l (Mat.mul hX (Mat.mul hX U F) U') := (mat_smul_mul_left hX l (Mat.mul hX U F) U').symm
  _ = Mat.smul l (conjugation hX U U' F) := rfl

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism`：U · U' = 1 かつ U' · U = 1 なら、
κ_{U,U'} は ℂ-代数 B から B への ℂ-代数の準同型である。 -/
theorem conjugation_isComplexAlgebraHomomorphism (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hUU' : Mat.mul hX U U' = Mat.one) (hU'U : Mat.mul hX U' U = Mat.one) :
    ComplexAlgebra.IsComplexAlgebraHomomorphism (matricesComplexAlgebra hX) (matricesComplexAlgebra hX)
      (conjugation hX U U') where
  isRingHomomorphism :=
    { map_add := conjugation_map_add hX U U'
      map_mul := fun F G => (conjugation_map_mul hX U U' hU'U F G).symm
      map_one := conjugation_map_one hX U U' hUU' }
  isLinearMap :=
    { map_add := conjugation_map_add hX U U'
      map_smul := conjugation_map_smul hX U U' }

/-- 本文 `claim_conjugations_by_mutually_inverse_matrices_compose_to_identity`：U' · U = 1 なら κ_{U',U}(κ_{U,U'}(F)) = F。 -/
theorem conjugation_conjugation (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat X)
    (hU'U : Mat.mul hX U' U = Mat.one) (F : Mat X) :
    conjugation hX U' U (conjugation hX U U' F) = F := calc
  conjugation hX U' U (conjugation hX U U' F)
      = Mat.mul hX (Mat.mul hX U' (Mat.mul hX (Mat.mul hX U F) U')) U := rfl
  _ = Mat.mul hX (Mat.mul hX (Mat.mul hX U' (Mat.mul hX U F)) U') U := by
      rw [mat_mul_assoc hX U' (Mat.mul hX U F) U']
  _ = Mat.mul hX (Mat.mul hX U' (Mat.mul hX U F)) (Mat.mul hX U' U) :=
      mat_mul_assoc hX (Mat.mul hX U' (Mat.mul hX U F)) U' U
  _ = Mat.mul hX (Mat.mul hX U' (Mat.mul hX U F)) Mat.one := by rw [hU'U]
  _ = Mat.mul hX U' (Mat.mul hX U F) := mat_mul_one hX (Mat.mul hX U' (Mat.mul hX U F))
  _ = Mat.mul hX (Mat.mul hX U' U) F := (mat_mul_assoc hX U' U F).symm
  _ = Mat.mul hX Mat.one F := by rw [hU'U]
  _ = F := mat_one_mul hX F

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
