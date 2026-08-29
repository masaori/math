/- 具体版が必要十分版の四場合の恒等式から従うことを記録する。 -/
import Ising2DLambda.KacWard.ArfFourierSignProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem arfFourierSignProjection_from_necSuf (h v : Bool) :
    sign (arfParity false false) * sign (quadraticParity false false h v) +
    sign (arfParity false true) * sign (quadraticParity false true h v) +
    sign (arfParity true false) * sign (quadraticParity true false h v) +
    sign (arfParity true true) * sign (quadraticParity true true h v) = 2 :=
  arfFourierSignProjection_necSuf h v

end Ising2DLambda.KacWard
