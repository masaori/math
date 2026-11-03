import Mathlib.Data.Finset.Prod
import Ising2DLambda.NecSuf.KacWard.SmoothingIndexBlocks
import Ising2DLambda.NecSuf.KacWard.SmoothedSuccessorMap

namespace Ising2DLambda.NecSuf.KacWard

/-- Mixed crossing pairs between the two index blocks after smoothing. -/
noncomputable def splitMutualCrossingNumber {E V A : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A)
    (k l : Fin (m + 1)) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 ∈ smoothingIndexBlockA k l ∧ p.2 ∈ smoothingIndexBlockB k l ∧
      target (γ p.1) = target (γ p.2) ∧
      straight (γ p.1) (smoothedSuccessorEdge γ k l p.1) ∧
      straight (γ p.2) (smoothedSuccessorEdge γ k l p.2) ∧
      axis (γ p.1) ≠ axis (γ p.2)).card

end Ising2DLambda.NecSuf.KacWard
