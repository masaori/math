/-
章「トーラス上の Kac--Ward 行列式」の「回転位相は一歩の回転数の冪である」
（`claim_rotation_phase_as_turning_power`）と「回転位相の積は総回転数の冪である」
（`claim_walk_rotation_phase_total_turning`）の具体版。

人手証明と同じく、一歩の等式は三場合の照合、積の等式は列の長さの帰納法で進む
（場合分けと帰納法の本体は必要十分版にあり、ここでは代数的数の体と
原始 8 乗根の約束 `z ^ 4 = -1` に固定して `z ≠ 0` を導く）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.KacWard.TotalTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

/-- 回転位相は一歩の回転数の整数冪である（代数的数の体に固定した具体版）。 -/
theorem phaseOfTurn_eq_zpow (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = z ^ turnValue turn :=
  phaseOfTurn_eq_zpow_necSuf z turn

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem phaseOfTurn_eq_zpow_from_necSuf (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = z ^ turnValue turn :=
  phaseOfTurn_eq_zpow_necSuf z turn

/-- 回転位相の積は総回転数の冪である（`z ^ 4 = -1` の原始 8 乗根の設定）。 -/
theorem walk_rotation_phase_total_turning {z : Qbar} (hz4 : z ^ 4 = -1)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum := by
  have hz : z ≠ 0 := by
    intro hzero
    have hpow : z ^ 4 = 0 := by simp [hzero]
    rw [hpow] at hz4
    norm_num at hz4
  exact phase_prod_eq_zpow_sum_necSuf hz turns

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem walk_rotation_phase_total_turning_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum :=
  phase_prod_eq_zpow_sum_necSuf hz turns

end Ising2DLambda.KacWard
