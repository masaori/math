import Ising2DLambda.KacWard.ModeSmallMatrixForbiddenTerm
import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixForbiddenTerm

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem modeSmallMatrix_forbidden_term_zero_from_necSuf
    (z varpi varsigma : Qbar) (σ : Equiv.Perm (ZMod 4))
    (i : ZMod 4) (hi : σ i = i + 2) :
    (∏ j : ZMod 4,
      ((1 - (Polynomial.X : QbarPoly) •
          (modeSmallMatrix z varpi varsigma).map Polynomial.C :
            Matrix (ZMod 4) (ZMod 4) QbarPoly) j (σ j))) = 0 := by
  exact Ising2DLambda.NecSuf.KacWard.modeSmallMatrix_forbidden_term_zero
    z varpi varsigma σ i hi

end Ising2DLambda.KacWard
