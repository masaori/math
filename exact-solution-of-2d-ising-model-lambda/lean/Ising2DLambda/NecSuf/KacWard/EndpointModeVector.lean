import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A Fourier vector needs only target coordinates and a direction map. -/
noncomputable def endpointModeVector {E R : Type*} [MonoidWithZero R]
    (row column : E → ℕ) (direction : E → ZMod 4)
    (varpi varsigma : R) (δ₀ : ZMod 4) : E → R := fun e =>
  if direction e = δ₀ then varpi ^ column e * varsigma ^ row e else 0

end Ising2DLambda.NecSuf.KacWard
