import Ising2DLambda.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.DirectionAxis
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 方向番号の標準整数代表。対角ゲージの指数に用いる。 -/
def directionStandardRepresentative (d : ZMod 4) : ℤ := d.val

/-- `def_direction_axis`。偶数方向は水平、奇数方向は垂直。 -/
def directionAxis (d : ZMod 4) : ZMod 2 := (d.val : ZMod 2)

theorem directionAxis_values :
    directionAxis 0 = 0 ∧ directionAxis 1 = 1 ∧
      directionAxis 2 = 0 ∧ directionAxis 3 = 1 := by
  decide

theorem directionAxis_from_necSuf (d : ZMod 4) :
    directionAxis d = Ising2DLambda.NecSuf.KacWard.residueAxis 2 d := rfl

end Ising2DLambda.KacWard
