/- 本文 `claim_target_direction_bijection` の具体的な対象を必要十分版へ代入する。 -/
import Ising2DLambda.KacWard.TargetDirectionBijection
import Ising2DLambda.NecSuf.KacWard.TargetDirectionBijection

namespace Ising2DLambda.KacWard

theorem targetDirection_bijective_from_necSuf {L : ℕ} [NeZero L] :
    Function.Bijective (fun e : OrientedEdge L => (orientedTarget e, directionNumber e)) := by
  apply Ising2DLambda.NecSuf.KacWard.targetDirection_bijective_necSuf
    orientedSource orientedTarget directionNumber reversal
  · exact reversal_involutive
  · exact orientedTarget_reversal
  · exact directionNumber_reversal
  · exact sourceDirection_bijective

end Ising2DLambda.KacWard
