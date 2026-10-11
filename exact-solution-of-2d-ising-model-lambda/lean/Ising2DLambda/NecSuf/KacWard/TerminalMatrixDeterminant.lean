/-
端末行列の行列式一致の必要十分版。
必要なのは有限添字、可換環間の環準同型、元の行列式が一であることだけである。
有限性は置換の有限和と成分の有限積に、可換環は行列式の乗法性に、
環準同型は有限和・有限積・整数の符号・一の保存に用いる。
置換展開の符号は整数の像で扱い、格子、係数体、添字の順序を要求しない。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.DeterminantMultiplicativity

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

/-- 自前の写像展開・非単射項の相殺・全単射の再添字付けへ整数符号を供給する。
ライブラリの行列式は行指定の置換展開との定義橋だけで用いる。 -/
theorem determinant_mul_from_permutationSum_necSuf (A B : Matrix ι ι S) :
    Matrix.det (A * B) = Matrix.det A * Matrix.det B := by
  classical
  let c : Equiv.Perm ι → S := fun σ => ((Equiv.Perm.sign σ : ℤ) : S)
  have hc (π τ : Equiv.Perm ι) : c (π * τ) = c π * c τ := by
    simp only [c, map_mul, Units.val_mul, Int.cast_mul]
  have hswap (a b : ι) (hab : a ≠ b) (σ : Equiv.Perm ι) :
      c (σ * transpositionPerm a b) = -c σ := by
    have ht : transpositionPerm a b = Equiv.swap a b := by
      ext i
      simp only [transpositionPerm, Equiv.coe_fn_mk,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.transpositionOn, Equiv.swap_apply_def]
    calc
      c (σ * transpositionPerm a b) = c σ * c (transpositionPerm a b) := hc _ _
      _ = c σ * (-1) := by simp [c, ht, hab]
      _ = -c σ := mul_neg_one _
  calc
    Matrix.det (A * B) = ∑ σ : Equiv.Perm ι, c σ * ∏ i, (A * B) i (σ i) :=
      det_eq_rowSignedPermutationSum _
    _ = (∑ τ : Equiv.Perm ι, c τ * ∏ i, A i (τ i)) *
        (∑ π : Equiv.Perm ι, c π * ∏ i, B i (π i)) :=
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matrixProduct_permutationSum_mul_necSuf
        A B c hc hswap
    _ = Matrix.det A * (∑ π : Equiv.Perm ι, c π * ∏ i, B i (π i)) :=
      congrArg (· * (∑ π : Equiv.Perm ι, c π * ∏ i, B i (π i)))
        (det_eq_rowSignedPermutationSum A).symm
    _ = Matrix.det A * Matrix.det B :=
      congrArg (Matrix.det A * ·) (det_eq_rowSignedPermutationSum B).symm

/-- 行列式一の行列の像を左から掛けても行列式は変わらない。 -/
theorem mappedMatrix_mul_determinant_necSuf (φ : R →+* S) (A : Matrix ι ι R)
    (K : Matrix ι ι S) (hA : Matrix.det A = 1) :
    Matrix.det (A.map φ * K) = Matrix.det K := by
  calc
    Matrix.det (A.map φ * K) = Matrix.det (A.map φ) * Matrix.det K :=
      determinant_mul_from_permutationSum_necSuf _ _
    _ = 1 * Matrix.det K := by rw [mappedMatrix_determinant_one_necSuf φ A hA]
    _ = Matrix.det K := one_mul _

end Ising2DLambda.NecSuf.KacWard
