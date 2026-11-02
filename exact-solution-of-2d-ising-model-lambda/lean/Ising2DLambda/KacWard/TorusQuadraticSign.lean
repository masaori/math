import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.KacWard

/-- The parity of `hv + (1-a)h + (1-b)v` for Boolean residues. -/
def torusQuadraticParity (a b h v : Bool) : Bool :=
  Bool.xor (Bool.xor (h && v) ((!a) && h)) ((!b) && v)

/-- The integer sign associated with the torus winding parity. -/
def torusQuadraticSign (a b h v : Bool) : ℤ :=
  if torusQuadraticParity a b h v then -1 else 1

end Ising2DLambda.KacWard
