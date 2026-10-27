/- claim_fourier_similarity_preserves_determinant の必要十分版。
必要なのは有限行列の乗法、行列式の乗法性と単位行列の値、係数の可換性だけである。
代数的数、多項式、Fourier 行列の成分形は使わない。 -/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

theorem similarity_preserves_determinant_necSuf {ι R : Type*}
    [Fintype ι] [DecidableEq ι] [CommRing R]
    (F T G : Matrix ι ι R) (hFG : F * G = 1)
    (hdetMul : ∀ A B : Matrix ι ι R,
      Matrix.det (A * B) = Matrix.det A * Matrix.det B)
    (hdetOne : Matrix.det (1 : Matrix ι ι R) = 1) :
    Matrix.det (F * T * G) = Matrix.det T := by
  -- 乗法性と単位行列の行列式だけが必要である。
  have hdetFG : Matrix.det F * Matrix.det G = 1 := by
    calc
      Matrix.det F * Matrix.det G = Matrix.det (F * G) := (hdetMul F G).symm
      _ = Matrix.det (1 : Matrix ι ι R) := congrArg Matrix.det hFG
      _ = 1 := hdetOne
  calc
    Matrix.det (F * T * G) = Matrix.det (F * T) * Matrix.det G := hdetMul _ _
    _ = (Matrix.det F * Matrix.det T) * Matrix.det G := by rw [hdetMul F T]
    _ = Matrix.det F * (Matrix.det T * Matrix.det G) := mul_assoc _ _ _
    _ = Matrix.det F * (Matrix.det G * Matrix.det T) :=
      congrArg (Matrix.det F * ·) (mul_comm _ _)
    _ = (Matrix.det F * Matrix.det G) * Matrix.det T := (mul_assoc _ _ _).symm
    _ = 1 * Matrix.det T := by rw [hdetFG]
    _ = Matrix.det T := one_mul _

end Ising2DLambda.NecSuf.KacWard
