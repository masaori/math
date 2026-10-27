import Ising2DLambda.KacWard.ModeSmallMatrix
import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem modeSmallMatrix_from_necSuf (z varpi varsigma : Qbar) :
    modeSmallMatrix z varpi varsigma =
      Ising2DLambda.NecSuf.KacWard.modeSmallMatrix z varpi varsigma := rfl

end Ising2DLambda.KacWard
