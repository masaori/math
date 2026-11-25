/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitCrossingDescent
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingDescent

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

omit [NeZero L] in
/-- 具体版の第一段が必要十分版 `crossing_straightVisitCount_pos_necSuf` の特殊化として得られること。
通過の添字を歩道の添字、頂点を入辺の終点、直進を一歩の回転数が零、軸を入辺の方向の軸に取る。 -/
theorem crossing_vertexAxisStraightVisitCount_pos_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    1 ≤ vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a := by
  classical
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  exact Ising2DLambda.NecSuf.KacWard.crossing_straightVisitCount_pos_necSuf
    (fun r => orientedTarget (γ r))
    (fun r => stepTurning (γ r) (γ (closedWalkSuccessor r)) = 0)
    (fun r => directionAxis (directionNumber (γ r)))
    (by decide) k l hcross.2.2.2.1 hcross.2.2.2.2.1 hcross.2.2.2.2.2.1 hcross.2.2.2.2.2.2 a

/-- 具体版が必要十分版 `smoothing_split_crossing_descent_necSuf` の特殊化として得られること
（四つの自然数の関係は上の具体版の各段）。 -/
theorem smoothing_split_crossing_descent_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl)
      < closedWalkCrossingNumber γ hγ :=
  Ising2DLambda.NecSuf.KacWard.smoothing_split_crossing_descent_necSuf _ _ _ _ _ _
    (smoothing_split_crossing_partition γ hγ hcross hkl)
    (closedWalk_smoothing_crossing_number_update γ hγ hcross)
    (crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 0)
    (crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 1)

end Ising2DLambda.KacWard
