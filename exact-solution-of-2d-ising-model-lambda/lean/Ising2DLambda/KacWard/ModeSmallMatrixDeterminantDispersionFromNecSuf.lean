import Ising2DLambda.KacWard.ModeSmallMatrixDeterminantDispersion
import Ising2DLambda.KacWard.ModeSmallMatrixFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixDeterminantDispersion

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The field proof specializes to the algebraic mode matrix. -/
theorem modeSmallMatrix_determinant_dispersion_from_necSuf
    (z varpi varsigma : Qbar) (hz4 : z ^ 4 = -1)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (Matrix.det (1 - (X : QbarPoly) •
      (modeSmallMatrix z varpi varsigma).map C : Matrix (ZMod 4) (ZMod 4) QbarPoly)) =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  rw [modeSmallMatrix_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.modeSmallMatrix_determinant_dispersion
    z varpi varsigma hz4 hp hs

end Ising2DLambda.KacWard
