/-
章「複素行列環」の、有限集合で添字づけた行列の集合が ℂ-代数であることの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  claim_matrices_indexed_by_finite_set_form_complex_algebra     matricesComplexAlgebra・
                                                                matricesComplexAlgebra_toComplexVectorSpace（二つ目の条件の組は
                                                                matricesVectorSpace そのものであること）

本文の四つの条件の根拠は、欄ごとに次のとおりである。
  環の加法の四つ（一つ目の条件）・スカラー倍の四つ（二つ目の条件）   matricesVectorSpace の欄
  乗法の結合法則                                                     mat_mul_assoc
  乗法の単位元（右・左）                                             mat_mul_one・mat_one_mul
  分配法則（左・右）                                                 mat_mul_add・mat_add_mul
  スカラー倍と乗法の両立（左の因子・右の因子）                       mat_smul_mul_left・mat_smul_mul_right
`ComplexAlgebra` は環の加法の四つと線型空間の加法の四つを重ねて置かない（`ComplexAlgebra/Definitions.lean`）ので、
本文の「二つの組は同じ集合・同じ加法・同じ加法の単位元をもつ」は、二つ目の条件の組 `toComplexVectorSpace` が
`matricesVectorSpace X` と一致すること（rfl）として書く。

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Algebra.lean`、導出版は `MatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.VectorSpace
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Product
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Definitions

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra`：
(Mat_X(ℂ), +_{Mat_X}, ·_{Mat_X}, ∗_{Mat_X}, 0_{Mat_X}, 1_{Mat_X}) は ℂ-代数である。 -/
noncomputable def matricesComplexAlgebra (hX : IsFiniteSet X) [DecidableEq X] : ComplexAlgebra (Mat X) where
  add := Mat.add
  mul := Mat.mul hX
  zero := Mat.zero
  one := Mat.one
  -- 一つ目の条件のうち加法の四つ：ℂ-線型空間の最初の四つの条件と同じ主張
  add_assoc := (matricesVectorSpace X).add_assoc
  add_comm := (matricesVectorSpace X).add_comm
  add_zero := (matricesVectorSpace X).add_zero
  exists_add_inverse := (matricesVectorSpace X).exists_add_inverse
  -- 一つ目の条件のうち乗法の結合法則・単位元・分配法則
  mul_assoc := mat_mul_assoc hX
  mul_one := mat_mul_one hX
  one_mul := mat_one_mul hX
  left_distrib := mat_mul_add hX
  right_distrib := mat_add_mul hX
  -- 二つ目の条件
  smul := Mat.smul
  smul_assoc := (matricesVectorSpace X).smul_assoc
  one_smul := (matricesVectorSpace X).one_smul
  smul_add := (matricesVectorSpace X).smul_add
  add_smul := (matricesVectorSpace X).add_smul
  -- 三つ目・四つ目の条件
  smul_mul_left := mat_smul_mul_left hX
  smul_mul_right := mat_smul_mul_right hX

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra` の二つ目の条件：
二つ目の条件の組 (Mat_X(ℂ), +_{Mat_X}, ∗_{Mat_X}, 0_{Mat_X}) は `matricesVectorSpace X` である。 -/
theorem matricesComplexAlgebra_toComplexVectorSpace (hX : IsFiniteSet X) [DecidableEq X] :
    (matricesComplexAlgebra hX).toComplexVectorSpace = matricesVectorSpace X := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
