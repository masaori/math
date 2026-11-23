/- 具体版が必要十分版の四場合の恒等式から従うことを記録する。 -/
import Ising2DLambda.KacWard.ArfFourierSignProjection
import Ising2DLambda.KacWard.TorusQuadraticSignFromNecSuf

namespace Ising2DLambda.KacWard

theorem torusArfSign_from_necSuf (a b : Bool) :
    torusArfSign a b =
      NecSuf.KacWard.sign (NecSuf.KacWard.arfParity a b) := rfl

theorem arfFourierSignProjection_from_necSuf (h v : Bool) :
    torusArfSign false false * torusQuadraticSign false false h v +
    torusArfSign false true * torusQuadraticSign false true h v +
    torusArfSign true false * torusQuadraticSign true false h v +
    torusArfSign true true * torusQuadraticSign true true h v = 2 := by
  simp only [torusArfSign_from_necSuf, torusQuadraticSign_from_necSuf]
  exact NecSuf.KacWard.arfFourierSignProjection_necSuf h v

end Ising2DLambda.KacWard
