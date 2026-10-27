import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

noncomputable def dualFourierMatrix {E M R : Type*} (κ : E ≃ M)
    (ψbar : M → E → R) : Matrix E E R :=
  fun g e => ψbar (κ g) e

noncomputable def fourierInverseCandidate {E M R : Type*} [SMul R (Matrix E E R)]
    (scale : R) (κ : E ≃ M) (ψbar : M → E → R) : Matrix E E R :=
  scale • dualFourierMatrix κ ψbar

end Ising2DLambda.NecSuf.KacWard
