import Ising2DLambda.KacWard.PlaneLift
import Mathlib

namespace Ising2DLambda.KacWard

/-- The right-ray crossing count of the plane lift of an actual closed walk. -/
def rightRayVerticalCrossingCount {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (r c : ℤ) : ℕ :=
  (Finset.univ.filter (fun k : Fin (m + 1) =>
    c < (planeLift γ k.castSucc).2 ∧
      (planeLift γ k.castSucc).2 = (planeLift γ k.succ).2 ∧
      (((planeLift γ k.castSucc).1 = r ∧
          (planeLift γ k.succ).1 = r + 1) ∨
       ((planeLift γ k.castSucc).1 = r + 1 ∧
          (planeLift γ k.succ).1 = r)))).card

end Ising2DLambda.KacWard
