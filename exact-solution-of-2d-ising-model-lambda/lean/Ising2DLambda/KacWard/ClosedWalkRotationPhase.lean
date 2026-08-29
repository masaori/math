/-
章「トーラス上の Kac--Ward 行列式」の
「閉歩道の回転位相積は循環総回転数の冪である」
（`claim_closed_walk_rotation_phase`）の具体版。

閉歩道の内側の回転を `turns`、終辺から始辺への回転を `closing` として、
人手証明と同じ四段を必要十分版から代数的数の体へ特殊化する。
-/
import Ising2DLambda.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

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
  exact phase_prod_mul_closing_eq_zpow_sum_add_necSuf hz turns closing

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem closed_walk_rotation_phase_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) (closing : Turn) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
      z ^ ((turns.map turnValue).sum + turnValue closing) :=
  phase_prod_mul_closing_eq_zpow_sum_add_necSuf hz turns closing

end Ising2DLambda.KacWard
