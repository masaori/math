/- 必要十分版を、具体的な双対辺の全単射へ特殊化する。 -/
import Ising2DLambda.FisherZero.DualEdgeMap
import Ising2DLambda.NecSuf.FisherZero.DualEdgeMap

namespace Ising2DLambda.FisherZero

/-- 明示した逆写像の往復律から得る双対辺写像の全単射性。 -/
theorem dualEdgeEquiv_bijective_from_necSuf (L : ℕ) [NeZero L] :
    Function.Bijective (dualEdgeEquiv L) := by
  exact Ising2DLambda.NecSuf.FisherZero.map_bijective_of_two_sided_inverse_necSuf
    (dualEdgeEquiv L) (dualEdgeEquiv L).symm
    (dualEdgeEquiv L).symm_apply_apply (dualEdgeEquiv L).apply_symm_apply

end Ising2DLambda.FisherZero
