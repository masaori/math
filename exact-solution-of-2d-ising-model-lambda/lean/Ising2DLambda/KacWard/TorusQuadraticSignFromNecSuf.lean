import Ising2DLambda.KacWard.TorusQuadraticSign
import Ising2DLambda.NecSuf.KacWard.ArfFourierSignProjection

namespace Ising2DLambda.KacWard

theorem torusQuadraticParity_from_necSuf (a b h v : Bool) :
    torusQuadraticParity a b h v =
      NecSuf.KacWard.quadraticParity a b h v := rfl

theorem torusQuadraticSign_from_necSuf (a b h v : Bool) :
    torusQuadraticSign a b h v =
      NecSuf.KacWard.sign (NecSuf.KacWard.quadraticParity a b h v) := rfl

end Ising2DLambda.KacWard
