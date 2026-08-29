/-
必要十分版: 可換環 R 上の有限正方行列 A について、det(I - X C(A)) の定数項が 1 であることを示す。

人手証明と同じ四段を使う。
  定数項 = 0 での評価
  評価は行列式の有限和・有限積を保つ
  I - 0 C(A) = I
  det I = 1

可換環を仮定するのは行列式を定めるためである。体・順序・代数閉性は使わない。
-/
import Mathlib.LinearAlgebra.Matrix.Polynomial

namespace Ising2DLambda.NecSuf.KacWard

open Matrix Polynomial

/-- `det(I - X C(A))` の定数項は 1。 -/
theorem det_one_sub_X_mul_coeff_zero {R : Type} [CommRing R]
    {ι : Type} [Fintype ι] [DecidableEq ι] (A : Matrix ι ι R) :
    (Matrix.det ((1 : Matrix ι ι (Polynomial R)) -
      (Polynomial.X : Polynomial R) • A.map Polynomial.C)).coeff 0 = 1 := by
  rw [Polynomial.coeff_zero_eq_eval_zero]
  let B : Matrix ι ι (Polynomial R) :=
    1 - (Polynomial.X : Polynomial R) • A.map Polynomial.C
  calc
    Polynomial.eval (0 : R) (Matrix.det B)
        = Matrix.det ((Polynomial.evalRingHom (0 : R)).mapMatrix B) :=
          (Polynomial.evalRingHom (0 : R)).map_det B
    _ = Matrix.det (1 : Matrix ι ι R) := by
      congr 1
      ext i j
      by_cases h : i = j <;> simp [B, h, Matrix.one_apply]
    _ = 1 := Matrix.det_one

end Ising2DLambda.NecSuf.KacWard
