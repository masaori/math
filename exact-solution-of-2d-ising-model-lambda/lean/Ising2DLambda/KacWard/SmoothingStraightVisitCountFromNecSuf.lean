/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingStraightVisitCount
import Ising2DLambda.NecSuf.KacWard.SmoothingStraightVisitCount
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard
open Ising2DLambda.PartitionPolynomial

theorem smoothedStraightVisitCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1))
    (w : Vertex L) (a : ZMod 2) :
    smoothedStraightVisitCount γ hγ k l w a =
      Ising2DLambda.NecSuf.KacWard.smoothedStraightVisitCount γ orientedTarget
        (fun e f => stepTurning e f = 0)
        (fun e => directionAxis (directionNumber e)) k l w a := by
  simp only [smoothedStraightVisitCount,
    Ising2DLambda.NecSuf.KacWard.smoothedStraightVisitCount,
    smoothedExitEdge, Ising2DLambda.NecSuf.KacWard.smoothedSuccessorEdge,
    closedWalkSuccessor_from_necSuf]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_straight_visit_count_update_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight)
    (w : V) (ax : Bool) :
    (Finset.univ.filter fun k : Fin m => vertex k = w ∧
        (visit k).turn = .straight ∧ (visit k).vertical = ax).card
      = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit' k).turn = .straight ∧ (visit' k).vertical = ax).card
        + (if vertex a = w then 1 else 0) :=
  smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb w ax

end Ising2DLambda.KacWard
