/-
端末行列の行列式一致の必要十分版。
必要なのは有限添字、可換環間の環準同型、元の行列式が一であることだけである。
有限性は置換の有限和と成分の有限積に、可換環は行列式の乗法性に、
環準同型は有限和・有限積・整数の符号・一の保存に用いる。
置換展開の符号は整数の像で扱い、格子、係数体、添字の順序を要求しない。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

variable {ι R S : Type*} [Fintype ι] [DecidableEq ι] [CommRing R] [CommRing S]

/-- 列指定のライブラリ定義を転置によって本文の行指定へ移す。 -/
theorem det_eq_rowSignedPermutationSum (A : Matrix ι ι R) :
    Matrix.det A = ∑ σ : Equiv.Perm ι, ((Equiv.Perm.sign σ : ℤ) : R) *
      ∏ i, A i (σ i) := by
  calc
    Matrix.det A = Matrix.det A.transpose := (Matrix.det_transpose A).symm
    _ = ∑ σ : Equiv.Perm ι, ((Equiv.Perm.sign σ : ℤ) : R) *
        ∏ i, A.transpose (σ i) i := Matrix.det_apply' _
    _ = ∑ σ : Equiv.Perm ι, ((Equiv.Perm.sign σ : ℤ) : R) *
        ∏ i, A i (σ i) := rfl

/-- 元の行列式が一なら、有限積・積・有限和の保存から像の行列式も一になる。 -/
theorem mappedMatrix_determinant_one_necSuf (φ : R →+* S) (A : Matrix ι ι R)
    (hA : Matrix.det A = 1) : Matrix.det (A.map φ) = 1 := by
  classical
  calc
    Matrix.det (A.map φ) = ∑ σ : Equiv.Perm ι,
        φ ((Equiv.Perm.sign σ : ℤ) : R) * ∏ i, A.map φ i (σ i) := by
      rw [det_eq_rowSignedPermutationSum]
      simp only [map_intCast]
    _ = ∑ σ : Equiv.Perm ι,
        φ ((Equiv.Perm.sign σ : ℤ) : R) * ∏ i, φ (A i (σ i)) := rfl
    _ = ∑ σ : Equiv.Perm ι,
        φ ((Equiv.Perm.sign σ : ℤ) : R) * φ (∏ i, A i (σ i)) := by
      simp only [map_prod]
    _ = ∑ σ : Equiv.Perm ι,
        φ (((Equiv.Perm.sign σ : ℤ) : R) * ∏ i, A i (σ i)) := by
      simp only [map_mul]
    _ = φ (∑ σ : Equiv.Perm ι,
        ((Equiv.Perm.sign σ : ℤ) : R) * ∏ i, A i (σ i)) := by rw [map_sum]
    _ = φ (Matrix.det A) := by rw [det_eq_rowSignedPermutationSum]
    _ = φ 1 := by rw [hA]
    _ = 1 := map_one _

/-- 行列式一の行列の像を左から掛けても行列式は変わらない。 -/
theorem mappedMatrix_mul_determinant_necSuf (φ : R →+* S) (A : Matrix ι ι R)
    (K : Matrix ι ι S) (hA : Matrix.det A = 1) :
    Matrix.det (A.map φ * K) = Matrix.det K := by
  calc
    Matrix.det (A.map φ * K) = Matrix.det (A.map φ) * Matrix.det K :=
      Matrix.det_mul _ _
    _ = 1 * Matrix.det K := by rw [mappedMatrix_determinant_one_necSuf φ A hA]
    _ = Matrix.det K := one_mul _

end Ising2DLambda.NecSuf.KacWard
