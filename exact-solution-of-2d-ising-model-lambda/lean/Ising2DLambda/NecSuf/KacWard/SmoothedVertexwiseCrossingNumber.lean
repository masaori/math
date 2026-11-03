import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.NecSuf.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.NecSuf.KacWard

/-- Crossing pairs after exchanging the outgoing edges at two indices. -/
noncomputable def smoothedVertexwiseCrossingNumber {E V A : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A)
    (k l : Fin (m + 1)) (w : V) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ target (γ p.1) = w ∧ target (γ p.2) = w ∧
      straight (γ p.1) (smoothedSuccessorEdge γ k l p.1) ∧
      straight (γ p.2) (smoothedSuccessorEdge γ k l p.2) ∧
      axis (γ p.1) ≠ axis (γ p.2)).card

end Ising2DLambda.NecSuf.KacWard
