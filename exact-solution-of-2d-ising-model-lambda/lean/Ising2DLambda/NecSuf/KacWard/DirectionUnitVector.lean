import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four distinct direction labels determine a map on the four residue classes. -/
def directionUnitVector {A : Type*} (right down left up : A) (d : ZMod 4) : A :=
  if d = 0 then right else if d = 1 then down else if d = 2 then left else up

end Ising2DLambda.NecSuf.KacWard
