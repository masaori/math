/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の「回転位相は一歩の回転数の冪である」
（`claim_rotation_phase_as_turning_power`）と「回転位相の積は総回転数の冪である」
（`claim_walk_rotation_phase_total_turning`）の具体版。

一歩の等式は人手証明と同じ三場合の照合で示す。積の等式は末尾の回転を
分離する帰納法で示し、整数指数の加法則に必要な非零性を `z ^ 4 = -1` から得る。
-/
import Ising2DLambda.KacWard.ReversalRotationPhase
import Ising2DLambda.NecSuf.KacWard.TotalTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の一歩の回転数は、場合を送った先の必要十分版の回転数に等しい。 -/
theorem turnValue_eq_necSuf (turn : Turn) :
    turnValue turn = Ising2DLambda.NecSuf.KacWard.turnValue turn.toNecSuf := by
  cases turn <;> rfl

/-- 回転位相の列は、場合を送った先の必要十分版の回転位相の列に等しい。 -/
theorem phaseOfTurn_map_eq_necSuf (z : Qbar) (turns : List Turn) :
    turns.map (phaseOfTurn z) =
      (turns.map Turn.toNecSuf).map (Ising2DLambda.NecSuf.KacWard.phaseOfTurn z) := by
  rw [List.map_map]
  exact List.map_congr_left (fun turn _ => phaseOfTurn_eq_necSuf z turn)

/-- 回転数の列は、場合を送った先の必要十分版の回転数の列に等しい。 -/
theorem turnValue_map_eq_necSuf (turns : List Turn) :
    turns.map turnValue =
      (turns.map Turn.toNecSuf).map Ising2DLambda.NecSuf.KacWard.turnValue := by
  rw [List.map_map]
  exact List.map_congr_left (fun turn _ => turnValue_eq_necSuf turn)

/-- 回転位相は一歩の回転数の整数冪である（代数的数の体に固定した具体版）。 -/
theorem phaseOfTurn_eq_zpow (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = z ^ turnValue turn := by
  cases turn
  · simp [phaseOfTurn, turnValue]
  · simp [phaseOfTurn, turnValue]
  · simp [phaseOfTurn, turnValue]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem phaseOfTurn_eq_zpow_from_necSuf (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = z ^ turnValue turn := by
  rw [phaseOfTurn_eq_necSuf, turnValue_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phaseOfTurn_eq_zpow_necSuf z turn.toNecSuf

/-- 回転位相の積は総回転数の冪である（`z ^ 4 = -1` の原始 8 乗根の設定）。 -/
theorem walk_rotation_phase_total_turning {z : Qbar} (hz4 : z ^ 4 = -1)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum := by
  have hz : z ≠ 0 := by
    intro hzero
    have hpow : z ^ 4 = 0 := by simp [hzero]
    rw [hpow] at hz4
    norm_num at hz4
  induction turns using List.reverseRecOn with
  | nil =>
      -- 空積・空和・零乗。
      simp
  | append_singleton turns closing ih =>
      -- 本文と同じく末尾の因子を分離し、帰納法の仮定と一歩の位相を順に代入する。
      calc
        ((turns ++ [closing]).map (phaseOfTurn z)).prod =
            (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing := by simp
        _ = z ^ (turns.map turnValue).sum * phaseOfTurn z closing := by rw [ih]
        _ = z ^ (turns.map turnValue).sum * z ^ turnValue closing := by
          rw [phaseOfTurn_eq_zpow]
        _ = z ^ ((turns.map turnValue).sum + turnValue closing) := by
          rw [zpow_add₀ hz]
        _ = z ^ ((turns ++ [closing]).map turnValue).sum := by simp

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem walk_rotation_phase_total_turning_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum := by
  rw [phaseOfTurn_map_eq_necSuf, turnValue_map_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phase_prod_eq_zpow_sum_necSuf hz (turns.map Turn.toNecSuf)

end Ising2DLambda.KacWard
