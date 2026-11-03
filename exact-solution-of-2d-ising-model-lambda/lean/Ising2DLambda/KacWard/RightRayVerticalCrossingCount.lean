import Ising2DLambda.KacWard.PlaneLift
import Ising2DLambda.NecSuf.KacWard.RightRayVerticalCrossingCount

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

theorem rightRayVerticalCrossingCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (r c : ℤ) :
    rightRayVerticalCrossingCount γ hγ r c =
      Ising2DLambda.NecSuf.KacWard.rightRayVerticalCrossingCount m (planeLift γ) r c := rfl

end Ising2DLambda.KacWard
