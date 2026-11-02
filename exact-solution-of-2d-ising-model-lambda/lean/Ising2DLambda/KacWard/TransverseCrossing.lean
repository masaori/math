/-
「格子頂点で横断する二つの通過」と「二つの通過の横断関係は順序に依らない」
（`def_transverse_crossing`・`claim_transverse_crossing_symmetric`）の具体版。
住処は有限な方向データであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.TransverseCrossing
import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.KacWard.DirectionGateCrossingTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 実際の向き付き辺が作る、共通頂点での二つの直進通過の横断。 -/
def edgeTransverseCrossing {L : ℕ} (e f e' f' : OrientedEdge L) : Prop :=
  f ∈ nonbacktrackingSuccessors e ∧ f' ∈ nonbacktrackingSuccessors e' ∧
    orientedTarget e = orientedTarget e' ∧
    stepTurning e f = 0 ∧ stepTurning e' f' = 0 ∧
    directionAxis (directionNumber e) ≠ directionAxis (directionNumber e')

theorem edgeTransverseCrossing_from_necSuf {L : ℕ}
    (e f e' f' : OrientedEdge L) :
    edgeTransverseCrossing e f e' f' ↔
      Ising2DLambda.NecSuf.KacWard.edgeTransverseCrossing
        (fun a b => b ∈ nonbacktrackingSuccessors a)
        orientedTarget stepTurning (fun a => directionAxis (directionNumber a))
        e f e' f' := by
  rfl

/-- 正方格子の一回の通過が持つ局所データ。一歩の回転と、水平・垂直の軸。 -/
structure LocalVisit where
  turn : Turn
  vertical : Bool

/-- 二つの通過が横断するとは、両方が直進し、一方が水平で他方が垂直であること。 -/
def TransverseCrossing (u v : LocalVisit) : Prop :=
  u.turn = .straight ∧ v.turn = .straight ∧ u.vertical ≠ v.vertical

/-- 二つの通過の横断関係は順序に依らない（具体版）。 -/
theorem transverse_crossing_symmetric (u v : LocalVisit) :
    TransverseCrossing u v ↔ TransverseCrossing v u := by
  unfold TransverseCrossing
  constructor
  · rintro ⟨hu, hv, haxis⟩
    exact ⟨hv, hu, Ne.symm haxis⟩
  · rintro ⟨hv, hu, haxis⟩
    exact ⟨hu, hv, Ne.symm haxis⟩

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem transverse_crossing_symmetric_from_necSuf (u v : LocalVisit) :
    TransverseCrossing u v ↔ TransverseCrossing v u := by
  exact transverse_crossing_symmetric_necSuf
    (fun w : LocalVisit => w.turn = .straight) LocalVisit.vertical (· ≠ ·)
    (fun _ _ h => Ne.symm h) u v

end Ising2DLambda.KacWard
