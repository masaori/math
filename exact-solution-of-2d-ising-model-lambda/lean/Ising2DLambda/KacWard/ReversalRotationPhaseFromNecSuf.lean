/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ReversalRotationPhase
import Ising2DLambda.NecSuf.KacWard.ReversalRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

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
