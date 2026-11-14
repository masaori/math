/-
章「複素行列環」の、有限集合で添字づけた行列の集合が成分ごとの和とスカラー倍で ℂ-線型空間であることの具体版。
人手証明と 1 対 1 に対応させる。mathlib の `Matrix`・`Module` は使わない。

  本文のラベル                                                       このファイル
  claim_matrices_indexed_by_finite_set_form_complex_vector_space     matricesVectorSpace

八つの条件は、どれも本文どおり各 (x, y) 成分の等式を calc で示し、`Mat.ext` で行列の等式にする。
加法の逆元 A' は本文どおり A'_{x,y} := -_ℂ A_{x,y} で置く。
本文の主張は X が有限集合であることを前提に置くが、証明は有限性を使わない（積を含まない）ので、ここでは任意の型 X で書く。

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/VectorSpace.lean`、導出版は `MatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Definitions

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

universe u

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_vector_space`：
(Mat_X(ℂ), +_{Mat_X}, ∗_{Mat_X}, 0_{Mat_X}) は ℂ-線型空間である。 -/
def matricesVectorSpace (X : Type u) : ComplexVectorSpace (Mat X) where
  add := Mat.add
  smul := Mat.smul
  zero := Mat.zero
  add_assoc A B C := Mat.ext fun x y => calc
    Mat.entry (Mat.add (Mat.add A B) C) x y
        = Mat.entry (Mat.add A B) x y + Mat.entry C x y := rfl
    _ = (Mat.entry A x y + Mat.entry B x y) + Mat.entry C x y := rfl
    _ = Mat.entry A x y + (Mat.entry B x y + Mat.entry C x y) := by
        rw [_root_.add_assoc (Mat.entry A x y) (Mat.entry B x y) (Mat.entry C x y)]
    _ = Mat.entry A x y + Mat.entry (Mat.add B C) x y := rfl
    _ = Mat.entry (Mat.add A (Mat.add B C)) x y := rfl
  add_comm A B := Mat.ext fun x y => calc
    Mat.entry (Mat.add A B) x y = Mat.entry A x y + Mat.entry B x y := rfl
    _ = Mat.entry B x y + Mat.entry A x y := by
        rw [_root_.add_comm (Mat.entry A x y) (Mat.entry B x y)]
    _ = Mat.entry (Mat.add B A) x y := rfl
  add_zero A := Mat.ext fun x y => calc
    Mat.entry (Mat.add A Mat.zero) x y = Mat.entry A x y + Mat.entry (Mat.zero : Mat X) x y := rfl
    _ = Mat.entry A x y + 0 := rfl
    _ = Mat.entry A x y := by rw [_root_.add_zero (Mat.entry A x y)]
  exists_add_inverse A :=
    -- A'_{x,y} := -_ℂ A_{x,y}
    let A' : Mat X := fun p => -Mat.entry A p.1 p.2
    ⟨A', Mat.ext fun x y => calc
      Mat.entry (Mat.add A A') x y = Mat.entry A x y + Mat.entry A' x y := rfl
      _ = Mat.entry A x y + -Mat.entry A x y := rfl
      _ = 0 := by rw [add_neg_cancel (Mat.entry A x y)]
      _ = Mat.entry (Mat.zero : Mat X) x y := rfl⟩
  smul_assoc l μ A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul (l * μ) A) x y = (l * μ) * Mat.entry A x y := rfl
    _ = l * (μ * Mat.entry A x y) := by rw [_root_.mul_assoc l μ (Mat.entry A x y)]
    _ = l * Mat.entry (Mat.smul μ A) x y := rfl
    _ = Mat.entry (Mat.smul l (Mat.smul μ A)) x y := rfl
  one_smul A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul 1 A) x y = 1 * Mat.entry A x y := rfl
    _ = Mat.entry A x y := by rw [_root_.one_mul (Mat.entry A x y)]
  smul_add l A B := Mat.ext fun x y => calc
    Mat.entry (Mat.smul l (Mat.add A B)) x y = l * Mat.entry (Mat.add A B) x y := rfl
    _ = l * (Mat.entry A x y + Mat.entry B x y) := rfl
    _ = l * Mat.entry A x y + l * Mat.entry B x y := by
        rw [_root_.mul_add l (Mat.entry A x y) (Mat.entry B x y)]
    _ = Mat.entry (Mat.smul l A) x y + Mat.entry (Mat.smul l B) x y := rfl
    _ = Mat.entry (Mat.add (Mat.smul l A) (Mat.smul l B)) x y := rfl
  add_smul l μ A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul (l + μ) A) x y = (l + μ) * Mat.entry A x y := rfl
    _ = l * Mat.entry A x y + μ * Mat.entry A x y := by
        rw [_root_.add_mul l μ (Mat.entry A x y)]
    _ = Mat.entry (Mat.smul l A) x y + Mat.entry (Mat.smul μ A) x y := rfl
    _ = Mat.entry (Mat.add (Mat.smul l A) (Mat.smul μ A)) x y := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
