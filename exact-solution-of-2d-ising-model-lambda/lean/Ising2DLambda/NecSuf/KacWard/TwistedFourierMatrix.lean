import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

noncomputable def fourierMatrix {E M R : Type*} (κ : E ≃ M)
    (ψ : M → E → R) : Matrix E E R :=
  fun e g => ψ (κ g) e

end Ising2DLambda.NecSuf.KacWard
