import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def directionModeWeight (varpi varsigma : Qbar) (δ : ZMod 4) : Qbar :=
  if δ = 0 then varpi else if δ = 1 then varsigma
    else if δ = 2 then varpi⁻¹ else varsigma⁻¹

/-- The four cases in the definition of the mode matrix, with the direction
unit vector evaluated at each of the four directions. -/
noncomputable def modeSmallMatrix (z varpi varsigma : Qbar) :
    Matrix (ZMod 4) (ZMod 4) Qbar := fun δ δ' =>
  (if δ' = δ then 1 else if δ' = δ + 1 then z
    else if δ' = δ - 1 then z⁻¹ else 0) * directionModeWeight varpi varsigma δ'

end Ising2DLambda.KacWard
