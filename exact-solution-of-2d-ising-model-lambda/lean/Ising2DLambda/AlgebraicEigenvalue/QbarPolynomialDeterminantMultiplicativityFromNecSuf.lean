/-
全単射の再添字付けと乗法性の必要十分版へ、Polynomial Qbar と本文の符号を供給する。
具体版の乗法性を使わず、行指定の定義橋と、係数の合成保存・互換反転を使う。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantMultiplicativity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.DeterminantMultiplicativity

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

/-- 可換半環を多項式に、合成保存の重みを整数符号の定数多項式に特殊化する。 -/
theorem qbarPolynomial_bijective_inner_sum_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (B : Matrix J J (Polynomial Qbar)) (τ : Equiv.Perm J) :
    (∑ σ : Equiv.Perm J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, B (τ i) (σ i)) =
      Polynomial.C ((sign (fun i j : J => i < j) τ : ℤ) : Qbar) * Matrix.det B := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  calc
    (∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (τ i) (σ i)) =
        c τ * (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) :=
      NecSuf.AlgebraicEigenvalue.permutation_row_sum_reindex_necSuf B c
        (fun π τ => qbarPolynomial_sign_comp π τ) τ
    _ = c τ * Matrix.det B :=
      congrArg (c τ * ·) (qbarPolynomial_det_row_expansion B).symm

/-- 可換環の相殺には具体的な互換による符号反転を渡す。
順序は符号の定義にだけ必要で、非空性は本文の対象に合わせて残している。 -/
theorem qbarPolynomial_det_mul_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J] [Nonempty J]
    (A B : Matrix J J (Polynomial Qbar)) :
    Matrix.det (A * B) = Matrix.det A * Matrix.det B := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  calc
    Matrix.det (A * B) =
        ∑ σ : Equiv.Perm J, c σ * ∏ i : J, (A * B) i (σ i) :=
      qbarPolynomial_det_row_expansion (A * B)
    _ = (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i (τ i)) *
        (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) :=
      NecSuf.AlgebraicEigenvalue.matrixProduct_permutationSum_mul_necSuf A B c
        (fun π τ => qbarPolynomial_sign_comp π τ)
        (fun a b hab σ => qbarPolynomial_sign_right_transposition_neg a b hab σ)
    _ = Matrix.det A * (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) :=
      congrArg (· * (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)))
        (qbarPolynomial_det_row_expansion A).symm
    _ = Matrix.det A * Matrix.det B :=
      congrArg (Matrix.det A * ·) (qbarPolynomial_det_row_expansion B).symm

end Ising2DLambda.AlgebraicEigenvalue
