/-
章「複素行列環」の、行列の集合が代数であることの必要十分版。具体版 `ComplexMatrixAlgebra/MatrixAlgebra/Algebra.lean` と
同じ欄の割り当てで、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                  このファイル                       使う K の性質
  claim_matrices_indexed_by_finite_set_form_complex_algebra     matricesAlgebra・                  `ValuedMapsLaws`・乗法の交換法則・
                                                                matricesAlgebra_toVectorSpace      a · 0 = 0

使う K の性質は、欄に入れる主張（`VectorSpace.lean`・`Product.lean`）が使うものを合わせたものである。
乗法の交換法則は、乗法の結合法則と右の因子のスカラー倍との両立の二つの欄が使う（どちらも `Product.lean` の冒頭）。
右の単位元の欄が使うのは 0 と 1 がどの元とも交換することだけで、ここでは交換法則 hcomm を 0 と 1 に当てて渡す
（行列の集合を代数にする組は結合法則の欄のために交換法則を仮定するので、引数を変えずに済む）。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.VectorSpace
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Product
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {X : Type u}

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra` の必要十分版：
(Mat_X(K), +, ·, ∗, 0, 1) は K の上の代数である。 -/
noncomputable def matricesAlgebra (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) [DecidableEq X] : AlgebraOver K (Mat K X) where
  add := Mat.add
  mul := Mat.mul L hX
  zero := Mat.zero
  one := Mat.one
  -- 一つ目の条件のうち加法の四つ：線型空間の最初の四つの条件と同じ主張
  add_assoc := (matricesVectorSpace L X).add_assoc
  add_comm := (matricesVectorSpace L X).add_comm
  add_zero := (matricesVectorSpace L X).add_zero
  exists_add_inverse := (matricesVectorSpace L X).exists_add_inverse
  -- 一つ目の条件のうち乗法の結合法則・単位元・分配法則
  mul_assoc := mat_mul_assoc L hcomm hmul0 hX
  mul_one := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX
  one_mul := mat_one_mul L hX
  left_distrib := mat_mul_add L hX
  right_distrib := mat_add_mul L hX
  -- 二つ目の条件
  smul := Mat.smul
  smul_assoc := (matricesVectorSpace L X).smul_assoc
  one_smul := (matricesVectorSpace L X).one_smul
  smul_add := (matricesVectorSpace L X).smul_add
  add_smul := (matricesVectorSpace L X).add_smul
  -- 三つ目・四つ目の条件
  smul_mul_left := mat_smul_mul_left L hmul0 hX
  smul_mul_right := mat_smul_mul_right L hcomm hmul0 hX

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_algebra` の二つ目の条件の必要十分版：
二つ目の条件の組は `matricesVectorSpace L X` である。 -/
theorem matricesAlgebra_toVectorSpace (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) [DecidableEq X] :
    (matricesAlgebra L hcomm hmul0 hX).toVectorSpace = matricesVectorSpace L X := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
