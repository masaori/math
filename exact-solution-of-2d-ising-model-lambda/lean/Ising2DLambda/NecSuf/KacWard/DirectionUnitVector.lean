import Mathlib.Data.ZMod.Basic
import Ising2DLambda.NecSuf.KacWard.PlaneDisplacement

namespace Ising2DLambda.NecSuf.KacWard

/-- Four distinct direction labels determine a map on the four residue classes. -/
def directionUnitVector {A : Type*} (right down left up : A) (d : ZMod 4) : A :=
  if d = 0 then right else if d = 1 then down else if d = 2 then left else up

def directionNumberOf {E : Type*} (isHorizontal : E → Bool)
    (e : E × Bool) : ZMod 4 :=
  if isHorizontal e.1 then (if e.2 then 2 else 0)
  else (if e.2 then 3 else 1)

theorem planeDisplacement_eq_directionUnitVector {E : Type*}
    (isHorizontal : E → Bool) (e : E × Bool) :
    planeDisplacement isHorizontal e =
      directionUnitVector (0, 1) (1, 0) (0, -1) (-1, 0)
        (directionNumberOf isHorizontal e) := by
  rcases e with ⟨edge, reverse⟩
  by_cases hh : isHorizontal edge = true <;> cases reverse <;>
    simp [planeDisplacement, directionNumberOf, directionUnitVector, hh] <;> decide

end Ising2DLambda.NecSuf.KacWard
