import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.NecSuf.KacWard.IndexPairCrossing

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of crossing pairs of distinct cyclic passes, counted once in index order. -/
noncomputable def closedWalkCrossingNumber {E : Type*} {m : ℕ}
    (cross : E → E → E → E → Prop) (γ : Fin (m + 1) → E) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ indexPairCrossing cross γ p.1 p.2).card

end Ising2DLambda.NecSuf.KacWard
