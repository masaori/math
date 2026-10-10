/-
多項式行列積の行列式を添字写像ごとの和へ開く具体版。
本文の十等号を Polynomial Qbar 上で独立に辿る。行指定の行列式への定義橋だけは
転置と mathlib の置換展開を使い、乗法性や添字写像展開の全体定理へは委ねない。
-/
import Ising2DLambda.IntegerMatrix.Determinant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialProductSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 転倒数の符号を定数多項式へ写した、本文の行指定の行列式定義との橋。
線型順序はこの符号表示に必要であり、行列積の展開自体には使わない。 -/
theorem qbarPolynomial_det_row_expansion {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) :
    Matrix.det A = ∑ σ : Equiv.Perm J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := by
  classical
  calc
    Matrix.det A = Matrix.det A.transpose := (Matrix.det_transpose A).symm
    _ = ∑ σ : Equiv.Perm J, ((Equiv.Perm.sign σ : ℤ) : Polynomial Qbar) *
        ∏ i : J, A.transpose (σ i) i := Matrix.det_apply' _
    _ = ∑ σ : Equiv.Perm J,
        Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
          ∏ i : J, A i (σ i) := by
      simp only [IntegerMatrix.inversionSign_eq_mathlibSign, Matrix.transpose_apply,
        map_intCast]

/-- 本文の十等号。非空性は本文の対象に合わせた仮定で、有限和・有限積の展開は
空添字でも成り立つ。減法、除法、代数閉性、次数は使わない。 -/
theorem qbarPolynomial_det_mul_function_expansion
    {J : Type*} [Fintype J] [LinearOrder J] [Nonempty J]
    (A B : Matrix J J (Polynomial Qbar)) :
    Matrix.det (A * B) = ∑ f : J → J, (∏ i : J, A i (f i)) *
      (∑ σ : Equiv.Perm J,
        Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
          ∏ i : J, B (f i) (σ i)) := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  calc
    Matrix.det (A * B) = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, (A * B) i (σ i) :=
      qbarPolynomial_det_row_expansion (A * B)
    _ = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, ∑ j : J, A i j * B j (σ i) := by
      simp only [Matrix.mul_apply]
    _ = ∑ σ : Equiv.Perm J, c σ * ∑ f : J → J, ∏ i : J, A i (f i) * B (f i) (σ i) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (c σ * ·) (qbarPolynomial_prod_sum_eq_sum_prod_pi (fun i j => A i j * B j (σ i)))
    _ = ∑ σ : Equiv.Perm J, ∑ f : J → J, c σ * ∏ i : J, A i (f i) * B (f i) (σ i) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact Finset.mul_sum _ _ _
    _ = ∑ f : J → J, ∑ σ : Equiv.Perm J, c σ * ∏ i : J, A i (f i) * B (f i) (σ i) :=
      Finset.sum_comm
    _ = ∑ f : J → J, ∑ σ : Equiv.Perm J, c σ * ((∏ i : J, A i (f i)) * (∏ i : J, B (f i) (σ i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (c σ * ·) (Finset.prod_mul_distrib)
    _ = ∑ f : J → J, ∑ σ : Equiv.Perm J, (c σ * (∏ i : J, A i (f i))) * (∏ i : J, B (f i) (σ i)) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact (mul_assoc _ _ _).symm
    _ = ∑ f : J → J, ∑ σ : Equiv.Perm J, ((∏ i : J, A i (f i)) * c σ) * (∏ i : J, B (f i) (σ i)) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (· * (∏ i : J, B (f i) (σ i))) (mul_comm (c σ) (∏ i : J, A i (f i)))
    _ = ∑ f : J → J, ∑ σ : Equiv.Perm J, (∏ i : J, A i (f i)) * (c σ * (∏ i : J, B (f i) (σ i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact mul_assoc _ _ _
    _ = ∑ f : J → J, (∏ i : J, A i (f i)) * (∑ σ : Equiv.Perm J, c σ * (∏ i : J, B (f i) (σ i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      exact (Finset.mul_sum _ _ _).symm

end Ising2DLambda.AlgebraicEigenvalue
