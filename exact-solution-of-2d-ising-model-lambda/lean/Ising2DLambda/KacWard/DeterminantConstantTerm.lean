/-
章「トーラス上の Kac--Ward 行列式」の「四つの Kac--Ward 行列式の定数項は一である」
（`claim_kac_ward_determinant_constant_term_one`）の具体版。

人手証明                                      このファイル
Qbar[x] 成分の有限行列                         `QbarPolynomialMatrix`
K(x) = I - x C(M)                            `kacWardPolynomialMatrix`
D(x) = det K(x)                              `kacWardDeterminant`
定数項 = 0 での評価                           `Polynomial.coeff_zero_eq_eval_zero`
評価を行列式へ通す                            `RingHom.map_det`
K(0) = I                                     成分ごとの同じ計算
det I = 1                                    `Matrix.det_one`

添字集合を向き付き辺に特殊化し、M を四つの遷移行列に取れば本文の四つの主張を得る。
住処は Qbar と Qbar[x] であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Ising2DLambda.NecSuf.KacWard.DeterminantConstantTerm
import Mathlib.LinearAlgebra.Matrix.Polynomial

namespace Ising2DLambda.KacWard

open Matrix Polynomial Ising2DLambda.AlgebraicEigenvalue

/-- 本文の `Mat_J(Qbar[x])`。 -/
abbrev QbarPolynomialMatrix (ι : Type) := Matrix ι ι QbarPoly

/-- 本文の `K(x) = I - x M`。 -/
noncomputable def kacWardPolynomialMatrix {ι : Type} [DecidableEq ι]
    (M : Matrix ι ι Qbar) : QbarPolynomialMatrix ι :=
  1 - (Polynomial.X : QbarPoly) • M.map Polynomial.C

/-- 本文の `D(x) = det K(x)`。 -/
noncomputable def kacWardDeterminant {ι : Type} [Fintype ι] [DecidableEq ι]
    (M : Matrix ι ι Qbar) : QbarPoly :=
  Matrix.det (kacWardPolynomialMatrix M)

/-- 人手証明の四段に対応する具体版。 -/
theorem kacWardDeterminant_coeff_zero {ι : Type} [Fintype ι] [DecidableEq ι]
    (M : Matrix ι ι Qbar) : (kacWardDeterminant M).coeff 0 = 1 := by
  rw [Polynomial.coeff_zero_eq_eval_zero]
  calc
    Polynomial.eval (0 : Qbar) (kacWardDeterminant M)
        = Matrix.det ((Polynomial.evalRingHom (0 : Qbar)).mapMatrix
            (kacWardPolynomialMatrix M)) := by
          exact (Polynomial.evalRingHom (0 : Qbar)).map_det (kacWardPolynomialMatrix M)
    _ = Matrix.det (1 : Matrix ι ι Qbar) := by
      congr 1
      ext i j
      by_cases h : i = j <;> simp [kacWardPolynomialMatrix, h, Matrix.one_apply]
    _ = 1 := Matrix.det_one

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem kacWardDeterminant_coeff_zero_from_necSuf {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) :
    (kacWardDeterminant M).coeff 0 = 1 := by
  exact Ising2DLambda.NecSuf.KacWard.det_one_sub_X_mul_coeff_zero M

end Ising2DLambda.KacWard
