import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The four cases in the definition of the mode matrix, with the direction
unit vector evaluated at each of the four directions. -/
noncomputable def modeSmallMatrix (z varpi varsigma : Qbar) :
    Matrix (ZMod 4) (ZMod 4) Qbar := fun δ δ' =>
  let weight := if δ' = 0 then varpi else if δ' = 1 then varsigma
    else if δ' = 2 then varpi⁻¹ else varsigma⁻¹
  (if δ' = δ then 1 else if δ' = δ + 1 then z
    else if δ' = δ - 1 then z⁻¹ else 0) * weight

end Ising2DLambda.KacWard
