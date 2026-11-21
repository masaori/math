/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の
「閉歩道の回転位相積は循環総回転数の冪である」
（`claim_closed_walk_rotation_phase`）の具体版。

閉歩道の内側の回転を `turns`、終辺から始辺への回転を `closing` として、
人手証明の式鎖を代数的数の体で示す。
-/
import Ising2DLambda.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 閉歩道の回転位相積は循環総回転数の冪である（代数的数に固定した具体版）。 -/
theorem closed_walk_rotation_phase {z : Qbar} (hz4 : z ^ 4 = -1)
    (turns : List Turn) (closing : Turn) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
      z ^ ((turns.map turnValue).sum + turnValue closing) := by
  have hz : z ≠ 0 := by
    intro hzero
    have hpow : z ^ 4 = 0 := by simp [hzero]
    rw [hpow] at hz4
    norm_num at hz4
  calc
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
        z ^ (turns.map turnValue).sum * phaseOfTurn z closing := by
          rw [walk_rotation_phase_total_turning hz4 turns]
    _ = z ^ (turns.map turnValue).sum * z ^ turnValue closing := by
      rw [phaseOfTurn_eq_zpow]
    _ = z ^ ((turns.map turnValue).sum + turnValue closing) := by
      rw [zpow_add₀ hz]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem closed_walk_rotation_phase_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) (closing : Turn) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
      z ^ ((turns.map turnValue).sum + turnValue closing) := by
  rw [phaseOfTurn_map_eq_necSuf, turnValue_map_eq_necSuf, phaseOfTurn_eq_necSuf,
    turnValue_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phase_prod_mul_closing_eq_zpow_sum_add_necSuf hz
    (turns.map Turn.toNecSuf) closing.toNecSuf

end Ising2DLambda.KacWard
