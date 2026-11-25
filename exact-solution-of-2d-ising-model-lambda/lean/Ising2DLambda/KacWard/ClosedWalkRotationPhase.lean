/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の
「閉歩道の回転位相積は循環総回転数の冪である」
（`claim_closed_walk_rotation_phase`）の具体版。

閉歩道の内側の回転を `turns`、終辺から始辺への回転を `closing` として、
人手証明の式鎖を代数的数の体で示す。
-/
import Ising2DLambda.KacWard.TotalTurning

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

end Ising2DLambda.KacWard
