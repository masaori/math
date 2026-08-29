/-
「閉歩道の回転位相積は回転数の符号である」の具体版。
循環総回転数 `n`、回転数 `r` と等式 `n = 4*r` に固定し、人手証明の四段に対応させる。
-/
import Ising2DLambda.KacWard.ClosedWalkRotationPhase
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationNumberSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

theorem closed_walk_rotation_phase_sign {z : Qbar} (hz4 : z ^ 4 = -1)
    (turns : List Turn) (closing : Turn) (r : ℤ)
    (hr : (turns.map turnValue).sum + turnValue closing = 4 * r) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing = (-1 : Qbar) ^ r := by
  calc
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
        z ^ ((turns.map turnValue).sum + turnValue closing) :=
      closed_walk_rotation_phase hz4 turns closing
    _ = z ^ ((4 : ℤ) * r) := by rw [hr]
    _ = (-1 : Qbar) ^ r := zpow_four_mul_eq_neg_one_zpow_necSuf hz4 r

theorem closed_walk_rotation_phase_sign_from_necSuf {z : Qbar} (hz4 : z ^ 4 = -1)
    (r : ℤ) : z ^ ((4 : ℤ) * r) = (-1 : Qbar) ^ r :=
  zpow_four_mul_eq_neg_one_zpow_necSuf hz4 r

end Ising2DLambda.KacWard
