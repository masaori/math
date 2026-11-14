/-
章「複素行列環」の、行列の集合が成分ごとの和とスカラー倍で線型空間であることの必要十分版。具体版
`ComplexMatrixAlgebra/MatrixAlgebra/VectorSpace.lean` と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                       このファイル            使う K の性質
  claim_matrices_indexed_by_finite_set_form_complex_vector_space     matricesVectorSpace     `ValuedMapsLaws` の八つ

八つの条件はどれも成分ごとに K の性質を一つずつ当てるので、使う K の性質は K^X を線型空間にする八つ（`ValuedMapsLaws`：
加法の結合法則・交換法則、a + 0 = a、加法の逆元の存在、乗法の結合法則、1 · a = a、左右の分配法則）と同じである。
乗法の交換法則と a · 1 = a は使わない。加法の逆元は、具体版が ℂ の -A_{x,y} を書くところを、存在から一つ選ぶ。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

/-- 本文 `claim_matrices_indexed_by_finite_set_form_complex_vector_space` の必要十分版：
(Mat_X(K), +, ∗, 0) は K の上の線型空間である。 -/
def matricesVectorSpace {K : Type uK} [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (X : Type u) : VectorSpace K (Mat K X) where
  add := Mat.add
  smul := Mat.smul
  zero := Mat.zero
  add_assoc A B C := Mat.ext fun x y => calc
    Mat.entry (Mat.add (Mat.add A B) C) x y
        = Mat.entry (Mat.add A B) x y + Mat.entry C x y := rfl
    _ = (Mat.entry A x y + Mat.entry B x y) + Mat.entry C x y := rfl
    _ = Mat.entry A x y + (Mat.entry B x y + Mat.entry C x y) := by
        rw [L.add_assoc (Mat.entry A x y) (Mat.entry B x y) (Mat.entry C x y)]
    _ = Mat.entry A x y + Mat.entry (Mat.add B C) x y := rfl
    _ = Mat.entry (Mat.add A (Mat.add B C)) x y := rfl
  add_comm A B := Mat.ext fun x y => calc
    Mat.entry (Mat.add A B) x y = Mat.entry A x y + Mat.entry B x y := rfl
    _ = Mat.entry B x y + Mat.entry A x y := by
        rw [L.add_comm (Mat.entry A x y) (Mat.entry B x y)]
    _ = Mat.entry (Mat.add B A) x y := rfl
  add_zero A := Mat.ext fun x y => calc
    Mat.entry (Mat.add A Mat.zero) x y = Mat.entry A x y + Mat.entry (Mat.zero : Mat K X) x y := rfl
    _ = Mat.entry A x y + 0 := rfl
    _ = Mat.entry A x y := by rw [L.add_zero (Mat.entry A x y)]
  exists_add_inverse A :=
    -- A'_{x,y} := (A_{x,y} の加法の逆元)
    let A' : Mat K X := fun p => Classical.choose (L.exists_neg (Mat.entry A p.1 p.2))
    ⟨A', Mat.ext fun x y => calc
      Mat.entry (Mat.add A A') x y = Mat.entry A x y + Mat.entry A' x y := rfl
      _ = Mat.entry A x y + Classical.choose (L.exists_neg (Mat.entry A x y)) := rfl
      _ = 0 := Classical.choose_spec (L.exists_neg (Mat.entry A x y))
      _ = Mat.entry (Mat.zero : Mat K X) x y := rfl⟩
  smul_assoc l μ A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul (l * μ) A) x y = (l * μ) * Mat.entry A x y := rfl
    _ = l * (μ * Mat.entry A x y) := by rw [L.mul_assoc l μ (Mat.entry A x y)]
    _ = l * Mat.entry (Mat.smul μ A) x y := rfl
    _ = Mat.entry (Mat.smul l (Mat.smul μ A)) x y := rfl
  one_smul A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul 1 A) x y = 1 * Mat.entry A x y := rfl
    _ = Mat.entry A x y := by rw [L.one_mul (Mat.entry A x y)]
  smul_add l A B := Mat.ext fun x y => calc
    Mat.entry (Mat.smul l (Mat.add A B)) x y = l * Mat.entry (Mat.add A B) x y := rfl
    _ = l * (Mat.entry A x y + Mat.entry B x y) := rfl
    _ = l * Mat.entry A x y + l * Mat.entry B x y := by
        rw [L.left_distrib l (Mat.entry A x y) (Mat.entry B x y)]
    _ = Mat.entry (Mat.smul l A) x y + Mat.entry (Mat.smul l B) x y := rfl
    _ = Mat.entry (Mat.add (Mat.smul l A) (Mat.smul l B)) x y := rfl
  add_smul l μ A := Mat.ext fun x y => calc
    Mat.entry (Mat.smul (l + μ) A) x y = (l + μ) * Mat.entry A x y := rfl
    _ = l * Mat.entry A x y + μ * Mat.entry A x y := by
        rw [L.right_distrib l μ (Mat.entry A x y)]
    _ = Mat.entry (Mat.smul l A) x y + Mat.entry (Mat.smul μ A) x y := rfl
    _ = Mat.entry (Mat.add (Mat.smul l A) (Mat.smul μ A)) x y := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
