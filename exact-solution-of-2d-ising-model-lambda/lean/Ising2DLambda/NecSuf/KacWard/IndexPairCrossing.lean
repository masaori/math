import Ising2DLambda.NecSuf.KacWard.ClosedWalkPasses

namespace Ising2DLambda.NecSuf.KacWard

/-- Two distinct indices cross when their cyclic passes satisfy the crossing relation. -/
def indexPairCrossing {E : Type*} {m : ℕ}
    (cross : E → E → E → E → Prop)
    (γ : Fin (m + 1) → E) (k l : Fin (m + 1)) : Prop :=
  k ≠ l ∧ cross (γ k) (γ (cyclicSuccessor k))
    (γ l) (γ (cyclicSuccessor l))

end Ising2DLambda.NecSuf.KacWard
