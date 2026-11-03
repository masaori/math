import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of pairs of passages through the same target vertex. -/
noncomputable def contactPairCount {E V : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    0 < p.1 ∧ p.1 < p.2 ∧ target (γ p.1) = target (γ p.2)).card

end Ising2DLambda.NecSuf.KacWard
