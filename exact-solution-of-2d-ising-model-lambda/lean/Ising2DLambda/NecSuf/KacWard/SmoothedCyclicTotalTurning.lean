import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.NecSuf.KacWard

/-- The sum of local turns after exchanging the outgoing edges at two indices. -/
def smoothedCyclicTotalTurning {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E)
    (k l : Fin (m + 1)) : ℤ :=
  ∑ r : Fin (m + 1), turn (γ r) (smoothedSuccessorEdge γ k l r)

end Ising2DLambda.NecSuf.KacWard
