import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

def fourierModeIndexSet (L : ℕ) (s : SpinStructure) : Set (Qbar × Qbar × ZMod 4) :=
  {m | m.1 ∈ horizontalTwistedModes L s ∧ m.2.1 ∈ verticalTwistedModes L s}

end Ising2DLambda.KacWard
