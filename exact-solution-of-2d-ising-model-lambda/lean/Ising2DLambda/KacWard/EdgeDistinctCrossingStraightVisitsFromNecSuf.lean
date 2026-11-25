/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EdgeDistinctCrossingStraightVisits
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctCrossingStraightVisits

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.PartitionPolynomial

variable {L : ℕ} [NeZero L]

/-- 具体版が必要十分版 `crossing_straightVisitCount_eq_one` の特殊化として得られること。
通過の添字を歩道の添字、頂点を入辺の終点、入る方向・出る方向を入辺・出辺の方向番号に取る。 -/
theorem crossing_vertexAxisStraightVisitCount_eq_one_from_necSuf {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun k => (γ k).1)
    {k l : Fin (m + 1)} (hkl : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a = 1 := by
  classical
  obtain ⟨hk, hl⟩ := crossing_straight γ hγ hkl
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  exact Ising2DLambda.NecSuf.KacWard.crossing_straightVisitCount_eq_one
    (fun r => orientedTarget (γ r)) (fun r => directionNumber (γ r))
    (fun r => directionNumber (γ (closedWalkSuccessor r)))
    (fun r => stepTurning (γ r) (γ (closedWalkSuccessor r)) = 0)
    (fun r p d hv hr hp => pass_shared_halfEdge_eq γ hγ hinj r p d hv hr hp)
    k l hkl.2.2.2.1 hk hl hkl.2.2.2.2.1 hkl.2.2.2.2.2.1 hkl.2.2.2.2.2.2 a

end Ising2DLambda.KacWard
