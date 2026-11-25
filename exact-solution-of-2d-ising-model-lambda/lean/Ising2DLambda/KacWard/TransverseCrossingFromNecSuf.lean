/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TransverseCrossing
import Ising2DLambda.NecSuf.KacWard.TransverseCrossing

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem edgeTransverseCrossing_from_necSuf {L : ℕ}
    (e f e' f' : OrientedEdge L) :
    edgeTransverseCrossing e f e' f' ↔
      Ising2DLambda.NecSuf.KacWard.edgeTransverseCrossing
        (fun a b => b ∈ nonbacktrackingSuccessors a)
        orientedTarget stepTurning (fun a => directionAxis (directionNumber a))
        e f e' f' := by
  rfl

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem transverse_crossing_symmetric_from_necSuf (u v : LocalVisit) :
    TransverseCrossing u v ↔ TransverseCrossing v u := by
  exact transverse_crossing_symmetric_necSuf
    (fun w : LocalVisit => w.turn = .straight) LocalVisit.vertical (· ≠ ·)
    (fun _ _ h => Ne.symm h) u v

end Ising2DLambda.KacWard
