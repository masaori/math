import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/-- The definition needs only a field for the mode inverses. -/
noncomputable def dispersionPolynomial {R : Type*} [Field R]
    (varpi varsigma : R) : Polynomial R :=
  (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
    (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹)

end Ising2DLambda.NecSuf.KacWard
