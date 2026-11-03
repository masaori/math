import Mathlib.Data.Int.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- A horizontal or vertical unit step, with its orientation. -/
def planeDisplacement {E : Type*} (isHorizontal : E → Bool)
    (e : E × Bool) : ℤ × ℤ :=
  if isHorizontal e.1 then
    if e.2 then (0, -1) else (0, 1)
  else
    if e.2 then (-1, 0) else (1, 0)

end Ising2DLambda.NecSuf.KacWard
