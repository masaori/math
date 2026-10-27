import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

noncomputable def dualEndpointModeVector {E R : Type*} [GroupWithZero R]
    (row column : E → ℕ) (direction : E → ZMod 4)
    (varpi varsigma : R) (δ₀ : ZMod 4) : E → R := fun e =>
  if direction e = δ₀ then varpi⁻¹ ^ column e * varsigma⁻¹ ^ row e else 0

end Ising2DLambda.NecSuf.KacWard
