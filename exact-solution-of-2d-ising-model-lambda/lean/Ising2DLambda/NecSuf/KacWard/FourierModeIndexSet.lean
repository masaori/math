import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

def fourierModeIndexSet {R : Type*} (U W : Set R) : Set (R × R × ZMod 4) :=
  {m | m.1 ∈ U ∧ m.2.1 ∈ W}

end Ising2DLambda.NecSuf.KacWard
