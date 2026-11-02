import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 偶数個の方向を二つの軸へ送る剰余類写像。必要なのは偶数個の巡回方向だけ。 -/
def residueAxis (halfDirections : ℕ) (d : ZMod (2 * halfDirections)) : ZMod 2 :=
  (d.val : ZMod 2)

end Ising2DLambda.NecSuf.KacWard
