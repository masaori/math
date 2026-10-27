import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only a field, a four-element cyclic direction set, and three nonzero
weights are used to define the mode matrix. -/
noncomputable def modeSmallMatrix {R : Type*} [Field R] (z varpi varsigma : R) :
    Matrix (ZMod 4) (ZMod 4) R := fun δ δ' =>
  let weight := if δ' = 0 then varpi else if δ' = 1 then varsigma
    else if δ' = 2 then varpi⁻¹ else varsigma⁻¹
  (if δ' = δ then 1 else if δ' = δ + 1 then z
    else if δ' = δ - 1 then z⁻¹ else 0) * weight

end Ising2DLambda.NecSuf.KacWard
