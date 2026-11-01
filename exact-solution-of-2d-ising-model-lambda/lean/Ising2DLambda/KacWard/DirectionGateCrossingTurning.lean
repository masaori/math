import Ising2DLambda.KacWard.TotalTurning
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 方向番号の標準整数代表。対角ゲージの指数に用いる。 -/
def directionStandardRepresentative (d : ZMod 4) : ℤ := d.val

end Ising2DLambda.KacWard
