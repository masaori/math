/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の「反転辺対の回転位相の積は 1」
（`claim_reversal_rotation_phase_product`）の具体版。

人手証明の直進・左回転・右回転の三場合と同じ場合分けで、
逆順の辺対では回転の向きが逆になることを使う。
-/
import Ising2DLambda.KacWard.Turn
import Ising2DLambda.NecSuf.KacWard.ReversalRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の三つの場合。回転差に応じた位相と、逆順・反転後の位相の積は 1。 -/
theorem reversal_rotation_phase_product {z : Qbar} (hz4 : z ^ 4 = -1)
    (turn : Turn) : phaseOfTurn z (reverseTurn turn) * phaseOfTurn z turn = 1 := by
  have hz : z ≠ 0 := by
    intro hzero
    have hpow : z ^ 4 = 0 := by simp [hzero]
    rw [hpow] at hz4
    norm_num at hz4
  cases turn
  · -- 直進: 1 · 1 = 1
    simp [phaseOfTurn, reverseTurn]
  · -- 左回転: z⁻¹ · z = 1
    simp [phaseOfTurn, reverseTurn, hz]
  · -- 右回転: z · z⁻¹ = 1
    simp [phaseOfTurn, reverseTurn, hz]

/-- 具体版の三つの場合を、必要十分版の三つの場合へ送る写像（導出だけが使う）。 -/
def Turn.toNecSuf : Turn → Ising2DLambda.NecSuf.KacWard.Turn
  | .straight => .straight
  | .left => .left
  | .right => .right

/-- 具体版の回転位相は、場合を送った先の必要十分版の回転位相に等しい。 -/
theorem phaseOfTurn_eq_necSuf (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = Ising2DLambda.NecSuf.KacWard.phaseOfTurn z turn.toNecSuf := by
  cases turn <;> rfl

/-- 逆順の場合は、送った先でも逆順の場合である。 -/
theorem Turn.reverseTurn_toNecSuf (turn : Turn) :
    (reverseTurn turn).toNecSuf = Ising2DLambda.NecSuf.KacWard.reverseTurn turn.toNecSuf := by
  cases turn <;> rfl

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem reversal_rotation_phase_product_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turn : Turn) : phaseOfTurn z (reverseTurn turn) * phaseOfTurn z turn = 1 := by
  rw [phaseOfTurn_eq_necSuf, phaseOfTurn_eq_necSuf, Turn.reverseTurn_toNecSuf]
  exact Ising2DLambda.NecSuf.KacWard.reverse_phase_mul_necSuf hz turn.toNecSuf

end Ising2DLambda.KacWard
